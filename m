From: Phil Hord <phil.hord@gmail.com>
Subject: Re: odd behavior with git-rebase
Date: Wed, 28 Mar 2012 02:58:32 -0400
Message-ID: <CABURp0r2_3GdG+iX1BmCbHo5aUoRNLt0WCnDJDcO583qaXT3tQ@mail.gmail.com>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <7vvclvrrad.fsf@alter.siamese.dyndns.org> <20120324165536.GA17932@neilslaptop.think-freely.org>
 <7v1uofqoa7.fsf@alter.siamese.dyndns.org> <20120326172028.GB12843@hmsreliant.think-freely.org>
 <4F70E53E.6060608@gmail.com> <CABURp0oP3YBEhpDrAL-mvt1dR+ZH3av-P_sqDQAdgcN10WS2ig@mail.gmail.com>
 <4F72AD25.2090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neil Horman <nhorman@tuxdriver.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 08:59:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCmqT-0001zo-RJ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 08:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab2C1G6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 02:58:55 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55915 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752196Ab2C1G6y convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 02:58:54 -0400
Received: by lahj13 with SMTP id j13so814026lah.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eXlyZTkTrVLcPfPmNZrFrHCa0wzdVIGqbxa3hcdT0jU=;
        b=051NchjbmnwQfaxBj8chyObNYTqWnd/WTIl+jRVORMkcDvKjXytFMZ4wTT3bKfxtXt
         HeGJvdhAHY5ixYp5t0oVmoAVX6qNgPQHPawmtufE7EiQoYLt6EHwpbfM6J7rn4S+ZWwn
         ifl85qiNqZ/eHg9WE0fZhIxGgdnPKGOU8zqHEQi0O8CHAiJh0zlyM+hU6RM8wROZ5+tV
         7V0oAz1AG/jSx38E0veSTrI9XajIg45uBsUX7J3fY4G+Nr42aj7IWem9HhgHus6vHRO6
         07yokqcSIIcxHe8s6PbIcy/ysAiQp/XFpo0cBYxwfc4izqKNzY0FmeY/tGb5umLGuYDV
         meNw==
Received: by 10.152.133.9 with SMTP id oy9mr21286383lab.43.1332917932349; Tue,
 27 Mar 2012 23:58:52 -0700 (PDT)
Received: by 10.112.55.43 with HTTP; Tue, 27 Mar 2012 23:58:32 -0700 (PDT)
In-Reply-To: <4F72AD25.2090102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194109>

On Wed, Mar 28, 2012 at 2:18 AM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 3/26/2012 5:53 PM, Phil Hord wrote:
>> On Mon, Mar 26, 2012 at 5:53 PM, Neal Kreitzinger
>> <nkreitzinger@gmail.com> wrote:
>>> On 3/26/2012 12:20 PM, Neil Horman wrote:
>>>>
>>>> On Mon, Mar 26, 2012 at 10:12:48AM -0700, Junio C Hamano wrote:
>>>>>
>>>>> Neil Horman<nhorman@tuxdriver.com> writes:
>>>>>
>>>>>> I agree, I think perhaps adding an --allow-empty option to
>>>>>> the rebase logic, so that empty commits (or perhaps just
>>>>>> initially empty, as opposed to commits made empty) would be
>>>>>> very beneficial.
>>>>>
>>>>>
>>>>> Yeah, that probably may make sense.
>>>>>
>>>> Ok, cool, I'll have a patch in a few days, thanks!
>>>>
>>> IMO, it seems like --allow-empty is an appropriate patch for
>>> git-rebase (non-interactive), and that git-rebase -i would need a
>>> command like "k"eep to distinguish which empty commits are not to
>>> be discarded and which empty commits are ok to discard
>>> automatically. git-rebase -i should allow explicit control on a
>>> commit by commit basis as opposed to blanket rules like "discard
>>> all empty commits" or "keep all empty commits" that apply to all
>>> commits in the rebase-to-do list based on a single cli option.
>>
>> But I don't want a 'keep-even-if-empty' option in interactive.
>
> That's why its called an option.=A0 Don't use it if you don't want it=
=2E=A0 ;-)

Yeah, I didn't mean I don't want it to exist in git.  I just meant
that it's not what I'm seeking atm.

But you seem to have forgotten that you were arguing against it at the
beginning of the paragraph I was responding to.

>> I want a 'purge-if-empty' option instead.
>
> That's the default behavior currently.=A0 We're not proposing to chan=
ge that.

It ostensibly is the current behavior.  But Peff and I think we've
seen it misbehave in --interactive mode.  However, I may have been
confused by its doppelg=E4nger, the "rerere autoresolved to empty
commit" situation, where the behavior is to announce "Could not apply"
and pause the process to wait for human intervention.

>> But I don't want to be bothered with telling git this for every
>> commit.
>
> You only tell it which empty commits you want to "k"eep (to not
> "auto-purge").=A0 In your case, you don't want to keep any so you don=
't have
> to tell it anything.=A0 The default behavior will purge them all (emp=
ty
> commits) because you didn't mark any as "k"eep.
>
>
>> I recently had a long-running branch to clean up.
>
> I have users with branches over a year old.

