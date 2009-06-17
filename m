From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Improving git-svn documentation
Date: Wed, 17 Jun 2009 18:04:04 -0400
Message-ID: <4A396854.1090008@xiplink.com>
References: <20090617201851.GA6123@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH3Ey-0008TF-AA
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 00:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbZFQWEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 18:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbZFQWEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 18:04:09 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:46640 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbZFQWEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 18:04:08 -0400
Received: from relay4.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay4.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 6D7C710CBF3C
	for <git@vger.kernel.org>; Wed, 17 Jun 2009 18:04:11 -0400 (EDT)
Received: by relay4.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D98F810CBE64;
	Wed, 17 Jun 2009 18:04:07 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <20090617201851.GA6123@nan92-1-81-57-214-146.fbx.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121778>

I can't comment on the wisdom of your plan, but I do have a hankering to hack that git-svn.perl (to support multiple "branches" paths -- see http://marc.info/?l=git&m=124484360104600&w=2).

As I've quickly gotten lost in two attempts at figuring out how the script supports its --branches option, I applaud any effort to make this thing more approachable.  Thanks, and good luck!  (I'll need it!)

		M.


Yann Dirson wrote:
> While diving into the git-svn code, I realized that many things could
> be done to make it more documented/understundable.  I need to get more
> understanding of it, so I'd like to improve this state of things.  But
> first, I'd like to be sure there is a consensus on what is a good idea
> to do, since that could easily turn up into a lot of textual change.
> 
> - (on the user doc side of things) some options appear not to be
>   documented (I spotted --parent for 'clone' and --revision for
>   'dcommit').  But looking at where to document them, I found it not
>   always easy, since some options are documented together with the
>   command they modify, some others in the "options" section (even when
>   they are documented as applying to a single command, like --shared
>   or --stdin).  This IMHO leads to confusion for the user looking for
>   information, as well as to the reviewer trying to check that nothing
>   was forgotten.  I would rather make that only very commons are
>   described in a common "options" section, and that all commands using
>   them explicitely say so in their descriptions (with xref).
> 
> - (on the code side of things) git-svn.perl weights more than 5500
>   lines, most classes functions and methods severely lack
>   documentation, and some extensively-used variable names are so short
>   they make the code harder to grasp
> 
>   Eg. $gs to refer to an instance of the Git::SVN class, which I would
>   suggest to change to something like $gsrepo, while at the same time
>   renaming Git::SVN to eg. Git::SVN::Repository - which would make it
>   much easier for a newcomer to grasp what this is supposed to
>   represent - supposing, that is, that my understunding of this part
>   is accurate enough, which it is probably not after spending many
>   hours in there :)
> 
>   As to the size of the file, it seems natural to me to split the
>   classes into their own files.  That would still let git-svn.perl and
>   the Git::SVN class to be 1500-lines tall, the largest others
>   achieving around 500 lines.  That should be much more manageable
>   pieces, and would require some refactoring wrt a couple of global
>   variables used throughout the script; which, incidentally, could
>   make it much easier to simultanously look at several git-svn
>   repositories (for my work on mapping externals to submodules), and
>   to allow reusing the existing code, eg. as a git-vcs backend.
> 
> How are you people feeling about this rough plans ?
> 
