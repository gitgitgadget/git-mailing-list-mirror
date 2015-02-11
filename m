From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Thu, 12 Feb 2015 00:49:57 +0100
Message-ID: <54DBEAA5.6000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBJGV56TAKGQEZXYD6HQ@googlegroups.com Thu Feb 12 00:49:58 2015
Return-path: <msysgit+bncBCH3XYXLXQDBBJGV56TAKGQEZXYD6HQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f188.google.com ([74.125.82.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBJGV56TAKGQEZXYD6HQ@googlegroups.com>)
	id 1YLh2b-0006gE-UL
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 00:49:57 +0100
Received: by mail-we0-f188.google.com with SMTP id m14sf250115wev.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Feb 2015 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=MP+p4IgZs7b8kq/6PX7KYeVN+2J656+tg6Wop4zXEwI=;
        b=sVecLkHSGJ2Bdj4Kzdnuedp4LQjbaktEuSQqGcvPIKq65p5FcpwXDuzppflFZzVqQh
         aofXLiyY+Fa1TpMtWMGbUZjGjv0ch3GK1f4SGVk8Uotv4EyVdI18P7XrzoUYqXFhprxW
         jx349n+Vi4QJCC79kbO2wHUjU2lBJeYG+HaH/Rx2L1l1JDoYgJiqDSROETYMui2m5GzT
         WJM/pBsWvGBsn/3Mhop5VGj6bb/BjQfuWIGJPxqcbLAoCF8j3W9FdRbfj36Z6gwrKb+j
         Axp5By+uxS/4WeJSuKv2NOjkbOlXHzq0el/zsHWhL7yWnjvEPGwHjDVkdr+CbSe6F5iA
         HeaQ==
X-Received: by 10.152.22.198 with SMTP id g6mr21549laf.16.1423698597382;
        Wed, 11 Feb 2015 15:49:57 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.17 with SMTP id s17ls130506lal.22.gmail; Wed, 11 Feb
 2015 15:49:55 -0800 (PST)
X-Received: by 10.152.219.136 with SMTP id po8mr144325lac.4.1423698595850;
        Wed, 11 Feb 2015 15:49:55 -0800 (PST)
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com. [2a00:1450:400c:c00::22c])
        by gmr-mx.google.com with ESMTPS id i7si33233wif.0.2015.02.11.15.49.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 15:49:55 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22c as permitted sender) client-ip=2a00:1450:400c:c00::22c;
Received: by mail-wg0-x22c.google.com with SMTP id z12so6763831wgg.3
        for <msysgit@googlegroups.com>; Wed, 11 Feb 2015 15:49:55 -0800 (PST)
X-Received: by 10.180.102.69 with SMTP id fm5mr638762wib.61.1423698595724;
        Wed, 11 Feb 2015 15:49:55 -0800 (PST)
Received: from [10.1.116.53] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id lu13sm161548wic.10.2015.02.11.15.49.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 15:49:55 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22c
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263702>

This patch series was inspired by the problem that Git does not
detect changed file content if st_size, st_mtime and st_ctime
are unchanged. This was apparently caused by VSS2Git resetting
mtime to a value in the past. [1]

I believe (or rather hope) that all involved in the discussion
agree that Git cannot reasonably be expected to detect changed
file content if file time(s) are reset on purpose.

However, some users have expressed concerns that 'same size and
mtime' [2] may theoretically happen by chance in daily operation.

This patch series adopts POSIX 2013 'struct timespec' file times
to make this practically impossible, at least on NTFS with 100ns
file time resolution.

Cheers,
Karsten

[1] https://github.com/msysgit/git/issues/312
[2] Note that st_ctime of a file never changes on Windows, as it
    means 'creation time' rather than 'change status time'.

Karsten Blees (3):
  Win32: make FILETIME conversion functions public
  Win32: replace MSVCRT's fstat() with a Win32-based implementation
  Win32: implement nanosecond-precision file times

 compat/mingw.c   | 56 +++++++++++++++++++++++++-------------------------------
 compat/mingw.h   | 55 +++++++++++++++++++++++++++++++++++++++++++++----------
 config.mak.uname |  4 ++--
 3 files changed, 72 insertions(+), 43 deletions(-)

-- 
2.3.0.3.ge7778af

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
