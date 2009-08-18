From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/11] Add O_BINARY flag to open flag at mingw.c
Date: Tue, 18 Aug 2009 11:40:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181136420.4680@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171856290.4991@intel-tinevez-2-302> <1976ea660908171902ubf04991x7d6890d4d9accd9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2051557664-1250588436=:4680"
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 11:40:48 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdLBP-0008OR-PZ
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 11:40:48 +0200
Received: by ywh4 with SMTP id 4so5929987ywh.22
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2009 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ZUQ20GlWFMUsrW7NRBjjvirFirzljsXpxmgPBtvj/RM=;
        b=e8A1mNcfMGbWJ1U0jRG2ChmSEb9prYI9JYnAQ1UVbEIZ8zl5xlE/yjyXkpZ+rXH+ce
         ggQkZpww8j3rQhDepqOY6Gr2lXq4gGQxlzlCchkbHBrkaEFIXZuSLzn6FhCz6DXtBZ9j
         qf3gpODsND9Nxu9gWIq9E8gYkQCwe4U3eiBu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=VmLZFyONS+4jHbiItgptKqCGlG6dywWn1J54luaEKvOdXQeKn6XUaqiF0W3bR+dj5h
         IDzeKmc0ijVhW9KdnK8ClkwEOTeB8IB+uOkZpqEiWMex8oUpJIu72H9jY/APqCK1G6Zi
         OYSLUUv/SA8mNK1lPspjQuzBi3wsLG5EcavPE=
Received: by 10.150.173.39 with SMTP id v39mr1536540ybe.9.1250588441669;
        Tue, 18 Aug 2009 02:40:41 -0700 (PDT)
Received: by 10.177.102.22 with SMTP id e22gr6444yqm.0;
	Tue, 18 Aug 2009 02:40:37 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.143.15 with SMTP id s15mr151000fau.8.1250588436618; Tue, 18 Aug 2009 02:40:36 -0700 (PDT)
Received: by 10.223.143.15 with SMTP id s15mr150999fau.8.1250588436597; Tue, 18 Aug 2009 02:40:36 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si742369bwz.2.2009.08.18.02.40.36; Tue, 18 Aug 2009 02:40:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 18 Aug 2009 09:40:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp066) with SMTP; 18 Aug 2009 11:40:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hw0MrAwkhLzV3gEUkRrU2oxRrt+/7fSNLUZCM6D vgOITBnt9qOpu3
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1976ea660908171902ubf04991x7d6890d4d9accd9a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126363>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2051557664-1250588436=:4680
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> > How about this instead?
> >
> >        mingw.c: Use the O_BINARY flag to open files
> >
> >        On Windows, non-text files must be opened using the O_BINARY flag.
> >        MinGW does this for us automatically, but Microsoft Visual C++
> >        does not.
> >
> >        Also, Johannes said that this would be a nice cleanup.
> >
> 
> Okay, Do you need me change commit comments to resubmit patch?

How about updating your branch at tgit.git with the new commit 
messages first?  (Use rebase -i...)

> > BTW what about fopen()?
> 
> I never found problem at fopen, I will double check it.

Well, it is better to be sure, not by testing it, but rather by inspecting 
the code paths.  Is there any way Git wants to open a binary file with 
fopen()?  If so, it cannot use the modes "r" and "w" there, but must use 
"rb" and "wb".

It gets doubly complicated if there are code paths that _want_ to open 
text files (such as .git/config), which are user-writable, so they could 
(in theory) contain CR/LF line endings.

Ciao,
Dscho

>
> >
> > Patch is obviously good.
> >
> > Ciao,
> > Dscho
> >
>

P.S.: please remove such quoted text, it is totally uninteresting in this 
context (you do not reply to it, either). 
--8323329-2051557664-1250588436=:4680--
