From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: #178  parsing of pretty=format:"%an %ad" causes fatal:
 bad revision '%ad'
Date: Fri, 2 May 2014 10:23:58 -0700
Message-ID: <20140502172358.GI9218@google.com>
References: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Dave Bradley <dbradley2@bell.net>
X-From: msysgit+bncBD6LRKOE4AIRBMNJR6NQKGQE5NFLUEQ@googlegroups.com Fri May 02 19:24:03 2014
Return-path: <msysgit+bncBD6LRKOE4AIRBMNJR6NQKGQE5NFLUEQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f183.google.com ([209.85.223.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBMNJR6NQKGQE5NFLUEQ@googlegroups.com>)
	id 1WgHBr-00032Q-1m
	for gcvm-msysgit@m.gmane.org; Fri, 02 May 2014 19:24:03 +0200
Received: by mail-ie0-f183.google.com with SMTP id as1sf1026629iec.10
        for <gcvm-msysgit@m.gmane.org>; Fri, 02 May 2014 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=jjDC1nKaA+SJTzwXKrX7BwyES51BGt43PLmaZPe9ahY=;
        b=XMT20gOCT9zxnWDNRfraS9zMj4iZ7yUq571ZiNdORh9ma57ygDPP0+PCmaD4UBv7Qb
         06pV4+DL5DsqP6SFc68pDsr5wZplN0906zBMPTw9vFmgmwZ2pWavdheu/I3gcJ93/VRA
         apLxNDIdfkKA8lGjvRuMfSzimqBqm9zUi9To0cT2oKawe+spmv8AT/F43WKujyAazKI0
         Sl/IL65BFGghhMi7sgXbbNk35goXvJuA46MzAvcnfNEXJFNyKGazaI8pKLzVnwgSX6rh
         qEhdjt+0a6P8EtoY1ZFwh1w2Y+1VffWi1YX28eBHZrcBX3whDz6wbYqCBpbIY75nbqeB
         lgng==
X-Received: by 10.140.18.194 with SMTP id 60mr26629qgf.36.1399051442136;
        Fri, 02 May 2014 10:24:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.82.42 with SMTP id g39ls1557999qgd.25.gmail; Fri, 02 May
 2014 10:24:01 -0700 (PDT)
X-Received: by 10.58.142.135 with SMTP id rw7mr9108863veb.14.1399051441647;
        Fri, 02 May 2014 10:24:01 -0700 (PDT)
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com [2607:f8b0:4001:c03::235])
        by gmr-mx.google.com with ESMTPS id s1si299700ign.1.2014.05.02.10.24.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 May 2014 10:24:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4001:c03::235 as permitted sender) client-ip=2607:f8b0:4001:c03::235;
Received: by mail-ie0-f181.google.com with SMTP id y20so5129074ier.26
        for <msysgit@googlegroups.com>; Fri, 02 May 2014 10:24:01 -0700 (PDT)
X-Received: by 10.43.94.9 with SMTP id bw9mr16893866icc.19.1399051441546;
        Fri, 02 May 2014 10:24:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id om5sm8479103igb.16.2014.05.02.10.24.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 May 2014 10:24:01 -0700 (PDT)
In-Reply-To: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4001:c03::235
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247947>

(resending with the correct address for the Git for Windows developers.
Sorry for the noise.)
Hi Dave,

Dave Bradley wrote:

> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all --pretty=format:"%an %ad" -- pom.xml
> xxxx xxxx Mon Nov 23 03:09:17 2009 +0000
> xxxx xxxx Mon Nov 23 02:42:24 2009 +0000
>
> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all "--pretty=format:"%an %ad"" -- pom.xml
> fatal: bad revision '%ad'

On Linux, this example gets passed to git as six arguments:

	log
	--all
	--pretty=format:%an
	%ad
	--
	pom.xml

I think the intent was instead to pass five arguments (the third being
'--pretty=format:%an %ad').  That means you shouldn't unquote before
the space, or in other words that the space should be part of a quoted
argument.

On Windows, I believe the argument passing convention is more
complicated.  Programs can inspect the entire command line if they
want to.  But there's still an ambiguity in the command you passed: if
I look at space-separated or double-quoted parts of the command line,
it looks like

	git
	log
	--all
	"--pretty=format:"
	(no space)
	%an
	%ad
	(no space)
	""
	--
	pom.xml

What's the right way to parse this?  How can git tell whether %an %ad
were meant to be separate arguments or not?  In absence of a stronger
convention I suspect the simplest rule is to mimic what a Unix shell
does, where they are separate arguments because the space is not
quoted.

Cc-ing Windows folks in case they have more insight.

Thanks and hope that helps,
Jonathan

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
