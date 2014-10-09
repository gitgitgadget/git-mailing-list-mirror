From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH 14/14] MINGW: config.mak.uname: auto-detect
 MinGW build from compiler
Date: Thu, 9 Oct 2014 12:18:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410091213440.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-15-git-send-email-marat@slonopotamus.org> <xmqqoatm8irn.fsf@gitster.dls.corp.google.com> <20141009050318.GA17479@seldon> <xmqqzjd57l32.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1410090936381.990@s15462909.onlinehome-server.info> <CAPc5daUo+Fw2Oh3LK+0HJCmtVjicYk62qiQ2v8h8pitYHAZL3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, marat@slonopotamus.org
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBJOC3GQQKGQEVRDDQFI@googlegroups.com Thu Oct 09 12:19:19 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBJOC3GQQKGQEVRDDQFI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJOC3GQQKGQEVRDDQFI@googlegroups.com>)
	id 1XcAoX-0004RK-HK
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 12:19:17 +0200
Received: by mail-lb0-f190.google.com with SMTP id l4sf83747lbv.17
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=0/ou7fYSNXoc8FSW8gyVvtrxLUUh7IwSwCtdTaZ2yWw=;
        b=sWDXe4KLCXiyIn0faKY091vePW361B6HxreF2HxNvMBZuwcy5ESJMs+zAU8ANRS4ax
         T/EQfze1Zs2OLyc9zgELLayp/LdykhWRnV3c4U6PArdVoguuiZcjDdqinko5qZvmRuaf
         xuMNv9Q4jzEJOfDbxzmGN5hJQMnMIpFrpcpcvHMAt41ciiUAK6EKpunpz2ZUXVny4ISV
         nG3GaWmpp5K0rNkNH6+3ToknBZOTu7m+xVSbOZfohn3frCzIp2Dg3w5gkvu6cqRcZt/Z
         sOgZF9suVaL3pAq416lC8oEFeLaxxStQic+RdkjkzYk+CPeEKEEzq6we0rs7/9zpLrLJ
         UmEw==
X-Received: by 10.180.107.2 with SMTP id gy2mr20937wib.3.1412849957354;
        Thu, 09 Oct 2014 03:19:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.198.103 with SMTP id jb7ls238978wic.25.gmail; Thu, 09 Oct
 2014 03:19:16 -0700 (PDT)
X-Received: by 10.180.82.74 with SMTP id g10mr575753wiy.0.1412849956752;
        Thu, 09 Oct 2014 03:19:16 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id us10si404844lbc.1.2014.10.09.03.19.16
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 03:19:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MH0eg-1XOPRR3IjS-00Dkfw;
 Thu, 09 Oct 2014 12:18:51 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAPc5daUo+Fw2Oh3LK+0HJCmtVjicYk62qiQ2v8h8pitYHAZL3w@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:F4h7eVTddaUlA5H7h+Gz59xpCLjnpaY6WRNChzfSbMJqEgwCZy0
 Xs0STbp/O3zKSomWxeWM60cSFnboaNvEvUb8CRlLm66xENRu7rBwMyoysAPvWDN3fs4AX15
 nFArWetnijlHp0T1grJPa1GY9L+0a3av9RiAuHNjKzctpFFd7Pqc36tcPk8JRGiXQttTDAg
 px2pjLdDzsvTHV/ZbV0ZQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
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

> Isn't the primary reason we use colon-assign to avoid running the same
> $(shell) over and over again every time $(uname_?) gets referenced? How
> would it work with ?= ???

I was under the impression that ?= would only define the variable once,
the next time ?= would be encountered, no assignment (and actually, no
evaluation) would take place because the variable already has a value?

According to

	https://www.gnu.org/software/make/manual/make.html#index-_003f_003d

	FOO ?= bar

	is exactly equivalent to this (see The origin Function):

	ifeq ($(origin FOO), undefined)
	  FOO = bar
	endif

> Pardon misspellings and grammos, typed on a tablet.

No worries. But you really should use your tablet for reading books after
midnight instead of doing work... ;-)

Ciao,
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
