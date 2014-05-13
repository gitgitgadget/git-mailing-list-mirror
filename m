From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] wincred: avoid overwriting configured variables
Date: Tue, 13 May 2014 08:34:36 +0200
Message-ID: <CABPQNSYU5haMzdy2cDn=KF2+j_aFK19Ju+x+LTeex6JqWJMncQ@mail.gmail.com>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com>
 <20140430112724.GA22929@camelia.ucw.cz> <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com>
 <20140513055953.GA28182@camelia.ucw.cz> <20140513060144.GC28182@camelia.ucw.cz>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, Pat Thoyts <patthoyts@users.sourceforge.net>, 
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBDR53PPJ7YHRBJP2Y2NQKGQEXN4FDLI@googlegroups.com Tue May 13 08:35:19 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBJP2Y2NQKGQEXN4FDLI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f184.google.com ([209.85.220.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBJP2Y2NQKGQEXN4FDLI@googlegroups.com>)
	id 1Wk6J4-0006jK-RZ
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 08:35:19 +0200
Received: by mail-vc0-f184.google.com with SMTP id hq16sf1564698vcb.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 May 2014 23:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=LrPpz/+2lhjPnDUeHsFTEoEf9tiDu2Z3TOZKKttKmwE=;
        b=EHSFUqv3O7o+tuW7HQWq+P4Lh/AwA5TyC65IFd4xqKgJ3cGpSgfsFy+IFDlNJrhKwq
         zO/CWAiHt3Ju690WmtLRjwKvGYkQ45L8QukiNBkIDNdBvOIbdpMxtBlrybksBJ0jPVF6
         UUH9gBLemPr2gbwfJt/zXjx55r920ocJQj0R1Yjf4GGrGOhA43QXvMKzVtm3++38xhIw
         cTJ2xDb64xR5Ok3sepy/EmnrnqN0sqmK806e5IRZtitAbLx8pf54d/avroy/GolT+L/K
         7JbxsbsTpRBoyR8uOfaDM7nfMVitMyOex233guAERTcvM0cLsjyqWMPL7PdB+GrqaTs/
         kpCw==
X-Received: by 10.50.92.34 with SMTP id cj2mr305862igb.4.1399962917996;
        Mon, 12 May 2014 23:35:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.25.70 with SMTP id a6ls2597841igg.42.canary; Mon, 12 May
 2014 23:35:17 -0700 (PDT)
X-Received: by 10.66.138.17 with SMTP id qm17mr5663103pab.34.1399962917136;
        Mon, 12 May 2014 23:35:17 -0700 (PDT)
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com [2607:f8b0:4001:c05::234])
        by gmr-mx.google.com with ESMTPS id ng6si654218igb.2.2014.05.12.23.35.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 May 2014 23:35:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::234 as permitted sender) client-ip=2607:f8b0:4001:c05::234;
Received: by mail-ig0-f180.google.com with SMTP id c1so18451igq.7
        for <msysgit@googlegroups.com>; Mon, 12 May 2014 23:35:17 -0700 (PDT)
X-Received: by 10.50.85.37 with SMTP id e5mr51576600igz.43.1399962917014; Mon,
 12 May 2014 23:35:17 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 12 May 2014 23:34:36 -0700 (PDT)
In-Reply-To: <20140513060144.GC28182@camelia.ucw.cz>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::234
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248751>

On Tue, May 13, 2014 at 8:01 AM, Stepan Kasal <kasal@ucw.cz> wrote:
> From: Pat Thoyts <patthoyts@users.sourceforge.net>
> Date: Wed, 24 Oct 2012 00:15:29 +0100
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  contrib/credential/wincred/Makefile | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
> index 39fa5e0..e64cd9a 100644
> --- a/contrib/credential/wincred/Makefile
> +++ b/contrib/credential/wincred/Makefile
> @@ -1,9 +1,5 @@
>  all: git-credential-wincred.exe
>
> -CC = gcc
> -RM = rm -f
> -CFLAGS = -O2 -Wall
> -

Would it be better to set these if not already set, i.e:

-CC = gcc
-RM = rm -f
-CFLAGS = -O2 -Wall
+CC ?= gcc
+RM ?= rm -f
+CFLAGS ?= -O2 -Wall

instead?

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
