Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018408;
	b=lonJ9t9z8VlANPOZPbVWUxCGbj+tBPvWPp0m1cFvhx2HraLPuVB3P4W86JHQplMYsiF1
	 wCyBh0bSGC4pHeRQtzlL4WahArhUTQDDcwe7/noTP8v06aEYDkga1hZY2W2gfR+qJVXIL
	 fcWSIhSb9OIovnObSKVPTkhsKKgGdDQb7y0xHoT5f6JyFaeby+cEinhjWbKGhE4V+aK/q
	 dCEkYhNChyLBBwKBnxMH8hCcmE/PPXxK2h/rCTcOKfDzwuOKHpNjz9W7yaEuFUqacHG3K
	 sxDqDQlYBIBkxEbpxsAXGz/cQwCqYNq60IYUZqHLOBjKfyMGCxumxH4qHSPomh9kx4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=6nwjNsMaPcFM+VWXVkhlVy1vxvFjhAP0ghmYlJ+FPTI=;
	b=AK8TYY5IjrKM3UUr+lWiPJFts8ScDxGr8VmLgn2/Np+8GfA5NQvLmHWqlBJacqbCJP+X
	 /2/6Ctrq+sNazrEnzMoZxPIKqOlf2ZiRPFyqen3yM0wl567nv+3KiWtrzEFlNcm+moARY
	 D1J77jSoiZnrNZYrJ2r1ww9BhZZbGjmDQWdpGEm57XDYGgbJhYEv+4pF/HHbJIq7mkOKm
	 k+tdEkcAS1R1jY+XDaJgWQuWWIj7gyQsYB3SxWu5nhK1778AXju+NyLajr+4eLZMFhIFZ
	 9PJ3S5hDTRexEnHetwzDJy9b003ZJ8wVC/GONXr/yUBL943qtABQjhuh7Btl1DzHqzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgLVcnft;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73274606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73274606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgLVcnft
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c46d41f6af3so157362666b.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018407; x=1793623207; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6nwjNsMaPcFM+VWXVkhlVy1vxvFjhAP0ghmYlJ+FPTI=;
        b=jgLVcnftsWR+N3ZzyMc2r3YjbG2MYlOFMegxQWgOfhoiVTTcrUfj9u+gHfSzg9EltA
         tz2qCtiJtRTLOl6G6TJ+IDKBlcRcIONeILbPWJEL+N2oM3ruKC2L+s8Njnbo24S4gV9k
         BPGrSYcMqJYgY8FXPKQvIyiJUsrOHsZjkNWsNqIQwlBKGQZ/cUD6jPToXYzS/qdrJpHd
         eSny5OAdM+PjQ2izVR+xqCLw7AivJjrg26/t00cuS79AqmMFA2AGWfeCxcLfkg/xz/z6
         9YwIZUeFl2OC2ctbFhjGhlNBX4kQZ8DTtQyJqu/o9FVHPfXuxyXbPEoq3JBsn8yqoOVV
         EYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018407; x=1793623207;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nwjNsMaPcFM+VWXVkhlVy1vxvFjhAP0ghmYlJ+FPTI=;
        b=xxPAbrMcPHBxSjJ6Oq8v0hQ77CUWp8dVDaWFGzE1+itrF5Jo4eqRHUbgZ0DWLBsXu4
         KIjFe17LdW0WH2LUxp51J+5GglF7bMqi9g+V3n2MQsdFRiP6Tl9Tng1beYNiWF20QWz7
         RNQF0s3tU0NKEdigR9KMKI31x4Tk3D/iVuuZsd7qt6o9qABd7hKkBHWTHcv1mF+rrt77
         0zrIb1+4ybqZZYzS0ijlX3pMTxDRaKkToEwgPri2oOhvseIb9okVEVwxSfky3qW2HRXY
         1BPh3JscYOtcie3IUAP6uyUYs+Au9O2gMmlvxM9t3n/7t3qTBWqv88Sse5NWUGiNN0gm
         Mv3A==
X-Gm-Message-State: AFq9FYJfEa98P4Ap43REdm6srGRr11E3aAB9AWokuX8skadr5xiLNsWA
	2fUCQX4K3aCQG/a2BDTpkvB91f4VjmhU7d6SH8y3YmsedC2kOTZ6MnJ9tt5vHdKnaic=
