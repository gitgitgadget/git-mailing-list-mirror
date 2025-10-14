Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A4231856
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445098; cv=pass; b=aQ63GiTnn3WIGIG01b5AWdosS5pl7IkNHApLwO/3LfW9op3DWIVxPUgEW3FCLBvoF/tJkoummOpMkwQNOctwiNxIGb6JsP95Si6YJAyXD7RjyfuD7SGfB7bwPk5DvnmJKze39LtwCvSdCXxFogaqtXyQi+3cARu/tWN75fsgIkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445098; c=relaxed/simple;
	bh=BJtBH8vpKjK1EPaMYdLeBnHT2z85j3+Mfc3DrX1uoAA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=phuWnyw8UuO0vYINVd5i+EZSv4OpUmn/XiQde5ImPte37yjvFOsieWXn4mLe475swlAkZrGioHhwKn5B8kSn0x1WZmESMxeJFXRGWU3NDaS/vG4KsTge0eJeREMnqqd+STh64ywgcSEixhJQhAtbOCfpXy5/Ll8QeaYFzc+zbts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=egaF53ND; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="egaF53ND"
ARC-Seal: i=1; a=rsa-sha256; t=1760445086; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=evJjTD/spFC8PGrZgA/Nyyn50jEFcquduOsoV7EvIfI+cvmHyqwEu9qK/pudy/LDMgfnXUGR2+u7j+le+/Iu3t7KRLmNI+OpOt25NmTUdCrZ6AAIYvLpS6AghUu1RMj+GuI/0uD3aQPzy4L9vRtmsZkcxaqUmtdjpwimz0hisAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760445086; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=kAhhTZ2FVYFMud/kfXROszQOF7Nq4IDNUuCl2xafKlE=; 
	b=ginWLP+zxtNZ5vHggjBieSMgHB4124LeYjkuLjH/1FjvCO6t4e8aOKAkqdzjRMywt/KDH+4A27DFV0wrKJbb3odd1KggdXeN1b3laybhP23GbHWcM4r8TZ2ywHp8V1NK3vmwPd+Y7y8B96p8qONqX4e56yNEeE8wqijh7miiBA8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760445086;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=kAhhTZ2FVYFMud/kfXROszQOF7Nq4IDNUuCl2xafKlE=;
	b=egaF53NDuKUsV7AwE2W93WhSmaSDdeEXSoojBjIvuiSPStHkwILooik630fKz3Sa
	II012kYgSJlFyOWYdR5SWpezfwR10f1si8WUdTUjuLsnD4ji8dgxnVYp/rfNhVXW2C6
	fQNx/96D+4vAx0Gv6nWFHPCyY0hAfQKps02bp3nE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1760445085084849.4909983893075; Tue, 14 Oct 2025 05:31:25 -0700 (PDT)
Date: Tue, 14 Oct 2025 20:31:25 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Message-ID: <199e2b43582.47bdac39780183.537796020815726330@linux.beauty>
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Subject: Re: [PATCH v4 00/29] rebase: support --trailer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Phillip & Junio,

I apologize for the delay in sending out v4. I will respond to
and update the code in the following patchset (if needed)
 as soon as possible.=20

My apologies!

 ---- On Tue, 14 Oct 2025 20:24:13 +0800  Li Chen <me@linux.beauty> wrote -=
