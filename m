From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] git-svn.txt: mention how to rebuild rev_map files
Date: Wed, 25 Sep 2013 18:37:10 -0500
Message-ID: <874n98qxqx.fsf@gmail.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
	<20130925194402.GA9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 01:37:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOyeA-000469-7n
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 01:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781Ab3IYXhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 19:37:25 -0400
Received: from plane.gmane.org ([80.91.229.3]:38681 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab3IYXhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 19:37:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VOye2-00040d-Tr
	for git@vger.kernel.org; Thu, 26 Sep 2013 01:37:22 +0200
Received: from nat-128-62-40-141.public.utexas.edu ([128.62.40.141])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 01:37:22 +0200
Received: from keshav.kini by nat-128-62-40-141.public.utexas.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 01:37:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-128-62-40-141.public.utexas.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:PT4JU1clsN/ZqfROIu4Px8DR0x8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235380>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Taking a step back, the reader might wonder *why* he would want
> to run "git svn fetch" to rebuilt these .rev_map.* files, and what
> they are for.
>
> Perhaps there should be a separate REVISION MAP section describing
> this in more detail.  Something as simple as
>
> 	FILES
> 	-----
> 	.git/svn/\*\*/.rev_map.\*::
> 		Mapping between Subversion revision numbers and Git
> 		commit names.  Can be rebuilt using the git-svn-id:
> 		lines at the end of every commit as long as the
> 		noMetadata option is not set (see the 'svn.noMetadata'
> 		section above for details).
> 	+
> 	'git svn fetch' and 'git svn rebase' automatically update
> 	the rev_map if it is missing or not up to date.  'git svn
> 	reset' automatically rewinds it.
>
> Then this reference in 'fetch' could just say something like
>
> 	...
> 	argument.
> 	+
>  This automatically updates the rev_map if needed (see
>  '.git/svn/\*\*/.rev_map.\*' in the FILES section below for
>  details).

Note that only the first two asterisks are escaped in my patch. For some
reason, escaping all three causes a literal '\' to appear in asciidoc's
output...

I changed the wording of your first paragraph a bit according to what I
thought it meant. Does it still convey what you wanted to convey, and is
it still correct?

	Mapping between Subversion revision numbers and Git commit
	names.  In a repository where the noMetadata option is not set,
	this can be rebuilt from the git-svn-id: lines that are at the
	end of every commit (see the 'svn.noMetadata' section above for
	details).

Also, I'm having a bit of trouble trying to get a definition to start
with a '.' character in AsciiDoc.  Escaping the '.' produces a
definition block, but with a literal '\' before the '.'.  If I don't
escape the '.', asciidoc thinks it's a section heading or something. Is
asciidoc just incapable of doing this, or am I missing something?

-Keshav
