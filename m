Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380573;
	b=p1bisMUdpb8NFGGfE7iWD9cT+clad8EI3fx7d0OsbTX56W1j72DhD0g1vP9u6o4v9kRa
	 VEKrDAMbnIQ5ojmYjmvJa1RJS/EdRliKQSLZmgZKHqJLxh6XAz7EyWsfZpHox4NFOecJj
	 abg4nsvhtKuDkCMR8kow+aTCcc9gQysKfzg8dFXrCtWQbV0lB1UJt2RRhRreQTEBuX1Nx
	 Sci+gDOPyB22+T6VHwzvCz1jd8L6g9r8u/2rC5rloBWFK8Sb6IhX7p5DRx7UWlbLNsaeo
	 g80pLQujrR3eF90x34g9kUK33KFqgrz3QBdmqVHPJ85FTPPeX5TTWnE63esx2IAX7Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=aBXQnRWd2l8s3ju5lydCM3xwkIyz6QlsH1Pd50JqbTE=;
	b=jGYK8DRarxovg64gQCX89tde76v84a7blXSt57Q30AGp6BlVMYKV4eO92j+wYBdihGAo
	 jLsrCvKUAS6MYKpz5bjMqdK3JbHpyUNnG0exqKUyg/Q5GJWGvIMqn9LTAe8lIT3ncm3Yr
	 mMcScrh2YZ+3fRMxmc/Ur8aUp6RZpnTV7+nDaIa4hXaEo01sN2KfP/4IoZ3egyRmg9+SB
	 9UFgZk/jbBJsMphtQP+12ZBPAW1LgiBndAWOIQfkch5EKR7+o/47NaAaq/Z69c/6fdFZv
	 5AYTlTxYMACZonlCmIdw0XrCnqYB2NPKGn2nI4oNbGumZ8jrl8f8WmJdCmZyxy3dBeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TxIQEALi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F1606A32A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E49F1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TxIQEALi
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5337c7b9937so5761cf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793380571; cv=none;
        d=google.com; s=arc-20260327;
        b=odBN0fD5o7um3cf8nLLJqBYDw4RZ2ppOaSESxmqV9nyLIhmMa+Kqjgea57XlWCBmlV
         7eJwNzcTdxgTojch5LB4zmwDgFZm8OHDIFe9MrcpowYZAkJkyuH1NcAapCLeb3DyeUbp
         k2NZPjqB3LxPVWSlAzf7sTCkI6II7txd9GsF4OA/kc+e3jxlusTL3T+0V4mMlJ28NUgP
         +wXVvS+W46TCh8QG/8REvDxNp99115ZbqPYfPUGX/OMt7olPgV3ZjiMjfZIrhrRH1ygt
         HfYSalmH8hK2tEyMzKguNfg8enFnaQmORSDH3ZG/660Apws0A9wlmmXJ1wj8idyr25gr
         Dovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBXQnRWd2l8s3ju5lydCM3xwkIyz6QlsH1Pd50JqbTE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=foKOFWx/AjP+t8nVAoiNV4cY0Di8CQG72PcbrmmAgvRzmqgU+KRPmo6eNtWKiMAYL/
         vLn/hVD5tII8bu4lmR/tTIMdwnGcsAieCf1LTsuXELj/+DwZhObw54tIKtt848SuULDi
         Z01tDu/8m6cpUJEEHlolRRiRxdY9mtmlvol9BQxkKrC5csFAaa2WIkTVJyE5QSb4U02l
         G2x46N0ImUljQXzJlD75IOc2fdUbmosv1B0/bEj/8nXksgrsVRIcVGQKN5ofs9VZRHYk
         h3L8uALFboTbeMFpQs+hCnEMmePdsuJSPc2DXtcxVbC7s81uqhEx87xYC6vppqHhZ+Y4
         MhTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793380571; x=1793985371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBXQnRWd2l8s3ju5lydCM3xwkIyz6QlsH1Pd50JqbTE=;
        b=TxIQEALiRlujeAQ5Q04x+5KyMgKZEa5B0aCGvrIOGncJB0gqeS1LBDlSMAyfnASpEH
         GeEGu875IbEpZjauuFZr8uJOBLxSU93xuHXPDhx62fmaYa71LsTawGWybSXQ8WbmbSxh
         aiKKHxXJTWMlm4OiVIhyQLO3jJqIWfDPPYJEoDscvqgFAWVG+1UFajOgeB9Y1Yhq1rKQ
         R9PmNMNaaSVxjAAME+7Lq3Zxa8R3JOvaKxFjuRKMfnVcHQXkHCgBtmG+hSJ4zL3DV91P
         ARclK6lbKhALW7RazM96NR2iw9kVc7F4tDFCsOzVLnk0biTZang2WVTHFI8Sl4Fjjs9L
         Xugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380571; x=1793985371;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBXQnRWd2l8s3ju5lydCM3xwkIyz6QlsH1Pd50JqbTE=;
        b=KxwU9GFE82PFnbsytQleC7WACq20fsGamQOByyxRvZfslxL56tzreI5SJOQCh5y+WJ
         4NKW8wtOTV9d+m+FU3ci5IoETxtu1QvYMAaHjFqF4+qQt5Ztu3Uo+i9xcpdgM6sStjTv
         ceNS28l8CMMB7Pk+zwyY2XsZEV14rFyUYtbFNL/g7AIn/TyFSlKL1EkM3XnHVi/yIlJe
         dsP+v96jQtn3QgUIA5HDFe9ur3i78cLqFES6s4ozOKpNsU/F8vwWL3329zB4F8eeZgGp
         QGVBvZ+dXGVhnaMaZBseBOZqd3elM+L0NQtv2WEDqNGSel5jdvHiVpoojAanOw50UPXj
         cwOg==
