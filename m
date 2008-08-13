From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Wed, 13 Aug 2008 22:05:04 +0200
Message-ID: <48A33E70.8060804@gmail.com>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:19:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMbf-0005FA-He
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYHMUFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbYHMUFD
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:05:03 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:3255 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbYHMUFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:05:01 -0400
Received: by fk-out-0910.google.com with SMTP id 18so91188fkq.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=3zuMLtyuhii2b5I0ej/coeQG9Zh2+TZm0jOGYuApFus=;
        b=BAXukZ+L/hLq+yE+zDKQwD1FMklkBG/+aC7qNfPA58a/dpsvN2NNg3rgJSPxx1aJTm
         JwcBz/YqZ8DDb4JGoFXbGauGRBY1oVLxUqesaENysMXGQH7QUx7MESbpsAcnrZk00an6
         fGa493WuTcvZBi00Htk7wYcQs6tdEF5XRbVDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=J2TnEFxZcSasnY0W3E6PGYiC+wQZm8/SnXD6K/CYaSIIUct0YKozjuO38VT+i6+rFx
         nQHjpLJcrJEZonXwdIV3VYzY3D/sH/GaWgG34LIqYiZSm/VKTqljzSFRXnn2M1UIlhG5
         +fxgVr/0Ruaqidar3NIS82FPxA4xhjYIGvyc4=
Received: by 10.180.234.2 with SMTP id g2mr149300bkh.54.1218657899578;
        Wed, 13 Aug 2008 13:04:59 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.235.99])
        by mx.google.com with ESMTPS id k29sm988314fkk.2.2008.08.13.13.04.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 13:04:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <1218470035-13864-2-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92260>

Marcus Griep wrote:
> diff --git a/perl/Git.pm b/perl/Git.pm
>
> +require File::Spec;

This makes Git.pm dependent on Perl 5.6.1.  Some tests (like
t3701-add-interactive.sh) seem to work with pretty much any Perl version
out there, and requiring File::Spec changes this.  Hence to avoid
complaints about failing tests, I suggest that you add a check for
File::Spec availability at the beginning of any test that (indirectly)
uses Git.pm.

(All my statements are untested... ;-))

-- Lea
