X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Document git-runstatus
Date: Sun, 19 Nov 2006 19:13:08 +0100
Message-ID: <20061119181307.GY7201@pasky.or.cz>
References: <455F1595.9020009@lsrfire.ath.cx> <20061118092644.a9f15669.seanlkml@sympatico.ca> <20061118143511.GM7201@pasky.or.cz> <455F210B.8000107@lsrfire.ath.cx> <BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE> <455F4F06.3090902@gmail.com> <BAYC1-PASMTP06DE3E6CFF9E49C2BF16C7AEEF0@CEZ.ICE> <455F60EA.2080009@gmail.com> <20061118150431.81076072.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 18:13:26 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061118150431.81076072.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31847>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlrAI-0006Ee-7r for gcvg-git@gmane.org; Sun, 19 Nov
 2006 19:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932693AbWKSSNL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 13:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbWKSSNK
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 13:13:10 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28806 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932693AbWKSSNJ (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 13:13:09 -0500
Received: (qmail 9913 invoked by uid 2001); 19 Nov 2006 19:13:08 +0100
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 09:04:31PM CET, Sean wrote:
> On Sat, 18 Nov 2006 11:37:14 -0800
> A Large Angry SCM <gitzilla@gmail.com> wrote:
> 
> > I disagree. If a command is install on a system, it's man 
> > pages/documentation should also be installed.
> 
> Well this isn't a huge issue.  One point you made though that struck
> a chord is that many of the commands should probably not be in
> section 1.

The trouble is that there's no other good place where to put them. But
perhaps we can get away with putting them to section 3? After all, Perl
installs documentation for its modules to section 3 as well.

> > I'm also not convinced that there are a "large number of commands [...] 
> > that should only ever be accessed as plumbing". I am convinced, however, 
> > that there are a number of relatively low level commands with poor user 
> > interfaces that are useful on their own.
> 
> Is there really a reason for a git user to access these from the
> command line rather than a script:
> 
> commit-tree, diff-files, diff-index, diff-tree, for-each-ref,
> hash-object, http-fetch, http-push, index-pack, local-fetch,
> merge-base, merge-index, merge-octopus, merge-one-file, merge-ours,
> merge-recur, merge-recursive, merge-recursive-old, merge-resolve,
> merge-stupid, merge-tree, receive-pack, runstatus, ssh-fetch, ssh-pull,
> ssh-push, ssh-upload, symbolic-ref, unpack-file, unpack-objects,
> update-ref, upload-archive, upload-pack, upload-tar, write-tree
> 
> Not a complete list, and maybe i overlooked something in there
> that is needed from the command line, but for the most part 
> these could be installed somewhere other than the users path.

There certainly are reasons, but the situations where it is needed is
sufficiently rare; I think that's a reason good enough, when doing
something exotic like recovery of a corrupted repository it's ok to have
to do something slightly special to execute a lowlevel command.

It has been proposed for a long time that we put the "pure plumbing"
commands to /usr/libexec/git/ or somewhere there (some say /usr/libexec/
is obsolete), and I think it would be a great move.  Note that nowadays
the transition needs to be done carefully because of backwards
compatibility.


BTW, I've finally found a fine example of situation parallel to Git:
TeX!  There are the core TeX commands (plumbing) and plain TeX (basic
porcelain) on top of that as well as a bunch of other macro sets (other
porcelains). Now I need to dig out The TeXbook from wherever I've put it
to see how did Knuth deal with it, documentation-wise.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
