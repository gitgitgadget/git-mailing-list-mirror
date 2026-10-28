Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146533;
	b=zLzDl3gvR3crHeOaLj8cdeTG0hepKznTYOZo0zuChyhKR0FmsknPSPZASFhGE0k5K8Vr
	 eErOco1EOhQZUgRr9/T/yqHQoWj8GpLQNtDqr37YSlA5j5u4v2+qSKcy6jRTwEY3lvyQG
	 6/E6Vbzp0+SDo199fMR57lg1zTTSb/u4pDdLSDDtitGoHGM9eB+PYbbgVLVsVgFxaNyRv
	 JISKeoFEJES135EE4KzAMr82r0tpA5kQAo4hKYtxyd8Co2rnHy0hglhMF4Li8C6mCxZku
	 aY4V3oQeucDpPlwIlVRxmnhr1whafn3pQ1mAvgkZm97fYM/jiF+E8UFiH+djtLPVpeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0kufzUFQ8a5cekKgSVKYdYZlTro9zGZLuNn1kSFvO2Q=;
	b=BJ5Z3m+tjJu5K4lzd6+p8glZw066mbr4Ab+wUSAbxAcjoYDnwl0AzX0+2Kn42fgqNYQH
	 UEKgdMCoS5C7MnrQIyYuEqsbDTd45LMfAW6dzU6owBew9dA5ma2nDsBAzO77798qZRM32
	 gi8S9jrvMpnGL/m0Sm7A3JdnX35M8EfiuQgfyi27b1Zn2tOS+x5gBELKRJ3+GJg7i1QMb
	 IoyvsxyINuh50ghp1C+nlYZab4DpuZpG5EKqm/W7Erfqb6tCpr+i39AhQAazeDbkNclpQ
	 McsAvG4SelYTtjdFWB0+5W8qwPmw7WcG5vA/ApOv4RQHFpC6jGF5lUhmLBLUZQq/ewA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KrpMgTrk;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1299606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 00:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1299606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KrpMgTrk
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53667180af3so6092471cf.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793146532; x=1793751332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kufzUFQ8a5cekKgSVKYdYZlTro9zGZLuNn1kSFvO2Q=;
        b=KrpMgTrkq5UC0T+9KvY0eWagng1YzKNzm5phtyLqjS1cdx6lyN+ILI5//YeADS4BPU
         dPlDMZq7pcJy1ELXDiqhOVl//1v4Kl8U9YopunhIXeqvDJupJrD2HuefyY+ikijqqrXs
         kUU9ZDzvmEqNVMK1Ag9KNMfSG+6OJkdxN1iPtxNdy27v5GLY3+7/uK6YQm91smBVssuo
         89ALeKIpGraAXhnqNk1MbSp81lcuw3WaRZ+Lq/GJ5jeYGkrP2UY9KFLyLAd23QqLYLuN
         vV7AnzGVZDkF/ZXQBgYeVBItcMSasA8qisTA2AWjauM9/mN/UtDm4IUTExzWyHDEBQ0K
         4eAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146532; x=1793751332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kufzUFQ8a5cekKgSVKYdYZlTro9zGZLuNn1kSFvO2Q=;
        b=KAf0dw6ZFV9Ljf7Dw1SuEkgUSrIS4wcucS0V2W5LqL6cqPax5kB1qDL5XDXH3gOP7n
         5W+szMPiEoun+HUF48xxxxV96Ix41hnYH6E5TGsubYYEUzFk++ftwKq2HeagDXXiOkAH
         H1gRaplOnZyYG3vfqk2/5bEmV8yjGOUOaJ3FZJkuGE/CbGNN+8cFKmnrfXSX6MF5u9+t
         OvgDD3breM3QryD65Am8n16kgZJQOlXs7wk0ZyQ6xP85BuYsQdsxDcwGWrVuvdj03wCV
         kifrhCdRTaWNd5Ax6WtFQ+dj2EzkCEfuXgJHyiWXDD4D2IWfImK1ueDvWmGszG8pr8/I
         UwWg==
X-Gm-Message-State: AFq9FYIsEDLZ5NAkXZVaAd+qT2F9TwWmiA6TJTt0OLznS0VlMWTDh85H
	a6bf9jNiM+610GtUJnyu9JG9UAePo+SYhRGEOCVMflgT4AegB/A4NP6Jr/8IzA==
X-Gm-Gg: AYBFou1860Q40u39k71hMoP8B4gnFCxoN7RZay95i+/T3omjd0bk5/Ps69SzT55CjUO
	FvmYMfT2UW/JFwN8ewTEdfnOqf3CEOUwAWi9MSIHZO1rBueiJZMXxbdCnt2x1Tz6YUvaZXp/gSH
	jWcsnj8PnMy3tFxEh5O7urmPl4NZOcO7yiHJOp+PrAyrcv0DoC2wgItp/dl7leoYj0o7rFrsv0e
	l3v/Yud1LIJ1Kz970UyOJyBot8ireLEUBZlsoZtm63NsNtr4oXfMGpr6lXXSWKlE4FQYBW9emD6
	atDQ5bi/45794DvutQ/uvc1Pbo806WiTqd/tBwqfow7jeRB3v/Hy44ZbEDHjEjf00CveuMU52Tn
	EGs1r5dt/2Kb6VcbBDd91YZYcj0hW8HOMmADbFcoipcqVrIvD/i9gKwi0Mbt9AM9RMAsm63LqWL
	JQqBkz4yJtRFxfejJedbVflMgy6UAROm2/cuWHOi3FMjH2DX4K68ucwUp5bR7fOdvLbAME8En/J
	VjK14Mh2wU465K+KBTDHSx6h16kJWBLLYHVRgi27jKS9mFH1e0S8brP+vqtoZmPiLY1wlSnBxWi
	+RLPwpuQOZm01dVqZxvXNsnj9Knjpw/fUXiA43EzXyaKx2x9fb+T2tZgonN1tw==
