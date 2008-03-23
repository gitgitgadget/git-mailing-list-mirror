From: Steffen Prohaska <prohaska@zib.de>
Subject: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Sun, 23 Mar 2008 10:31:36 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803230943500.7541@cougar>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site>
Reply-To: prohaska@zib.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, prohaska@zib.de, tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 23 10:31:38 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.174])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdMYC-0001F9-OH
	for gcvm-msysgit@m.gmane.org; Sun, 23 Mar 2008 10:31:37 +0100
Received: by py-out-1314.google.com with SMTP id u10so4249893pyb.2
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=0Ep2urCdNrdgcBpqt7y6fx0wAwjQgowCPpxlJnBSUVg=;
        b=R5avZAVMUmKqPW6NyGNsAJ6CBsBd62u5BjrhynWjDSrYxyn7sQkb/nNIhcrVRBVT8NrOvOO31pV3cLx3Acs35LMfuNY8t+tz6Ke2ErnVVgZdMxTamJy4gC5niBIhtSXEgBOR267FS4lTcwhXMEWskzj0t8MPXJEuBQuQuP8VXjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=zIQFfN7nhZ6HhxUF1XD1IXYRP4XRtZ9VqL+W3I/0dmsM7LF9Ya42lHrvp4zeRXmIs5sdyIEWNuNMlCg8EBYsUHFtRtYLyD+hyx5NKPRL2h1/prkFAqbb8yBoOSnOQo0LzssFOS5bNIwLxBoVowuKcG0ntd9ZYQkASGJrE3pD0bk=
Received: by 10.150.152.17 with SMTP id z17mr483657ybd.15.1206264656462;
        Sun, 23 Mar 2008 02:30:56 -0700 (PDT)
Received: by 10.44.74.68 with SMTP id w68gr1992hsa.0;
	Sun, 23 Mar 2008 02:30:56 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.43.2 with SMTP id v2mr6223742pyj.3.1206264655889; Sun, 23 Mar 2008 02:30:55 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id x46si7328361pyg.2.2008.03.23.02.30.55; Sun, 23 Mar 2008 02:30:55 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2N9Uqnq011384; Sun, 23 Mar 2008 10:30:52 +0100 (CET)
Received: from cougar (brln-4db97827.pool.einsundeins.de [77.185.120.39]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2N9Uiir006027 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Sun, 23 Mar 2008 10:30:47 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0803230310500.4353@racer.site>
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77872>


On Sun, 23 Mar 2008, Johannes Schindelin wrote:

> On Sat, 22 Mar 2008, Junio C Hamano wrote:
> 
> > 
> > Steffen Prohaska <prohaska@zib.de> writes:
> > 
> > >> I suppose autocrlf enabled by default could be useful for new 
> > >> repositories, but not for working with existing repositories.
> > >
> > > We changed the global default to a sane setting for cross-platform 
> > > projects to avoid such problems in the future.  This means that from 
> > > now on git will take care that any repository newly created will have 
> > > sane line endings (LF in the repository; and CRLF in the work tree if 
> > > checked out on Windows respectively LF if checked out on Unix).
> > 
> > I've always wondered why you guys used /etc/gitconfig instead of setting 
> > it in the templates (or a patch to git-init).
> > 
> > I was against the idea of /etc/gitconfig from the very beginning (even 
> > before msysgit existed) in git.git itself, but this is a very good 
> > example why /etc/gitconfig is a bad idea.  It affects _existing_ setups.
> > 
> > How about fixing msys port so that it sets the configuration when the 
> > user initializes a _new_ repository, without breaking repositories the 
> > user has been happily using?
> 
> Makes sense.

Hmm.  I am not convinced.

Setting autocrlf for every repository limits the user's options to
override the default.  Currently we provide a global default and the
user can either override globally for all his repositories or on
a per-repository basis.  Hence, users can decide that they want autocrlf
to never happen and can easily set this in ~/.gitconfig.  If we stored
autocrlf in every newly created repository, the user would need to
override our default again and again for every new repository.

Maybe what we want is to conserve the setup that exists when a new
repository is created.  Changing autocrlf later is tricky because the
work tree's line endings depend on the settings during checkout.
Therefore, it makes sense to preserve the value of autocrlf that exists
during the first checkout.  In this regards autocrlf is different from,
for example, author because author can be easily changed later without
requiring any conversion of existing files in the work tree.

Patch follows.

Unfortunately the proposed change won't change the fact that existing
msysgit setups still break.  I still do not see an easy way to avoid
this.

            Steffen
