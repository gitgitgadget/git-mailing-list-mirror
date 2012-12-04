From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw_rmdir: do not prompt for retry when non-empty
Date: Tue, 4 Dec 2012 17:35:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1212041728210.31987@s15462909.onlinehome-server.info>
References: <1354617713-7436-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBOWM7CCQKGQEZT3NYEA@googlegroups.com Tue Dec 04 17:35:21 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBOWM7CCQKGQEZT3NYEA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBOWM7CCQKGQEZT3NYEA@googlegroups.com>)
	id 1TfvSp-0006xQ-LX
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 17:35:19 +0100
Received: by mail-ee0-f58.google.com with SMTP id e49sf1672214eek.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 08:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=BkuWLj36l60GEtTvOJHJxwTNozkFwOz72hz1VonjzzY=;
        b=zZJmX425hcf6OTapLYD5uy82YV2oLoltvRjoejcKXrmNSEo31E9+GROL/bBR5VrW5z
         6nF8umuM3W7PxPSevyVrGBSlFoIvHqBBxtROH96zsjLXLaumMnRHsX1SjEQ86gZp19N7
         3Kmw7olNYU2T/dYOSg6eEFViWHl7CS0Jbpg7oLm6zVY5jVGPJhe4/n2oUuSN24xyZevq
         mVZrCOhPey3JTYggXdOW5LiGSMIv3LjdhJqcmiOHWdEW5kDK62okW+ZZoLFcLHN2J9DI
         aQuhXLJQRGrQbuwbRS 
Received: by 10.180.105.167 with SMTP id gn7mr628276wib.3.1354638907836;
        Tue, 04 Dec 2012 08:35:07 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.100.133 with SMTP id ey5ls370444wib.32.gmail; Tue, 04 Dec
 2012 08:35:06 -0800 (PST)
Received: by 10.14.173.136 with SMTP id v8mr15044890eel.2.1354638906481;
        Tue, 04 Dec 2012 08:35:06 -0800 (PST)
Received: by 10.14.173.136 with SMTP id v8mr15044889eel.2.1354638906471;
        Tue, 04 Dec 2012 08:35:06 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.23])
        by gmr-mx.google.com with SMTP id z44si550454een.0.2012.12.04.08.35.06;
        Tue, 04 Dec 2012 08:35:06 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted sender) client-ip=213.165.64.23;
Received: (qmail invoked by alias); 04 Dec 2012 16:35:06 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp039) with SMTP; 04 Dec 2012 17:35:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZM4Y34cbZC1aN2XXjWU6h1cFOaAoCytI8rcLbfy
	5/nYx76mS8q1gX
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1354617713-7436-1-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211087>

Hi kusma,

On Tue, 4 Dec 2012, Erik Faye-Lund wrote:

> in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"),
> a check was added to prevent us from retrying to delete a directory
> that is both in use and non-empty.
> 
> However, this logic was slightly flawed; since we didn't return
> immediately, we end up falling out of the retry-loop, but right into
> the prompting loop.
> 
> Fix this by simply returning from the function instead of breaking
> the loop.
> 
> While we're at it, change the second break to a return as well; we
> already know that we won't enter the prompting-loop, beacuse
> is_file_in_use_error(GetLastError()) already evaluated to false.

I usually prefer to break from the loop, to be able to add whatever
cleanup code we might need in the future after the loop.

So does this fix the problem for you?

-- snipsnap --
diff --git a/compat/mingw.c b/compat/mingw.c
index 04af3dc..504495a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -259,7 +259,8 @@ int mingw_rmdir(const char *pathname)
 		return -1;
 
 	while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
-		if (!is_file_in_use_error(GetLastError()))
+		errno = err_win_to_posix(GetLastError());
+		if (errno != EACCESS)
 			break;
 		if (!is_dir_empty(wpathname)) {
 			errno = ENOTEMPTY;
@@ -275,7 +276,7 @@ int mingw_rmdir(const char *pathname)
 		Sleep(delay[tries]);
 		tries++;
 	}
-	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
+	while (ret == -1 && errno == EACCESS &&
 	       ask_yes_no_if_possible("Deletion of directory '%s' failed. "
 			"Should I try again?", pathname))
 	       ret = _wrmdir(wpathname);

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
