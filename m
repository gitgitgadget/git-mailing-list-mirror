From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 01/16] perl/Makefile: treat a missing PM.stamp as
 if empty
Date: Sun, 19 Jul 2015 21:08:01 +0100
Message-ID: <1437336497-4072-2-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBZMGWCWQKGQE6YO5OFY@googlegroups.com Sun Jul 19 22:07:02 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBZMGWCWQKGQE6YO5OFY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBZMGWCWQKGQE6YO5OFY@googlegroups.com>)
	id 1ZGurW-0002H9-31
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:02 +0200
Received: by laef2 with SMTP id f2sf52635592lae.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=tEaShValo+f2yBY2O/Cw8iQbOMW624vUwV3+bNbwYj8=;
        b=F9fDYSbgRzk9RhSLXNnEYcM0WZijY6T0M7vqaP/QlGo38+Dk+IKSDWQVdTt7fb0XLL
         InJKZdj3y1dIs0PVmv0AF86XdG+D0kgigp4YRgrObJ2ar6DJO0aKtI/Qm+KYOgyzWdIS
         wSNeqRHnsU2dj3KicZSLQXvAgc0f583nWj5Xcpf9U+YbzA14G3H8CQn2hQU+bQ5jULlE
         5IJCgQsV73pXKmoi8XEioHbmr8IYw6AJ5DcXvQkPjpU87DQXaltORE4Jb0uDWsh5i9zW
         t2jLF3nd24+7QZP/CCjFxr5rO84pbHXIoKS2H69XVWmcDmtR22TaygS3gIRPtBVPrjrb
         +Eag==
X-Received: by 10.152.179.195 with SMTP id di3mr372570lac.4.1437336421795;
        Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.234.108 with SMTP id ud12ls700655lac.43.gmail; Sun, 19 Jul
 2015 13:07:00 -0700 (PDT)
X-Received: by 10.152.237.36 with SMTP id uz4mr13181551lac.1.1437336420583;
        Sun, 19 Jul 2015 13:07:00 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.00
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:00 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AjKgCSAqxVPN4GFlxcgkFSVGmBRbogCYF1hXEEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDIJxF8BAQEHIo9vEQFRB4QrBZRShG+JO5Z+gQmDGj0xgQQJFzVyAQEB
X-IPAS-Result: A2AjKgCSAqxVPN4GFlxcgkFSVGmBRbogCYF1hXEEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDIJxF8BAQEHIo9vEQFRB4QrBZRShG+JO5Z+gQmDGj0xgQQJFzVyAQEB
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118924"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:01 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274276>

'make clean', or a 'git clean -dfx' will delete the PM stamp file,
so it cannot be a direct target in such clean conditions, resulting
in an error.

Normally the PM.stamp is recreated by the git/Makefile, except when
a dry-run is requested, for example, as used in the msysgit msvc-build
script which implements the compat/vcbuild/README using
contrib/buildsystems. The script msvc-build is introduced later in this
series.

Protect the PM.stamp target when the PM.stamp file does not exist,
allowing a Git 'Makefile -n' to succeed on a clean repo.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
This is development of the original "[PATCH 4/17] Makefile: a dry-run
can error out if no perl. Document the issue" 2015-06-25,
(http://marc.info/?l=git&m=143519054716960&w=2), which simply documented
the issue and then used NO_PERL to avoid the problem. See follow on
email thread for some discussion.
---
 perl/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/perl/Makefile b/perl/Makefile
index 15d96fc..5b86aac 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -22,7 +22,9 @@ clean:
 	$(RM) $(makfile).old
 	$(RM) PM.stamp
 
+ifneq (,$(wildcard PM.stamp))
 $(makfile): PM.stamp
+endif
 
 ifdef NO_PERL_MAKEMAKER
 instdir_SQ = $(subst ','\'',$(prefix)/lib)
-- 
2.4.2.windows.1.5.gd32afb6

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
