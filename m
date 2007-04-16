From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Mon, 16 Apr 2007 09:18:13 +0300
Message-ID: <20070416061813.GD23255@mellanox.co.il>
References: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
	<20070416055111.GC23255@mellanox.co.il>
	<7vodlox3fx.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKXk-0007P7-Nn
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbXDPGSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXDPGSN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:18:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:53329 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbXDPGSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:18:11 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1032210uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 23:18:09 -0700 (PDT)
Received: by 10.66.218.15 with SMTP id q15mr36689ugg.1176704289511;
        Sun, 15 Apr 2007 23:18:09 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id l33sm6123553ugc.2007.04.15.23.18.08;
        Sun, 15 Apr 2007 23:18:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vodlox3fx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44588>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] display the subject of the commit just made
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > Display the subject of the commit just made.
> >
> > Useful e.g. to figure out what I did from screen history,
> > or to make sure subject line is short enough and makes sense
> > on its own.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>
> >
> > ---
> >
> >> Quoting Junio C Hamano <junkio@cox.net>:
> >> Close but no cigar.  You broke it for a merge commit, I think.
> >> 
> >> Perhaps
> >> 
> >> 	pretty="format:Created${initial_commit:+ initial} commit %h: %s%n"
> >> 	git-diff-tree --always --shortstart --summary --root --pretty="$pretty" HEAD
> >
> > OK, thanks fo rpointing this out.
> > But why the extra %n at the end?
> 
> Because I *got* *rid* *of* "echo".

Oh.
But, this seems to stick an extra newline before the shortstart summary,
instead of at the end. No?

 ./git-commit.sh --amend
Created commit 63cfb8c: test more

 1 files changed, 1 insertions(+), 1 deletions(-)

while in my version

 ./git-commit.sh --amend
Created commit 63cfb8c: test more
 1 files changed, 1 insertions(+), 1 deletions(-)

so I think we are stuck with echo.


-- 
MST
