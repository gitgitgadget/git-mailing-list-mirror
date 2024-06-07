Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E3194C8B
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767190; cv=none; b=SMQJkSbCipURBmLD+psFKAtHSLOH4w+lJAHkuXXDzPpXCYn+dOYM2slobK7vggquN1X8/DNIEG+MK0JtP0T/A9gWEXTM34Jq+ujhRwOi79AZQla//uPxDA98rvdjynXS13T716F5gv5/Fs1e+wdcDwRxmefP8uAOCirhAdkFCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767190; c=relaxed/simple;
	bh=9r9aLsI9G+WzfcO4xuOVj/83PMF1SS44pU9JrapTYLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7ACRtxlh2rgMBGq+tj4uUp8RSHiyP8bJmBaPwog2oEZuHcZbT405BD9d01WrLDHNxD/PlV+CWkLVJHM88C2gfwG5ecUPnbGsXdHUf8GPS7YZW1lFA5plUIB/f9aTqsvK5cFDIEoiHxjFLGGlsnXLzVesYo1aO85boNSVVKGBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA9jzaxe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA9jzaxe"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a68c5524086so248228366b.3
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767187; x=1718371987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs8qoBknTNW5GPdJ+YmPwd93GaqONGkxKuDqh4NtH70=;
        b=GA9jzaxehW0YRhGu/0mRDqzjoU4rHVuJI3TfsP71XBokejBnM+z5ZPnEzqVuVfl921
         +ZobKooLJsvpbaYczcG5/GACbLYRNiOb0HHIjq1GjbyPhxOg0cl5F83YXVNOED0sxBPK
         KJMJbSs1cvxVFAaFIqbVXzw3hcgdHJPPFVWtYwAZqVz1qvMpBn0WvqpvPoFZs2X3o9j/
         qvjt3kvJPRmtp/6gw1RyZky8/vMlT7bDuD24bKETtkCUoBxFeOoCl6IuCi7wn5NDJLeT
         w/p7YnL9ssl8Tijdoo1Y13aEGeYZhQvtj3ihpPtBJBP34dlopaPVDKSPmakXhisGvimY
         G28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767187; x=1718371987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs8qoBknTNW5GPdJ+YmPwd93GaqONGkxKuDqh4NtH70=;
        b=q/VAUKF1s9ZM5iaE1/3fllMN/ZqnaeTx6nG6rowpAq2+8DNT2cokhW+KAQrY5/nI4x
         IN7mYxwgdMem9QzTP3198eQpXtS/Jk2BxPUI8yYXPvIl8y1L9cO/9Oo8M3W8eUSOu35I
         Z0gjYL1oAfRSY30DjNi8JKVwjhF4P0YOpIyTyo+iYB6ht8n7VPOMqhc25FH/MTdF5bXd
         pk7OFor5d1NaA+PvGJQzIpE4WJDJPf34S65PEtReUR8Ev5eFda5V22kjgMki8onLtB1I
         o9X816nX3XmipmBAMA/XactZCJiHvcBtN4igjF9kHIPTtNDgjSU+zisQ4YLwgHxyuMX9
         8t+A==
X-Gm-Message-State: AOJu0YxJj6c0WTDFTnvwIAPnWwR3SUqgcmvtmwhf1Eogj+tur9Pm6Cut
	K1U2mKU/hP+I7qUQ9cUA/8nMeLZx21t/JUbOwbA/vbf8ttqHeQYMkPNJB4+7
X-Google-Smtp-Source: AGHT+IHp6C8V0z8NU4GA5OkxzXI6AP6fOlGF3ynJllT/OWvIaUKTVUl7Bv5ll7RITVVbLsOyZPvcqg==
X-Received: by 2002:a17:907:2099:b0:a68:abf9:2ba5 with SMTP id a640c23a62f3a-a6cd637e1b8mr164134666b.26.1717767186541;
        Fri, 07 Jun 2024 06:33:06 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2764167a12.90.2024.06.07.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:33:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 0/7] update-ref: add symref support for --stdin
Date: Fri,  7 Jun 2024 15:32:57 +0200
Message-ID: <20240607133304.2333280-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240605102958.716432-1-knayak@gitlab.com>
References: <20240605102958.716432-1-knayak@gitlab.com>
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

The patches 1, 2, & 6 fix small issues in the reference backends. The other
patches 3, 4, 5, & 7 each add one of the new sub-commands.

The series is based off master, with 'kn/ref-transaction-symref' merged
in.

There was some discussion [1] also about adding `old_target` support to
the existing `update` command. I think its worthwhile to do this with
some tests cleanup, will follow that up as a separate series.

Changes since v4:
* Modified the commit message for the second patch and also the error to be
less technical and more user friendly. 
* Renamed an incorrectly named test.

Version 1-3 can be found here:
https://lore.kernel.org/all/20240530120940.456817-1-knayak@gitlab.com/

[1]: https://lore.kernel.org/r/CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com

