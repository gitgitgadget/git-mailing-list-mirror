Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471AB20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 01:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbdLABv2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 20:51:28 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:39726 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdLABvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 20:51:23 -0500
Received: by mail-wr0-f170.google.com with SMTP id a41so6621692wra.6
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 17:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GjjHiXdZv/kpbEcHZSMuVMZdFCihhCfd9hQUuO+n6Po=;
        b=vyI0dzxX9BDxpbt+d2bz2KpRm4fvpReVY6Bth85GcsHFbVGSYEiJdQfK5lblnqjR5/
         DQqjgnh+MG8X170e/5MxTA1R/IhY5HWRvCGZsXBaW0KkWIY56QuYJTs0CxYmQZYXpXIp
         Wxqqq8hhPDsmhA/zb6DsiH1pbGVLhB58bBcX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GjjHiXdZv/kpbEcHZSMuVMZdFCihhCfd9hQUuO+n6Po=;
        b=p4Ntf42tmZDM/w812/Ggr1E/JS/0fhw7SRmcQntEBFO0V1igElK3z7k/Hu2WhxVkRP
         MaxjHZDlydc2A6lT3DLbFFc/+dxv61gcJC7cTb/lXpBDxAlPwdTLSViBELZptiv266GW
         1lemkPpfdRCc1ImaFw/3hb/u02LvCGE9ruGpcJxXcbNcoXWJsJxpMyVBeATRtW3rjDGJ
         DKQMEgiHMmB7Yu/O82DjDbCCcqADLltxnoTyjGR5qac+RZk9595FqO7gQ0yFzB8sk6Zm
         R5MVU4jhTAuCsivLoxII+TFTw/ZZt20BMBwgybupb+bxQ+hdoBu2fWaiiOycl+UT3sY1
         NYYw==
X-Gm-Message-State: AJaThX4uJxEclxym0IJ3Uz2H0mM1S1vqX6K2UMjgkZQa7er3k7meeI2b
        U13C3ZW1uuwo2LyQoP6pJYiguDaQnDXoM21OVLCu
X-Google-Smtp-Source: AGs4zMYX3VQzNhEnUoLwfNEmUUU1rAXddrjc4ENPA0q1eAhZIvQ6HQfk/5WZktJRP/2zOrQbScOAssVkpILlrtZQd9A=
X-Received: by 10.223.138.246 with SMTP id z51mr3653787wrz.152.1512093082071;
 Thu, 30 Nov 2017 17:51:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.213.12 with HTTP; Thu, 30 Nov 2017 17:51:01 -0800 (PST)
In-Reply-To: <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com> <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley> <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com>
From:   Vitaly Arbuzov <vit@uber.com>
Date:   Thu, 30 Nov 2017 17:51:01 -0800
Message-ID: <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think it would be great if we high level agree on desired user
experience, so let me put a few possible use cases here.

1. Init and fetch into a new repo with a sparse list.
Preconditions: origin blah exists and has a lot of folders inside of
src including "bar".
Actions:
git init foo && cd foo
git config core.sparseAll true # New flag to activate all sparse
operations by default so you don't need to pass options to each
command.
echo "src/bar" > .git/info/sparse-checkout
git remote add origin blah
git pull origin master
Expected results: foo contains src/bar folder and nothing else,
objects that are unrelated to this tree are not fetched.
Notes: This should work same when fetch/merge/checkout operations are
used in the right order.

2. Add a file and push changes.
Preconditions: all steps above followed.
touch src/bar/baz.txt && git add -A && git commit -m "added a file"
git push origin master
Expected results: changes are pushed to remote.

3. Clone a repo with a sparse list as a filter.
Preconditions: same as for #1
Actions:
echo "src/bar" > /tmp/blah-sparse-checkout
git clone --sparse /tmp/blah-sparse-checkout blah # Clone should be
the only command that would requires specific option key being passed.
Expected results: same as for #1 plus /tmp/blah-sparse-checkout is
copied into .git/info/sparse-checkout

4. Showing log for sparsely cloned repo.
Preconditions: #3 is followed
Actions:
git log
Expected results: recent changes that affect src/bar tree.

5. Showing diff.
Preconditions: #3 is followed
Actions:
git diff HEAD^ HEAD
Expected results: changes from the most recent commit affecting
src/bar folder are shown.
Notes: this can be tricky operation as filtering must be done to
remove results from unrelated subtrees.

*Note that I intentionally didn't mention use cases that are related
to filtering by blob size as I think we should logically consider them
as a separate, although related, feature.

What do you think about these examples above? Is that something that
more-or-less fits into current development? Are there other important
flows that I've missed?

-Vitaly