X-Gm-Gg: AYBFou3GFxIcrTD46FIQvAJNr8L3Okn5+ZmpqJQ0FHGH8jQT0kOWDkcNKYeCt1eaBuK
	D4Xw9s6+DrVHbn9MVyPlpDxfYam/gpO8LLAaL2tjJJ08Y6VJ6ny2NOiVkp4xD3ynOAylkuXke3T
	FfbRHPNAxKQDm2fSpeQcr+1i7a8o/qGB7eAMpTZbdE1QFZKIADzvHoh9Ms+bEHVjDqrL9Py1xJJ
	RPOfBy1A30cviQUtqBGduJSsNadFirmZ6PGD3Uae989eGQfFJ9mKEIOgq93jBy3KtPukRngQP2l
	G0Wg7ydiAtLa58YUZbupBghgl41TkIgsqSmd9Pke81z9Cast4mk99qNTchGdI15kl0sAo/lxLgS
	w+d3gYf2zrNB3cVGGv0xNL1W8Q+sFI6EQdn8Dr+HYcuf0+kgObRzm175iDTaea67vHQ97KW3ORQ
	B5G7wAccy3LXiwuv9SeuP6eNKNxeB6x8oIYP47ZhFcfQnj9BhYTE727CXAFMTdcyJV5w2vKw4My
	ntryVuoPXYFhcwSAjBc4ZzxJ0/hKVTXQs9ezQL6Ve3lvlbVEakVKlOFJoMa
X-Received: by 2002:a17:906:1012:20b0:c48:9228:bdcb with SMTP id a640c23a62f3a-c489228c5eemr274281266b.3.1793018406581;
        Mon, 26 Oct 2026 05:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.191.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd350706sm325644566b.3.2026.10.26.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:40:05 -0700 (PDT)
Message-Id: <pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 12:39:59 +0000
Subject: [PATCH v5 0/6] [doc] Add new page on merge conflicts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>

Handling merge conflicts is difficult, and currently Git's guidance on merge
conflicts isn't giving users the information they need to navigate the
process. As usual, the process I used to write this was to collect comments
from Git users on the existing documentation, and then address those issues.
I listed the specific issues we're aiming to solve in the first commit
message in the series.

This patch series introduces a new manual page, gitmergeconflicts, which
explains the process of explaining a merge conflict with examples. It also
links to that new page from the commands which can cause merge conflicts,
instead of trying to reexplain the process every time.

Changed in v2:

 * Explain what a merge conflict is (thanks to Junio & Ben)
 * rewrite the "ours" vs "theirs" section (thanks to Patrick for the
   comments)
 * add git log --merge (thanks to Ben)
 * Leave most of the content of git cherry-pick as-is, to make this patch
   set smaller (thanks to Junio)
 * remove the SYNOPSIS since hopefully that won't be required anymore by the
   time this is merged
 * Fix a typo in git revert (s/reverted conflict/reverted commit/)
 * 's/the the/the/' (thanks to Patrick)
 * s/[doc] Thing/doc: thing/ in commit messages (thanks to Tuomas)'
 * squash the commit fixing the linter error (thanks to Junio)
 * list reviewers in Reviewed-by

Changed in v3:

Thanks to all the comments from Junio.

 * Add signoff from Marie
 * In "For example, here's a merge conflict where both sides edited a list
   of", add a little more detail about how to interpret the merge conflict
 * When we introduce a merge mention "semantic merge conflicts"
 * Say "... and any other command that does a merge" when listing commands
   that can cause merge conflicts.
 * Reviewed-by is not the right thing, use Helped-by
 * Adjust phrasing in git revert and git cherry-pick man pages
 * Reference the "ours" section in "git show :2:filename shows the "ours""
 * "there's one file left with conflicts in it: fruits.py" isn't precise
   enough, instead say "the conflicts in fruits.py haven't been marked as
   resolved"
 * Delete the explanation of zdiff3 and add a brief warning instead. Don't
   be too prescriptive, we should tell people what the issue is (ambiguity)
   instead of trying to impose our opinion.
 * Explain ||||||| when we add diff3
 * Fix example in "EXAMPLE OF RESOLVING A MERGE CONFLICT" to make it
   consistent with the other examples
 * Replace "configuration option" with "configuration variable"
 * Mention --skip instead of saying "the most common ways", which is
   ambiguous
 * Add a pointer to the extended AUTO_MERGE sentence

