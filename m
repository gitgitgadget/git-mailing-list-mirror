From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: Re: [PATCH 2/2] contrib/git-candidate: Add README
Date: Wed, 11 Nov 2015 09:48:17 +0000
Message-ID: <20151111094816.GA2949@salo>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
 <1447160198-23296-3-git-send-email-richard.ipsum@codethink.co.uk>
 <1447186751.20147.24.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 10:49:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwS1J-0005xh-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 10:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbbKKJsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 04:48:30 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:40882 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbKKJsY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 04:48:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 3F9B34602EA;
	Wed, 11 Nov 2015 09:48:21 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vbBZMDm7-LiP; Wed, 11 Nov 2015 09:48:18 +0000 (GMT)
Received: from salo (salo.dyn.ducie.codethink.co.uk [10.24.1.218])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 29174461A91;
	Wed, 11 Nov 2015 09:48:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1447186751.20147.24.camel@twopensource.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281153>

On Tue, Nov 10, 2015 at 03:19:11PM -0500, David Turner wrote:
> I didn't actually read the code.  Instead, I started with the README and
> decided to provide both text and UX comments all mixed up.  These are
> mostly my personal preferences; take them or leave them as you choose. 
> 
> I'm really excited about this tool and I think it's got great potential!

It's great to hear that, I think there is a need for a tool like this.

> 
> On Tue, 2015-11-10 at 12:56 +0000, Richard Ipsum wrote:
> > Describes motivation for git-candidate and shows an example workflow.
> > 
[snip]
> 
> I have not heard the name "candidate" used this way.  What about "git
> codereview"? 

I admit to being quite bad at naming things,
originally we were going to call this git-pull-request after the
initial concept provided by Daniel Silverstone[1]. We later realised
that we'd created something more flexible than pull-requests:
git-candidate can be used with a pull-request model or a more tranditional
patch submission model.

I certainly have nothing against renaming this tool if there's some
agreement on a new name, though I will point out that it's possible
that the content of a candidate is not code.

> 
> > +=============
> > +
> > +git-candidate provides candidate review and patch tracking,
> > +it differs from other tools that provide this by storing _all_
> > +content within git.
> > +
> > +## Why?
> 
> I've made a few suggestions below that you might think are out of scope.
> If they are, it might be good to have a "non-goals" section so that
> people know what the scope of the tool is.
> 
> > +Existing tools such as Github's pull-requests and Gerrit are already
> > +in wide use, why bother with something new?
> > +
> > +We 
> 
> who?  

At the moment the 'we' is Codethink who are sponsoring this work,
but I'd like to resolve the text to not need that.

> 
> > are concerned that whilst 
> 
> Today I learned: "whilst" can be used in the sense of "although" (I had
> previously thought only "while" could be used this way, but I was wrong!
> )

:)

> 
> > git is a distributed version control
> > +system the systems used to store comments and reviews for content
> 
> insert comma after "system"

ack

> 
> > +under version control are usually centralised,
> 
> replace comma with period.

ack

> 
> > +git-candidate aims to solve this by storing
> > +all patch-tracking data in git proper.
> 
> s/tracking/tracking and review/ ?  Or something

"all patch-tracking and review data in git proper" would probably be better.

> 
> > +## Example review process
> > +
> > +### Contributor - Submits a candidate
> > +
> > +	(hack hack hack)
> > +
> > +	(feature)$ git commit -m "Add archived repo"
> > +	(feature)$ git candidate create archivedrepo master
> > +		-m "Add support for archived repo"
> > +	Candidate archivedrepo created successfully.
> > +	(feature)$ git candidate submit origin archivedrepo
> > +	Candidate was submitted successfully.
> > +### Upstream - Reviews candidate
> 
> What happens if a third party wants to review candidate?  OR is this
> just the same as if upstream does it?

Exactly, the third party follows the same process as upstream.

> 
> > +	(master)$ git candidate fetch origin
> > +	(master)$ git candidate status origin/archiverepo
> > +	Revision: 6239bd72d597357af901718becae91cee2a32b73
> > +	Ref: candidates/origin/archiverepo
> > +	Status: active
> > +	Land: master
> 
> Could this be "Merge: master"?  Or something that doesn't invent a new
> term?

Consider it done. :)

