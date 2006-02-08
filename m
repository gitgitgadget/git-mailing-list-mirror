From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the
 revision and person that created each line in the file.
Date: Wed, 8 Feb 2006 17:05:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602081702280.19744@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11394103753694-git-send-email-ryan@michonline.com>
 <20060208150950.GA29346@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 17:11:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6roo-0006l4-JR
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 17:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbWBHQFS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 11:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWBHQFS
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 11:05:18 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30371 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965169AbWBHQFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 11:05:16 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A72531411F4; Wed,  8 Feb 2006 17:05:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 98CC71268;
	Wed,  8 Feb 2006 17:05:15 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 44870146870; Wed,  8 Feb 2006 17:05:15 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20060208150950.GA29346@ebar091.ebar.dtu.dk>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15739>

Hi,

On Wed, 8 Feb 2006, Peter Eriksen wrote:

> On Wed, Feb 08, 2006 at 09:52:55AM -0500, Ryan Anderson wrote:
> > Signed-off-by: Ryan Anderson <ryan@michonline.com>
> > 
> > ---
> > 
> > I think this version is mostly ready to go.
> > 
> > Junio, the post you pointed me at was very helpful (once I got around to
> > listening to it), but the code it links to is missing - if that's a
> > better partial implementation than this, can you ressurrect it
> > somewhere?  I'd be happy to reintegrate it together.
> 
> Does it depends on some ealier patch?  I get this:
> 
> git]$ git-annotate diff-delta.c
> Undefined subroutine &main::all_lines_claimed called at
> /home/peter/bin/git-annotate line 124.

Just add a function like

-- snip --
sub all_lines_claimed {
        return ($leftover_lines == 0);
}
-- snap --

and you're done.

However, it does not yet do the correct thing: it does not show the root 
commit. For example, if you do "git annotate git-am.sh" it should show 
"d1c5f2a4" for the first lines, not "a1451104" as it does.

Ciao,
Dscho
