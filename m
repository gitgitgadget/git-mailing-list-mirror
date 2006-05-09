From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 23:07:52 -0400
Message-ID: <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	<BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 05:32:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdIxZ-0000Fr-VU
	for gcvg-git@gmane.org; Tue, 09 May 2006 05:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWEIDcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 23:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWEIDcS
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 23:32:18 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:48790 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751356AbWEIDcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 23:32:17 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 8 May 2006 20:32:17 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 52771644C28;
	Mon,  8 May 2006 23:12:58 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060508230752.43118643.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 May 2006 03:32:17.0462 (UTC) FILETIME=[2BE7B560:01C67319]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 8 May 2006 20:08:41 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 8 May 2006, sean wrote:
> > 
> > What's the advantage of section quotation marks over just allowing these
> > characters in regular section names?  To be specific, what is wrong with:
> > 
> >    [jc/show-branch-dense]
> 
> This would _suck_
> 
> What if you have a branch called "core"? Not all all unlikely. 
> 
> Think about what a section like
> 
> 	[core]
> 
> really means.


Yeah, but the part of my message you didn't quote made it quite clear i know
about this problem, what i would really propose is:

[core]
 ...
[branch.core]
 ...
[remote.core]
 ...

etc...
 
> Plus I really want to not be case sensitive by default. Case sensitivity 
> really is _not_ normal for this kind of config file syntax.

But it's not just the config file, it's also how it ends up being used
on the command line..  you have to admit silent differences between
these two command lines is _not_ desirable:

    $ git repo-config "Branch".url  
    $ git repo-config Branch.url

That can't be something you want to see either.

Sean
