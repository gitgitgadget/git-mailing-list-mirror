From: Johan Herland <johan@herland.net>
Subject: Re: Premerging topics (was: [RFD] annnotating a pair of commit objects?)
Date: Wed, 24 Apr 2013 01:06:55 +0200
Message-ID: <CALKQrgeGPo--cYoGZ30nSfASh4CPzqGXQojkG9Ve96NFr+LrjA@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 01:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUmIr-0001UX-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 01:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab3DWXHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 19:07:05 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:50582 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3DWXHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 19:07:03 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUmId-000Ii4-H4
	for git@vger.kernel.org; Wed, 24 Apr 2013 01:06:59 +0200
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUmIc-000LWL-Qb
	for git@vger.kernel.org; Wed, 24 Apr 2013 01:06:59 +0200
Received: by mail-ob0-f173.google.com with SMTP id xn12so990148obc.32
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 16:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8zfQpEJzGoY+0w/vN1gQXiNGH73I9iW+4hMCnufyL8M=;
        b=o64NQBcjL/Jc+Q0Tuq/aqLmdFSXNYpGRjMZI2l03JoAXALv0v8aYfJoF8+7gyhQuR2
         Ti+LMpXKe8tnwb7FwpB2whTrf67O+t0DIns6LsBSO1eF2jEsjt1DoVNw/mEbhw4CFenR
         dVoz2dWjPbt6nLZs0Y7Tt77SNmwJ+b9kF2E4NyhlNF5WU/sJAL359hnZfcV7XuHXGAm6
         X0sGWEHccW8ttiesVmG/BqwiHcyXmJ7yzN00HdafKXqUTnH9GumbpFUM5Zu+63JI5KJB
         O7mQfg5SwP/1OlI8LRXFw2r+qRrhev956NphCsiUKmEclXtrwjugfRwJHjEoWy7kqFfj
         Scbw==
X-Received: by 10.60.41.9 with SMTP id b9mr1622951oel.41.1366758415362; Tue,
 23 Apr 2013 16:06:55 -0700 (PDT)
Received: by 10.182.210.233 with HTTP; Tue, 23 Apr 2013 16:06:55 -0700 (PDT)
In-Reply-To: <CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222218>

On Tue, Apr 23, 2013 at 4:51 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Tue, Apr 23, 2013 at 8:34 AM, Johan Herland <johan@herland.net> wrote:
>> On Wed, Apr 10, 2013 at 10:35 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> Data-structure
>>> ==============
>>> We could use a note ref to store the pre-merge information. Each commit
>>> would be annotated with a blob containing the list of pre-merges (one
>>> sha1 per line with sha1 pointing to a merge commit). The commit on the
>>> other side of a merge would also be annotated.
>>> The choice of the refname could be done like we do with notes:
>>> - Have a default value
>>> - Have a default value configured in config
>>> - Use a specific value when merging/creating the pre-merges
>>>[snipped]
>>> Cons
>>> ----
>>> 4. Checking connectivity means opening the blob and parsing it
>>
>> Can you solve this problem with a tree object, instead of inventing a
>> specially-formatted blob?
>
> That looks like a good idea.
>
>> I.e. given pre-merge info P for a merge between commits A and B: A is
>> annotated by a tree object that contains all pre-merges where A is
>> involved. Each entry in the tree object has a filename and a blob
>> SHA1; we store other commit involved in this pre-merge (B) in the
>> filename, and the pre-merge data (P) in the blob SHA1.
>
> But P is a commit(/merge with two parents), not a blob. Can we have trees
> pointing to commits instead of blobs ?

Sort of. We do so when recording submodules in regular git trees. The
submodule is recorded as a tree entry whose type is commit, name is the
subdir containing the submodule, and SHA1 is the commit ID recorded for
that submodule at this point in history. So it definitely _can_ be done.
That said, I'm not sure whether it's actually a good idea in this case...

I apologize for not having followed the initial discussion. I did not
know that the pre-merge information would be stored as commits.
I figured since it would only contain a partial merge resolution, it
could be represented as something like a tree object containing (only)
the pre-resolved paths...

>> A nice side-effect of using tree objects to store pre-merge entries,
>> is that you can do a tree-level merge of them, and it'll do the Right
>> Thing (assuming two-way merge with no common history), i.e. perform a
>> union merge, and leave you to handle conflicts of individual
>> pre-merges (i.e. you'll only get conflicts when both sides offer
>> different pre-merge data for A + B).
>
> I'm definitely not sure what you mean here, especially with "tree-level
> merge". Also I think we could be doing three-way merges. But I'm
> no merge-strategies expert, so I'm kind of confused.

I was simply thinking of the simple two-way merge that can be done between
two independent trees:
- All paths that exist in only one tree, exist unchanged in the result
- All paths that are identical in both trees exist unchanged in the result
- All paths that exist in both trees, but are different, yield a conflict

In your pre-merge domain, this would become (for given commit A, B, C):
- If one tree records a pre-merge for (A,B) and the other for (A,C), then
  both (A,B) and (A,C) will exist in the result
