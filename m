From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Tue, 17 Feb 2015 22:57:45 +0100
Message-ID: <54E3B959.9040105@gmail.com>
References: <54DBEAA5.6000205@gmail.com>	<xmqqbnkysygl.fsf@gitster.dls.corp.google.com>	<54DD2FDA.7030604@gmail.com>	<xmqqsieaog4a.fsf@gitster.dls.corp.google.com>	<54DD5A89.5080502@gmail.com>	<xmqq61b5obla.fsf@gitster.dls.corp.google.com>	<54E250A6.4070605@gmail.com> <xmqqtwyl4idp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBU7SR2TQKGQEDZE7JUI@googlegroups.com Tue Feb 17 22:57:41 2015
Return-path: <msysgit+bncBCH3XYXLXQDBBU7SR2TQKGQEDZE7JUI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBU7SR2TQKGQEDZE7JUI@googlegroups.com>)
	id 1YNq9E-0003e3-GK
	for gcvm-msysgit@m.gmane.org; Tue, 17 Feb 2015 22:57:40 +0100
Received: by mail-wg0-f63.google.com with SMTP id k14sf7314879wgh.8
        for <gcvm-msysgit@m.gmane.org>; Tue, 17 Feb 2015 13:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=AAQlWgCTFzisBr1VE0EVokhwBTQB8+9Wd86eVMUJVv0=;
        b=YN6PDUH0P1kf+bn8G+4X36oGghr7Ir403U/Ydjmtn4ExiQbjSDu3iv8rnD6M6YSpjp
         WVtmWy9KALuxbzUZgw2OHjLe8YfcsWp0lTE0WEf3A6ycjNN67wQZpNNIX9wmKg3dGXC/
         gr59DHicGRuC0c+J5v0xC1MlL85F9Ad7UXJVJKmqa8OlNXznvMlmpHXP8bfr42C1pXzg
         3zDw4aZltQiBUP6kzn0Woc/29EGxScT2a9f7hhEXSWVMANE1nrmjwCh2YhDOZGPaFFMZ
         u9H8+FhdF7cFv9brp2KEGqYdYq6HJBcW5uetm1mRUS7kCV+BQX5A5OT8w6u2kX2wVUVz
         2e2A==
X-Received: by 10.180.87.196 with SMTP id ba4mr210206wib.13.1424210260220;
        Tue, 17 Feb 2015 13:57:40 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.109.228 with SMTP id hv4ls1064437wib.23.gmail; Tue, 17 Feb
 2015 13:57:39 -0800 (PST)
X-Received: by 10.194.86.1 with SMTP id l1mr3884581wjz.0.1424210259349;
        Tue, 17 Feb 2015 13:57:39 -0800 (PST)
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com. [2a00:1450:400c:c05::22d])
        by gmr-mx.google.com with ESMTPS id ev8si6040204wib.3.2015.02.17.13.57.39
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2015 13:57:39 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22d as permitted sender) client-ip=2a00:1450:400c:c05::22d;
Received: by mail-wi0-x22d.google.com with SMTP id bs8so36990603wib.0
        for <msysgit@googlegroups.com>; Tue, 17 Feb 2015 13:57:39 -0800 (PST)
X-Received: by 10.180.105.97 with SMTP id gl1mr48404436wib.74.1424210259295;
        Tue, 17 Feb 2015 13:57:39 -0800 (PST)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id y14sm16078249wjr.39.2015.02.17.13.57.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2015 13:57:38 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqtwyl4idp.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22d
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263990>

Am 16.02.2015 um 23:10 schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> However, the Makefile has this to say on the subject:
>>
>> # Define USE_NSEC below if you want git to care about sub-second file mtimes
>> # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
>> # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
>> # randomly break unless your underlying filesystem supports those sub-second
>> # times (my ext3 doesn't).
>>
>> Am I missing something?
> 
[...]
> 
> If you use NSEC, however, and "refresh" grabbed a subsecond time and
> then later "diff-files" learned a truncated/rounded time because the
> filesystem later purged the cached inodes and re-read it from the
> underlying filesystem with no subsecond time resolution, the times
> would not match so you will again see "diff-files" report that "foo"
> is now different.
> 
> That is what the comment you cited is about.
> 

OK, so it all boils down to the "inode cache doesn't round to on-disk
resolution" issue after all, as explained in racy-git.txt.

But then the Makefile comment is quite misleading. Enabling USE_NSEC
will not unconditionally "BREAK YOUR LOCAL DIFFS". Show-diff / diff-files
will also not "break", but may report false positives instead (which may
be worse than failing hard...).

It also seems to me that this is a Linux-only issue which is only remotely
related to the USE_NSEC setting or file systems' timestamp resolutions.

The kernel patch referenced in racy-git.txt only addresses sub-second
resolutions. So even if USE_NSEC is *disabled*, the diff-files issue will
bite you on e.g. FAT32-formatted flash-drives on Linux, at least on
re-mount ("sync && echo 2>/proc/sys/vm/drop_caches" didn't seem to trigger
the rounding, though).

I also suspect that the sub-second rounding function of that patch
(timespec_trunc()) takes some invalid shortcuts - if you configure the
kernel for 300 jiffies per second (i.e. 3,333,333 ns per tick), UDF, NTFS,
SMBFS and CIFS file times will most likely not be properly rounded in the
inode cache. Haven't tested this, though.

So the only file systems with reliable file times on Linux seem to be
those with exactly 1s or 1ns resolution...?

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
