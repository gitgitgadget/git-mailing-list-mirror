From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: make --dense the default (and introduce "--sparse")
Date: Tue, 25 Oct 2005 15:29:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510251525540.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510251459070.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 00:31:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUXIo-00080q-F2
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 00:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVJYW3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 18:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVJYW3v
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 18:29:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932444AbVJYW3v (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 18:29:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9PMTiFC023632
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Oct 2005 15:29:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9PMTgUo001218;
	Tue, 25 Oct 2005 15:29:43 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510251459070.10477@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10627>



On Tue, 25 Oct 2005, Linus Torvalds wrote:
> 
> This actually does three things:
> 
>  - make "--dense" the default for git-rev-list. Since dense is a no-op if 
>    no filenames are given, this doesn't actually change any historical 
>    behaviour, but it's logically the right default (if we want to prune on 
>    filenames, do it fully. The sparse "merge-only" thing may be useful, 
>    but it's not what you'd normally expect)
> 
>  - make "git-rev-parse" show the default revision control before it shows 
>    any pathnames.

Btw, if it wasn't obvious, this has some subtle (and very nice) side 
effects.

For example, try this:

	git log git-fetch.sh

and notice how "git log" automagically became able to give per-file logs. 
With _zero_ changes to git-log.sh itself ;)

And same old rev-confusion-avoidance:

	git log -- gitk

to make clear that you want to get the log of "gitk the file", rather than 
"gitk the branch".

Magic. 

		Linus
