From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH] Add custom memory allocator to MinGW and MacOS
 builds
Date: Sat, 04 Apr 2009 07:16:34 +0200
Message-ID: <49D6ED32.4000706@gmail.com>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com> <49D61B35.8060508@trolltech.com> <a5b261830904031412o60b7eb4fv7e25a2ca4f89fe60@mail.gmail.com>
Reply-To: mstormo@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: marius@trolltech.com, git@vger.kernel.org, msysgit@googlegroups.com
To: patthoyts@googlemail.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Apr 04 07:18:17 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpyGj-0000d4-WE
	for gcvm-msysgit@m.gmane.org; Sat, 04 Apr 2009 07:18:14 +0200
Received: by yw-out-2122.google.com with SMTP id 1so435958ywp.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 03 Apr 2009 22:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=/E5SbiWnYs3sPxBgmsf3zMmYy5iYr9Dcuwd6rW0Zp+A=;
        b=iyUSY7p/CwiRqYy2lwTC8gjDs/hzx85BBHGHBwj7m3DfQg+hvSDYj9eFCQFn0nRIOf
         nPwQCLfmT+rLt85Ir55Nstf5g+3W31JoJkf1azhftxhlwiwhmSwxGwcby5n8ZslB9TLH
         2IBn9yuwt4hqgRpzcxYHTbdVpAmWRAKDy+mCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=kBO4DzGGUjwNI2bd9ny4EXFuPip0R2DC+1pRRE+UXDmwoeLNnH+8JMol78xfVrBhUk
         jDjX05p1qbryrgUYMFkD9XjuBPZm/8C7WXoTCOrHP7a/Athq1Y7Xitk4sLf/rmKTiS4Q
         o2Qr9yxE2gTyj7WRbst0ApAdX78JuaCMZsSeQ=
Received: by 10.151.11.19 with SMTP id o19mr289798ybi.9.1238822198395;
        Fri, 03 Apr 2009 22:16:38 -0700 (PDT)
Received: by 10.177.113.42 with SMTP id q42gr4640yqm.0;
	Fri, 03 Apr 2009 22:16:38 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.18.8 with SMTP id 8mr1168578ebr.3.1238822197011; Fri, 03 Apr 2009 22:16:37 -0700 (PDT)
Received: from mail-ew0-f174.google.com (mail-ew0-f174.google.com [209.85.219.174]) by gmr-mx.google.com with ESMTP id 15si388623ewy.0.2009.04.03.22.16.35; Fri, 03 Apr 2009 22:16:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.174 as permitted sender) client-ip=209.85.219.174;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.174 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy22 with SMTP id 22so1316627ewy.0 for <msysgit@googlegroups.com>; Fri, 03 Apr 2009 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from :user-agent:mime-version:to:cc:subject:references:in-reply-to :content-type:content-transfer-encoding; bh=EaFNWzcTSmvlxhLEHn/psUYMxwZJhlZSqMN5ZTEiBxU=; b=t6ayMuKVuREV+qptJ8dFEm0frmsgWsnep56ACPBwEO+yvCMPRd8EN+03RvVKEyEfvI F3B1wZpj0JQjNDHPLhSdMs0aqAqsoGZCmKqvMASY4i9Xv1gm/9MNhxAXjL1W+sFI8IxY qN7VMF+QsjLGk8UrG/Nm42pj56kk8ydLaLzpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:user-agent:mime-version:to:cc:subject :references:in-reply-to:content-type:content-transfer-encoding; b=aEr+KbbV4Iviar4cUHeHWmiC4bIPAo9GQQlyhpLROLLpUPium3LJm0qFQK68b0gakO FsIqXbpt0gxL3YwBmicVvf40Lwre3CubjIarsRuKh/slj8u0XYWaaRmdD7Y1I9znMuKn wWTPyQcjuCqHi1iPpLIxvJhkLkn0RVxJjH8L8=
Received: by 10.210.87.14 with SMTP id k14mr1107266ebb.5.1238822195930; Fri, 03 Apr 2009 22:16:35 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206]) by mx.google.com with ESMTPS id 5sm3876512eyh.41.2009.04.03.22.16.34 (version=TLSv1/SSLv3 cipher=RC4-MD5); Fri, 03 Apr 2009 22:16:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <a5b261830904031412o60b7eb4fv7e25a2ca4f89fe60@mail.gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115571>


Pat Thoyts said the following on 03.04.2009 23:12:
> 2009/4/3 Marius Storm-Olsen <marius@trolltech.com>:
>> Marius Storm-Olsen said the following on 03.04.2009 15:52:
>>> The standard allocator on Windows is pretty bad prior to
>>> Windows Vista, and nedmalloc is better than the modified
>>> dlmalloc provided with newer versions of the MinGW libc.
>> Actually, it just struck me that it's probably the
>> synchronization primitives which are better on Vista than XP, and
>> not the memory manager? (Since mingw 4.3.3-tdm on XP and Vista
>> most likely use the same dlmalloc fork?) ^shrug^
>> 
>> Anyways, not that I haven't tried to 'tune' nedmalloc in any way,
>> just ensured that it compiles with the different MinGWs which I 
>> benchmarked. So, if anyone feels like it, maybe we can squeeze
>> more performance out of it by tweaking it.
> 
> The difference on Windows Vista is that the low fragmentation heap
> is the default memory allocator. On Windows XP you need to enable
> it specifically for an application. So a possible alternative to
> this is just to enable the low fragmentation heap. (done via
> GetProcessHeaps and HeapSetInformation Win32 API calls).

I know about the low-fragmentation heap, but given that it was only 
supported on XP and up (and given that I also had MacOSX in mind when 
considering a custom allocator; see MacOSX got 12% itself ;-), I 
didn't even consider it.
Thanks for clearing up the differences on the Vista and XP benchmarks 
though! Makes sense.

--
.marius