X-Received: by 2002:ac8:5e06:0:b0:536:986f:e97e with SMTP id d75a77b69052e-53fccbb76e9mr15334611cf.63.1793146531618;
        Tue, 27 Oct 2026 17:15:31 -0700 (PDT)
Received: from Williams-MBP.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6e20ba4fsm38666656d6.14.2026.10.27.17.15.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 17:15:31 -0700 (PDT)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH v2 0/3] submodule: foreach in reverse order, with the superproject
Date: Tue, 27 Oct 2026 20:15:26 -0400
Message-ID: <20261028001529.81557-1-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260131214309.1899376-1-whatfield.git@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some commands need to visit nested submodules before the repositories
that contain them.  For example, when committing changes throughout a
project, a superproject can record a submodule's new commit only after
that commit exists.  "git submodule foreach --recursive" visits each
submodule before descending into it, so it cannot do that in one pass.

This adds three options to "git submodule foreach":

 - --reverse-traversal visits submodules in the reverse of their usual
   order.  With --recursive, each submodule is visited after the
   submodules nested in it.

 - --include-superproject also runs the command in the superproject,
   after all the submodules.

 - --reversive is a shorthand for --recursive --reverse-traversal
   --include-superproject.

Take a project "top" with a submodule "mods/a" that has a nested
submodule "inner", and uncommitted changes in all three.  After

    git submodule foreach --reversive 'git commit -a -m update || :'

"git status" shows nothing modified in any of them.  With --recursive
instead of --reversive, "inner" is committed after "mods/a", which
still records its old "inner" and shows it as modified.  t7427 checks
both outcomes.  (The "|| :" is there because "git commit" fails where
there is nothing to commit.  What a failure means is left to the
command, as it is for "git submodule foreach" today: a non-zero exit
status stops the traversal, and the superproject is only visited if
every submodule succeeded.)

This is a new version of "[PATCH 0/5] submodule: add 'reversive'
traversal options to foreach" [1], reworked after the review by Junio
and Jean-Noel:

 - Tests are part of the commits that add the behavior they test,
   instead of a separate first commit with test_expect_failure.

 - --append-superproject is now --include-superproject, which says
   what it does: the command is run in the superproject too, last.  Of
   the variables a command can use in a submodule, Git sets only
   $displaypath there, to the name of the superproject's directory.
   The others are not cleared and may come from the environment.

 - The command run in the superproject keeps the environment that
   selects the repository, such as GIT_DIR and GIT_INDEX_FILE, because
   it is the repository "git submodule foreach" itself runs in, not
   another one being entered.  The tests cover a detached worktree and
   an alternate index, also from a subdirectory.

 - --reverse-traversal keeps its name, but the manual now says what the
   order it reverses is: the submodules by path, each one immediately
   followed by the submodules nested in it.  That was the missing piece
   in the objection that there is no "natural" order.  I do not think
   of it as a walk of a tree, for which "bottom-up" or "post-order"
   would be better names: those say nothing without --recursive, and
   reversing also reverses the order of siblings, which "bottom-up"
   does not promise.  Please tell me if it still reads as unclear.

 - With --recursive and --reverse-traversal, the submodules nested in
   a submodule are looked for before the command runs in it, so a
   command that checks out nested submodules itself does not get them
   visited, unlike in the usual order.  This is documented and tested.

 - The documentation follows the synopsis style that git-submodule.adoc
   has been converted to, describes each option by what it does first,
   and has an example of the resulting order.  The usage message, the
   synopsis and the completion are updated too.

Because the series is organised differently from v1 (three patches
instead of five, with the tests moved), a range-diff against v1 would
only show it as replaced, so there is none.

[1] https://lore.kernel.org/git/20260131214309.1899376-1-whatfield.git@gmail.com/

William Hatfield (3):
  submodule: add --reverse-traversal to foreach
  submodule: add --include-superproject to foreach
  submodule: add --reversive shorthand to foreach

 Documentation/git-submodule.adoc       |  41 ++-
 builtin/submodule--helper.c            | 103 ++++--
 contrib/completion/git-completion.bash |   5 +-
 git-submodule.sh                       |  17 +-
 t/meson.build                          |   1 +
 t/t7427-submodule-foreach-reversive.sh | 429 +++++++++++++++++++++++++
 6 files changed, 573 insertions(+), 23 deletions(-)
 create mode 100755 t/t7427-submodule-foreach-reversive.sh


base-commit: 37b3475fb530c14109211faca33716a173db61ed
-- 
2.56.0

