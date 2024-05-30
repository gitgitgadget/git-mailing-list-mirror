Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4A176183
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070990; cv=none; b=HRhb7/hnPcwhdbcn/SvO+XSLgW2fKj1pchWvoVM+58L+0aGXkQqVmW+6eeAx8w2LBLC+m6kR4s9rb2ebIIzCrUpyy6vGC9pBV1n2NRbt0YLjWz9q3Yo9GCHV6o5WM5wt8giyW7ibx3F2OGF9avGDrCQpU3dV+T7nHxauHN1eHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070990; c=relaxed/simple;
	bh=yjZbmMBacGCl7HlSJ3TVxxLsjwAuvn2J3pa2ROMCX9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jva8MWI3l3A2z+4l9KYcTk+sTQ8qsRRHng+fQ+gcecTBlrCeWGfYdJ1OxIgpXOBaJuTRJmVs0eWneDMbxFO6NM+DYafi3txfPF9jl/bACupUfrNZsHvAXmJDoZj1V9jKOJxOt3b+AJbIYfsNJUiIXLWc2m4DORaGpp/zb9fDlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6UYr93P; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6UYr93P"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5320so975568a12.0
        for <git@vger.kernel.org>; Thu, 30 May 2024 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070987; x=1717675787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWyozSctvfVyMFLFl2u1SkLJqL1OvxT0Wg9H1V1d+bI=;
        b=m6UYr93P1uMYtyZvKne3eJsPzMCviNSvCwYROPRQ1I84+pAYNGD5BaAwRBhGPJ/EdK
         I00K9Dpz8yhCsE5jkL58W8qiYMk58Oh52jYHgZbD+580nzCoPXGmeU/EhVtZfqBwoYp0
         xEcezx7Yq/wcFSBdSeOnMKiJXFsqh12T8bomqoKguG1onZPkdnmkMkMLaHjzALt4DdzP
         0kc/LGqpZRAo9uracd8HdQqR075JGvsp8fWIKvy/9QMt050cGVp1zGsE8d0z655s8/BX
         jK0bO787yh81+Yh092K00AjbBILZ0A28/yspoGqquwWJiZBxTr/bZAyNYzn37/ovf0B5
         KUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070987; x=1717675787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWyozSctvfVyMFLFl2u1SkLJqL1OvxT0Wg9H1V1d+bI=;
        b=XfSYKFZ4HjdZHBsVam15xBZ+C5IS4idafH7UsmijGzTFwICzTHI5c0JUuTO/dXzJJq
         pEa2g/RsSVSM2rxPImeKuZnyCkTxNcL1OnIXuHDOFnbqHIRmLGJqb/iafn6bjou/ksx+
         z8VaA0o2Q0RLAa8lh1HUKHX0vwhxwttYjUjFcP0GX3woeOY23+ejl7AriYeSXIr7fZ0J
         TlMCD9kVByUqkZxHDPIPJbaqkbE2a+DMFtn3AnopIMnng8f0uivonKYBboBIIaNZXGkI
         SP4F7ky5ok21KCmKqfd6E30RD+EXfpHeXuojz1g98GIlDLAo92ymSq5Kda8e74vs1jG5
         mKhw==
X-Gm-Message-State: AOJu0Yyr2H2OOBFaEWm6RPqddsWpwBftlOqgFzPP1bdjf2uth8XkgLgc
	3o6LHIMd3u/beekSG+f5cPfYQjOg7Are95IfHPmu6/nhmeZ4VqfYu91sbej6/cCaKg==
X-Google-Smtp-Source: AGHT+IEmnUD+CYAOaanNnal39fF8fAPqgnzJQ/vSajnYT7VHludweKqFhpg06MqgH6W7sGBwSIO8+w==
X-Received: by 2002:a17:907:592:b0:a66:7f1a:61e0 with SMTP id a640c23a62f3a-a667f1a62b2mr50552366b.62.1717070986749;
        Thu, 30 May 2024 05:09:46 -0700 (PDT)