X-Gm-Message-State: AFq9FYLfLE9BJuUT5i3pFqX9X5NzoW66/Vqkkrz7tHJTdK7B9+ZnxJUi
	taGra4Dn9leg2sSnXjMTg0+oaUpG35qd6DwHVzTCAwcACfMQ6qJ6mEsu+KaBmGPBa1t7Jb/K2ev
	d7sizoCD84FnEFxunGFT1t/pfg+py1C9NwNJV9xKVTCN3D7JircLvPASCMXU=
X-Gm-Gg: AYBFou1G7i8mtFdkuYI7FfN9qZwl8Nt8eM/ayl0NAKNamv2rZl+Ez+E/6g276ab5fAy
	3Vcar1LcunFN+9oXuLfFAWTDGdiYkVwEVgJtwxnw/0nw20nizuoGe2bFM0njloeouAuJ7mbjIP1
	UlVQ70fot7VClQMwtuteysAh1rYajVkOinDkwefGm+//q5pUhd5Z5RNNLNj2isHbisEbkynae3t
	fJIQw/EV6C6x1GGqJ2hS1I7YJOqk6vGMpYmMy+n8Xruq1vMswMnbwz2XI3/sc6UnOQUWu2JQYMk
	O1tkDRmIpCpdxTGmVQe+4xWF4mre/4EjANu1HPPD/K7krPpGWpMFqxviVwIHD5CasUA9uWsUy8w
	s+oDbUKkHjsyZd40sUXbICVkEBjeaXJlIEN5a3ymTaFCNmYUiavIGxZeqNpD7hBxofVwAdKYhap
	fM0sEIbWwkIrfij/WlDFHMXw==
X-Received: by 2002:a05:622a:480c:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-5414f4bf7c5mr48714211cf.14.1793380570391; Fri, 30 Oct 2026
 10:16:10 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com> <20261021200341.378978-1-emilyshaffer@google.com>