- If both trees records the _same_ pre-merge resolution for (A,B), then
  that will also exist in the result
- If one tree records one way of pre-merging (A,B), and the other tree
  records a _different_ way of pre-merging (A,B), then there will be a
  conflict that needs resolving.

>>> 5. Regular notes and pre-merge notes have to be handled separately
>>> because of 4.
>>
>> Sort of, but you get that for any automated usage of notes for a
>> specific purpose. Just look at the notes-cache mechanism in
>> notes-cache.{h,c}. That's another example of functionality layered on
>> top of notes that makes assumptions on how its notes trees are
>> structured.
>
> Thanks, I will have a look at it.
>
>>> The goal is to merge branches J and B using existing pre-merges.
>>>
>>> E0. Create an empty stack S
>>> E1. Create set of commits 'J..B' and 'B..J' (that is probably already done)
>>> E2. For each commit C in smallest(J..B, B..J), execute E3
>>> E3. For each premerge P in notes-premerge(C), execute E4
>>> E4. If one of both parents of P belongs to biggest(J..B, B..J), stack P in S
>>
>> I don't think _both_ parents of P can belong to biggest(J..B, B..J).
>> AFAICS J..B and B..J must always be completely disjoint sets of
>> commits (this is easier to see when you consider that "A..B" is
>> equivalent to "B ^A" for any commits A and B), and in E2/E3, you have
>> already made sure that P has a parent in one of them. There is then no
>> way that the same parent can occur in the other set, so you have at
>> most _one_ parent in the other set.
>
> I agree with that. After step E3, one of the parent belongs to one of
> the two branches. Step E4 makes sure the other parent belongs to the other
> branch (and not another unrelated branch).
>
>>> E5. Merge J and B using all pre-merges from S
>>
>> This is where things get complicated... :)
>>
>> First there is one important thing that I have not seen a decision on
>> yet (maybe this was discussed in an earlier thread?):
>>
>> Given pre-merge data P for commit A and B, does P encode the merge of
>> the entire history up to A with the entire history up to B, or does it
>> only encode the merging of the changes introduced in A with the
>> changes introduced in B? In other words, are we merging snapshots or
>> diffs?
>>
>> In the former case, we only need to find the most recent commits A and
>> B on their respective branches - for which P exists - and then execute
>> that one P (or at most two Ps, if there is a criss-cross pre-merge
>> situation). In the other case, however, we need to enumerate all Ps
>> that apply to the two branches, and find a way to execute them
>> chronologically, dealing with missing Ps and conflicting Ps along the
>> way. IMHO, only the former approach seems practically solvable.
>>
>> So you do not need to enumerate all Ps in J..B vs. B..J, you only need
>> to find the _most_ _recent_ P, and execute that one.
>
> Indeed, we only need to know the most recent. That's a good point.
>
>        B1   B2    B3
>     O---o---o-----o
>     |      / \      \
>     |    P1  P2     M
>     |    /    |     /
>      \__o_____o___o
>        J1   J2  J3
>
> In this use-case, we can use P1 to compute P2, and then we only need P2
> to compute the real merge M. The idea would be to use P1 as an implicit
> third parent to the pre-merge P2, and then P2 as an implicit third
> parent to the real merge M.

I'm not sure what is really meant by "implicit third parent" here. Will
Git automatically help you (i.e. auto-resolve conflicts in the correct
manner) if you do an octopus merge between (B3, J3, P2)? I thought you
would have to start by merging J3 and B3, and then - as part of the
conflict resolution process - you invoke the pre-merge machinery, which
goes searching for pre-merges and finds P2, which is then used to help
auto-resolve (some of) the conflicts between B3 and J3. This means that
P2 is not a merge parent in the traditional sense, and I also don't think
that you want to record P2 as a "proper" parent of the resulting merge
commit M.

At this point I also wonder why the pre-merges (P1, P2) has to be
recorded as commit objects. Do they have meaningful commit messages?

...Johan

>>>     $ git pre-merge topicA topicB topicC
>>>
>>> to find, resolve and store all interactions between the topics.
>>
>> Let's leave out octopus merges for now, and only concentrate on two
>> branches at a time.
>
> I was not thinking about octopus merge here, but an easy way to
> pre-merge many topic in a "single step", so it could be used like this:
>
>     $ git pre-merge $(git for-each-ref refs/heads/??/*)
>
> And that would pre-merge each pair of branches between each other. That
> is: "n choose 2" (with n the number of branches given)
>
>> Hope this helps,
>
> It does, thanks !
>
>> PS: Could you also use this mechanism to store rerere information?
>
> That's one of the primary goal. The problem it would solves are:
> - You could apply pre-merges even on clean merges, while rerere focuses
> on conflict resolution. (typical use case is: somebody renames a
> function in one topic, somebody decides to use that function in another
> topic. You won't have a conflict in this situation but the code no
> longer compiles.)
> - You could easily pull/push pre-merges while today there is not built-in
> mechanism to exchange/remote-save rerere's


--
Johan Herland, <johan@herland.net>
www.herland.net
