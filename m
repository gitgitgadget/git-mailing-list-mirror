From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 11:51:17 -0800
Message-ID: <7vy81j6h56.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
	<7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
	<7vzmm0eod1.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP01A07DAA61F181E9D9679EAE260@CEZ.ICE>
	<40b2b7d90601130311v78db741dx7c5eaa57ad300850@mail.gmail.com>
	<7v64oo9gc7.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0918AE856AD34E35597CA4AE260@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 20:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExUzM-0003Ls-5v
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 20:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422916AbWAMTvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 14:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422907AbWAMTvf
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 14:51:35 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39859 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1422909AbWAMTvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 14:51:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113195023.EFYB15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 14:50:23 -0500
To: sean <seanlkml@sympatico.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14643>

sean <seanlkml@sympatico.ca> writes:

> So do you still agree with that, would you accept a patch?  Or do you have
> some fundamental reason to think that environment variables are a better
> way to pass information in this case?

Fundamental reason of not doing anything is (1) not to make
unnecessary changes and (1) to avoidi decisions ;-).

No objections to --from='John Doe <john.doe@example.com>' by
itself, other than "You could say GIT_AUTHOR_* before the
command instead of --from after the command; as long as it is
not done regularly as an interactive command, the difference
does not matter".  At that point, "making no unneeded changes"
kicks in.  While I do understand that it might be necessary to
commit somebody else's patch occasionally, you have not
convinced me that is not such a rare thing, so until then the
change stays at lower priority.

After I am convinced that it is not so rare and having an easier
and more consistent way (something coming from environment and
other things from command line is inconsistent) would generally
be a good addition, I further need to think about these issues
before taking such a patch, in the context of the "git commit"
command as a whole:

 - Is --from the right word?  Shouldn't it be --author?
 - Do we want author date?  If not, why not?
 - What about committer information?  If not, why not?
