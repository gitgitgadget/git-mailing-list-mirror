Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC347605C
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300939; cv=pass; b=gAoEVgVhp9Mqm7Vj/IB8dBAt9UMWfSVqsS6fFoUNAvS9dXeY1iTo020i2uMhVkLCu+cdlAHph5+JNZTAH05Rj3VJuhxT08SkuemdJCBFfTB/qIuEsVkKCczGqH0FyqXKeRM5ONygoWFU662V2MXzXZB1/FlcFPP9jSTsXBiQfrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300939; c=relaxed/simple;
	bh=E1yebOHCljUcw7M69zod1U1p5sV1kFYjblwiNyoZD54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPhJ/HpGdzBVbabUliGvxFXcJZCYXrTuNEhm+RgGLjun9HgWUBXpBpcC6qe3Za0oMuJ71FyS3Ho2l8EoHKi/5paCN8iAumrHO9k866hWQSHqLDqaDxXszhgf+133A5q3oQljoDDXVhz72ADL0Yw8I7CB3wvBCEx+FuA4RpLsw5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRTDtWMX; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRTDtWMX"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso338154eaf.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 15:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788300932; cv=none;
        d=google.com; s=arc-20260327;
        b=rOOEYKlknyJTocuUE8BSd1MrlFfrBMMDcxlMycGEV1Aceh9+QAJIWRAXlqx/i2oOH6
         8xtdPy9mJhVBxJBDHGxRJNnQ5oahUfpTrgwv0LUqmmqpd0WPHOwR7GgyijvSuEie12+t
         KnlU1cpxNo0XiD673UU3Q93D61wstRQznOvJ3x4tdSIFbWJ5QSjwCBJSLWq2aLTvDqMs
         OFHRDNNf91AiLgFpxGLIaahl/3zGO4A1JKX/+B0FhiEKGOxgc5XYH90R/GV5IXHFUK7C
         NZFi4EV0gmjZAMiz4SOc/WmycbX8D9if7kbNczbPtLuy/J2IJA2XMvFvBV5LMYNA47/3
         32Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+mQmojfcEYBekuAt5IYnKPa3EBYURQxrl8Y+r/+7gFk=;
        fh=D6Ci89b2WnMUTfOt2/3OlhCeAZeRbbNQYeR6/7UEA64=;
        b=bBxfkGxbd5d2jt04z7+QwljFUlGueSXFWi0lTEisJxilbr/qQlVKgrUcVVKwxFoc7G
         Edm/21nKRbMdvFTIP9fIfLttUM7SibHK/30PPcOMeTC2wZ4OXxrvXa5zi37KWZUwAqo5
         RAuxXKHVWGJSB6SfeOpuJFFmc8sMzEUoHLpbeeF31bKXNIUWzIEFA95BZzaxAn0ug0XV
         tlt90ojVYW/+TDUb4vGx560W/zKawqBEOpandpHEB6W/4qEsdFKY0dYdjleotx6uHcDB
         MAFU6UQ/KltTWV+hdwuE5Z3RdEoDb3y5mzRhHUA/1UaazM5VHXLhWQO3JD9mvgqgp7ln
         OoWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788300932; x=1788905732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+mQmojfcEYBekuAt5IYnKPa3EBYURQxrl8Y+r/+7gFk=;
        b=LRTDtWMX6+AJMVAnjY0BvKMgsYZWyPDaHDx35iuX/7OG186s78r9eohdzwlr45xf16
         WcCeMqjM8uru94JxGcmSk6TDjdImjOTlpTu0Wz8SpcNK1ug6Txus1APxPaYrq2HPv7KO
         dV2aWvQSTwVruNAgDqHaia8KBlmW/+zIWTVck8qQq9USQAsG+UVSzfl0sJ+0OBW5j5fU
         TlmSyrAhbycHarjpql0ZDGuqO1zv4GkCMAZ8/XKCJeFqr/PbBQ8iWjRtRe25tiQgcksO
         fQNhVCJ9MN7nDncv8Akc/wJVc5c9iSqq0ars19pFEwRjw2gbR1fbbp4XQXS2TP+jtQfQ
         +ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788300932; x=1788905732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mQmojfcEYBekuAt5IYnKPa3EBYURQxrl8Y+r/+7gFk=;
        b=VHKJsxLSytC4lPs28BkkMm6a3bwT3Sw04kcNVRJgMP4eASy6xnHelwha/HpTu/5DmL
         83JdjELKVcml7+L2rRxiKMR6MFc9CnSYDzUH9HkxAhXg6z6pteg3FutB4aJ4EUFkoBII
         tpGYuBNhZ6rcIZ8lip+iumDh82/GBcnu/w68n5bTLyB8zZ7lJhiYaiGXxupBT09AsPS3
         LX24pZkXOlpMJ9I3xub8ZE7g46YxBXZLbmPBdv/YytLh0tlLBnyGSMz4c1Rjnf2GGN5t
         PVliIdrxswOdqCRSjt5Y1J5CB2QOErFyKqjrVbS7IVlFqRUfk9G8izjoKETMBNEENmtG
         Ysjw==
