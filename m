From: Karsten Blees <karsten.blees@gmail.com>
Subject: [RFC/PATCH v4 0/3] add performance tracing facility
Date: Tue, 20 May 2014 21:11:06 +0200
Message-ID: <537BA8CA.6070800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBSWR52NQKGQEKNIBMCA@googlegroups.com Tue May 20 21:11:09 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBSWR52NQKGQEKNIBMCA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f59.google.com ([209.85.215.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBSWR52NQKGQEKNIBMCA@googlegroups.com>)
	id 1WmpRL-0007pr-8A
	for gcvm-msysgit@m.gmane.org; Tue, 20 May 2014 21:11:07 +0200
Received: by mail-la0-f59.google.com with SMTP id ec20sf111439lab.14
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 May 2014 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=EBed5DXE5ZFJytQ273+XI5kQKP0bwePY3FyGlqLyHJQ=;
        b=mu1ajp5a0IkMkpQ7osE+5q5dM0QbM1Z1pGJHKwO9enn62CHjMoupiOZDpvkqsvcfdm
         /AAoEhD2DVmCM3+XjiPzw4f/2Z4KmsSB0LJMOOMTpws4j9bkj28A2jbRR1IV0t29WrTa
         0cdXLNgYh7lSlYkOSm59OQDCb2b9i275HdwpLessEwICvoXO2Zg/Ddk0IbeejAaKEhq1
         hZCN0Qr4kxrVaxERXnbC439E4mWFW6F71Y50FbQ9uVHV/1y9P0tooQHKNjyUw1PZcthw
         w9YySwrQ6LZWQRyVOh45y51VLg4Jbuy6GeXWTnvUqGHYQwNp5MkGZ0mQspC/yJJ5xal/
         yZaQ==
X-Received: by 10.152.9.194 with SMTP id c2mr38623lab.20.1400613067063;
        Tue, 20 May 2014 12:11:07 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.199.8 with SMTP id jg8ls79693lac.5.gmail; Tue, 20 May 2014
 12:11:05 -0700 (PDT)
X-Received: by 10.152.203.226 with SMTP id kt2mr3693923lac.2.1400613065817;
        Tue, 20 May 2014 12:11:05 -0700 (PDT)
Received: from mail-ee0-x232.google.com (mail-ee0-x232.google.com [2a00:1450:4013:c00::232])
        by gmr-mx.google.com with ESMTPS id g42si975066eev.1.2014.05.20.12.11.05
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:11:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::232 as permitted sender) client-ip=2a00:1450:4013:c00::232;
Received: by mail-ee0-f50.google.com with SMTP id e51so908716eek.9
        for <msysgit@googlegroups.com>; Tue, 20 May 2014 12:11:05 -0700 (PDT)
X-Received: by 10.14.184.68 with SMTP id r44mr6083457eem.116.1400613065736;
        Tue, 20 May 2014 12:11:05 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v47sm5926540eel.22.2014.05.20.12.11.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:11:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::232
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249730>

This is the POSIX port of the patches I typically use to track down msysgit
performance issues (thus v4, the latest windows-only version is here [1]).
Sebastian and Dscho thought this might be useful in core git, so here it is.

[1] https://github.com/msysgit/git/pull/46

Karsten Blees (3):
  add high resolution timer function to debug performance issues
  add trace_performance facility to debug performance issues
  add command performance tracing to debug scripted commands

 Makefile         |   7 +++
 cache.h          |  20 ++++++++
 config.mak.uname |   1 +
 git.c            |   2 +
 trace.c          | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 174 insertions(+)

-- 
1.9.2.msysgit.0.493.g47a82c3

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
