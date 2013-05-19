From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Sat, 18 May 2013 22:51:30 -0700
Message-ID: <7vtxlz1pr1.fsf@alter.siamese.dyndns.org>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	<7vk3my33vb.fsf@alter.siamese.dyndns.org>
	<CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
	<7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
	<CAMP44s3xdWzVviPvrN7D1fTG6Lwgg-dEzju--VuiwZA-8bV+MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 07:51:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdwWx-00032G-Ci
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 07:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab3ESFve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 01:51:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab3ESFve (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 01:51:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 190941BB28;
	Sun, 19 May 2013 05:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yZoQd62pBTJKtEHXnoFntNfLSmE=; b=anI11Q
	whBXkZa0vE9eWXt6Sana6f3vKTd0xhu095wTn2v9GoAPJf6iU8g1isexHSBNxxxJ
	SNHvQv+68aIDKJuR+Yq9QDd3Id+bRPIXhEoWPt4TvKSCAMQQe4sBGoV2aA65bIKl
	nw2l+Rs0ffiuzmazPbNGrUhLSS76bcyJ/HqoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j66LQjzKekZPBOYHbqaEhMkaC+KNv9f4
	L65AFcIC1NN5uMYnxc3dZ3kD0gL0NPVefy1gqAp1Fs1enE62urBl3WMueyTm5ZXU
	mA67IWt8zgYqZ+DNTPjVt6/Nkcz+0dgySLzddHBzAZI0jgkp4vCnh+EyGKYXwJ74
	Ws9F2O5zJ9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F1B71BB27;
	Sun, 19 May 2013 05:51:33 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F2241BB25;
	Sun, 19 May 2013 05:51:32 +0000 (UTC)
In-Reply-To: <CAMP44s3xdWzVviPvrN7D1fTG6Lwgg-dEzju--VuiwZA-8bV+MQ@mail.gmail.com>
	(Felipe Contreras's message of "Sat, 18 May 2013 07:25:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 285F663E-C048-11E2-B099-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224817>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, May 17, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> This is irrelevant, it's an implementation detail of 'git pull'. *THE
>>> USER* is not running 'git fetch .'
>>
>> To those who fear running "git pull", the following has worked as a
>> quick way to "preview" what they would be getting.
>>
>>         git fetch
>>         git log ..FETCH_HEAD
>>
>> and then they can "git merge FETCH_HEAD" to conclude it, or run a
>> "git pull" for real.  We teach the more explicit form to end users
>> in our tutorial,
>
> That "tutorial" is mostly irrelevant; it has not been properly updated
> in years, and it doesn't do it's job properly.
>
> Nowadays most people use the Pro Git book, which doesn't mention
> FETCH_HEAD even once. And why would it?

Because the book was written by those who did not know about its
use, and I do not necessarily think it is their fault.  Our own
documentation can use updates.

Patches to the tutorial to explain (you can refer to postings by
people who discuss on public "users help other users" site like
stackoverflow) the equivalence of the "git pull" == "git fetch"
followed by "git merge FETCH_HEAD" better than it currently does is
welcome.  IIUC, ProGit is maintained in public and you can send
patches to it, too.

Users of stackoverflow seem to know about and how to use FETCH_HEAD:

    http://stackoverflow.com/questions/9237348/what-does-fetch-head-in-git-mean
    http://stackoverflow.com/questions/11478558/fetch-head-not-updating-after-git-fetch

and they expect exactly what I described in the earlier message.  If
you ask your search engine about "FETCH_HEAD", you would find other
real-world use of it as well (one of them I found was about somebody
requesting to teach TortoiseGit to offer FETCH_HEAD as a candate to
be merged, IIRC).

Incidentally, this discussion on our own list

    http://thread.gmane.org/gmane.comp.version-control.git/42788/focus=42798

shows that I was originally not very keen to defend "fetch, then
inspect with log FETCH_HEAD, and then finally merge" workflow to
keep working myself [*1*], which is somewhat funny.

So, no, it is not my whim, but people do depend on "git fetch" that
updates FETCH_HEAD to what is to be merged with "git pull".

>> So when "the user" is running "git fetch" on "mywork" branch that
>> happens to be forked from a local "master",...
>> we still need to have FETCH_HEAD updated to point at what we would
>> be merging if she did a "git pull".
>
> No, we don't need that. That is only needed by 'git pull', and in
> fact, it should be possible to reimplement 'git pull' so that it skips
> FETCH_HEAD when the remote is local.
>
> These are mere implementation details.

You seem to be incapable to understand what backward compatibility
is.  It is not about "keep only what I use myself, I think others
should use, and/or I understand, working, and destroy everything
else".

Also your "special-case local repository and fetch from 'origin'"
breaks down once your users need to work on a project with subsystem
maintainers.

Imagine one clones from me (i.e. git.git is her upstream), and forks
her fh-octopus branch out of her master branch ("git clone" arranges
the latter to be a fork of origin/master taken from me).  She helps
git-svn and has Eric's repository as her "git-svn" remote (because
my tree lags behind Eric's tree with respect to git-svn).  Her local
git-svn branch is a fork of Eric's master, and she has her svn-ext
branch that is a fork of it [*2*].

    git clone git://git.kernel.org/pub/scm/git/git.git git
    cd git

    git checkout -t -b fh-octopus master
    git remote add git-svn git://git.bogomips.org/git-svn.git/
    git checkout -t -b git-svn git-svn/master
    git checkout -t -b svn-ext git-svn

She has four local branches, master, fh-octopus, git-svn, and
svn-ext.  Is this a too-contrived example?  I do not think so.

On any of these branches, she can say

    git pull [--rebase]

without having to be constantly aware of what branch (either remote
or local) the work on her current branch builds on.  Like some
people in the thread $gmane/42788 discussion, she may prefer to do
the same integration with "first fetch, inspect and then integrate"
workflow, relying on the equivalence "git pull" == "git fetch" +
"git merge/rebase":

    git fetch
    git log ..FETCH_HEAD
    git merge FETCH_HEAD

But when she does this:

    git checkout fh-octopus
    git fetch

the "git fetch" does not fetch from me (i.e. her 'origin').

Would she be unhappy?

I agree that it could be argued so.

After all, she is working on a topic that is eventually based on my
'master' and the only reason she forked from her 'master' is because
she may have other changes of her own on her 'master' that are not
necessarily related to her fh-octopus topic.  She wants her "git log
@{u}.."  not to show those unrelated changes on her 'master', but
wants to rebase against her 'master'.

Because her @{u} does not refer to 'origin/master' taken from me (it
refers to her local 'master'), however, even if we change "git
fetch" to fetch from 'origin', what "git log ..@{u}" shows does not
change, so the only "improvement" is that it does not trigger "I
said 'git fetch' but it did not fetch anything?  Did I make some
mistake?" confusion.

Is that lack of confusion a big enough improvement, or is it easy
enough for her to realize that what she wanted to inspect was what
I've been doing in the meantime and run "git fetch origin"?

I know you would say it is an improvement; I am on the fence in the
sense that no confusion is better than confusion, but that is a
qualified "on the fence".  I do not mind it fixed as long as the
confusion avoidance does not regress other aspects of the operation
we have kept working for people.

But more importantly, what should happen when she is working on her
svn-ext branch?

    git checkout svn-ext
    git fetch

This does not fetch from me (i.e. her 'origin'), either.  If this
fetched from me, would she be happier?

It could be argued that it might be better if it fetched from Eric;
after all she is working on svn-ext that eventually reaches Eric's
tree.  But fetching from me while she is working on svn-ext does not
make any sense at all in her set-up, does it?

As I already said, I am OK with an enhancement that does (an
equivalent of) the following:

 - Teach "git fetch --no-fetch-head <any args>" an option that
   causes it to do everything "git fetch <any args>" would do,
   except that in that mode, it does not touch FETCH_HEAD at all
   (the "--append" option that changes the behaviour of "git fetch"
   to only change what happens to FETCH_HEAD can be thought of a
   precedent).

 - Only when 'git fetch' (with no parameters, i.e. relies on
   configured defaults) is to fetch from '.':

   - First internally fork and run "git fetch --no-fetch-head
     <remote>" from the <remote> found by the following loop:

    - Set a variable B to the name of the current branch 
    - while branch.B.remote is the local repository:
      - assign the branch the branch B forked from,
        i.e. branch.B.merge, to variable B
    - branch.B.remote is the first remote repository in the fork
      ancestry chain.  That is the <remote> we are looking for.

   - Then do the usual 'git fetch' against the local repository,
     leaving what is to be merged in FETCH_HEAD as usual.

 - (optional) make the second "special case" opt-in, as people who
   have known Git may be upset when their "git pull" that they know
   would go to local repository touches network.  I do not think it
   is a huge deal, though, and that is why I marked it as optional.

I think that would alleviate the puzzlement some people may feel
when they run 'git fetch' on a branch that integrates with their
local branch, and sees no objects are transferred.  It would do so
without breaking anything.

Anything that breaks the "pull=fetch+merge" equivalence is not
acceptable and no loud repeating from you will change that, with or
without patches.

We owe at least that much to the people who asked us to keep it
working over time and those who responded to them by working on
maintaining it over time.


[Footnotes]

*1* Back then, FETCH_HEAD did not have the commit to be merged
    necessarily on the first line, so it was not very easy to work
    with it.  But that was fixed by 96890f4c428e (write first
    for-merge ref to FETCH_HEAD first, 2011-12-26), has been with us
    since v1.7.9, and the fix was not made by me, but Joey Hess.


*2* The invariant "git pull <fetch params>" == "git fetch <the same
    fetch params>" + "git merge FETCH_HEAD" (for any <fetch params>,
    including empty) has been true forever, and over time we made
    sure it hold true when we introduced new features because people
    depended on it, with commmits like these:

     - 85295a52e683 (git-merge: Put FETCH_HEAD data in merge commit
       message, 2007-03-22)

     - 96890f4c428e (write first for-merge ref to FETCH_HEAD first,
       2011-12-26)

    A remaining known bug is when the pull is to create an octopus,
    because "git merge FETCH_HEAD" currently can resolve FETCH_HEAD
    as only one commit.  The fh-octopus topic would extend the itch
    these two fixes started to scratch by teaching "git merge" to
    expand FETCH_HEAD into all commits that are not marked as
    not-for-merge to finish scratching that itch.

    svn-ext may teach git-svn to express a svn external as a git
    submodule.