On Thu, Nov 30, 2017 at 5:27 PM, Vitaly Arbuzov <vit@uber.com> wrote:
> Jonathan, thanks for references, that is super helpful, I will follow
> your suggestions.
>
> Philip, I agree that keeping original DVCS off-line capability is an
> important point. Ideally this feature should work even with remotes
> that are located on the local disk.
> Which part of Jeff's work do you think wouldn't work offline after
> repo initialization is done and sparse fetch is performed? All the
> stuff that I've seen seems to be quite usable without GVFS.
> I'm not sure if we need to store markers/tombstones on the client,
> what problem does it solve?
>
> On Thu, Nov 30, 2017 at 3:43 PM, Philip Oakley <philipoakley@iee.org> wro=
te:
>> From: "Vitaly Arbuzov" <vit@uber.com>
>>>
>>> Found some details here: https://github.com/jeffhostetler/git/pull/3
>>>
>>> Looking at commits I see that you've done a lot of work already,
>>> including packing, filtering, fetching, cloning etc.
>>> What are some areas that aren't complete yet? Do you need any help
>>> with implementation?
>>>
>>
>> comments below..
>>
>>>
>>> On Thu, Nov 30, 2017 at 9:01 AM, Vitaly Arbuzov <vit@uber.com> wrote:
>>>>
>>>> Hey Jeff,
>>>>
>>>> It's great, I didn't expect that anyone is actively working on this.
>>>> I'll check out your branch, meanwhile do you have any design docs that
>>>> describe these changes or can you define high level goals that you
>>>> want to achieve?
>>>>
>>>> On Thu, Nov 30, 2017 at 6:24 AM, Jeff Hostetler <git@jeffhostetler.com=
>
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 11/29/2017 10:16 PM, Vitaly Arbuzov wrote:
>>>>>>
>>>>>>
>>>>>> Hi guys,
>>>>>>
>>>>>> I'm looking for ways to improve fetch/pull/clone time for large git
>>>>>> (mono)repositories with unrelated source trees (that span across
>>>>>> multiple services).
>>>>>> I've found sparse checkout approach appealing and helpful for most o=
f
>>>>>> client-side operations (e.g. status, reset, commit, etc.)
>>>>>> The problem is that there is no feature like sparse fetch/pull in gi=
t,
>>>>>> this means that ALL objects in unrelated trees are always fetched.
>>>>>> It may take a lot of time for large repositories and results in some
>>>>>> practical scalability limits for git.
>>>>>> This forced some large companies like Facebook and Google to move to
>>>>>> Mercurial as they were unable to improve client-side experience with
>>>>>> git while Microsoft has developed GVFS, which seems to be a step bac=
k
>>>>>> to CVCS world.
>>>>>>
>>>>>> I want to get a feedback (from more experienced git users than I am)
>>>>>> on what it would take to implement sparse fetching/pulling.
>>>>>> (Downloading only objects related to the sparse-checkout list)
>>>>>> Are there any issues with missing hashes?
>>>>>> Are there any fundamental problems why it can't be done?
>>>>>> Can we get away with only client-side changes or would it require
>>>>>> special features on the server side?
>>>>>>
>>
>> I have, for separate reasons been _thinking_ about the issue ($dayjob is=
 in
>> defence, so a similar partition would be useful).
>>
>> The changes would almost certainly need to be server side (as well as cl=
ient
>> side), as it is the server that decides what is sent over the wire in th=
e
>> pack files, which would need to be a 'narrow' pack file.
>>
>>>>>> If we had such a feature then all we would need on top is a separate
>>>>>> tool that builds the right "sparse" scope for the workspace based on
>>>>>> paths that developer wants to work on.
>>>>>>
>>>>>> In the world where more and more companies are moving towards large
>>>>>> monorepos this improvement would provide a good way of scaling git t=
o
>>>>>> meet this demand.
>>
>>
>> The 'companies' problem is that it tends to force a client-server, alway=
s-on
>> on-line mentality. I'm also wanting the original DVCS off-line capabilit=
y to
>> still be available, with _user_ control, in a generic sense, of what the=
y
>> have locally available (including files/directories they have not yet lo=
oked
>> at, but expect to have. IIUC Jeff's work is that on-line view, without t=
he
>> off-line capability.
>>
>> I'd commented early in the series at [1,2,3].
>>
>>
>> At its core, my idea was to use the object store to hold markers for the
>> 'not yet fetched' objects (mainly trees and blobs). These would be in a
>> known fixed format, and have the same effect (conceptually) as the
>> sub-module markers - they _confirm_ the oid, yet say 'not here, try
>> elsewhere'.
>>
>> The comaprison with submodules mean there is the same chance of
>> de-synchronisation with triangular and upstream servers, unless managed.
>>
>> The server side, as noted, will need to be included as it is the one tha=
t
>> decides the pack file.
>>
>> Options for a server management are:
>>
>> - "I accept narrow packs?" No; yes
>>
>> - "I serve narrow packs?" No; yes.
>>
>> - "Repo completeness checks on reciept": (must be complete) || (allow na=
rrow
>> to nothing).
>>
>> For server farms (e.g. Github..) the settings could be global, or by rep=
o.
>> (note that the completeness requirement and narrow reciept option are no=
t
>> incompatible - the recipient server can reject the pack from a narrow
>> subordinate as incomplete - see below)
>>
>> * Marking of 'missing' objects in the local object store, and on the wir=
e.
>> The missing objects are replaced by a place holder object, which used th=
e
>> same oid/sha1, but has a short fixed length, with content =E2=80=9CGitNa=
rrowObject
>> <oid>=E2=80=9D. The chance that that string would actually have such an =
oid clash is
>> the same as all other object hashes, so is a *safe* self-referential dev=
ice.
>>
>>
>> * The stored object already includes length (and inferred type), so we d=
o
>> know what it stands in for. Thus the local index (index file) should be =
able
>> to be recreated from the object store alone (including the =E2=80=98prom=
ised /
>> narrow / missing=E2=80=99 files/directory markers)
>>
>> * the =E2=80=98same=E2=80=99 as sub-modules.
>> The potential for loss of synchronisation with a golden complete repo is
>> just the same as for sub-modules. (We expected object/commit X here, but
>> it=E2=80=99s not in the store). This could happen with a small user grou=
p who have
>> locally narrow clones, who interact with their local narrow server for
>> =E2=80=98backup=E2=80=99, and then fail to push further upstream to a se=
rver that mandates
>> completeness. They could create a death by a thousand narrow cuts. Havin=
g a
>> golden upstream config reference (indicating which is the upstream) coul=
d
>> allow checks to ensure that doesn=E2=80=99t happen.
>>
>> The fsck can be taught the config option of 'allowNarrow'.
>>
>> The narrowness would be defined in a locally stored '.gitNarrowIgnore' f=
ile
>> (which can include the size constraints being developed elsewhere on the
>> list)
>>
>> As a safety it could be that the .gitNarrowIgnore is sent with the pack =
so
>> that fold know what they missed, and fsck could check that they are loca=
lly
>> not narrower than some specific project .gitNarrowIgnore spec.
>>
>> The benefit of this that the off-line operation capability of Git contin=
ues,
>> which GVFS doesn=E2=80=99t quite do (accidental lock in to a client-serv=
er model aka
>> all those other VCS systems).
>>
>> I believe that its all doable, and that Jeff H's work already puts much =
of
>> it in place, or touches those places
>>
>> That said, it has been just _thinking_, without sufficient time to delve
>> into the code.
>>
>> Phil
>>
>>>>>>
>>>>>> PS. Please don't advice to split things up, as there are some good
>>>>>> reasons why many companies decide to keep their code in the monorepo=
,
>>>>>> which you can easily find online. So let's keep that part out the
>>>>>> scope.
>>>>>>
>>>>>> -Vitaly
>>>>>>
>>>>>
>>>>>
>>>>> This work is in-progress now.  A short summary can be found in [1]
>>>>> of the current parts 1, 2, and 3.
>>>>>
>>>>>> * jh/object-filtering (2017-11-22) 6 commits
>>>>>> * jh/fsck-promisors (2017-11-22) 10 commits
>>>>>> * jh/partial-clone (2017-11-22) 14 commits
>>>>>
>>>>>
>>>>>
>>>>> [1]
>>>>>
>>>>> https://public-inbox.org/git/xmqq1skh6fyz.fsf@gitster.mtv.corp.google=
.com/T/
>>>>>
>>>>> I have a branch that contains V5 all 3 parts:
>>>>> https://github.com/jeffhostetler/git/tree/core/pc5_p3
>>>>>
>>>>> This is a WIP, so there are some rough edges....
>>>>> I hope to have a V6 out before the weekend with some
>>>>> bug fixes and cleanup.
>>>>>
>>>>> Please give it a try and see if it fits your needs.
>>>>> Currently, there are filter methods to filter all blobs,
>>>>> all large blobs, and one to match a sparse-checkout
>>>>> specification.
>>>>>
>>>>> Let me know if you have any questions or problems.
>>>>>
>>>>> Thanks,
>>>>> Jeff
>>
>>
>> [1,2]  [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing
>> blobs")
>> https://public-inbox.org/git/BC1048A63B034E46A11A01758BC04855@PhilipOakl=
ey/
>> Date: Tue, 25 Jul 2017 21:48:46 +0100
>> https://public-inbox.org/git/8EE0108BA72B42EA9494B571DDE2005D@PhilipOakl=
ey/
>> Date: Sat, 29 Jul 2017 13:51:16 +0100
>>
>> [3] [RFC PATCH v2 2/4] promised-object, fsck: introduce promised objects
>> https://public-inbox.org/git/244AA0848E9D46F480E7CA407582A162@PhilipOakl=
ey/
>> Date: Sat, 29 Jul 2017 14:26:52 +0100
>>
