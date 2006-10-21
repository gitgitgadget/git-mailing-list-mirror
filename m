From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 10:38:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610211035170.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
 <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
 <46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com> <45373E27.3050209@op5.se>
 <vpqwt6wsmb5.fsf@ecrins.imag.fr> <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
 <45379A02.1010105@utoronto.ca> <72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com>
 <45384B0F.4040901@utoronto.ca> <20061021123027.GB29843@artax.karlin.mff.cuni.cz>
 <ehd5u7$c5g$1@sea.gmane.org> <453A513B.1070006@utoronto.ca>
 <Pine.LNX.4.64.0610211007320.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 19:39:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbKoI-0004dx-2F
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 19:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993114AbWJURi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 13:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993118AbWJURi6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 13:38:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2993114AbWJURi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 13:38:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9LHcpaX031617
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 Oct 2006 10:38:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9LHco7o028836;
	Sat, 21 Oct 2006 10:38:50 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <Pine.LNX.4.64.0610211007320.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29642>



On Sat, 21 Oct 2006, Linus Torvalds wrote:
> 
> 	# Tell people we want to work with ".git-1"
> 	export GIT_DIR=.git-1

Actually, I think Jakub's approach is better: you'd be better off doing 
this as

	alias git-1="git --git-dir=.git-1"
	alias git-2="git --git-dir=.git-2"

and now you should be able to just do

	git-1 diff

(or any other git command) and

	git-2 diff

and can happily share the same directory and mix git commands without 
changing an environment variable all the time.

That would still be insane, but it wouldn't likely be _quite_ as confusing 
(or error-prone in case you forgot to switch the variable).

			Linus

PS. I'd still _not_ suggest doing this. It should _work_, but I mean - 
really..