In-Reply-To: <20261021200341.378978-1-emilyshaffer@google.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 30 Oct 2026 10:15:57 -0700
X-Gm-Features: AclHuK9P0p48ConNlFALmnU-V8t5iRkzMP7rJedY_WknQ_n8yLCCSV2ZC5QA_Po
Message-ID: <CAJoAoZmyADCU8VdVDrvR-OuDKybSnT2pMOKbrofRBg6YdpxZ0A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:03=E2=80=AFPM Emily Shaffer <emilyshaffer@google.=
com> wrote:
>
> Not all discussions can be settled by community consensus. For truly
> contentious decisions we need a way to democratically make a decision
> that represents the majority will of the project. This doc outlines the
> methodology we use in the rare case where we need to vote to make a
> decision.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Hi folks,
>
> Thanks for your patience with this taking much longer than I expected or
> wanted it to.
>
> As we discussed in the Contributor Summit this past September[1], there's
> interest in taking a formal community vote to decide whether and how to a=
ccept
> AI contributions. The topic is of course a very contentious one, and I do=
n't
> think that we're going to come to general consensus the way we have on mo=
st
> other concerns in the past.
>
> With this patch I'm trying to outline only the process for collecting the=
 vote,
> NOT a proposal for the AI contribution policy itself. I'm interested in m=
aking
> sure that the Git community is able to be heard fairly, and that we don't=
 end
> up dealing with tampering during the voting process (e.g. non-contributor=
s
> dogpiling to shift the vote one way or another
>
> I expect the approval of the voting process itself to be fairly non-conte=
ntious
> (or else I haven't managed to write a fair process!) so for approving the
> voting process, I suggest we use a similar approach to the one we did wit=
h the
> Code of Conduct back in 2019[2][3]: discussing the process itself, ultima=
tely
> coming to general consensus, and collecting a list of Acked-by: to put on=
to the
> commit outlining the voting process. And by the way, I do think that we s=
hould
> check in the voting process; it seems likely to me that we will want to r=
evise
> the AI policy again given the pace of development, and it may be useful f=
or
> other discussions that we've had trouble resolving in the past.
>
> BTW, there are some parts of this proposal that I still don't have a good
> answer for, so look for my self-review immediately to follow, highlightin=
g open
> questions.
>
> [1]: https://lore.kernel.org/git/summit-2026.94e33e9ddf234334.06@ttaylorr=
.com/
> [2]: https://lore.kernel.org/git/20190924064454.GA30419@sigill.intra.peff=
.net/
> [3]: https://github.com/git/git/commit/5cdf2301d4a8b439f89fd2cdfed13736cc=
d64a30
>
> ---

I was hoping to provide a reroll of the policy this morning, but I
think there are still a few points that we should decide. So I will
make a summary here of the changes I am going to carry locally for
now, and then the questions we still need to decide as a community.

Changes I will make:
* Modify the subject line so that it makes sense after merging, from
"Propose..." to "Specify..." a voting policy.
* Make explicit the requirement for secret votes.
* Specify that we will vote on _only_ the most recent version of a
proposal (not an earlier one), and that votes should refer to the
commit ID of a patch in Junio's tree, not a particular subject line on
the mailing list.

Questions that remain open:

* Which voting platform should we use?
I think there is no serious consideration being given to GitHub polls
- like brian mentioned, Git has never been dependent on a forge before
and there's no reason to change that for this particular policy
adjustment. But nobody has made much noise about CIVS vs. devotee vs.
a secret third option (in fact nobody brought a secret third option).
Both of those platforms use roughly the same model - Condorcet - and
while CIVS allows you to choose a tiebreaking method from six options
(https://civs1.civs.us/rp.html), devotee appears to support only the
method used by Debian, see section A.5 at the bottom of
https://www.debian.org/devel/constitution.

It also appears that CIVS has a hosted service (that same
civs2.civs.us) which means we wouldn't need to set up hosting
ourselves. However, we could - Konstantin Ryabitsev mentioned to me
that he thinks it would be feasible to set it up. I believe that to
use devotee we would need to set up hosting somehow ourselves.

If it's worth anything, my opinion is that CIVS looks friendlier to
set up and use - doubly so if we decide to use the hosted service
rather than to self-host. Although I don't know if we feel concern
about putting our own project business on a host we don't know... at
least the person running that site definitely isn't working for one of
the big FAANG companies or forges ;) so we can assume some neutrality
that way.

* How should we limit votes?
Universally, people don't like my proposed limits - that's fine, I
didn't think very hard about them because I assumed that there would
be a lot of discussion on the parameters :)

I see suggestions across a few criteria:
* Number of topics appearing in any released version of Git.
* Number of commits appearing in any released version of Git.
* Number of commits appearing in a released version of Git in the past
<N> years.

Peff has shown some sample numbers for the latter two criteria in
https://lore.kernel.org/git/20261026011731.GA3575069@coredump.intra.peff.ne=
t/
and Junio has expressed support of the first criteria in
https://lore.kernel.org/git/xmqqfqxylnct.fsf@gitster.g/ (towards the
bottom).