X-Gm-Message-State: AFuF++kCvVHRHUgXmJrJvWdWD2W1n+tyvOkv3tygtRo5J76R/tuj8wz2
	whu1uYxQ02JcwnTDj/6zCzk8Mjlv9yXBiBd8aWLs0jaGroG6sKDqBqtGZUZFpJTqr+DEAHeD12r
	UlTREpzlq8cZUM4dchoOF9osUxymZpYTEVA==
X-Gm-Gg: AR+sD136gxyqKZcpxL5dBziKtf8HaRP0zwHToJmjlqLr+7v0/j5noAYYGo6arztCKo+
	p6NnOlH9csBqn9jcO/I4LMz3dx4FjlPqRrB2zrCyYVYjOuZ0S/aMIUGHHda4gFUP9cH0y9k514j
	x526wMABHVnxxzig3uzA4EXoz4pfT9kW/e8QrueamgSIk+TPHVKxm1ZaFitI2R4LxBK2uq7S6Ep
	YYQ0sqAmXIje43aS0wuMyBXuYZ6HcQhTL0UNhyz91dhT5FyZa8QMyMfayioM3R8hNiflgyLcpvk
	TBbIBgIBi5AZeyXKdjy6U6LVvdRpdPyY87XISaUFN+XGCVQ9ssATIULGsWkjzVCnBWUVfLxE3Ia
	uBxzZxphIZR7N/xOyRezrFwBVLEOHce/Y/nMXJMzmK/l5/w4Ul1FlNJEZWKPj
X-Received: by 2002:a05:6820:1614:b0:6ae:774d:45ab with SMTP id
 006d021491bc7-6b47eac0b06mr41454eaf.27.1788300932209; Tue, 01 Sep 2026
 15:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com> <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
