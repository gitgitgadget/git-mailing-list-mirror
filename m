Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762076;
	b=wSAqY4MPsH9tMFm1AiVF5GELhlhOd24mFBWNBZEKCgH3K9ym7N2dm//lTVaAITBFuN+q
	 s4atOKmW4bisjt6dn5/r8M/ROfbjs0Fi/3oANkGMU2EFW7wMGZ2FGbWnljPUajgqY1grV
	 xfQKDyf/zjH/73D5e64MoUNb2KOybVbGH6pomrczjo9AhM+E0llqi7x3AOIpLHIja4T+9
	 i7DU1UIzsjFhwCcLWk/7YQ/QG+uwlXP4WbyjZpdZZ/B67jpjbdeo6EmwF8JD4Q+OBTtfY
	 brGymN/6KKXZ9zLpjMsJD2tYP/RGDQozhlVR28yZbZTXPCZCpzy94YFCB0WE1R5bM4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=x0zZMYkKZGs6fp2M3DYiGrPPpRIqkI/gdrj8KL2OlJ4=;
	b=hIdECN+Tt5jN25EUDH4cy5Z03sBm55hqwnuUz7zTauNFsSRWrO9ugk6v65oZl5MHrevC
	 gDivh8FLXzV0z9rLafMetnfid8JeKxXLR3XI38K2pLLQaFFyqevgeL9/P8mwXQZHRGP/V
	 IHph7hGfbcho9VJiyE6QFoK4VxKZIvmkO3qUal3J5YCly0pVjArUM/uUSnbsb/eCyyxLK
	 T3FJ8sbZO9Q082d2Ofiq7H92fVyW3XhgmDqUYrVhqU0P9ZRile4Q3M2bUKk43z9aAPdb1
	 tY/jb3Kw77dtm3A+qam9MVVKmXwQn2C0xrQdbBE65jeOnZtOsnEtxe+ooDaj+HHClCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FLnmpCDW;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD6606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6BD6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FLnmpCDW
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b09e07e149so7990287b3.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792762075; x=1793366875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x0zZMYkKZGs6fp2M3DYiGrPPpRIqkI/gdrj8KL2OlJ4=;
        b=FLnmpCDWYaHHcqt3+k2phRbT6Ro7arVqJTAqwAXUIwpJ5sw8wloq2/Bjc12Nrw+wp5
         PxoGjtEkBdQgp2wnA66Daa4zg7aNgiPqvtCW/L99knQ/3gJUhTrRZDXpc2eLetfLxuhH
         yLCz0cY0F6B0ZAY/ZJIuMeUr8rrwxOwhfVXkE4oyXifC6Tut8VfuOHChJDrtqamIpu5A
         kGPvd2hzUL62RkS4Sno+/ZBCYbtfNDD4lIqOWXnZuu56wiKpu/o2YxxGZ3Bdsize1epT
         itt7ER3mrew0KFZnZCCfQ0mvcts8yjC0JmCYZdk8hA3rOu+UaH/qIJwC+klstBXD/7Ct
         G/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762075; x=1793366875;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0zZMYkKZGs6fp2M3DYiGrPPpRIqkI/gdrj8KL2OlJ4=;
        b=PBdRpdqdGK45U5SUSuteKAXbkGBKq0rTiPTtotHgyKXH7oKp/8fn4hB0U2Bt9Wom3d
         3I2We/i+HhJI5uW0chPw5cwzGXZJng08O8TX+KzRMt+iQArDdPMmARxRjyJ2qUp5x6Nh
         7/wRwEerBBSpfO9zFZ6Dkh2yGWtTX55F7meKK8ed8im1yGeTdWthmzF0027eRwbv1b4G
         N2f8+5gb81uqPnOy8qYX8tU6rXs0UckN2Wqz19BQtdx650adZ9fKs80nuSZLwOxhgIjw
         QKylHod8h3SjGNK+Mv1BiSpyRg6/O6+ubp9CxAOcvzHoBIuOir3lXVg+OKydpnsmQeKO
         9U/Q==
