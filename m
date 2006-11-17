X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.18.2
Date: Fri, 17 Nov 2006 02:58:06 +0100
Message-ID: <20061117015806.GE7201@pasky.or.cz>
References: <20061117004930.GC7201@pasky.or.cz> <46a038f90611161744q6c535218n5b815ef1fc5228b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 01:59:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <46a038f90611161744q6c535218n5b815ef1fc5228b6@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31661>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkszd-0007o6-4s for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424908AbWKQB6K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424909AbWKQB6J
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:58:09 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3025 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1424908AbWKQB6I (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:58:08 -0500
Received: (qmail 9300 invoked by uid 2001); 17 Nov 2006 02:58:06 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 02:44:47AM CET, Martin Langhoff wrote:
> On 11/17/06, Petr Baudis <pasky@suse.cz> wrote:
> 
> >* cg-log does not follow history across renames anymore; it never really
> >  actually worked and was instead causing problems and random error
> >  messages. There needs to be git-core support for this funcionality,
> >  hacking it with a perl filter is bad design, so I'm not going to fix
> >  the filter (but I'd take patches if someone else did ;).
> 
> I was looking at the follow renames Perl script last week (hey, I was
> bored!) and while I could tell it didn't work, I did get the feeling
> that it wasn't an impossible task, at least for the 'explicit paths'
> case.

Yes. It's fixable, but IIRC the current script is fairly broken; I'd
have to look at it again to remember why, but I think I wrote it to a
comment inside there somewhere.

It would be cool if someone would fix it, of course.

> For the 'whole tree' and subpath cases it _is_ tricky, and would
> be faster to solve within git, but not impossible.
> 
> And even then, I am tempted to think that git log could provide some
> better hints than it does today when walking the whole tree or
> subpaths, so that cg-log or gitk can ask [if relevant] for selective
> rename info.
> 
> I am curious as to why you see it as bad design...

Exactly because this information is really something core Git should
provide, and I'm feeling bad for not pushing this kind of functionality
to core Git and instead going at lengths implementing it in Cogito.

The conceptually proper solution I'd imagine is

	http://news.gmane.org/find-root.php?message_id=<20060515203700.GB4497@c165.ib.student.liu.se>

(I didn't look at the actual code though), currently in limbo and
waiting for someone to fight for it. :-)

OTOH doing it in a filter simulates greatly how powerful the Git's
pipeline architecture is, and has certain undeniable cool factor
associated. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