--=20
 > From: Li Chen <chenl311@chinatelecom.cn>
 >=20
 > This patch series teaches git rebase a new
 > --trailer <text> option and, as a prerequisite, moves all trailer
 > handling out of the external interpret-trailers helper and into the
 > builtin code path, as suggested by Phillip Wood.
 >=20
 > Patch 0 switches trailer.c to an in-memory implementation
 > (amend_strbuf_with_trailers()). It removes every fork/exec.
 >=20
 > Patch 1~8 fix all reviewer comments from v3 for patch 0.=20
 >=20
 > Patch 9 builds on that helper to implement
 > git rebase --trailer. When the option is given we:
 > force the merge backend (apply/am backend lacks a message filter),
 > automatically enable --force-rebase so that fast-forwarded
 > commits are rewritten, and append the requested trailer(s) to every
 > rewritten commit.
 > State is stored in $state_dir/trailer so an interrupted rebase can
 > resume safely. A dedicated test-suite (t3440) exercises plain,
 > conflict, --root, invalid-input scenarios and etc.
 >=20
 > The rest patches address all reviewer comments from v3 for patch 9.=20
 >=20
 > All t/*.sh testcases have run successfully.
 >=20
 > v4: fix all reviewer comments in v3. [2]
 > v3: merges the remaining trailer paths into one in-process helper, dropp=
ing the
 >     duplicate code, as pointed by Junio and Phillip [1]
 > v2: fix issues pointed by Phillip=20
 > RFC link: https://lore.kernel.org/git/196a5ac1393.f5b4db7d187309.2451613=
571977217927@linux.beauty/
 >=20
 > Comments welcome!
 >=20
 > [1]: https://lore.kernel.org/git/xmqq8qlzkukw.fsf@gitster.g/
 > [2]: https://lore.kernel.org/git/20250803150059.402017-1-me@linux.beauty=
/
 >=20
 > Li Chen (29):
 >   trailer: append trailers in-process and drop the fork to
 >     `interpret-trailers`
 >   trailer: restore interpret_trailers helper
 >   trailer: drop --trailer prefix handling in amend helper
 >   trailer: move config_head and arg_head to if storage
 >   trailer: use bool for had_trailer_before
 >   interpret-trailers: buffer stdout output
 >   trailer: mirror interpret-trailers output flow
 >   trailer: handle trailer append failures gently
 >   rebase: support --trailer
 >   rebase: inline trailer state paths
 >   rebase: reuse buffer for trailer args
 >   rebase: drop redundant strbuf_release call
 >   rebase: skip stripping of --trailer option prefix
 >   rebase: die on invalid trailer args
 >   rebase: validate trailers with configured separators
 >   sequencer: add trailers to message before writing file
 >   tests: t3440: create expect files at point of use
 >   tests: t3440: check apply backend error includes option
 >   tests: t3440: use test_commit_message for trailer checks
 >   tests: t3440: drop redundant resets and pass branch to rebase where
 >     needed
 >   tests: t3440: assert trailer on HEAD after conflict rebase
 >   rebase: persist --trailer options across restarts
 >   tests: t3440: remove redundant --keep-empty
 >   tests: t3440: use helper for trailer checks
 >   tests: t3440: test --trailer without values
 >   tests: t3440: convert ex.com to example.com
 >   tests: t3440: ensure trailers persist after rebase continue
 >   tests: t3440: exercise trailer config mapping
 >   sequencer: honor --trailer with fixup -C
 >=20
 >  Documentation/git-rebase.adoc |   7 ++
 >  builtin/commit.c              |   2 +-
 >  builtin/interpret-trailers.c  |  94 +++++-------------------
 >  builtin/rebase.c              |  50 +++++++++++++
 >  builtin/tag.c                 |   3 +-
 >  sequencer.c                   |  34 +++++++++
 >  sequencer.h                   |   4 +-
 >  t/meson.build                 |   1 +
 >  t/t3440-rebase-trailer.sh     | 134 ++++++++++++++++++++++++++++++++++
 >  trailer.c                     | 130 ++++++++++++++++++++++++++++++---
 >  trailer.h                     |  23 +++++-
 >  wrapper.c                     |  16 ++++
 >  wrapper.h                     |   6 ++
 >  13 files changed, 411 insertions(+), 93 deletions(-)
 >  create mode 100755 t/t3440-rebase-trailer.sh
 >=20
 > --=20
 > 2.51.0
 >=20
 >=20

Regards,

Li=E2=80=8B

