From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [NOT_A_PATCH] A naive attempt to cross-build
 Linux->mingw64 Git
Date: Mon, 21 Apr 2014 18:59:10 -0500
Message-ID: <5355b0ce562b8_6c39e772f0cb@nysa.notmuch>
References: <535569e92cbcc_32c48493101f@nysa.notmuch>
 <1398118479-7731-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marat Radchenko <marat@slonopotamus.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Sebastian Schuberth <sschuberth@gmail.com>, 
 Heiko Voigt <hvoigt@hvoigt.net>, 
 git@vger.kernel.org, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>, 
 Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBDBJVMGGZYNBBPPG22NAKGQE4MJWNEQ@googlegroups.com Tue Apr 22 02:09:37 2014
Return-path: <msysgit+bncBDBJVMGGZYNBBPPG22NAKGQE4MJWNEQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f183.google.com ([209.85.223.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBPPG22NAKGQE4MJWNEQ@googlegroups.com>)
	id 1WcOHH-0006pF-1J
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 02:09:35 +0200
Received: by mail-ie0-f183.google.com with SMTP id as1sf1283632iec.20
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Apr 2014 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=R1aK0Hd8SKE8ZHdCIzzdhoEF4t9mOfSLn6Op97mtA9E=;
        b=mhK3RhO9T8WZm8qxmWUN+VGxDBNsWbykBWG4tQysxkAGazDslD34MsvwfFnMK0aWlP
         59Ai8KrPs4HS/lE54Pi4MW+s5kXZ4xB1P8lYJGhGmrR/B6H4ZArASVEd6Nn4Ad6w01VJ
         J1ohaoIZW6ua5Vfot/QG/wVXIMWlQWDZq2/RiwR+8KXa6teN1E3pPepNOL2+D9IYe186
         xbbEfCReG/cTAN/Jhp5Tst3I/v3n1KiScNv1NPqA6JZonztXfbJ2flcuFOoF3vmpc1Cn
         XaeZk1w2an5k5Z+AM8XLi52cj26WFZQxAoe1pT/nltg+oDRZCgzJBMsmRLjTiXjMDbaC
         jHxQ==
X-Received: by 10.140.108.132 with SMTP id j4mr356064qgf.1.1398125374020;
        Mon, 21 Apr 2014 17:09:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.89.136 with SMTP id v8ls2658439qgd.13.gmail; Mon, 21 Apr
 2014 17:09:33 -0700 (PDT)
X-Received: by 10.58.210.2 with SMTP id mq2mr19553461vec.3.1398125373407;
        Mon, 21 Apr 2014 17:09:33 -0700 (PDT)
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com [2607:f8b0:4003:c01::22f])
        by gmr-mx.google.com with ESMTPS id u5si2583333ige.1.2014.04.21.17.09.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 17:09:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4003:c01::22f as permitted sender) client-ip=2607:f8b0:4003:c01::22f;
Received: by mail-ob0-x22f.google.com with SMTP id wp4so4943108obc.20
        for <msysgit@googlegroups.com>; Mon, 21 Apr 2014 17:09:33 -0700 (PDT)
X-Received: by 10.182.120.5 with SMTP id ky5mr29223518obb.11.1398125373052;
        Mon, 21 Apr 2014 17:09:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ii8sm73290507obb.11.2014.04.21.17.09.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 17:09:32 -0700 (PDT)
In-Reply-To: <1398118479-7731-1-git-send-email-marat@slonopotamus.org>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4003:c01::22f as permitted sender) smtp.mail=felipe.contreras@gmail.com;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246679>

Marat Radchenko wrote:
> config.mak.uname: provide a way to explicitely request MinGW build.
> This is required to perform Linux->MinGW crosscompilation.
> ---
> 
> > Personally I don't see why ideally I shouldn't be able to build upstream Git
> > for Windows with mingw without leaving my Linux system.
> 
> One day you might be able, but as of today...
> 
> 1. Obtain x86_64-w64-mingw32 compiler for your *nix distro
>  * [Gentoo] emerge crossdev && crossdev -t x86_64-w64-mingw32
>  * [Debian/Ubuntu] apt-get install mingw-w64

Note that I didn't say 64-bit. Baby steps, first the tried-and-true 32-bit compiler.

> 2. Apply patch from this email to Git sources (git/git or msysgit/git - doesn't matter)

Funny I came with almost exactly the same patch.

> 3. `make CC=x86_64-w64-mingw32-gcc MINGW=1`

I did:

% make CC=i486-mingw32-gcc NO_OPENSSL=1 NO_GETTEXT=1

But ideally it should be:

% make CROSS_COMPILE=i486-mingw32-

(or whatever the name of the suite)

> 4. Observe errors [1]

I see those errors with a 64-bit compiler, but not with the old 32-bit one.

> I would be happy to find out I'm doing something wrong -- Johannes says building
> mingw64 Git is dirt-easy.

I get the same error. I've been cross-compiling since basically all my
professional life, so I don't think you are doing something wrong, it just
doesn't work.

-- 
Felipe Contreras

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