I am about to go on vacation, and then help host a conference when I
return - so I expect to be unable to respond again until November 12th
or 13th, or maybe even the week following. I will try to at least
check back the week of my return and see if there is some kind of
consensus. When I do, I plan to start by drafting my reroll from the
list I included here - if there's something I missed this morning in
my reread of the feedback provided so far, please feel free to point
it out to me.

Thanks all for the friendly and spirited discussion so far.
 - Emily

>
>  Documentation/CommunityVoting.adoc | 100 +++++++++++++++++++++++++++++
>  Documentation/DecisionMaking.adoc  |   6 ++
>  Documentation/Makefile             |   1 +
>  3 files changed, 107 insertions(+)
>  create mode 100644 Documentation/CommunityVoting.adoc
>
> diff --git a/Documentation/CommunityVoting.adoc b/Documentation/Community=
Voting.adoc
> new file mode 100644
> index 0000000000..155acc9777
> --- /dev/null
> +++ b/Documentation/CommunityVoting.adoc
> @@ -0,0 +1,100 @@
> +Voting in the Git Project
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +For the most part, technical concerns in Git should be resolved by commu=
nity
> +consensus - either on the mailing list or in one of the annual-ish Contr=
ibutor
> +Summits. Voting should be used as a last resort when the community reall=
y and
> +truly cannot come to a compromise on a policy decision. As such, the ini=
tiation
> +of a vote should be generally agreed on by the mailto:git@sfconservancy.=
org[Git
> +PLC] or primary maintainer.
> +
> +The voting discussion should be held to a single (huge) thread, to make =
it easy
> +to refer back to the decision process when looking at the successful pro=
posal
> +after the process concludes. The thread may be structured like so:
> +
> +--------
> +Formal vote: Commit subject line style guide
> +  Re: Formal vote: Commit subject line style guide
> +  ...
> +  [PROPOSAL] Require emojis in commit subjects
> +    Re: [PROPOSAL] Require emojis in commit subjects
> +    [PROPOSAL v2] Require emojis in commit subjects
> +      Re: [PROPOSAL v2] Require emojis in commit subjects
> +      ...
> +          [PROPOSAL v4] Require emojis in commit subjects
> +  [PROPOSAL] Require Camel Case In Commit Subjects
> +    Re: [PROPOSAL] Require Camel Case In Commit Subjects
> +    [PROPOSAL v2] Require Camel Case In Commit Subjects
> +  [PROPOSAL] forbid capitalization in commit subjects
> +  ...
> +--------
> +
> +A formal vote has three phases:
> +
> +1. Proposal collection and refinement
> +2. Voting window
> +3. Implementation
> +
> +Phase 1: Proposal collection and refinement
> +-------------------------------------------
> +
> +Proposals should be formatted as a patch to Git's documentation, for eas=
ier
> +review and implementation once landed. Anyone who is eligible to vote is
> +eligible to submit a proposal. To avoid noise on the final ballot, a pro=
posal
> +will only be added to the ballot if it has been seconded by another elig=
ible
> +voter, indicated by a `Seconded-by:` footer in the patch's commit messag=
e.
> +
> +After the first draft of the proposal has been sent, the community is
> +encouraged to discuss and polish the proposal, just like any other code =
review.
> +Keep in mind that these proposals still need to be voted on, so it is li=
kely
> +counterproductive to use the discussion period to try to completely chan=
ge the
> +nature of the proposal or the mind of the author.
> +
> +This phase should last around 4 weeks in order to provide plenty of time=
 for
