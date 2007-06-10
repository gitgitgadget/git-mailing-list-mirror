From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Mon, 11 Jun 2007 01:20:16 +0200
Message-ID: <20070610232016.GB5761@steel.home>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWhp-0003qd-RT
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739AbXFJXUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757839AbXFJXUT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:20:19 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:11638 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739AbXFJXUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:20:18 -0400
Received: from tigra.home (Faacf.f.strato-dslnet.de [195.4.170.207])
	by post.webmailer.de (fruni mo13) (RZmta 7.2)
	with ESMTP id A01b43j5AIiROu ; Mon, 11 Jun 2007 01:20:16 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8D543277BD;
	Mon, 11 Jun 2007 01:20:16 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3ACC3D258; Mon, 11 Jun 2007 01:20:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706091854330.4059@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtopI9Dg=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49789>

Johannes Schindelin, Sat, Jun 09, 2007 19:55:10 +0200:
> 
> With the provided script, edit-commit-annotations, you can add
> after-the-fact annotations to commits, which will be shown by
> the log if the config variable core.showannotations is set.
> 
> The annotations are tracked in a new ref, refs/annotations/commits,
> in the same fan-out style as .git/objects/??/*, only that they only
> exist in the object database now.
> 

I like it too. And "notes" _is_ less to type :)

BTW, the annotations are a bit cumbersome to merge, if this
implementation is to stay (and I personally would like it to) we may
have to mention this little inconvenience somewhere.

And can I suggest an interface like the below?

    git notes [[--show] <commit>+] [-d|--delete <commit>+] [-e|--edit <commit>]

With the annotations file being completely removed if it is empty.