X-Gm-Message-State: AFq9FYKFOCuV97kipR8K90fUHOorzCGTgXKaV3cdDh4QKr/zLLEQIocn
	MLbW3chEfqg4O7eAv0Nk8JfVPc1bbGuqJpfEbLnT6LNSiqdlEC4QfOwf38oWLX1u
X-Gm-Gg: AYBFou2ALymRpDqSGe34wg2T/MF0u4vlYtUwslYUtot3U1kxuqqQWpprtrkfd4KFx4o
	SVjCoVwikRzECABmY06qMwKhk/V+mIFWNPmiONhNwbht/9FRcDHQnTq6mwGWFSqhtrIjIKpluZg
	AegmhnH8lVLxdmi/SVd0EzoEaGznaeLsSwuJibt41hokGBqe4yMc1U2C80CNLTStTIxMlvG4fdO
	eZHBPwWJiKWCszI4EgUFfD0hdiUjaBKYW85vEeOSFAwQC7aDQ3fUrmWReRtPLaBFP0q65TniRj7
	dK9aDeifx9prnvPFqAx/E/Cm3Xaot2s9U3vGOeEn1qK62tguVVE8J1G943EyXvV2kbRYqceqPOI
	20r4pi4/ctHlYCs4qXCX6qsmPyC9hG7HPfprOuAiL+md5QjXdw5HIFJrWmQ9w4aNHXW33I8U8dK
	ZrAE6kQKugRjyW1YaNy/ql6kGMmwip1VBvuMlQFgUiXRzAldOE/cg5cnd5YdtAz2JTlndIpDLR7
	OakA8JvRpzCbr7hOgoUANI+X8fYtiPWSs4+6Pfi7fskuA2XJxgxZSphfBc/2sPIrvQlbW3yziZ4
	lyFaSRMu52cNTV3eEy/m0Y9fzi0zVDVf/0OIAA402WLKtf2BoH0VsR2/4cn7dFvEX/DXMrhxJBw
	K7ZY=
X-Received: by 2002:a05:690c:dc5:b0:8a2:496:1985 with SMTP id 00721157ae682-8b157d50be0mr16197707b3.54.1792762074786;
        Fri, 23 Oct 2026 06:27:54 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9d17:3000::3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156183032sm12898647b3.34.2026.10.23.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:27:54 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] stash completion miscellany
Date: Fri, 23 Oct 2026 09:20:50 -0400
Message-ID: <cover.1792761643.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.237.g5414b88716.dirty
In-Reply-To: <cover.1791827304.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This short patch series takes care of a few paper cuts in stash
completion. The first patch is a small code cleanup I noticed a while
back while working on bfc1b34859 (completion: add stash import, export,
2026-02-07), I think. The next 2 take care of a problem I've been having
with Zsh's completion of stashes (cf. Unix & Linux SE [1]).

[1]: https://unix.stackexchange.com/q/807580/301073

Changes in v2:
• Reworded a few commit messages thanks to Patrick
• Clarify the behavior of the final patches with completion for "git
  stash save" (also thanks to Patrick)

The final 2 are not only about completion; I noticed we were
special-casing save completion, did some digging, and was a bit confused
by the status of "git stash save". So, I figured while I was here I
would start a conversation about (a) restoring the git-stash(1) manual
to it's "no save" version and (b) ripping out the special case.

These last 2 may be controversial, and I'm not particularly attached to
them, so if they need to be dropped I won't really complain. OTOH,
what's the point of a deprecated subcommand we still advertise? ;)

Generated-with: git format-patch @{u}.. -o p -v2 --range-diff=@{u}..d1d0bf2d9a7d380d10771b5d1bceb8db91c5f05e --in-reply-to=cover.1791827304.git.ben.knoble@gmail.com --cc='Patrick Steinhardt <ps@pks.im>'

I accidentally left the above line in v1, but I'm considering leaving it in from
now on? It's the exact command I run to generate patches; I store it as a
"trailer" in the branch description, then run "git generated-with"† which
(effectively) does

    eval "$(git bdesc | git interpret-trailers --parse | grep ^Generated-with | cut -d: -f 2-)"