> +community members to write proposals and respond to feedback, and make s=
pace
> +for contributors' individual timezone and availability differences. The
> +maintainer or PLC member who sends the kickoff message should also inclu=
de the
> +closing date for proposal collection.
> +
> +It may also be useful to invite expert feedback during this time, e.g. f=
rom
> +Software Freedom Conservancy's legal counsel, depending on the topic und=
er
> +consideration.
> +
> +Phase 2: Voting window
> +----------------------
> +
> +The final version of each seconded proposal will be collected into a bal=
lot at
> +the end of Phase 1. When the ballot is prepared, eligible voters will be=
 able
> +to vote by mail for two weeks, to make space for contributors' individua=
l
> +timezone and availability differences. During this time the proposals ma=
y no
> +longer be altered; the ballot should refer to a specific version of the
> +proposal (e.g. `[PROPOSAL v4] Require emojis in commit subjects`) and an=
y later
> +version of the proposal will be ignored.
> +
> +Votes will be decided using <mechanism TBD>.
> +
> +Phase 3: Implementation
> +-----------------------
> +
> +When the voting window ends, the winning proposal should be merged to `m=
ain`
> +without delay by the maintainer. The commit message should be appended t=
o
> +include a link to the top of the voting discussion thread so that the
> +discussion can be revisited by history divers in the future, as well as =
a brief
> +summary of the result of the vote (% in favor out of total number of
> +proposals).
> +
> +Voting Eligibility
> +------------------
> +
> +Votes are welcome from contributors who have authored a commit which has=
 been
> +merged to next, or who have provided 2 or more code reviews, and who hav=
e not
> +been banned from participation in the project. All eligible contributor =
votes
> +are weighed equally, regardless of the overall number of contributions t=
hey
> +have landed.
> +
> +To prevent dogpiling, contributions are only eligible for a given vote i=
f they
> +landed before the beginning of the voting process (the kickoff email men=
tioned
> +above). That is, the code reviews must have been sent or the patch must =
have
> +been accepted before the initial email is sent. The intention is to ensu=
re the
> +mailing list isn't spammed with low-quality reviews during the voting pr=
ocess
> +solely to increase the number of eligible voters on one side of the issu=
e.
> diff --git a/Documentation/DecisionMaking.adoc b/Documentation/DecisionMa=
king.adoc
> index b43c472ae5..c08fb7abd5 100644
> --- a/Documentation/DecisionMaking.adoc
> +++ b/Documentation/DecisionMaking.adoc
> @@ -72,3 +72,9 @@ We prefer that "official" discussion happens on the lis=
t so that the full
>  community has opportunity to engage in discussion. This also means that =
the
>  mailing list archives contain a more-or-less complete history of project
>  discussions and decisions.
> +
> +Formal Voting
> +-------------
> +When a decision cannot be reached by general consensus or compromise, a =
formal
> +vote may be called. See link:CommunityVoting.adoc[Community Voting] for =
details
> +of this process.
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index f8dea4b395..314b8dc8f5 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -113,6 +113,7 @@ SP_ARTICLES +=3D $(API_DOCS)
>
>  TECH_DOCS +=3D BreakingChanges
>  TECH_DOCS +=3D DecisionMaking
> +TECH_DOCS +=3D CommunityVoting
>  TECH_DOCS +=3D ReviewingGuidelines
>  TECH_DOCS +=3D MyFirstContribution
>  TECH_DOCS +=3D MyFirstObjectWalk
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
>
