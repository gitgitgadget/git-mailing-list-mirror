X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Bash completion Issue?
Date: Sat, 4 Nov 2006 13:41:20 -0500
Message-ID: <20061104184120.GB2311@spearce.org>
References: <200611041236.59989.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 18:41:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611041236.59989.alan@chandlerfamily.org.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30933>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgQSN-00049J-E9 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 19:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965599AbWKDSlY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 13:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965600AbWKDSlY
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 13:41:24 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42976 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965599AbWKDSlX
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 13:41:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgQSA-0004uU-M5; Sat, 04 Nov 2006 13:41:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1727920E491; Sat,  4 Nov 2006 13:41:20 -0500 (EST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> When I type a normal command on the bash command line (say emacs) followed by 
> the partial directory name the completion completes the directory and then 
> adds a slash.  If I type a git command (say git update-index) with the same 
> partial directory name it completes the directory, but then adds a space.  I 
> have to backspace, manually add the slash, before continuing with the next 
> directory or filename.

Hmm.  I just tried 'git update-index' and it completed here for
me as you want it to (this is with the current stock Git bash
completion support).

However we do some funny things when completing into trees.  E.g. the
completion support for 'git ls-tree man:man<tab>' may seem a little
strange but it works well for my fingers.  I've never really had
any problem with it.

I think the only way we differ from normal bash completion is we
sometimes don't add a space after fully completing a path name.
Usually the user has to type the space in by hand.
 
> In debian, there seems to be a directory /etc/bash_completion.d with files for 
> each of the packages, and the debian git packages have entries in there.  So 
> I assume they are derived from the completion work mentioned on this list.

What completion script is it?  The one that is now shipped as part
of Git has a header of the following, and resides in git.git as
contrib/completion/git-completion.bash:

	#
	# bash completion support for core Git.
	#
	# Copyright (C) 2006 Shawn Pearce
	# Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
	#

> What seems strange to me is that nobody else has mentioned this before now.

Maybe because you have a different completion script?

-- 
