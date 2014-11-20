From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC 0/4] Fix the Visual Studio 2008 .sln generator
Date: Thu, 20 Nov 2014 23:37:58 +0000
Message-ID: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Wookey <michaelwookey@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBRXWXGRQKGQERQXTYHQ@googlegroups.com Fri Nov 21 00:37:46 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBRXWXGRQKGQERQXTYHQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBRXWXGRQKGQERQXTYHQ@googlegroups.com>)
	id 1XrbIE-0002Wq-W6
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 00:37:43 +0100
Received: by mail-lb0-f192.google.com with SMTP id 10sf27139lbg.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 20 Nov 2014 15:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:content-type:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=EccZiVoOM0eEyZOw+d/9DRjxKqtj5h9eLXV0brGSPEQ=;
        b=AOHiFPks+Pkfx0vfREFgWREQYQwXyKfSC5VJnW60T5HuMJu3xNelUMY+36HnGUsXLK
         jg/mEc0ws0rvHyMRJIQkXbFw0ba67gsZWMHQGJvL4Le0IjVBsla5VaEG9VcP7tC1n+YJ
         5ujxnKYKVdsqU65VQdD2JJm1TcqoMc59Pqki0Z5AKLYu6lngVnPaPVlwRpa62ecfz80L
         xpLsq4XUottZzHvCFbVunKCFmmQXi24cjFmLU/p8+/R2lVT6XsblTx9jfterV3gsKvJu
         XAS6qLfmW2N+gZYTHaQw7G5wl7bPQRHToG0CghR1W7FFDGQp5hiypBgn21EBhORUkaEl
         XLCQ==
X-Received: by 10.180.104.162 with SMTP id gf2mr144400wib.15.1416526662838;
        Thu, 20 Nov 2014 15:37:42 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.96.99 with SMTP id dr3ls1613697wib.18.canary; Thu, 20 Nov
 2014 15:37:41 -0800 (PST)
X-Received: by 10.180.85.97 with SMTP id g1mr8033484wiz.0.1416526661859;
        Thu, 20 Nov 2014 15:37:41 -0800 (PST)
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net. [62.24.128.242])
        by gmr-mx.google.com with ESMTP id jv2si90840wid.1.2014.11.20.15.37.41
        for <msysgit@googlegroups.com>;
        Thu, 20 Nov 2014 15:37:41 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.242 as permitted sender) client-ip=62.24.128.242;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvoZAPx5blROl3PwPGdsb2JhbABagw0BAVRZgja5HY9+C4dHBAKBCBcBAQEBAQEFAQEBATg7hF8jGIECCgYBE4hYCdRzASuOaoIehFIFlzWJHJkGPTCCSwEBAQ
X-IPAS-Result: AvoZAPx5blROl3PwPGdsb2JhbABagw0BAVRZgja5HY9+C4dHBAKBCBcBAQEBAQEFAQEBATg7hF8jGIECCgYBE4hYCdRzASuOaoIehFIFlzWJHJkGPTCCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,426,1413241200"; 
   d="scan'208";a="651403011"
Received: from host-78-151-115-240.as13285.net (HELO localhost) ([78.151.115.240])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 20 Nov 2014 23:37:41 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.242 as permitted sender) smtp.mail=philipoakley@iee.org
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

Potential Windows developers are likely to be using Visual Studio as
their IDE. The tool stack required for Windows can be tortuous as it
crosses the boundaries between platforms and philosophies. This RFC
seeks to maintain the tools that could assist such developers. In
particular, those tools that generate an initial Visual Studio project
(.sln ) file.

The .sln generator in contrib began to break when internationalisation
introduced an extra -o option. This recently worsened with the addition
of invalidcontinue.obj for 'improved POSIX compatibility'.

I hacked a bit when I first attempted to use the VS IDE and noticed the
i18n issue. I didn't completely solve all my issues because of further
issues with VS2010 Express, so no patches were submitted at the time.

Now, with a fresh copy of VS20008 Express, I see the additional problem
of the addition of the invalidcontinue.obj reference causing the .sln
generation to fail.

Are the patches going in the right direction?
Is the processing of the .obj file in engine.pl sensible?
and the extra care with s/\.o$/.c/ avoiding s/obj/cbj/.
Does it affect the Qmake capability? (I've no idea)
Is the quoting of filenames correct? (my perl foo is cargo cult!)

I've also updated the vcbuild/README to mention Msysgit (which
will be replaced soon by the newer/better Git-for-windows/SDK
(https://github.com/git-for-windows/sdk), but the benefits still
apply.

I've cc'd those who have contributed or patched the engine.pl, or
appear to be interested via a $gmane search, who can hopefully comment.

Obviously, the patches will need squashing together, and the commit
message(s) tidied after inclusion of comments.

Philip Oakley (4):
  Fix i18n -o option in msvc engine.pl
  Properly accept quoted space in filenames
  engine.pl: split the .o and .obj processing
  Improve layout and reference msvc-build script

 compat/vcbuild/README          | 29 +++++++++++++++++++++--------
 contrib/buildsystems/engine.pl | 38 ++++++++++++++++++++++++++++++--------
 2 files changed, 51 insertions(+), 16 deletions(-)

-- 
1.9.4.msysgit.0

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