where "bdesc" is an alias for

    git -c core.editor=cat branch --edit-description | git stripspace -s

Anyway, I've been hand-editing them out of cover letters for the last few
series, but if it doesn't bother anyone I'll just leave it around. Might be
helpful for new folks learning how to format patches?

†: https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-generated-with

[1/5] completion: simplify stash subcommand completion
[2/5] Completion: extract common stash listing code
[3/5] completion: fix Zsh handling of stash names
[4/5] doc: drop usage mentions of "git stash save"
[5/5] completion: drop "stash save" completion altogether

 Documentation/git-stash.adoc           |  2 --
 builtin/stash.c                        |  1 -
 contrib/completion/git-completion.bash | 22 +++++++++++++---------
 contrib/completion/git-completion.zsh  |  5 +++++
 4 files changed, 18 insertions(+), 12 deletions(-)

Diff-intervalle contre v1 :
1:  d0e461a14a ! 1:  90d36b6445 completion: simplify stash subcommand completion
    @@ Commit message
         The stash completion helper contains a hard-coded list of commands, but
         git-stash provides a mechanism to list such commands
         (--git-completion-helper). The pattern for using it is wrapped by
    -    __git_resolve_builtins, so use it, bring _git_stash closer in line with
    -    other completion helpers.
    +    __git_resolve_builtins, so use it, bringing _git_stash closer in line
    +    with other completion helpers. As a nice side-benefit, this also adds
    +    "store" subcommand completion, which is missing from the explicit list
    +    of subcommands.
     
    -    Note that we maintain the "save" special case, since it was removed from
    +    Note that we maintain the "save" special case†, since it was removed from
         default completion in 0eb5a4f911 (completion: stop showing 'save' for
    -    stash by default, 2018-04-20). We don't have to do anything special with
    -    the exclude (3rd) argument to __git_resolve_builtins, though, because
    -    save is already marked PARSE_OPT_NOCOMPLETE.
    +    stash by default, 2018-04-20). One might think we need to give "save" to
    +    __git_resolve_builtins' 3rd exclude argument to prevent it from
    +    showing up, but we don't: "save" is already marked PARSE_OPT_NOCOMPLETE.
    +
    +    †We don't complete the "save" subcommand unless at least "sa" has been
    +    typed, but we do complete its options if explicitly typed. With this
    +    change, we will complete "save" if GIT_COMPLETION_SHOW_ALL=1.
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
2:  6c24a833fc = 2:  abf8efb792 Completion: extract common stash listing code
3:  22283a1d5f ! 3:  f4f6b89ff6 completion: fix Zsh handling of stash names
    @@ Commit message
     
         From here, the list-choices widget (on Ctrl-D by default) will show
         stash@{0} and stash@{1}, but the complete-word widget (Tab) will just
    -    add another brace. Zsh things we're trying to do a brace expansion, I
    +    add another brace. Zsh thinks we're trying to do a brace expansion, I
         think! Interestingly, using menu-complete (Ctrl-N) does cycle through
         matches, since it's taking a slightly different completion path in Zsh.
     
         We might try to fix this by passing surrounding single quotes (using the
    -    -S/-p arguments of compadd, which we can do via __gitcomp_nl's other
    -    parameters), and indeed Zsh will generate
    +    -S/-p arguments of compadd, which we can do from Bash in our code via
    +    __gitcomp_nl's other parameters), and indeed Zsh will generate
     
             git stash show 'stash@{
                             cursor ^
4:  985a14f18e = 4:  3762f9d5bb doc: drop usage mentions of "git stash save"
5:  d1d0bf2d9a ! 5:  0266646fb4 completion: drop "stash save" completion altogether
    @@ Commit message
         further documentation suggesting to use it.
     
         Since we recommend push instead, stop completing for "save" and remove a
    -    special case in completion code.
    +    special case in completion code. It still appears for "git stash <tab>"
    +    when GIT_COMPLETION_SHOW_ALL=1, and when typed explicitly we still
    +    complete options for
    +
    +        git stash save --<tab>
    +
    +    which is helpful for folks with finger-memory for save.
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: _git_stash ()

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0.237.g5414b88716.dirty

