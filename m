From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] compat/terminal: support echoing on windows
Date: Mon, 25 Jun 2012 17:06:47 +0200
Message-ID: <CABPQNSYX9vZT0A4v5MMvC=yanNsLu7JMFoH1ZYy=vtaE7mwPpQ@mail.gmail.com>
References: <1340544903-37016-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCw_aH_BBoEg8FG-g@googlegroups.com Mon Jun 25 17:07:29 2012
Return-path: <msysgit+bncCOPdven-DxCw_aH_BBoEg8FG-g@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCw_aH_BBoEg8FG-g@googlegroups.com>)
	id 1SjAsy-0002Vm-Db
	for gcvm-msysgit@m.gmane.org; Mon, 25 Jun 2012 17:07:28 +0200
Received: by mail-qc0-f186.google.com with SMTP id c2sf4508261qcs.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 25 Jun 2012 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=yzpnASFDbrcfIPwQ6o8hmyXDGD3L/HNqkVw2tYYkHvA=;
        b=xaTe4gbdnWqW+VB34PruUYIMT9B8eaeU4QZMjaaARF9i4Yv5MAPdBLG2NdE5TKCp9Y
         SqIuMzEn6/RxJVLDhWR2USLMIQfoqCwLvnKe6X+ZnNIz+jv8ZKjRPYkQgDw0NELYMMgP
         wv3TCNlNWlTuf7YBSx3l7zugMgig/kqIKKly4=
Received: by 10.224.33.6 with SMTP id f6mr240102qad.16.1340636848565;
        Mon, 25 Jun 2012 08:07:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.198.129 with SMTP id eo1ls1709273qab.9.gmail; Mon, 25 Jun
 2012 08:07:27 -0700 (PDT)
Received: by 10.68.223.40 with SMTP id qr8mr13455186pbc.0.1340636847610;
        Mon, 25 Jun 2012 08:07:27 -0700 (PDT)
Received: by 10.68.223.40 with SMTP id qr8mr13455184pbc.0.1340636847600;
        Mon, 25 Jun 2012 08:07:27 -0700 (PDT)
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com [209.85.160.47])
        by gmr-mx.google.com with ESMTPS id iq5si550250pbc.1.2012.06.25.08.07.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 08:07:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.160.47 as permitted sender) client-ip=209.85.160.47;
Received: by mail-pb0-f47.google.com with SMTP id rq2so6672044pbb.20
        for <msysgit@googlegroups.com>; Mon, 25 Jun 2012 08:07:27 -0700 (PDT)
Received: by 10.68.134.201 with SMTP id pm9mr42856851pbb.49.1340636847399;
 Mon, 25 Jun 2012 08:07:27 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Mon, 25 Jun 2012 08:06:47 -0700 (PDT)
In-Reply-To: <1340544903-37016-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.160.47 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200583>

On Sun, Jun 24, 2012 at 3:35 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote=
:
> Without /dev/tty support, git_terminal_prompt simply ignores the
> 'echo'-parameter. On Windows we can do better by clevering up our
> getpass-implementation a bit so it can conditionally echo.
>
> While we're at it, plug a small memory-leak by returning a pointer
> to a static strbuf instead of detaching it. This is the same thing
> the /dev/tty-version of git_terminal_prompt does, and the callee
> doesn't expect to have to free it's memory.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> =A0compat/mingw.c =A0 =A0| 15 ---------------
> =A0compat/mingw.h =A0 =A0| =A02 --
> =A0compat/terminal.c | 20 ++++++++++++++++++++
> =A03 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index afc892d..56ab74c 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1699,21 +1699,6 @@ int link(const char *oldpath, const char *newpath)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -char *getpass(const char *prompt)
> -{
> - =A0 =A0 =A0 struct strbuf buf =3D STRBUF_INIT;
> -
> - =A0 =A0 =A0 fputs(prompt, stderr);
> - =A0 =A0 =A0 for (;;) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 char c =3D _getch();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c =3D=3D '\r' || c =3D=3D '\n')
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(&buf, c);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 fputs("\n", stderr);
> - =A0 =A0 =A0 return strbuf_detach(&buf, NULL);
> -}
> -
> =A0pid_t waitpid(pid_t pid, int *status, int options)
> =A0{
> =A0 =A0 =A0 =A0HANDLE h =3D OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFOR=
MATION,
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 61a6521..5e64a98 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -55,8 +55,6 @@ struct passwd {
> =A0 =A0 =A0 =A0char *pw_dir;
> =A0};
>
> -extern char *getpass(const char *prompt);
> -
> =A0typedef void (__cdecl *sig_handler_t)(int);
> =A0struct sigaction {
> =A0 =A0 =A0 =A0sig_handler_t sa_handler;
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 6d16c8f..53c5166 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -71,6 +71,26 @@ char *git_terminal_prompt(const char *prompt, int echo=
)
> =A0 =A0 =A0 =A0return buf.buf;
> =A0}
>
> +#elif defined(WIN32)
> +
> +char *git_terminal_prompt(const char *prompt, int echo)
> +{
> + =A0 =A0 =A0 static struct strbuf buf =3D STRBUF_INIT;
> +
> + =A0 =A0 =A0 fputs(prompt, stderr);
> + =A0 =A0 =A0 strbuf_reset(&buf);
> + =A0 =A0 =A0 for (;;) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int c =3D _getch();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c =3D=3D '\n' || c =3D=3D '\r')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (echo)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 putc(c, stderr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(&buf, c);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 putc('\n', stderr);
> + =A0 =A0 =A0 return buf.buf;
> +}
> +
> =A0#else
>
> =A0char *git_terminal_prompt(const char *prompt, int echo)
> --
> 1.7.11.1.27.gdae0dbb
>

Turns out, this patch is incorrect; _getch is defined in conio.h,
which is only included in compat/mingw.c and compat/msvc.c.

This patch on top fixes it:

diff --git a/compat/mingw.c b/compat/mingw.c
index 56ab74c..d7d4aea 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,6 +1,5 @@
 #include "../git-compat-util.h"
 #include "win32.h"
-#include <conio.h>
 #include "../strbuf.h"
 #include "../run-command.h"

diff --git a/compat/msvc.c b/compat/msvc.c
index 71843d7..a3a4e0e 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -1,6 +1,5 @@
 #include "../git-compat-util.h"
 #include "win32.h"
-#include <conio.h>
 #include "../strbuf.h"

 #include "mingw.c"
diff --git a/git-compat-util.h b/git-compat-util.h
index 5bd9ad7..fa3e1a9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -88,6 +88,7 @@
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+#include <conio.h>
 #endif

 #include <unistd.h>

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
