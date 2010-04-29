From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fix checkout of large files to network shares 
	under Windows XP
Date: Thu, 29 Apr 2010 22:01:18 +0200
Message-ID: <4BD9E58E.8020406@lsrfire.ath.cx>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx> <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com> <4BCE134C.8090802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org, 
 msysgit@googlegroups.com, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Johannes Sixt <j.sixt@viscovery.net>, Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncCJLGuZmNHhCTnejeBBoEHbnNxQ@googlegroups.com Fri Apr 30 00:56:45 2010
connect(): No such file or directory
Return-path: <msysgit+bncCJLGuZmNHhCTnejeBBoEHbnNxQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gy0-f186.google.com ([209.85.160.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCJLGuZmNHhCTnejeBBoEHbnNxQ@googlegroups.com>)
	id 1O7cey-0001dW-0w
	for gcvm-msysgit@m.gmane.org; Fri, 30 Apr 2010 00:56:44 +0200
Received: by gyf3 with SMTP id 3sf14141151gyf.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 29 Apr 2010 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:received:message-id:date:from
         :user-agent:mime-version:cc:subject:references:in-reply-to
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=QNQPMRYc1TN/kkdGAqsccmfRIoKp4Z/tfiR3uIwn68k=;
        b=KeVsDoOcHQ+OJFOt2av8V7saFuzHg7z+AfrYzFVUz3R8+PWSERI6a6Qpart2ZeA21h
         pG61VAey+ua4JnTC2RtAJJ/SiVm6e0hkO6POPppV+APuzrNkeQ5cuCVLsygN/n/SPbLu
         irqBwMZHnA+by8YfvvEwg0LtJjw3RUsXjINGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:cc:subject:references:in-reply-to
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=XHHNwV+K+4kZ9FUy6F7+DzdSNvLU1lC0f4uTuLBH4JSjETHkw+Vsh/BhZj612swcBo
         FrKMfhNkAexKcQFjbLx2UUjDUBVn51KQ9/IvrmOB7uZBNMs3PhY2VNfq6qRivf9Z8Xkq
         pBBfWrQtCZrNqM5931Hv6rduaGG8j2mpLX3YU=
Received: by 10.150.172.42 with SMTP id u42mr246661ybe.60.1272581779922;
        Thu, 29 Apr 2010 15:56:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.150.19.36 with SMTP id 36ls24604147ybs.3.p; Thu, 29 Apr 2010 
	15:56:19 -0700 (PDT)
Received: by 10.150.183.7 with SMTP id g7mr889069ybf.17.1272581778910;
        Thu, 29 Apr 2010 15:56:18 -0700 (PDT)
Received: by 10.204.48.214 with SMTP id s22mr543962bkf.26.1272571290829;
        Thu, 29 Apr 2010 13:01:30 -0700 (PDT)
Received: by 10.204.48.214 with SMTP id s22mr543961bkf.26.1272571290719;
        Thu, 29 Apr 2010 13:01:30 -0700 (PDT)
Received: from india601.server4you.de (india601.server4you.de [85.25.151.105])
        by gmr-mx.google.com with ESMTP id 17si176262bwz.7.2010.04.29.13.01.30;
        Thu, 29 Apr 2010 13:01:30 -0700 (PDT)
Received-SPF: neutral (google.com: 85.25.151.105 is neither permitted nor denied by best guess record for domain of rene.scharfe@lsrfire.ath.cx) client-ip=85.25.151.105;
Received: from [10.0.1.100] (p57B7CE59.dip.t-dialin.net [87.183.206.89])
	by india601.server4you.de (Postfix) with ESMTPSA id 7C62B2F806D;
	Thu, 29 Apr 2010 22:01:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BCE134C.8090802@lsrfire.ath.cx>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	85.25.151.105 is neither permitted nor denied by best guess record for domain 
	of rene.scharfe@lsrfire.ath.cx) smtp.mail=rene.scharfe@lsrfire.ath.cx
X-Original-Sender: rene.scharfe@lsrfire.ath.cx
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146028>

Am 20.04.2010 22:49, schrieb René Scharfe:
> Am 20.04.2010 14:42, schrieb Sebastian Schuberth:
>> I've updated work/issue-409 in 4msysgit.git accordingly.
> 
> This patch doesn't help in the test case I cobbled together quickly.
> It's a Windows XP SP3 client on VMWare mapping a file share exported by
> a Netapps filer, over a VPN.  It's very slow, and I admit that it's a
> weird setup.  I wouldn't actually use it that way, but couldn't find
> another file share momentarily.
> 
> I can check out a 1MB file, but checking out a 32MB file fails.  I've
> added a fprintf() to the loop and I can see that it's halving the size
> and retries, as intended, until it eventually hits zero.
> 
> The file is created using the correct file size (32MB), though.The first
> failed write(2) call needs to be undone somehow before we can try again,
> it seems.  Do we have to seek back or truncate the file?
> 
> Replacing the body of mingw_write() with the following line allows me to
> check out the 32MB file, by the way:
> 
> 	return write(fd, buf, min(count, 1024 * 1024));

