From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 04 Mar 2007 15:07:43 -0800
Message-ID: <7vd53o4ngg.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703041321290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703041401030.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNznv-0000rB-W8
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 00:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbXCDXHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 18:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbXCDXHp
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 18:07:45 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:65473 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbXCDXHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 18:07:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304230744.DWLF26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Mar 2007 18:07:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Wn7j1W0071kojtg0000000; Sun, 04 Mar 2007 18:07:43 -0500
In-Reply-To: <Pine.LNX.4.64.0703041401030.3953@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 4 Mar 2007 14:26:05 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41387>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 4 Mar 2007, Johannes Schindelin wrote:
>> > 
>> > This is to output logs in the GNU ChangeLog format.
>> 
>> FWIW I am opposed to include that. After letting it sink in, Linus' 
>> remarks convinced me that this format is not as useful as our other log 
>> formats, and for those people who really want it, there is git2cl.
>
> Side note: I would hate to be the person who torpedoes anything that some 
> people actually find useful (my motto: "actually useful is a lot better 
> than clean, but not as useful")
>
> So in that sense, if people actually find GNU changelog format to be 
> useful enough that they want a script for it, I don't think we should 
> relegate it to second-class citizenship just because _we_ don't think it's 
> a wonderful format.

Oh, I certainly would not disagree.

But I do not think encouraging people to script is necessarily
relegating it to second-class citizenship, as it appears there
are rooms for project and language specific heuristics to come
in for summarizing the real log into a variant of GNU changelog
that is most useful for a particular project, I think it makes
sense to implement it as a postprocessing filter to git-log -p
(even "git-log -p -U999", if somebody want to do a language
specific function labels), just like Simon did with his git2cl
to output a particular variant (i.e. the one that lacks the
function names) of GNU changelog to suit his projects' needs.

Given time, Simon's script may be improved and prove to be
flexible enough to accomodate the needs of all (or almost all)
other projects that want to use GNU changelog format.  At that
point, we might even want to include it in contrib/ of git.git,
if enough people are interested in it and if distributing with
the core helps the script gain wider exposure.

> The fact that GNU changelog is then mis-designed to do per-file changelogs 
> etc is more an effect of CVS misfeatures than anything else. But compared 
> to all the other things CVS gets wrong, that's a very small detail ;)

That part I 100% agree ;-).