> 
> > +	Add archived repo support
> > +
> > +	 lib/gitano/command.lua | 28 ++++++++++++++++++++++------
> > +	 1 file changed, 22 insertions(+), 6 deletions(-)
> > +
> > +	(master)$ git show candidates/origin/archiverepo
> > +	commit 2db28539c8fa7b81122382bcc526c6706c9e113a
> > +	Author: Richard Ipsum <richard.ipsum@codethink.co.uk>
> 
> Probably better to use example.com addresses in the README rather than
> real people.  Git traditionally uses "A U Thor" as the fake name.

Will do.

> 
> > +	Date:   Thu Oct 8 10:43:22 2015 +0100
> > +
> > +	    Add support for archived repository masking in `ls`
> > +
> > +	    By setting `project.archived` to something truthy, a repository
> > +	    is thusly masked from `ls` output unless --all is passed in.
> > +
> > +	    Signed-off-by: Richard Ipsum <richard.ipsum@codethink.co.uk>
> > +	....
> > +	....
> > +
> > +
> > +	(master)$ git candidate review origin/archiverepo --vote -1
> > +		-m "Sorry, I'll need to see tests before I can accept this"
> 
> Are per-line or per-commit comments supported?  If so, please add an
> example of this.

That's work in progress, there will soon be a --line option to the
'comment-file' command, the status command will then render per-line
comments.

> 
> > +	(master)$ git candidate submit origin archiverepo
> > +	Review added successfully
> 
> Is the contributor automatically (optionally) emailed on this? If not,
> consider this a feature request for this.

There's no server integration of any kind at the moment,
this is clearly something we will want to add.

> 
> > +### Contributor - Revises candidate
> > +
> > +	(master)$ git candidate fetch origin
[snip]
> > +	(master)$ git candidate status origin/archiverepo
> > +	Revision: 4cd3d1197d399005a713ca55f126a9086356a072
> > +	Ref: candidates/origin/archiverepo
> > +	Status: active
> > +	Land: master
> > +
> > +	Add archived repo support with tests
> > +
> > +	 lib/gitano/command.lua      | 28 ++++++++++++++++++++++------
> > +	 testing/02-commands-ls.yarn | 19 +++++++++++++++++++
> > +	 2 files changed, 41 insertions(+), 6 deletions(-)
> 
> "git candidate diff" might be nice too to show the diff between v1 and
> v2.  You might even have "git candidate commit-diff" (or some better
> name) so you can see which commit has changed in a changeset containing
> multiple commits. 

Yes, we definitely want that. I think "git candidate diff" to diff
between revisions would be sufficient, and it could take a list of files
to diff as an arg?

> 
> > +	(master)$ git candidate review origin/archiverepo --vote +2
> > +		-m "Looks good, merging.  Thanks for your efforts"
> > +	Review added successfully
> 
> Is that +2 "+1 because I like it, +1 because I previously -1'd it?" If
> so, it might be nice to have --replace-vote so you don't have to track,
> "wait, I did -1, then +1, then -1 again..."

Votes are per-review, perhaps they should simply be per-revision?
Then --vote sets the vote for the revision and there's no need for
a --replace-vote option?
This would use user.name and user.email as identification.

> 
> > +	(master)$ git candidate submit origin archiverepo
> > +	Candidate was submitted successfully.
> 
> I don't understand what the verb "submit" means here. Is it "mark this
> as accepted"?  If so, "accept" might be a better word.  

I'm tempted to change this to 'push', 'submit' comes from gerrit.

> 
> > +	(master)$ git merge candidates/origin/archiverepo
> 
> I would like "git candidate merge" to do a submit+merge the way that
> pull does a fetch+merge.  It seems like the common case.  Also, if it
> turns out at this point that there's a merge conflict, I might want to
> back out the acceptance.

There is currently no git-candidate-merge, I removed this recently
because I decided that you can merge candidates with git-merge
and that this is more flexible. Often a candidate will be rebased
before it is merged, it would be nice to avoid having to create
a merge command that needs to handle all the different cases for
merging a candidate.

> 
> > +	(master)$ git push origin master
> > +
> > +### Contributor - Observes candidate has been accepted
> > +
[snip]
> 
> You should include here "git candidate remove archiverepo".  And
> somewhere an example of "git candidate list".
> 

Good point, will do.

Thank you for taking the time to provide this excellent feedback. :)

[1]: https://www.gitano.org.uk/ideas/git-pull-request/
