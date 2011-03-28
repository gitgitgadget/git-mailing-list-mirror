From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] vcs-svn: make reading of properties binary-safe
Date: Mon, 28 Mar 2011 15:44:03 -0500
Message-ID: <20110328204403.GC16202@elie>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
 <20110325033431.GA3007@elie>
 <20110325040730.GB3007@elie>
 <4D90AA6A.1090904@web.de>
 <20110328194157.GC13433@elie>
 <4D90EFF5.9050603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 28 22:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4JIO-00037v-1L
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 22:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab1C1UoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 16:44:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62931 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1C1UoK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 16:44:10 -0400
Received: by vws1 with SMTP id 1so2649047vws.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=T4bVP8s3NnbAdSg+fFWcJUkygbo5jcWnGmojGoF22/w=;
        b=VKfpLyXYKD+5Jfew6xWdMuIqU72kSOF+qe+yHPM0ZLKJGkoEDDOXLEwblJkByerJED
         p33A3Acnhs92HGH7KlaYhBOoXY+Qj/vFIfYwAnXubaBKJy+CIkdAFRVQ76qXXSyqQbdI
         tSnq3j1pABQ8UQKaNz1+i9XaZznBzz31nQql8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=magQZVzkS7yw2IAZy67brO9XIVZV7gUM2ZWAsOR5lIttbX3KKC1fCjWslN9JF/g3WS
         lWq1olmR01tL7cNyTUI1mEmPG0xJwH5cCgzkb4wijp3B6wfB/pU+xYwudl6IM8k3JTCl
         NvKFScjGZN6qeblwfniwl0tJ4dvDZMLTPMaRY=
Received: by 10.52.18.47 with SMTP id t15mr6323792vdd.48.1301345049606;
        Mon, 28 Mar 2011 13:44:09 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.sbcglobal.net [68.255.101.206])
        by mx.google.com with ESMTPS id u9sm1270820vbx.9.2011.03.28.13.44.07
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 13:44:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D90EFF5.9050603@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170188>

Torsten B=C3=B6gershausen wrote:

> No good news from my side:
> Same (?) problem with 41e6b...
>
> not ok - 13 NUL in log message, file content, and property name

Alas.  Could you send the output for that test from
"sh t9010-svn-fe.sh -v -i", or from

	GIT_TRACE=3D1 sh -x t9010-svn-fe.sh -v -i

if it looks more enlightening?