In-Reply-To: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 1 Sep 2026 15:15:20 -0700
X-Gm-Features: AcwNN1UTH6qFVmGXOu50z7zx3kiJmize8W5B5ty7VZZYcMNFGmSjsc7D6x8sdqc
Message-ID: <CABPp-BF1=DZAxX5Now4pCKPi8=cpXo506z=8QVu2vYCSiKdqMA@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] Teach git-replay(1) to linearize merge commits
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:14=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>
> Hi,
>
> I'm back with another iteration of the patch series to implement
> --linearize into git-replay(1). My apologies for the long period of
> radio silence, but this topic was stalled on reviews for a while, and
> when I got some feedback I was on leave, so I'm finally back.
>
> As far as I could tell there weren't any remaining comments on the
> implementation itself, only on commit message and docs.
>
> Laters,
> Toon
>
> Original cover letter:
> =3D=3D=3D
>
> As an alternative to dscho's patch series to replay merges[1], add
> an option to git-replay(1) to linearize merges. This mimics what
> git-rebase(1) does with --no-rebase-merges (the default).
>
> The first two patches do some refactoring. The third patch implements
> the actual change. The original patch was kindly provided by Dscho,
> which I've tweaked to be upstreamed.
>
> The --linearize option is only added to git-replay(1) and not to
> git-history(1) because in my opinion it doesn't make much sense to do
> so, but I'm happy to hear if anyone disagrees.
>
> Dscho's series to replay merges[1] needs a bit of rework to fit on top
> of this, but I'm happy to help figuring that out. We've been discussing
> to either name the option --flatten or --linearize, but I've decided on
> "linearize" because the documentation of git-rebase(1) also mentions
> "linearize".
>
> [1]: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
>
> ---
> Changes in v9:
> - Rephrase "multiple revision ranges" to "multiple branches".
> - Reword some things in the commit message.
> - Tweak wording in replay.adoc.
> - Link to v8: https://patch.msgid.link/20260728-toon-git-replay-drop-merg=
es-v8-0-ced11dffe749@iotcl.com
>
> Changes in v8:
> - Disallow multiple revision ranges with --linearize.
> - Disallow --contained with --linearize.
> - Link to v7: https://patch.msgid.link/20260707-toon-git-replay-drop-merg=
es-v7-0-808ab9b4afa6@iotcl.com
>
> Changes in v7:
> - Allow --revert and --linearize to be used together.
> - Because quite a lot of changes have been made since the original
>   patch, change author from Johannes to Toon for the last commit.
>   Johannes already told me he doesn't really care about authorship when
>   he initially shared the patch with me.
> - Link to v6: https://patch.msgid.link/20260702-toon-git-replay-drop-merg=
es-v6-0-78a07cdd0382@iotcl.com
>
> Changes in v6:
> - Reworked the second commit that moves picking the base completely
>   outside pick_regular_commit(), instead of adding more explanation.
> - Drastically extended the commit message on commit #3.
> - Extended docs on flattening multiple revision ranges and how it's
>   different from git-rebase(1)'s --no-rebase-merges.
> - Added a bunch of tests to cover various scenarios.
> - Remove newline from BUG() message.
> - Link to v5: https://patch.msgid.link/20260626-toon-git-replay-drop-merg=
es-v5-0-5e120738b9d0@iotcl.com
>
> Changes in v5:
> - Dropped the enum->bool patch and instead added a patch that better
>   explains how pick_regular_commit() picks a base.
> - Order of commits is shuffled.
> - (BIGGEST CHANGE) When working on a refactor to undo the enum->bool
>   patch, I extended the code comments to explain how things work. This
>   made me realize the use of the "replayed_base" was incorrect when
>   multiple branches are rebased with --onto. This is fixed now and a
>   test is added for this scenario.
> - Link to v4: https://patch.msgid.link/20260622-toon-git-replay-drop-merg=
es-v4-0-ff257f534319@iotcl.com
>
> Changes in v4:
> - Use test_grep instead of a bare grep in the range-diff test, to
>   prepare for mm/test-grep-lint.
> - Link to v3: https://patch.msgid.link/20260616-toon-git-replay-drop-merg=
es-v3-0-153e9eb99ce1@iotcl.com
>
> Changes in v3:
> - Add --linearize to Documentation SYNOPSIS, and mention it's
>   incompatible with --revert.
> - Small language change in help message for --linearize.
> - Rephrase comment to include last_commit isn't modified when
>   linearizing merges.
> - Remove test that was added in earlier versions, but actually is
>   a duplicate of 'replaying merge commits is not supported yet'.
> - Add test to verify --revert and --linearize are incompatible.
> - Properly test that replaying down to root with --linearize works.
> - Add test for --linearize with --advance.
> - Add test that uses git-range-diff(1) to verify the patches created by
>   --linearize are correct.
> - Link to v2: https://patch.msgid.link/20260610-toon-git-replay-drop-merg=
es-v2-0-5714a71c6d83@iotcl.com
>
> Changes in v2:
> - Restructured the conditions to detect merge commits and added a line
>   of comment why the loop continues.
> - Rewrote tests to use the history from the setup step and added a few
>   test cases.
> - Re-added Johannes's Signed-off-by trailer. Johannes gave me the
>   patches with this trailer, and if I understand correctly, I can keep
>   it. Please let me know if that wrong.
> - Link to v1: https://patch.msgid.link/20260608-toon-git-replay-drop-merg=
es-v1-0-e3ee71fce7b4@iotcl.com
>
> ---
> Toon Claes (3):
>       replay: add helper to put entry into replayed_commits
>       replay: resolve the replay base outside pick_regular_commit()
>       replay: offer an option to linearize the commit topology
>
>  Documentation/git-replay.adoc |  17 ++++++-
>  builtin/replay.c              |   6 ++-
>  replay.c                      |  87 +++++++++++++++++++++++----------
>  replay.h                      |   5 ++
>  t/t3650-replay-basics.sh      | 109 ++++++++++++++++++++++++++++++++++++=
+++++-
>  5 files changed, 196 insertions(+), 28 deletions(-)
>
> Range-diff versus v8:
>
> 1:  9fd3641eaf =3D 1:  3ea73d7c98 replay: add helper to put entry into re=
played_commits
> 2:  0bd4cd9b9c =3D 2:  4a40c42684 replay: resolve the replay base outside=
 pick_regular_commit()