Changed in v4:

changes to the content:

 * use Junio's much better example for diff3
 * clarify in the commit message why we're not mentioning git apply: to
   avoid dealing with patches (thanks to Junio)
 * adjust the wording around "multi-step operation like a rebase" (thanks to
   Junio)
 * Say "see git-config for more" in the description of zdiff3. Like Patrick
   said the explanation of zdiff3 is not really satisfiying, but I don't
   know how to write a satisfying explanation, and it's better to have a
   short and obviously unsatisfying explanation than a long unsatisfying
   one. Added a note in the commit message that perhaps this should be
   improved in the future. (from Patrick's comment)

changes cleaning things up:

 * add periods at the ends of various sentences in an attempt to be more
   consistent (thanks to Junio & Patrick)
 * Adjust the formatting around the [NOTE] to make the CI whitespace check
   pass
 * Replace a couple of instances of "code" with "lines" (thanks to Junio)
 * Fix Ben's email address (thanks to Ben)
 * Remove the double signoff (thanks to Ben).
 * Make the cherry-pick commit message more accurate (thanks to Patrick)

Thanks to Lobo, Adam Svahn, Louis Vanier, David Turner, Ben Zanin, Salih,
and about 12 others who gave feedback on both the original git merge man
page, as well as the proposed improvements.

Julia Evans (6):
  doc: add new gitmergeconflicts man page
  doc: git-merge: link to new merge conflicts guide
  doc: git-rebase: link to new merge conflicts guide
  doc: git-revert: link to new merge conflicts guide
  doc: git-cherry-pick: link to new merge conflicts guide
  doc: git-pull: link to new merge conflicts guide

 .gitattributes                       |   1 +
 Documentation/Makefile               |   1 +
 Documentation/git-cherry-pick.adoc   |   8 +-
 Documentation/git-merge.adoc         | 125 +---------
 Documentation/git-pull.adoc          |   3 +-
 Documentation/git-rebase.adoc        |  13 +-
 Documentation/git-revert.adoc        |   5 +
 Documentation/gitmergeconflicts.adoc | 339 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 command-list.txt                     |   1 +
 10 files changed, 366 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/gitmergeconflicts.adoc


base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2237%2Fjvns%2Fmerge-conflicts-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2237/jvns/merge-conflicts-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2237

Range-diff vs v4:

 1:  486a77dbd7 ! 1:  8b526e2bd7 doc: add new gitmergeconflicts man page
     @@ Commit message
          there are other ways that merge conflicts can happen to avoid getting
          into the difference between applying a patch and doing a 3-way merge.
      
     -    Things to potentially improve in future docs revisions:
     -
     -    - The explanation of zdiff3 is unsatisfying. It would be good if we
     -      could have a clear example of a case where zdiff3 is helpful and a
     -      case where it's harmful, and if we could give a better sense for
     -      the reasons why users are actually choosing zdiff3 over diff3
     -      (or the reverse) in real life.
     -
          Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
          Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
          Helped-by: Patrick Steinhardt <ps@pks.im>
     @@ Documentation/gitmergeconflicts.adoc (new)
      +    "cherry",
      +    "mango",
      +||||||| 1c22e48
     -+	"banana",
     -+	"cherry",
     ++    "banana",
     ++    "cherry",
      +    "mangoooo",
      +=======
      +    "banana",
     @@ Documentation/gitmergeconflicts.adoc (new)
      +----
      +
      +With this view, you can see that both sides fixed a spelling
     -+mistake in "mango", and each removed one fruit to the list.
     ++mistake in "mango", and each removed one fruit from the list.
      +This makes it more clear how to resolve the merge conflict: since one
      +side removed `banana` and one side removed `cherry`, it would probably
      +make sense to remove both from the list, like this:
 2:  6862cb4f04 = 2:  3dc763a2a2 doc: git-merge: link to new merge conflicts guide
 3:  2bd9850822 = 3:  02351af1b5 doc: git-rebase: link to new merge conflicts guide
 4:  53083b48a3 = 4:  10f8947b68 doc: git-revert: link to new merge conflicts guide
 5:  92cfdf260c = 5:  e1fe1c4aa3 doc: git-cherry-pick: link to new merge conflicts guide
 6:  bbbf44aff1 = 6:  4f434f5acd doc: git-pull: link to new merge conflicts guide

-- 
gitgitgadget
