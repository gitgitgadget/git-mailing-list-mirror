Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792613121;
	b=GRh0qNT080eKwHCOhMibOkc9J092Beuv8V+MLEKqZolQ6nbNplKu2x1SwrFglcgT1/wL
	 /JAuBfxuQUGCidmfLix2WWXZRYUgBTEnUAAVXOMm3htrmgwFQO+IYm5hfMPTrtJyytl59
	 ycl687owaa3WoAHrTeJFFLf3TNTOjAeLLO1a3CW0cnjg/4lHD1x2v/o3ccErYtE03qarL
	 59aZqTEt0asRuu/pOu8Moeq3WkFTT/XEZohfgeo1CztfdOmihamGH4gtyWg3EH2JfHHXw
	 be3+HDUg1wHLHgwYejPIahf1JRWqqTotBocS0ds2H0ITMM7Ye4TlWyp8ZJBwc/v6JMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8S+4xuoF5zlgYEJ6P74Wmr1Qpy2aDAuuxBXTnlZ8P04=;
	b=2ysEjmll5N1ov+7Mx6HmRW5gRHWy2beilERXkcJX7wb2EDpwGq5dS7qKljtr8b2U8/MI
	 8sXlq9OccT3LAwyZggdLTG3UHQU3DH+4ixTzul1QHc1x1UaATgs7OVSjgeRrlUNJ+lAUB
	 TpaT9yWM2fbxrXwm8UGf+v9q5ymTBvJawCpOPuGvx/RT8lGZ9BY/5xeBwun/KZyd4yn9H
	 4ThtgMn8mC544mxfrMQVm+1shK6yZmpPPN9Pj39smHFAsQ+uLJaASh4wb/K6vrX/km+/G
	 1ewXA2fj4B0QTyJwVkWnIUGE+wgVYC7jDcylWN2T0eS4jNG4/UKs/hAq4SzylhCJFIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oc3VqdTi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C07606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 20:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oc3VqdTi
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337c7b9937so71541cf.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792613120; cv=none;
        d=google.com; s=arc-20260327;
        b=QTaM/IY9v052P67uWUzARLkg9xV01G0pR5DAejVop6/hpaZCJVxnvSFh4lko5aHPAT
         T9YCL65NoYMr9kJhwjZTSN57POAqlvW63/BYAnPjl3B40cwYtyVaYM+BLhtzvZimpfmJ
         CiyN6TputftGvc79B85B4SMWLmCQcf3wsvfxSl+Z7+W5HYfcue/WbIQM4cIaLVZp5oZV
         RbMlA+Zu8ASxtN+4+xTDdC3HlWP7vuupdyFttwzjm5uESgtzZsDIlGP0NTX49RPIgcri
         KLCdjZqqIwF8lqSlU27B/5ttGSIRgnPNl4R3VPre+kMuYJeHbtfaMF+Dtaqj9wHls60U
         4Cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8S+4xuoF5zlgYEJ6P74Wmr1Qpy2aDAuuxBXTnlZ8P04=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=bVoyLWlkqpLB2WLne4mAyjTdZ+/BWNtRmGHqxJaT2excp9sQa+kgfGXG7+vb4PNzFG
         /Gzj5gYr0JrXcjrildbUL8YNwJWKCemuroOEau0vemzem54rmsBvpPkZ6ceYkUHhsgL3
         7gntMaODIXcCF3YCtZ/458ITJEPc60X6ykaVlCYBZikhQn9lL4N+G+erbzU/nWIW+/JU
         nahHf3upNAaFqVx9mKHqbNoNPDCFbFrQVKGwhXyUnXw2jwa9/gpDLucH2zPOMW2HKQtH
         uT0a7BxT1KAFmZ8MEzN2TBrDbKQFhRt/vQshxHOtjTnK84eTMsKGdD5+y2Zq/imqg8C8
         3LCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792613120; x=1793217920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8S+4xuoF5zlgYEJ6P74Wmr1Qpy2aDAuuxBXTnlZ8P04=;
        b=oc3VqdTi94mYt1/COITG06lFholqb/5ytN5ZI5Gi8y7xtxRdURbx456zDgnyiQL4Wv
         tbVI2k3mQ80B6L/714k6euYWt4pnMUaFm+kgRPkYDm2cg4wshInk7ozLAhmEZwIAIG0+
         uSfudfQrVtXJH/96P3ZVR8WSjxu2gbjCaWjMo9MudXIpLUJAPFPz0K3XzCw8gcruQUFM
         LLapvVIk0VSl3snH694D3epJFKdtKCE1cEMqSnHMJi0VMMN6D8PtYWx047CcXF7Ba0nQ
         IvmBSB+rSQ+UTfULHKjIH/ReISAlT2y7CFwK295gej5SN+qQCvBnatASu3VEtdLT7/6q
         smVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792613120; x=1793217920;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8S+4xuoF5zlgYEJ6P74Wmr1Qpy2aDAuuxBXTnlZ8P04=;
        b=0keJSAGYG9i6jngBS7yDV0Z2URjwC5Y/AsZ+HDCkwQvVCn2vwZ8nVI3vXGCAZlaR5V
         yenwbFxaW3AkEDkDK5tit3mGEu5SWu7Sf1GbemcibAW7Eromr7EUQtKtVN1gm9z49Wv/
         Vj6U7Sq6PT1bnlM3klUXyrgy7OYoFpbx/KemtO1fSZr/bLBefOQt5SnPymd/zzSxdJir
         71oZyEw7lxdUENpiFXpgmCF2dUrnkD/WddvkWTlghXlGeWIArtURdR2QVIFkn5fbSi7M
         M9rDel6N2pORy/ReFymaQePsnNyKJSrcfT4+OpzZGILVF74uZher/Wx/k0VgVgmZWWez
         NyXg==