I don't understand this comment.  Is this a pissing contest?

>> It was polluted with commits pulled in by a ham-fisted developer
>> collaborating on this and another branch.
>
> My users cp files from other worktrees and do merges manually without=
 using
> git-merge, git-rebase, or git-cherry-pick.
>
>
>> He's not quite got the git mental model yet and he had lots of
>> commits doing things and then undoing them later on.
>
> Most of my users think git is cvs 3.0.

I see what you did there.  I like that one.

>
>> Rebase scares him.
>
> git as a whole scares most of my users.
>
>> So I did a lot of interactive rebasing on this branch to reorder the
>> "good" change commits to the front of the line where they could be
>> pushed to code review sooner. In the meantime, I wanted to keep the
>> rest of the branch in place so I could see what was left to tackle.
>
> You should create a "backup" branch of the before state so you don't =
get
> blamed for breaking their stuff.

Apologies for failing to mention that his branch remained "backed up"
in origin/shared/dumbass as well as on a local branch and in my
reflog.

>> I cherry-picked replacements for many of the "good" commits -- from
>> their original topic branches HamFist swiped them from -- so I would
>> have the current, reviewable commit to push. Then I tested the
>> long-running branch on top of these commits. This involved about 8
>> or 10 passes through 'git rebase -i master' for one reason or
>> another.
>
> Sounds like you may also be a little scared of git-rebase yourself.=A0=
 Be a
> man and do it all in one pass.=A0 (You have the backup branch to star=
tover if
> need be.)=A0 ;-)

Oh, it IS a pissing contest then.  Whip it out, boy!

No, I'm not scared of rebase.  There were 40 commits full of crap and
gems.  I made several pass through rebase-interactive not because
git-rebase is a problem but simply because I was sifting methodically
for gems and flushing turds.

>> On this branch of 40 commits, git interrupted me about 10 times on
>> each pass to ask me what to do. The reason is always one of these:
>>
>> 1. There is a new conflict I need to resolve
>> examine / mergetool / test / --continue
>>
>> 2. There is a rerere autoresolved conflict git wants me to approve
>> examine / test / --continue
>
> You trust rerere?=A0 I take back my earlier comment, you are a brave =
man.

Uh huh. That's what I thought!. Hmmph.

> Also, you're starting to sound like some of my users who think that g=
it
> magically does their work for them.

Git does do my work for me, and it does require more work from me.
But in this case, it saved me sifting the same turds over and over.

I do trust rerere to redo what it previously remembered I did for
resolution.  In that respect, rerere is only as reliable as I am.  But
I also have a backup that I'll consult periodically, these commits are
headed for the CI-Server and human reviewers, and there's plenty of
time to catch my stupid mistakes.


>> 3. There are no changes left in this commit because either a. they
>> were introduced into earlier commits, or b. git-rerere-membered that
>> I don't want those changes examine / --skip
>
> git-rerere-membered -- that's a good one.=A0 I felt like
> git-rerere-dismembered my merge the one time I tried it.=A0 But serio=
usly, I
> have no experience with this --skip scenario.

I think rerere seemed to butcher my first ugly merge, too.  But it was
really my fault.  I knew I was on a throwaway branch previously, so I
was not as careful with the merge.  Later when I revisited it to do it
"for real", rerere stepped in and was as un-careful as I had been.
:-)  I think he was rubbing my nose in it.


>> I went through this process about 5 or 6 times as I massaged the
>> stink out of this branch. Cases 2 and 3 became more common as I
>> went along. But git always wanted to stop and ask my approval before
>> continuing. It was frustrating.
>>
>> I always had my original branch to go compare to. This one is really
>> a trial rework of these commits. So I wish I could tell git to only
>> bother me when he sees a new conflict. Don't stop and ask me for
>> something every 3 or 4 commits.
>>
>> I really wanted something like this:
>>
>> $ git rebase --purge-empty --accept-rerere-authority -i master
>>
>
> --accept-rerere-authority sounds like another recent thread (maybe fr=
om
> you).

Maybe.


>> So, even though this is an "interactive" rebase, I wish git would do
>> more of the busywork for me. That is, I only want it to be as
>> interactive as it needs to be, and no more so.
>>
> FWIW, I think we may be a little spoiled.=A0 git rebase -i is one of =
the, if
> not the, most powerful, flexible, amazing change control commands in
> existence if you think about it.=A0 I guess we could switch to anothe=
r SCM
> that does it better.=A0 Oh, I forgot, there isn't one.

Yes, definitely spoiled.  rebase-interactive,  add-patch, and
checkout-patch have changed the way I manage my project.  I have a
much better project history because of them, but I'm also much more
intimate with my SCM than I ever was under Subversion, cvs, SourceSafe
or tar.  :-)

I never thought I would be excited about an SCM, but I've become the
resident evangelist at $dayjob.

> Hopefully, my sympathetically-inspired comments based on some shared
> experiences are helpful at some level.=A0 :-)

Yes, thanks.  Sometimes I'm long-winded.  I usually tone it down after
a couple of rewrites, but this time I left most of the elucidating
back story in.

Thanks for reading along.

Phil
