From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 14/14] MINGW: config.mak.uname: auto-detect
 MinGW build from compiler
Date: Thu, 9 Oct 2014 09:03:18 +0400
Message-ID: <20141009050318.GA17479@seldon>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
 <1412791267-13356-15-git-send-email-marat@slonopotamus.org>
 <xmqqoatm8irn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	marat@slonopotamus.org
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCE7TAPITACRBIFO3CQQKGQEE4Z2VZQ@googlegroups.com Thu Oct 09 07:03:30 2014
Return-path: <msysgit+bncBCE7TAPITACRBIFO3CQQKGQEE4Z2VZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBIFO3CQQKGQEE4Z2VZQ@googlegroups.com>)
	id 1Xc5sv-0003h9-TO
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 07:03:29 +0200
Received: by mail-la0-f64.google.com with SMTP id mk6sf26949lab.29
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=/uN5Ew+Y/FfwPk26YlmMSkXeG0iDN4N0BxX72bGuA4I=;
        b=hnjB/sPQGzoZ1WFBRyurUT/qwPoPSjGb/X/Nzi2nE2Pa8QXShhX0lxF20VwQpj9yuv
         u/65IEE0JfpUVl5zbaqi0z70acewSk7fFLbp8IZ4SDhyDBsob2krUt36S2a37v7/a9w1
         lje9g1vYQhjEwyRrfWgp6/XimhKR1LELdInRtUCmmDil80QHb+Fx5HGm0WFR1xkG52vD
         XmmDR7jvqPhLHGNyxtonE+nV4C9f7xBARuD2Uw5H5dLq3hhC+H4HNNqQh1ul6uS3Rejl
         0X9ZDw1zgVSAc+qwVyEGgHWuSxoEvq1HbjnFnno6UeLoZ9Ht1HjE4ddTZ10cDyU61xZO
         0+Og==
X-Received: by 10.152.42.137 with SMTP id o9mr50344lal.19.1412831009604;
        Wed, 08 Oct 2014 22:03:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.193 with SMTP id x1ls130951lae.53.gmail; Wed, 08 Oct
 2014 22:03:27 -0700 (PDT)
X-Received: by 10.152.5.137 with SMTP id s9mr1236las.10.1412831007658;
        Wed, 08 Oct 2014 22:03:27 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id rb5si335069lbb.0.2014.10.08.22.03.27
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 22:03:27 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Xc5sk-0004ZG-FK; Thu, 09 Oct 2014 09:03:18 +0400
In-Reply-To: <xmqqoatm8irn.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Content-Disposition: inline

On Wed, Oct 08, 2014 at 12:26:52PM -0700, Junio C Hamano wrote:
> Marat Radchenko <marat@slonopotamus.org> writes:
> 
> > When crosscompiling, one cannot rely on `uname` from host system.
> 
> That may well be true, but is that limited to cross-compiling to
> mingw?   Would it be generally true for any cross compilation,
> wouldn't it?
> 
> What I am wondering is if it is a better solution to make it easier
> to allow somebody who is cross compiling to express "Mr.  Makefile,
> we know better than you and want you to do a MINGW build for us
> without checking with `uname -?` yourself", i.e.
> 
> 	$ make uname_O=MINGW uname_S=MINGW
> 
> which would hopefully allow cross-compilation into other
> environments, not just MINGW.

So, do you really want this patch to be changed from 5-liner into
a full-blow system detection rewrite based on `cc -dumpmachine`
instead of `uname`?

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
