From: Preben Liland Madsen <prebenliland@gmail.com>
Subject: Re: Ignore version update changes on git show report?
Date: Fri, 1 Mar 2013 16:12:16 +0100
Message-ID: <BB9809E3-7698-48D6-A051-D1052506507A@gmail.com>
References: <DEC76CB0-9E35-40A8-9D73-77617CC605A3@gmail.com> <5130AE23.4040303@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 01 16:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBRYf-00015O-9m
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 16:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab3CAPHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 10:07:10 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:50988 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3CAPHI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Mar 2013 10:07:08 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so3055403lab.29
        for <git@vger.kernel.org>; Fri, 01 Mar 2013 07:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:subject:mime-version:content-type:from:in-reply-to:date
         :cc:content-transfer-encoding:message-id:references:to:x-mailer;
        bh=/ibw1nPkWF1w/KjBh63VtyqWW54WRinDSP64FODGCEI=;
        b=ykCDvjYYcY5Lb1GyV4PlhwujQYimFOt55E9gZz06+Z+hYBVnPIuKRWhXOpUJlUjWUd
         7nMXF/fjwkC2jmCw4BUnd6jn5xhHRWZN7bfxOUgHqLbGqhib4mbTOySoJ9AVQM2olkKX
         StBOV8eXnDXapLn8R74q/6lTz9A7nMMv6p/c0qx77uyc/AlS/Ja7xykmDNH1tkYFBCKE
         lt3droiaROnjnkDifuWdxx0A5VurBbYj3/jZybaeDHg8NyNoY0c+/trlGs9teGE8IpST
         OmAFYHj8aLof45GWl7ZK1CmJC7jJ2N/FvCDKCeLAhxuJOJ8qm6yA7SadXZA3LV/Z01Qu
         PUAQ==
X-Received: by 10.112.16.102 with SMTP id f6mr904545lbd.3.1362150426855;
        Fri, 01 Mar 2013 07:07:06 -0800 (PST)
Received: from [192.168.0.100] (ti0016a380-dhcp1358.bb.online.no. [83.109.133.81])
        by mx.google.com with ESMTPS id fl9sm4201433lbb.9.2013.03.01.07.07.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Mar 2013 07:07:05 -0800 (PST)
In-Reply-To: <5130AE23.4040303@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217279>

Den 1. mars 2013 kl. 14.33 skrev Michael J Gruber:

> First of all, there is
> 
> git beat-with-stick
> 
> that you should apply to those responsible for that mess ;)

Haha, yeah I should try that one ;-)

I wish they weren't included in their release, but what can you do... I'm sure they have their reason for including the updated version number. Maybe to ensure files have been updated or similar when doing support for their clients, I guess... Although for us it really is more a pain than gain that they update the version number in all their php files when we wish to review changes done in files we may have modified earlier or possibly investigate bugs that may suddenly crop up in newer versions.


> If you have to deal with that sort of situation then a textconv filter
> might get you as close as possible. Use "grep -v '^\* IP.Board v*'" as a
> textconv filter for those files, and those changes will disappear from
> the diff. (I do something like that for tracking my gitk config, which
> stores last window sizes.)

Thanks! I got a similar tips on stackoverflow: http://stackoverflow.com/questions/15097401/git-any-way-to-ignore-files-that-have-gotten-version-number-changed-only/

But unfortunately that doesn't work for --stat it seems, but I've written a small "sketchy" shell-script to just ignore all lines with 2+- in them...


Best regards, Preben