> 3:  45faa926f8 ! 3:  d6247ea743 replay: offer an option to linearize the =
commit topology
>     @@ Commit message
>          If a ref was pointing to a merge commit, that ref is updated to =
the
>          merge's last replayed ancestor.
>
>     -    git-replay(1) accepts multiple revision ranges, for example:
>     +    git-replay(1) accepts multiple branches, for example:
>
>              $ git replay --onto main topic1 topic2
>
>          Without `--linearize` this replays 'topic1' and 'topic2' onto 'm=
ain'
>     -    independently and updates both refs.
>     +    (keeping shared portions of history shared and divergent parts
>     +    divergent) and updates both refs.
>
>     -    For now this is disallowed with option `--linearize`. Linearizin=
g more
>     -    than one branch at once would concatenate unrelated histories in=
to a
>     -    single line, and update each branch to some point in that line. =
That
>     -    won't be the result most users want, especially because the orde=
r
>     -    depends on the order of the revision walk, not the order of the =
branch
>     -    names on the command line.
>     -
>     -    For the same reason disallow the use of `--contained` with
>     -    `--linearize`.
>     +    Due to current implementation limitations, replaying multiple br=
anches
>     +    with `--linearize` is disallowed to avoid concatenating unrelate=
d
>     +    histories into a single line. For the same reason disallow the u=
se of
>     +    `--contained` with `--linearize`.
>
>          Users who want to linearize multiple branches are advised to do =
this in
>          separate git-replay(1) invocations. Linearizing multiple branche=
s at
>     @@ Documentation/git-replay.adoc: SYNOPSIS
>
>       DESCRIPTION
>       -----------
>     -@@ Documentation/git-replay.adoc: incompatible with `--contained` (w=
hich is a modifier for `--onto` only).
>     +@@ Documentation/git-replay.adoc: Expanded description list compared=
 to 'replay.refAction'.
>       +
>       The default mode can be configured via the `replay.refAction` confi=
guration variable.
>
>     @@ Documentation/git-replay.adoc: incompatible with `--contained` (wh=
ich is a modif
>      +  previously replayed one, so all replayed commits are flattened in=
to
>      +  a single linear history.
>      ++
>     -+When a merge commit is encountered, the behavior of git-rebase(1)'s
>     -+option `--no-rebase-merges` is imitated. All commits in the range
>     -+reachable from the merge commit are replayed into a linear history,=
 and
>     -+the merge commit itself is dropped. A ref that pointed to a merge c=
ommit
>     -+is updated to the merge's last replayed ancestor.
>     ++When a merge commit is encountered, all commits in the range reacha=
ble
>     ++from the merge commit are replayed into the linear history, and the
>     ++merge commit itself is dropped. A ref that pointed to a merge commi=
t is
>     ++updated to the merge's last replayed ancestor. (This matches the
>     ++behavior of git-rebase(1)'s `--no-rebase-merges` option.)
>      ++
>     -+Only a single branch can be linearized at a time: `--linearize` can=
not
>     -+be combined with multiple positive revisions or with `--contained`,
>     -+because that would concatenate otherwise unrelated histories into o=
ne
>     -+line. To linearize several branches, replay them in separate `git
>     -+replay` invocations.
>     ++`--linearize` cannot be combined with multiple branches or with
>     ++`--contained`. To linearize several branches, replay them in separa=
te
>     ++`git replay` invocations.
>      +
>       <revision-range>::
>         Range of commits to replay; see "Specifying Ranges" in
>     @@ replay.c: int replay_revisions(struct rev_info *revs,
>
>      +  if (opts->linearize &&
>      +      update_refs && strset_get_size(update_refs) > 1) {
>     -+          ret =3D error(_("'--linearize' cannot be used with multip=
le revision ranges"));
>     ++          ret =3D error(_("'--linearize' cannot be used with multip=
le branches"));
>      +          goto out;
>      +  }
>      +
>     @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref r=
ejects multipl
>      +  test_line_count =3D 3 out
>      +'
>      +
>     -+test_expect_success '--linearize rejects multiple revision ranges' =
'
>     ++test_expect_success '--linearize rejects multiple branches' '
>      +  test_must_fail git replay --ref-action=3Dprint --linearize \
>      +          --onto main ^B topic2 topic3 topic4 2>err &&
>     -+  test_grep "cannot be used with multiple revision ranges" err
>     ++  test_grep "cannot be used with multiple branches" err
>      +'
>      +
>      +test_expect_success 'replay with --linearize of a divergent merge k=
eeps both sides' '

Thanks for making all these changes!  I think this version is good to go.

Reviewed-by: Elijah Newren <newren@gmail.com>
