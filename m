From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH 14/14] MINGW: config.mak.uname: auto-detect
 MinGW build from compiler
Date: Thu, 9 Oct 2014 17:49:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410091747090.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-15-git-send-email-marat@slonopotamus.org> <xmqqoatm8irn.fsf@gitster.dls.corp.google.com> <20141009050318.GA17479@seldon> <xmqqzjd57l32.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1410090936381.990@s15462909.onlinehome-server.info> <CAPc5daUo+Fw2Oh3LK+0HJCmtVjicYk62qiQ2v8h8pitYHAZL3w@mail.gmail.com> <alpine.DEB.1.00.1410091213440.990@s15462909.onlinehome-server.info>
 <CAPc5daWdkz16RnORjtjw+oP3PO043Y57wAMm3TxC6L5GBJz8uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, marat@slonopotamus.org
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBKO53KQQKGQE5NM4HOI@googlegroups.com Thu Oct 09 17:50:03 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBKO53KQQKGQE5NM4HOI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f192.google.com ([209.85.220.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBKO53KQQKGQE5NM4HOI@googlegroups.com>)
	id 1XcFyd-00082K-6G
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 17:50:03 +0200
Received: by mail-vc0-f192.google.com with SMTP id hq11sf445133vcb.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Tgu+SdpcABgBPn6YbJ7+GYCvgzRc2Mv3Km0kbdX9e9A=;
        b=q6rCmfBIhqJmDJUva4thUyWpvtDK+cppBtCf/sNhdlHzceMPusXkcb4EJAaCeT7xOB
         cXEiTZwt/DHa5pDdyavnv60VrspTYT7/jbFwO5HeTIj41V82Kjxxa0LNn/QT5GrX6AJp
         zPod6EysB0+r0k7ppQOQzC65ljwhGQt+2U+CXmh9WamQfE2meusv5xfTs82PQjbhBtSe
         X55t9UlNguXk5ACaSZFjKZFP9APVtqnw9nBtOjXDyg78eYAqIrhAZhaGFiDmdJGRiu6F
         uDQdWMtsv2hRdVafpd0NafhLxf05jeM9AbbaNaZet44nuybdgmISCvfviPc+8S1N1dJN
         5YtQ==
X-Received: by 10.50.13.4 with SMTP id d4mr55468igc.16.1412869802413;
        Thu, 09 Oct 2014 08:50:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.17.71 with SMTP id m7ls926823igd.5.gmail; Thu, 09 Oct 2014
 08:50:01 -0700 (PDT)
X-Received: by 10.70.128.129 with SMTP id no1mr3508pdb.2.1412869801481;
        Thu, 09 Oct 2014 08:50:01 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id hz7si1738169igb.2.2014.10.09.08.50.01
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 08:50:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LqzIJ-1Y6eql0smR-00eaui;
 Thu, 09 Oct 2014 17:49:56 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAPc5daWdkz16RnORjtjw+oP3PO043Y57wAMm3TxC6L5GBJz8uQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:4TkcceFyquyfW70CrHA+3IQhTJUq5aKA/0sMSYVdZTAvhb+4L+b
 BVsPOlaanEPpAvJyt/6j7wYZwr5DNeSOL2TXv0cBCo9M/cEAUqxPBFGc6EJ3OfrLjRpoLoi
 otGv4GfhDjLrkeFwyaH0s1vxUCW98XcR710de2uJP9CgZYDrvX369o4HIWKClRNNzr9JhUy
 1N4BajJZQXco3ZFT0gldg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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

Hi Junio,

On Thu, 9 Oct 2014, Junio C Hamano wrote:

> I didn't mean multiple uses of ?= for the same variable. I meant
> multiple uses of (references to) the variable. I.e. wouldn't FOO and
> BAR behave differently below?
> 
> FOO := $(shell random)
> BAR = $(shell random)
> all::
>    echo $(FOO) and $(BAR)
>    echo twice $(FOO) and $(BAR)

You're correct, of course, my mistake. I just tested with this:

	R ?= $(shell echo $$RANDOM)

	all:
		echo The values of $(R), $(R) and $(R)

and of course a "make" yields three different numbers. Sorry for missing
that.

So what we should do is something like

	ifeq ($(uname_S),)
		uname_S := $(shell uname -s)
	endif

even if repeating that pattern is kind of ugly...

Thanks for correcting my mistake,
Dscho

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