X-Gm-Message-State: AFq9FYLU+mNYElXDvVAxsasThpVa6tNp6iD5t20MMSFRmJ2H+lFjHL7w
	8kHUhU/llR3t8guhSR9veIBN1GgYeW5RTXqFimO9Xv2r5U0BYV94XTqpnOMzEP6xoCHeGGUNNmW
	XiqgNQ2jE0EmdLlTAgzHvki+okbGfiFYLKQGuD1E8GNmSku31oJQGBL53nB8=
X-Gm-Gg: AYBFou1atG2n5PUKmfYcjHpZfm7w/pspOZEz61E2I13P5EBGcjkEKxDYYZx4ckKOP/M
	r4geoCAHd4u+I5UUNfsi4+Tbr90bnBJfVo+MUKIFe10wlxD0Hmx/M78mpJ8kwn6E/X0AIixj/rX
	Q5W3TeiP/6qGkZnnZ16JIaxWoOOcISG/Cq4e1vYEzTVpYZ9TbD9TZibVxYt9gEhI0qzKrePEjl9
	dhD6o/j4i6YJziwgi0UVV/AbV2FiWI9bS/8MXWvW/VwN1qLtAcsxxzQwJPvNpRLyLSQULrJwwpz
	310pOC87Qos097AXloPrVmZVe8f1TmjTEo/mpTXgwznqVwo6XIqOol56Nq/NDralmPbv02sbeOy
	xmbx+hxDq6MC6Pz/wQcUPw8rHMkG38zb+ZDX0lI9FTkfj46QMRuJpLjqRwnTB5UQDu/yXyAaaUt
	nJI/DJlS9VrEC0csHvkOMPwv/uOEbk1+SvlcTBigku8a0Lz/NxRGyCHc0p
X-Received: by 2002:a05:622b:48:10b0:536:353e:8d2a with SMTP id
 d75a77b69052e-536ae90b909mr2141871cf.1.1792613119157; Wed, 21 Oct 2026
 13:05:19 -0700 (PDT)
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
Date: Wed, 21 Oct 2026 13:05:06 -0700
X-Gm-Features: AclHuK_QrQPfaik0HAVjNFI92bE_QfGiGB_zn5TJsXvyIKeTs2VQmIHzXM5S49o
Message-ID: <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
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

There are a few appealing options.

* Debian uses devotee (https://salsa.debian.org/debian/devotee), which
appears to require hosting. Finding neutral hosting may prove tricky.
* Konstantin let me know that The Linux Foundation's Technical
Advisory Board has used CIVS (https://civs1.civs.us/) in the past. He
says he wasn't involved in setting it up but doesn't think it looks
too challenging. CIVS and devotee use the same tallying algorithm.

* jj used voting on a GitHub poll in the past. That would just give us
simple majority, and it would require GitHub accounts, which may be a
barrier.

These all have their pros and cons; devotee and CIVS seem to me to be
better suited to many options that may be somewhat similar to each
other.

The other factor that I haven't dug into too much is how to only allow
eligible voters to cast a vote. GitHub isn't a great fit for this,
we'd need to collect GH IDs of every eligible voter and put them into
a group or something, if I understand best how this would work. CIVS
emails a link to each eligible voter - since I propose basing
eligibility on mailing list participation and patch submissions I
think there is no problem there. devotee also appears to be email
based.

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

The specifics of this eligibility rule can change a little. I'm trying
to figure a balance between a few principles:
* Not all contributions are code (e.g. community moderation is
contribution but a moderator may never send a patch). I think in the
Git project we have less issue with that, because we don't have a
community moderator unless we're counting the mods in the low-traffic
Discord, and I believe all of those mods have code or review
contributions anyways.
* Avoiding dogpiling. This is my biggest fear, Git is a very
well-known project and there will be a lot of big opinions on the open
internet once people know we're voting on this policy. I want us to
measure the opinions of those who participate in the project, not the
opinions of random passers-by.

* Easy (scriptable) eligibility determination. If we start to explore
other types of contribution, like user support in non-mailing-list
platforms, it becomes really difficult to send a ballot to everyone
who's supposed to get one.

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