Received: from laptop.modem.local ([85.100.180.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e105sm831393866b.172.2024.05.30.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:09:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 0/6] update-ref: add symref support for --stdin
Date: Thu, 30 May 2024 15:09:34 +0300
Message-ID: <20240530120940.456817-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240514124411.1037019-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'update-ref' command is used to update refs using transactions. The
command allows users to also utilize a '--stdin' mode to provide a
batch of sub-commands which can be processed in a transaction.

Currently, the sub-commands involve {verify, delete, create, update}
and they allow users to work with regular refs in the repository. To
work with symrefs, users only have the option of using
'git-symbolic-ref', which doesn't provide transaction support to the
users eventhough it uses the same behind the hood.

Recently, we modified the reference backend to add symref support,
following which, 'git-symbolic-ref' also uses the transaction backend.
But, it doesn't expose this to the user. To allow users to work with
symrefs via transaction, this series adds support for new sub-commands
{symrer-verify, symref-delete, symref-create, symref-update} to the
'--stdin' mode of update-ref. These complement the existing
sub-commands.

The patches 1, 5 fix small issues in the reference backends. The other
patches 2, 3, 4 & 6, each add one of the new sub-commands.

The series is based off master, with 'kn/ref-transaction-symref' merged
in. There seem to be no conflicts with 'next' or 'seen'.

There was some discussion [1] also about adding `old_target` support to
the existing `update` command. I think its worthwhile to do this with
some tests cleanup, will follow that up as a separate series.

Changes since v2:
* Based off 'ps/fixleaks' (commit: ebdbefa4fe9f618347124b37d44e517e0c6a3e4c)
which brought to light two leaks, which have been fixed.
* Adding credit where it's due.

[1]: https://lore.kernel.org/r/CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com

I used the '--range-diff' flag for 'git-format-patch(1)' this time.
Also I'm on vacation at the moment, so my responses are a bit slower than usual.

Karthik Nayak (6):
  refs: create and use `ref_update_expects_existing_old_ref()`
  update-ref: add support for 'symref-verify' command
  update-ref: add support for 'symref-delete' command
  update-ref: add support for 'symref-create' command
  reftable: pick either 'oid' or 'target' for new updates
  update-ref: add support for 'symref-update' command

 Documentation/git-update-ref.txt |  25 ++
 builtin/clone.c                  |   2 +-
 builtin/fetch.c                  |   2 +-
 builtin/receive-pack.c           |   3 +-
 builtin/update-ref.c             | 237 +++++++++++++++++-
 refs.c                           |  40 ++-
 refs.h                           |   6 +-
 refs/files-backend.c             |   3 +-
 refs/refs-internal.h             |   6 +
 refs/reftable-backend.c          |   7 +-
 t/t0600-reffiles-backend.sh      |  32 +++
 t/t1400-update-ref.sh            | 416 ++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh |  54 ++++
 t/t5605-clone-local.sh           |   2 +-
 14 files changed, 801 insertions(+), 34 deletions(-)

Range-diff against v2:
1:  2bbdeff798 ! 1:  cab5265c3c refs: create and use `ref_update_expects_existing_old_ref()`
    @@ Commit message
         `ref_update_expects_existing_old_ref()` and expose it internally via
         'refs-internal.h'.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs.c ##
2:  f509066cab ! 2:  ed54b0dfb9 update-ref: add support for 'symref-verify' command
    @@ Commit message
         divergence from behavior, but we never tested to ensure that reflog
         wasn't affected by the 'verify' command.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git-update-ref.txt ##
3:  a11f4c1e48 ! 3:  b82b86ff40 update-ref: add support for 'symref-delete' command
    @@ Commit message
         within a transaction, which promises atomicity of the operation and can
         be batched with other commands.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git-update-ref.txt ##
4:  9b71c9e07b ! 4:  ae127f7d52 update-ref: add support for 'symref-create' command
    @@ Commit message
         as a symlink. We fallback to creating a regular symref if creating the
         symlink is unsuccessful.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git-update-ref.txt ##
5:  a9b1a31756 ! 5:  8889dcbf40 reftable: pick either 'oid' or 'target' for new updates
    @@ Commit message
         want to introduce the 'symref-update' command in the upcoming commit,
         which would use this flow, correct it.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs/reftable-backend.c ##
6:  1bbbe86743 ! 6:  19d85d56c4 update-ref: add support for 'symref-update' command
    @@ Commit message
         This command supports deref mode, to ensure that we can update
         dereferenced regular refs to symrefs.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git-update-ref.txt ##
    @@ builtin/update-ref.c: static char *parse_next_refname(const char **next)
     +
     +	if (arg.len)
     +		return strbuf_detach(&arg, NULL);
    ++
    ++	strbuf_release(&arg);
     +	return NULL;
     +}
      
    @@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *trans
     +			if (repo_get_oid(the_repository, old_target, &old_oid))
     +				die("symref-update %s: invalid oid: %s", refname, old_target);
     +
    -+			old_target = NULL;
     +			have_old_oid = 1;
     +		} else if (!strcmp(old_arg, "ref")) {
     +			if (check_refname_format(old_target, REFNAME_ALLOW_ONELEVEL))
    @@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *trans
     +
     +	if (ref_transaction_update(transaction, refname, NULL,
     +				   have_old_oid ? &old_oid : NULL,
    -+				   new_target, old_target,
    ++				   new_target,
    ++				   have_old_oid ? NULL : old_target,
     +				   update_flags | create_reflog_flag,
     +				   msg, &err))
     +		die("%s", err.buf);
-- 
2.43.GIT