OK, I've been searching the web looking for documentation that explains
the issue, but haven't found any watertight evidence.

With Process Monitor [1], I found out that local write() calls are
translated to WriteFile() calls with a maximum size of 64KB on Windows XP
and 256KB on Vista.  Writes to a network drive are translated to
WriteFile() calls without applying a size cap.

In a forum discussion [2], someone explained that unbuffered writes using
WriteFile() have certain size limits, depending on the processor:

	x86:  67,076,096
	X64:  33,525,760
	IA64: 67,051,520

This post is cited by an MS employee in the comment section of the online
documentation for WriteFile() [3].

A Knowledge Base article [4] documents a size limit of 67,076,095 for
fwrite() to a file on a network drive.  fwrite() calls translate to
WriteFile() calls, too.  The reason for this is said to be an OS problem,
but no OS versions are named at all in this article.

Please note that the size limit of fwrite() is suspiciously close to the
one for an unbuffered WriteFile().

In my test setup, write() calls to a network drive fail with a size
parameter of 32MB, while with 33,525,760 bytes they succeed.

Based on these two observations, I suspect that there's a connection
between writes to a network drive and unbuffered writes.  Perhaps writes
over the net are passed to the NIC driver in one piece which is locked
into RAM?

The connection is a bit weak (it would be good to have someone comment on
this who actually knows something about this topic and doesn't have to
guesswork through a bunch of websites), but I think it's enough to create
a patch.  Based on the numbers above, I think 31MB is a good size to
simply cap writes.

When we learn that other systems need a lower limit still, we can easily
reduce our cap, without affecting local performance.

It would be nice to reach chris.gcode, who originally reported this
problem [5], and ask him to test.  I couldn't find an email address on
that webpage, though.  His proposed patch there also used an upper limit
slightly below 32MB, but tried to compensate for capping by looping until
the full requested size was written.  That's not really needed.

René


[1] http://technet.microsoft.com/en-us/sysinternals/bb896645.aspx
[2] http://social.msdn.microsoft.com/Forums/en-US/vcgeneral/thread/fef1c9b5-fd92-4ada-8de5-44c2eb30b516
[3] http://msdn.microsoft.com/en-us/library/aa365747(VS.85).aspx#5
[4] http://support.microsoft.com/kb/899149
[5] http://code.google.com/p/msysgit/issues/detail?id=409

-- >8 --
Bigger writes to network drives on Windows XP fail.  Cap them at 31MB to
allow them to succeed.  Callers need to be prepared for write() calls
that do less work than requested anyway.

On local drives, write() calls are translated to WriteFile() calls with
a cap of 64KB on Windows XP and 256KB on Vista.  Thus a cap of 31MB won't
affect the number of WriteFile() calls which do the actual work.  There's
still room for some other version of Windows to use a chunk size of 1MB
without increasing the number of system calls.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 compat/mingw.c |   17 +++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index f90a114..9a8e336 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -140,6 +140,23 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }
 
+#undef write
+ssize_t mingw_write(int fd, const void *buf, size_t count)
+{
+	/*
+	 * While write() calls to a file on a local disk are translated
+	 * into WriteFile() calls with a maximum size of 64KB on Windows
+	 * XP and 256KB on Vista, no such cap is placed on writes to
+	 * files over the network on Windows XP.  Unfortunately, there
+	 * seems to be a limit of 32MB-28KB on X64 and 64MB-32KB on x86;
+	 * bigger writes fail on Windows XP.
+	 * So we cap to a nice 31MB here to avoid write failures over
+	 * the net without changing the number of WriteFile() calls in
+	 * the local case.
+	 */
+	return write(fd, buf, min(count, 31 * 1024 * 1024));
+}
+
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 7c2ab64..0e3e743 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -170,6 +170,9 @@ int link(const char *oldpath, const char *newpath);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
+ssize_t mingw_write(int fd, const void *buf, size_t count);
+#define write mingw_write
+
 FILE *mingw_fopen (const char *filename, const char *otype);
 #define fopen mingw_fopen
 
-- 
1.7.1
