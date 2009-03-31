From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension
 more robust
Date: Wed, 1 Apr 2009 01:59:24 +0200
Message-ID: <200904010159.24764.markus.heidelberg@web.de>
References: <200903300030.03733.markus.heidelberg@web.de> <20090330141510.GW23521@spearce.org> <499F039601E4A981@joe.mail.tiscali.sys> (added by postmaster@tiscali.it)
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, msysgit@googlegroups.com, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Apr 01 02:00:58 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lont2-0000Wp-Td
	for gcvm-msysgit@m.gmane.org; Wed, 01 Apr 2009 02:00:57 +0200
Received: by yw-out-2122.google.com with SMTP id 1so998840ywp.63
        for <gcvm-msysgit@m.gmane.org>; Tue, 31 Mar 2009 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:jabber-id:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:x-sender
         :x-provags-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=CrB2M6q84jNLb2kul9tjZanCNZMn027aAmXR/JUP2n0=;
        b=3UQvFAx+hJEAgrPIvtmU/OOnudYOU0DeczaYk//8VIpRKLcdjm0W82t0DzdWLOupTx
         f9RiQv0MF1oQlP6GNG5j0Dw2EubmwTY/FYO6N0xqfVwZhhx6Gp5nq0vXOdr6hW66gl8a
         hKzJ1I/TRA+mKBz2qTmT/ee/n0YkATCI2rkCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :jabber-id:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:x-provags-id:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=GvyubojgoBzUugyBSxSxeqpk/FkT/IIeyOik4zVcpQNvbsmyiQisZ34bgg1Pu6LVfw
         HLvPWm6+BhoJoKfjyvaREnhEUavXbw2sVu7ywdkReKi9glxH+HIAGOk1hTmDyWk5FjXB
         G5g76XTFkZV3qdL3PAWEvTVuOqsCM+pV7Se9o=
Received: by 10.90.63.6 with SMTP id l6mr1029297aga.12.1238543961180;
        Tue, 31 Mar 2009 16:59:21 -0700 (PDT)
Received: by 10.177.113.42 with SMTP id q42gr4584yqm.0;
	Tue, 31 Mar 2009 16:59:21 -0700 (PDT)
X-Sender: markus.heidelberg@web.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.118.19 with SMTP id q19mr252041agc.5.1238543960185; Tue, 31 Mar 2009 16:59:20 -0700 (PDT)
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234]) by gmr-mx.google.com with ESMTP id 14si703240gxk.7.2009.03.31.16.59.19; Tue, 31 Mar 2009 16:59:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.234 as permitted sender) client-ip=217.72.192.234;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.234 as permitted sender) smtp.mail=markus.heidelberg@web.de
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172]) by fmmailgate03.web.de (Postfix) with ESMTP id 8C467F9CEE0F; Wed,  1 Apr 2009 01:59:19 +0200 (CEST)
Received: from [89.59.106.150] (helo=.) by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256) (WEB.DE 4.110 #277) id 1LonrT-0004go-00; Wed, 01 Apr 2009 01:59:19 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <499F039601E4A981@joe.mail.tiscali.sys>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18xUUKgz7YM4FPitj6TmLv/EFo2/n+xtets+1Yv Q7QH4tr0fq3Wn8EpQLSYp6wkbns6Cy3PKA6M2n8mjNdPlA6F4A krxH532ads2eIaH7mhVQ==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115334>


Giuseppe Bilotta, 31.03.2009:
> On Monday 30 March 2009 16:15, Shawn O. Pearce wrote:
> 
> > Markus Heidelberg <markus.heidelberg@web.de> wrote:
> >> 
> >> But I just noticed, that it will obviously "cd .." forever, if no .git/
> >> was found. Somehow the root directory has to be catched.
> > 
> > Yup.  I'm dropping this patch for now because of this issue, but
> > I'll look at it again if its addressed in another version.  :-)
> 
> I have a couple of pending patches to fix git gui handling of repositories,
> including support for nonstandard repository locations and bare repositories.
> You can find them at
> 
> http://git.oblomov.eu/git
> 
> and specifically
> 
> http://git.oblomov.eu/git/patches/b2e4c32e13df1b7f18e7b4a9f746650471a3122e..a63526bf3238cf25d9a5521f7ee35ed1bd11cb16

I just tried these two patches on Windows (Uhh, Qemu is too slow for
this, I have to setup something else).

> I got distracted by real-life issue and forgot to resend them. I'll try
> to find the time again later on this week. I'm not entirely sure these
> solve Markus' problem though.

Starting git-gui via Explorer "Git GUI Here" is now possible from the
.git/ directory with your patches, but it doesn't show the working tree
status. Also "Explore Working Copy" wants to open the .git directory
then instead of the project directory (I say "want" because of the issue
I just sent a patch out). It seems to be as non-functional as if you run
"git status" inside of .git/

Markus
