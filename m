From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] import-tars: Allow per-tar author and commit message.
Date: Mon, 24 Aug 2009 19:07:09 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908241659380.16576@perkele.intern.softwolves.pp.se>
References: <20090823203640.B195D189B12@perkele> <4A91B8BB.1030906@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>, Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:07:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfd0t-0001CF-Jg
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 19:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZHXRHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZHXRHL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 13:07:11 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51548 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752426AbZHXRHK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 13:07:10 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW00KAX4VYRV60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 24 Aug 2009 19:07:10 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW001YY4VY3O20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 24 Aug 2009 19:07:10 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.24.165417
Received: by perkele (Postfix, from userid 501)	id D1B482FC20; Mon,
 24 Aug 2009 19:07:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id CDEFD2FBF0; Mon, 24 Aug 2009 19:07:09 +0200 (CEST)
In-reply-to: <4A91B8BB.1030906@vilain.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126944>

Nanako Shiraishi:

> Instead of requiring the user to have millions of separate files, how 
> about reading a single metainfo file that may look like this?

The advantage of having one (or more) files per tarball is that I can use 
the shell's tab completion to make sure I spell the name of the archive 
correctly. And that it makes it a lot easier to parse.


Sam Vilain:

> Also I wonder if there isn't a nicer interface for users.  Why not allow
> the file to specify From:, Committer: etc as header lines

Good idea. My initial patch was simple, just using the .msg file to add a 
message. Then I needed to have a different author for one commit, so I added 
the .author file. Then came the changes that are in the current import-tars 
that separates author and committer, hence the .committer file. Somewhere 
along there it became a bit too complex.

Parsing the .msg file for (optional) committer and author info is probably 
better. I'll update the patch.

-- 
\\// Peter - http://www.softwolves.pp.se/
