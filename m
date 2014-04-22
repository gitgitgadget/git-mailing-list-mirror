From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [NOT_A_PATCH] A naive attempt to cross-build
 Linux->mingw64 Git
Date: Tue, 22 Apr 2014 11:08:45 -0500
Message-ID: <5356940d5ef3a_3e5aed73088d@nysa.notmuch>
References: <535569e92cbcc_32c48493101f@nysa.notmuch>
 <1398118479-7731-1-git-send-email-marat@slonopotamus.org>
 <5355b0ce562b8_6c39e772f0cb@nysa.notmuch>
 <5355b2807a10c_1d5ab792ecfd@nysa.notmuch>
 <20140422133616.GA5079@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Sebastian Schuberth <sschuberth@gmail.com>, 
 Heiko Voigt <hvoigt@hvoigt.net>, 
 git@vger.kernel.org, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>, 
 Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBDBJVMGGZYNBB7FM3KNAKGQEVAUIV7A@googlegroups.com Tue Apr 22 18:19:10 2014
Return-path: <msysgit+bncBDBJVMGGZYNBB7FM3KNAKGQEVAUIV7A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f56.google.com ([209.85.216.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBB7FM3KNAKGQEVAUIV7A@googlegroups.com>)
	id 1WcdPZ-00039v-S7
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 18:19:10 +0200
Received: by mail-qa0-f56.google.com with SMTP id j7sf1545223qaq.11
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Apr 2014 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=EJnIEDejcLrbgY5buYJfiZAU01FzmcunAh+Y6w+90F0=;
        b=cOiMDHoDEdal1Y0dxORnrMTdgjJlbLTKxII9kGCABtlP5nvsgYyrLXsOMAH5DptdVf
         7yg6N0eol39gE4QrrsudnXrR7mkX5d0muXOYe445RoYeC0TQPC+FhVaeFauhEB42IBB6
         M6PCQt7utF9YzCjpIKtVaIkd78W6N8S/9x2JhAOLaXOj8XIJgxnS9+rZB7j+esxi7FlC
         wOJdaTxwNemmZhgVPspDUsGCo8aqe/HkNQpExynFMwI4aO386KkMFycxXL/yKxYDcycI
         Q18kR0cRqRkfQNdokSTYRxGR5thfx4+r6/jLUAzW8d5GwoPYrpkQZIB426OUy8lzdNX+
         WdlQ==
X-Received: by 10.182.44.233 with SMTP id h9mr189obm.41.1398183548844;
        Tue, 22 Apr 2014 09:19:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.74.227 with SMTP id x3ls55989obv.75.gmail; Tue, 22 Apr
 2014 09:19:08 -0700 (PDT)
X-Received: by 10.183.11.102 with SMTP id eh6mr3992459obd.37.1398183548276;
        Tue, 22 Apr 2014 09:19:08 -0700 (PDT)
Received: from mail-oa0-x230.google.com (mail-oa0-x230.google.com [2607:f8b0:4003:c02::230])
        by gmr-mx.google.com with ESMTPS id h6si3199292iga.0.2014.04.22.09.19.08
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 09:19:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4003:c02::230 as permitted sender) client-ip=2607:f8b0:4003:c02::230;
Received: by mail-oa0-x230.google.com with SMTP id m1so5894335oag.35
        for <msysgit@googlegroups.com>; Tue, 22 Apr 2014 09:19:08 -0700 (PDT)
X-Received: by 10.60.132.75 with SMTP id os11mr1991408oeb.70.1398183548114;
        Tue, 22 Apr 2014 09:19:08 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm10610537obb.8.2014.04.22.09.19.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 09:19:07 -0700 (PDT)
In-Reply-To: <20140422133616.GA5079@seldon>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4003:c02::230 as permitted sender) smtp.mail=felipe.contreras@gmail.com;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246746>

Marat Radchenko wrote:
> On Mon, Apr 21, 2014 at 07:06:24PM -0500, Felipe Contreras wrote:
> > I managed to fix all the errors, some apply to newer mingw, regardless of 32 or
> > 64, others are specific to 64-bit. It's all hacky and I haven't checked if it
> > runs, but at least it compiles (mostly).
> 
> Do you plan to evolve it into something mergeable?

I might, but that would requiere a lot of effort to investigate the changes in
mingw, and I'm not sure if there's enough interest on this.

After fixing all the issues so that we can cross-compile, I would like to see a
real effort to move away from shell and perl scripts, so that we not only could
run the important commands, but properly test Git without bash, otherwise I
feel Windows will always be a second class citizen.

> P.S. besides CC/LD, I also had to define AR and fix `windres` executable name in `config.mak.uname`.

That's why we should have a CROSS_COMPILE variable which is standard in other projects.

This is what the Linux kernel has:

  AS		= $(CROSS_COMPILE)as
  LD		= $(CROSS_COMPILE)ld
  CC		= $(CROSS_COMPILE)gcc
  AR		= $(CROSS_COMPILE)ar
  NM		= $(CROSS_COMPILE)nm
  STRIP		= $(CROSS_COMPILE)strip
  OBJCOPY	= $(CROSS_COMPILE)objcopy
  OBJDUMP	= $(CROSS_COMPILE)objdump

I had patches for this, but I gave them up =/

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
