From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 22:53:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601132247530.32562@wbgn013.biozentrum.uni-wuerzburg.de>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
 <7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
 <7v4q48hizr.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
 <7vzmm0eod1.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP01A07DAA61F181E9D9679EAE260@CEZ.ICE>
 <40b2b7d90601130311v78db741dx7c5eaa57ad300850@mail.gmail.com>
 <7v64oo9gc7.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0918AE856AD34E35597CA4AE260@CEZ.ICE>
 <7vy81j6h56.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 22:54:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExWrl-0005Gv-Mc
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 22:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422942AbWAMVxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 16:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422990AbWAMVxq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 16:53:46 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:63141 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1422942AbWAMVxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 16:53:45 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C47BFE6017; Fri, 13 Jan 2006 22:53:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id B5D029AE;
	Fri, 13 Jan 2006 22:53:44 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 96EF39C;
	Fri, 13 Jan 2006 22:53:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8A00514620F; Fri, 13 Jan 2006 22:53:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy81j6h56.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14650>

Hi,

On Fri, 13 Jan 2006, Junio C Hamano wrote:

> sean <seanlkml@sympatico.ca> writes:
> 
> > So do you still agree with that, would you accept a patch?  Or do you have
> > some fundamental reason to think that environment variables are a better
> > way to pass information in this case?
> 
> Fundamental reason of not doing anything is (1) not to make
> unnecessary changes and (1) to avoidi decisions ;-).

You forgot the 3rd (1).

> No objections to --from='John Doe <john.doe@example.com>' by
> itself, other than "You could say GIT_AUTHOR_* before the
> command instead of --from after the command; as long as it is
> not done regularly as an interactive command, the difference
> does not matter".

Well, they are not completely idempotent. If you call

	git commit --form='Me <bla@bla.com>'

it will tell you that you misspelt an option. Try that with

	GIT_AUTOR_NAME='Me without H <dumm@my.com>' git commit


>  - Is --from the right word?  Shouldn't it be --author?
>  - Do we want author date?  If not, why not?
>  - What about committer information?  If not, why not?

These are very valid objections, however. As is: why would you want to do 
that instead of creating an mbox-style file in the first place. 

IIRC there was this strange use case which tried to make a clean git tree 
from several CVS repositories. IMHO it is much easier to cvsimport them, 
and fix everything from within git, which should be relatively easy with 
the nice recursive merge.

My 2 cents,
Dscho
