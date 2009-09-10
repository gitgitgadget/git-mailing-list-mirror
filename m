From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Thu, 10 Sep 2009 12:18:31 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909101206540.28290@iabervon.org>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:18:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlmM2-00070N-Qg
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 18:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZIJQSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 12:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZIJQS3
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 12:18:29 -0400
Received: from iabervon.org ([66.92.72.58]:52251 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbZIJQS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 12:18:29 -0400
Received: (qmail 12037 invoked by uid 1000); 10 Sep 2009 16:18:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Sep 2009 16:18:31 -0000
In-Reply-To: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128125>

On Mon, 7 Sep 2009, Junio C Hamano wrote:

> * db/vcs-helper (2009-09-03) 16 commits
>  - Allow helpers to report in "list" command that the ref is unchanged
>  - Add support for "import" helper command
>  - Add a config option for remotes to specify a foreign vcs
>  - Allow programs to not depend on remotes having urls
>  - Allow fetch to modify refs
>  - Use a function to determine whether a remote is valid
>  - Use a clearer style to issue commands to remote helpers
>  - Make the "traditionally-supported" URLs a special case
>   (merged to 'next' on 2009-08-07 at f3533ba)
>  + Makefile: install hardlinks for git-remote-<scheme> supported by libcurl if possible
>  + Makefile: do not link three copies of git-remote-* programs
>  + Makefile: git-http-fetch does not need expat
>   (merged to 'next' on 2009-08-06 at 15da79d)
>  + http-fetch: Fix Makefile dependancies
>  + Add transport native helper executables to .gitignore
>   (merged to 'next' on 2009-08-05 at 33d491e)
>  + git-http-fetch: not a builtin
>  + Use an external program to implement fetching with curl
>  + Add support for external programs for handling native fetches
>  (this branch is used by jh/cvs-helper.)
> 
> I'd really want to have this in 1.6.5 so that we can eject -lcurl from the
> main "git" binary.  The patches in 'pu' got some review comments, and I
> thought Daniel's responses were sensible.  Comments?

I'm pretty sure that there were no objections to 'Make the 
"traditonally-supported"...' patch, and directly after that is a 
reasonable stopping point (everything that used to work works the same, 
nothing new and user-visible is introduced, the implementation is 
reasonably straightforward and tidy, and the git binary doesn't 
link against -lcurl). I'd suggest putting everything up to that point into 
master and debating the rest of the series on its own merits (and likely 
deferring it to post-1.6.5, since it doesn't have an in-tree user to 
exercise it yet).

	-Daniel
*This .sig left intentionally blank*
