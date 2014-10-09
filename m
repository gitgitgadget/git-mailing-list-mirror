From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 14/14] MINGW: config.mak.uname: auto-detect
 MinGW build from compiler
Date: Thu, 9 Oct 2014 12:48:49 +0400
Message-ID: <20141009084848.GA18125@seldon>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
 <1412791267-13356-15-git-send-email-marat@slonopotamus.org>
 <xmqqoatm8irn.fsf@gitster.dls.corp.google.com>
 <20141009050318.GA17479@seldon>
 <xmqqzjd57l32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	marat@slonopotamus.org
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCE7TAPITACRB5UX3GQQKGQEX4YG7WQ@googlegroups.com Thu Oct 09 10:48:58 2014
Return-path: <msysgit+bncBCE7TAPITACRB5UX3GQQKGQEX4YG7WQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB5UX3GQQKGQEX4YG7WQ@googlegroups.com>)
	id 1Xc9P6-0000Ox-Ub
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 10:48:57 +0200
Received: by mail-wg0-f56.google.com with SMTP id y10sf67961wgg.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 01:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=ybIPpreoWDGZGa2dhpWkss6U2A04l4PNj0RLybWFBlo=;
        b=adD3hkIGg8KVtgWE6D+o6+vEpd6qAFQxxYcaUdaY/WB/g4SqY9eAuCfrxXDEgdpl5j
         PuM3nbkPdXBY/s8IhMtUKElA0KeyVYGxgcVDrJEFJa7ocEnGxDN/woBoqyUZe+Fn7qhP
         Hvb9yagYUJ5n/ckBiIXiHYFBHy0wNQ+7g5Mirw37vfubggCQ0lS/E5L2IIFX7MfjTqJ+
         Zlmw0kX2BD/iDEM48AmhlLR/kUoVG6L9qMXxtc52uRac65qP1CFMKDoPFMA8crNnpptv
         XSU2X3gLIil7dhVWzl3RxniXQKXNdNVOVepMZLqdKOsE6ArMJ5kwfhD0K04cy9Jl7PaE
         dEYQ==
X-Received: by 10.152.43.4 with SMTP id s4mr24lal.42.1412844536459;
        Thu, 09 Oct 2014 01:48:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.198.201 with SMTP id je9ls148156lac.92.gmail; Thu, 09 Oct
 2014 01:48:54 -0700 (PDT)
X-Received: by 10.112.140.199 with SMTP id ri7mr163424lbb.17.1412844534319;
        Thu, 09 Oct 2014 01:48:54 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id ed3si1028727wib.1.2014.10.09.01.48.54
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 01:48:54 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Xc9Oz-0004lS-1h; Thu, 09 Oct 2014 12:48:49 +0400
In-Reply-To: <xmqqzjd57l32.fsf@gitster.dls.corp.google.com>
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

On Thu, Oct 09, 2014 at 12:34:25AM -0700, Junio C Hamano wrote:
> No, and I do not quite see why you even need to look at -dumbmachine
> output when your goal is to make this command line
> 
> >> 	$ make uname_O=MINGW uname_S=MINGW
> 
> work sensibly.  Wouldn't it be more like a series of
> 
> 	ifndef uname_O
>         uname_O := $(shell uname -o)
> 	endif
> 
> or something like that?

I don't want to tell `make` my system name several times. It should be
possible to infer system type from CC.

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
