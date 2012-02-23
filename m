From: Nikolaj Shurkaev <snnicky@gmail.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 15:19:17 +0300
Message-ID: <4F462EC5.6090007@gmail.com>
References: <4F46036F.3040406@gmail.com> <m262exrg65.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 13:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0XeA-0007hY-7w
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 13:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab2BWMTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 07:19:25 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49197 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab2BWMTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 07:19:23 -0500
Received: by bkcjm19 with SMTP id jm19so946993bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 04:19:22 -0800 (PST)
Received-SPF: pass (google.com: domain of snnicky@gmail.com designates 10.205.129.141 as permitted sender) client-ip=10.205.129.141;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of snnicky@gmail.com designates 10.205.129.141 as permitted sender) smtp.mail=snnicky@gmail.com; dkim=pass header.i=snnicky@gmail.com
Received: from mr.google.com ([10.205.129.141])
        by 10.205.129.141 with SMTP id hi13mr591455bkc.7.1329999562463 (num_hops = 1);
        Thu, 23 Feb 2012 04:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=f6FOshxuw1EbMEy5KFI0Hw/LNW1ZgB0TKPlfe41mQq0=;
        b=VXrul178HPOnVAHVTH6epgqEamAS+rymQK8m4nDyukLWbrObBV0lD41cQCCFVoUc5Y
         4VLXHtLzKjgrRaxWDPQZ2PVE4KFPCz5tRJppBQpgzH033aEvfTPfetowQhFelDuyujtL
         tYYgQ4MExfS6TOmD5Z2QxGDMWdgk+Yf8LY2m0=
Received: by 10.205.129.141 with SMTP id hi13mr488380bkc.7.1329999562392;
        Thu, 23 Feb 2012 04:19:22 -0800 (PST)
Received: from [192.168.1.130] ([80.249.81.45])
        by mx.google.com with ESMTPS id x11sm2444566bkd.2.2012.02.23.04.19.20
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 04:19:21 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <m262exrg65.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191357>

Thank you.

That really helped me.
---
Nikolaj

23.02.2012 13:35, Andreas Schwab =EF=E8=F8=E5=F2:
> Nikolaj Shurkaev<snnicky@gmail.com>  writes:
>
>> I did something like this:
>> git log -z --patch HEAD~10..HEAD -- SomePathHere | xargs -0
>> --max-chars=3D1000000 ~/1.sh
>>
>> If I put
>> echo "started"
>> into the file  ~/1.sh I see that the file is called only once instea=
d of
>> multiple times.
> If you want the command to be called once for each commit you need to
> pass --max-args=3D1 to xargs.  Otherwise xargs will cumulate the argu=
ments
> until --max-chars is reached, and the command is expected to loop ove=
r
> them.
>
> Andreas.
>