Karthik Nayak (7):
  refs: create and use `ref_update_expects_existing_old_ref()`
  refs: specify error for regular refs with `old_target`
  update-ref: add support for 'symref-verify' command
  update-ref: add support for 'symref-delete' command
  update-ref: add support for 'symref-create' command
  reftable: pick either 'oid' or 'target' for new updates
  update-ref: add support for 'symref-update' command

 Documentation/git-update-ref.txt |  25 ++
 builtin/clone.c                  |   2 +-
 builtin/fetch.c                  |   4 +-
 builtin/receive-pack.c           |   3 +-
 builtin/update-ref.c             | 237 ++++++++++++++++-
 refs.c                           |  40 ++-
 refs.h                           |   6 +-
 refs/files-backend.c             |  17 +-
 refs/refs-internal.h             |   6 +
 refs/reftable-backend.c          |  17 +-
 t/t0600-reffiles-backend.sh      |  32 +++
 t/t1400-update-ref.sh            | 430 ++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh |  54 ++++
 t/t5605-clone-local.sh           |   2 +-
 14 files changed, 834 insertions(+), 41 deletions(-)

Range-diff against v4:
1:  cab5265c3c = 1:  cab5265c3c refs: create and use `ref_update_expects_existing_old_ref()`
2:  57b5ff46c0 ! 2:  94077e69cc refs: specify error for regular refs with `old_target`
    @@ Metadata
      ## Commit message ##
         refs: specify error for regular refs with `old_target`
     
    -    When a regular reference update contains `old_target` set, we call the
    -    `ref_update_check_old_target` function to check the referent value. But
    -    for regular refs we know that the referent value is not set and this
    -    simply raises a generic error which says nothing about this being a
    -    regular ref. Instead let's raise a more specific error when a regular
    -    ref update contains `old_target`.
    +    When a reference update tries to update a symref, but the ref in
    +    question is actually a regular ref, we raise an error. However the error
    +    raised in this situation is:
    +
    +      verifying symref target: '<ref>': reference is missing but expected <old-target>
    +
    +    which is very generic and doesn't indicate the mismatch of types. Let's
    +    make this error more specific:
    +
    +      cannot lock ref '<ref>': expected symref with target '<old-target>': but is a regular ref
    +
    +    so that users have a clearer understanding.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     -				ret = TRANSACTION_GENERIC_ERROR;
     -				goto out;
     -			}
    -+			strbuf_addf(err, _("cannot update regular ref: '%s': "
    -+					   "symref target '%s' set"),
    ++			strbuf_addf(err, _("cannot lock ref '%s': "
    ++					   "expected symref with target '%s': "
    ++					   "but is a regular ref"),
     +				    ref_update_original_update_refname(update),
     +				    update->old_target);
     +			ret = TRANSACTION_GENERIC_ERROR;
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		 */
      		if (u->old_target) {
     +			if (!(u->type & REF_ISSYMREF)) {
    -+				strbuf_addf(err, _("cannot update regular ref: '%s': "
    -+					    "symref target '%s' set"),
    ++				strbuf_addf(err, _("cannot lock ref '%s': "
    ++					   "expected symref with target '%s': "
    ++					   "but is a regular ref"),
     +					    ref_update_original_update_refname(u),
     +					    u->old_target);
     +				ret = -1;
3:  5710fa81bf = 3:  153d8cce75 update-ref: add support for 'symref-verify' command
4:  5f8fc4eb6e ! 4:  07382bfa09 update-ref: add support for 'symref-delete' command
    @@ t/t1400-update-ref.sh: do
     +		git update-ref refs/heads/regularref $a &&
     +		format_command $type "symref-delete refs/heads/regularref" "$a" >stdin &&
     +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
    -+		grep "fatal: cannot update regular ref: ${SQ}refs/heads/regularref${SQ}: symref target ${SQ}$a${SQ} set" err
    ++		grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}: expected symref with target ${SQ}$a${SQ}: but is a regular ref" err
     +	'
     +
     +	test_expect_success "stdin $type symref-delete fails with too many arguments" '
    @@ t/t1400-update-ref.sh: do
     +		test_must_fail git symbolic-ref -d refs/heads/symref2
     +	'
     +
    -+	test_expect_success "stdin $type symref-delete fails deleting regular ref without target" '
    ++	test_expect_success "stdin $type symref-delete deletes regular ref without target" '
     +		git update-ref refs/heads/regularref $a &&
     +		format_command $type "symref-delete refs/heads/regularref" >stdin &&
     +		git update-ref --stdin $type --no-deref <stdin
5:  1542cfb806 = 5:  d5f92f610d update-ref: add support for 'symref-create' command
6:  ec5380743d = 6:  117b9e49cd reftable: pick either 'oid' or 'target' for new updates
7:  f8d91f7fc9 = 7:  cc140fedbd update-ref: add support for 'symref-update' command
-- 
2.43.GIT

