From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] test-lib.sh: add --long-tests option
Date: Tue, 17 Jun 2008 09:09:57 +0200
Message-ID: <48576345.7000809@gmail.com>
References: <1213666142-24680-1-git-send-email-LeWiemann@gmail.com> <7vy7547egk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:11:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8VLG-0001kE-7D
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 09:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbYFQHKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 03:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752508AbYFQHKD
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 03:10:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:16539 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbYFQHKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 03:10:01 -0400
Received: by ug-out-1314.google.com with SMTP id h2so514944ugf.16
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=5ImOruDHt2ip43XAa3UpzUvrJE3kgC5lWjUjvGbeADE=;
        b=MFVpO4Iuim4hR4pZG3xtA9XwZgMK1y0YQQN0uEGcKlemJvT1jhh5q3qFlHaN6g6mPP
         jcQFtucVLholQbTiJoc27dhXxEwbrAUrXMhPpXZSjSXryuNM37Xfj6AQHeox+PyyplAr
         NSy8Sa999Xd6eBSCnAlXVmEVixu12Jgu48YZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=WwRMoeeFissyd4lqYNgTVsFg2Lk6HrPSyq23YwhhcEiO97I6J0O3S0OuQIEXKATu/X
         lOWfledtrm511hCf6l5KeJoivsSNFPR4dha+wAd5GTN5y2j7SiVBmgRoC1U0Cw8NdDo5
         OFOsLQ+2C2XrD/eseAUJz6OnUHMeTAJgpguyk=
Received: by 10.210.67.20 with SMTP id p20mr7280246eba.66.1213686597766;
        Tue, 17 Jun 2008 00:09:57 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.200.72])
        by mx.google.com with ESMTPS id f13sm11698494gvd.2.2008.06.17.00.09.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 00:09:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vy7547egk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85270>

Junio C Hamano wrote:
> I am guessing that the reason why you do not unset GIT_TEST_LONG upfront
> in the script is because the user can do:
> 
>         $ GIT_TEST_LONG=t; export GIT_TEST_LONG
>         $ ./t9999-this-test.sh
>         $ ./t9999-that-test.sh
> 
> or even:
> 
> 	$ GIT_TEST_LONG=t make test

Yes, that's the idea.

> If that is the case, however, I wonder if this --long-tests option is even
> necessary.

It's very convenient for development, where you go back and forth 
between "./t9503-gitweb-Mechanize.sh -v -l" and 
"./t9503-gitweb-Mechanize.sh -v".  All it takes is to add or remove the 
"-l" at each invocation.  So I think the switch is actually quite useful.

-- Lea
