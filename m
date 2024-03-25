Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB56FE05
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409156; cv=none; b=Sg3bOcRqCzQGLk/cl2fq1RmFQrrcIM6+S9i7Hku3HjgePmPmGtB76+Rcijp20kadwXdp6COp+9SPoOcgmXD8k75qu9LWk444qF1j/MILeb0cAn6pBXVqUB7DaTfkwUknVJaSOt47SK4BuKSZliWmOZLyybpn/0yphE6cVaBZ/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409156; c=relaxed/simple;
	bh=AuuXEvaUj5fwjddVj3K/2u7Nom0oZaLPf21+8UW1L+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JizPGey4+W+XMW56Qeh7u9SFHkY3CZNMKZg2izUiVy5wczXQJFz6/szgY7a3M/WuSQauGrXtxn7h1YtRw8o/1TXznXtrjQTIH4EV9yljEyyJY5V33giUoVmIzYjK47k1tF42qjoZCPXsVeQa+Hbi5LdrdH08MEITzPx0p1F5pug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LheXVw/X; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LheXVw/X"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22a353217c3so829944fac.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409153; x=1712013953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIOKr0Rqfbmx28KYym8PRa2ZmmNbDXjynbMfcEAf1WA=;
        b=LheXVw/XCA+FqhKJof/s4vJsoynWzMMvMQRiwYRejOqJjGlOGAymeUKfkRk/o2HU7d
         ilU6vkkViTW20Ma3kedG9hEEajP61+E69d6Tx7cE4g0MHGfWPEr7ipYZST3wmT76f4d5
         aoVLIJz0pr8IL3DXiBTpmSxGyOJKchisl/9Yn1eDW/8twGoPA8+E62PCpCLVTpzmk6BB
         CJ+GTAPKoga+oryXoak/VwEWkO1VJVgOb8QOKsezdMwfx54BF5HkCZwUi23vOgLkMuSO
         54ko7juzknBGcx7Uyzojmjed/84iWbv1Kx0EQPRExA6AUBPSovmmjcAt7itaMlTiZMds
         uhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409153; x=1712013953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIOKr0Rqfbmx28KYym8PRa2ZmmNbDXjynbMfcEAf1WA=;
        b=j0qy4tSH4vrjhf45Mtb6nVPSNVE14Al98kuGIfiOemV6I2iHlBX4ePdbAZUTbkQvlR
         wow6zd+7o5brl5asrN8BMqytvC5+wZIjC7K1Dg36JfCT7TSWgDxXBdz5gbdMAdWOQTTO
         qAOpH9tYnL1t+EEdx0Ki5+TVjQkR27ebndbxlBhno1dVq0uNEMjEbo3u8x+BT3HFaglu
         mt0H6izB9lQhH5SigcbCVkdJpReVYU+wqKcO0y/+W5loeKFOMBbrUA+oD/CtINHQE7E2
         otpdeOrkxxKkyGAOCzEE6mr+0ww5Qz4VJuS5sD+cWgy3buUxEDqQ5m6j9E722HaQP1DD
         RFJA==
X-Gm-Message-State: AOJu0Yz2coD+bXfTnin5FC//lnsILHxudT4QXtTJ8K09awT/8lb+EAQr
	HT3T7lEVEqSKyeJU+blGz0c96rW7W29Q3Dwrx+nxgr67A4ArzAdx+/einTKrCUQ=
X-Google-Smtp-Source: AGHT+IHpIdUf0oaB8gVRWSnrsGBmiFkkjAyh016cAfpHAh4CMjciMw+f/fY6Y8DbdMMStDKoeHlWkA==
X-Received: by 2002:a05:6870:e242:b0:22a:137a:799d with SMTP id d2-20020a056870e24200b0022a137a799dmr8265759oac.9.1711409152695;
        Mon, 25 Mar 2024 16:25:52 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id vp8-20020a056871a00800b0022a1d794bb8sm1454868oab.22.2024.03.25.16.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:25:52 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v5 0/7] cherry-pick: add `--empty` for more robust redundant commit handling
Date: Mon, 25 Mar 2024 18:16:47 -0500
Message-ID: <20240325232451.963946-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ultimate goal of this series is to allow git-cherry-pick(1) to
automatically drop redundant commits. The mechanism chosen is an
`--empty` option that provides the same flexibility as the `--empty`
options for git-rebase(1) and git-am(1).

Some secondary goals are to improve the consistency in the values and
documentation for this option across the three commands.

See "Does extending `--empty` to git-cherry-pick make sense?" [1] for
some context for why this option is desired in git-cherry-pick(1).

[1]: https://lore.kernel.org/git/CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com

Along the way, I (with some help from Elijah and Phillip) found a few
other things in the docs and related sequencer code to clean up.

This is the final planned re-roll of this series, addressing two minor
style concerns with commit 4/7 as noted in this [2] thread. All other
commits are left unchanged.

[2]: https://lore.kernel.org/git/xmqqa5mmhvx5.fsf@gitster.g

Range-diff from v4:

1:  f6b8a655cd = 1:  f6b8a655cd docs: address inaccurate `--empty` default with `--exec`
2:  401de76c0b = 2:  401de76c0b docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
3:  031b3bb7bb = 3:  031b3bb7bb rebase: update `--empty=ask` to `--empty=stop`
4:  fd53c39482 ! 4:  d3bfe41819 sequencer: handle unborn branch with `--allow-empty`
    @@ sequencer.c: static struct object_id *get_cache_tree_oid(struct index_state *ist
      	struct commit *head_commit;
      	struct index_state *istate = r->index;
     +	const char *head_name;
    -
    --	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
    --		return error(_("could not resolve HEAD commit"));
    ++
     +	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
    -+		/*
    -+		 * Check to see if this is an unborn branch
    -+		 */
    -+		head_name = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE, &head_oid, NULL);
    -+		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_null_oid(&head_oid))
    ++		/* Check to see if this is an unborn branch */
    ++		head_name = resolve_ref_unsafe("HEAD",
    ++			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    ++			&head_oid, NULL);
    ++		if (!head_name ||
    ++			!starts_with(head_name, "refs/heads/") ||
    ++			!is_null_oid(&head_oid))
     +			return error(_("could not resolve HEAD commit"));
     +		head_tree_oid = the_hash_algo->empty_tree;
     +	} else {
     +		head_commit = lookup_commit(r, &head_oid);

    +-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
    +-		return error(_("could not resolve HEAD commit"));
    +-
     -	head_commit = lookup_commit(r, &head_oid);
     +		/*
     +		 * If head_commit is NULL, check_commit, called from
5:  90dca45c12 = 5:  5e690bca6e sequencer: do not require `allow_empty` for redundant commit options
6:  ab3b6afc97 = 6:  ed03908e9e cherry-pick: enforce `--keep-redundant-commits` incompatibility
7:  0e2577ea56 = 7:  d3cf068c45 cherry-pick: add `--empty` for more robust redundant commit handling


Brian Lyles (7):
  docs: address inaccurate `--empty` default with `--exec`
  docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
  rebase: update `--empty=ask` to `--empty=stop`
  sequencer: handle unborn branch with `--allow-empty`
  sequencer: do not require `allow_empty` for redundant commit options
  cherry-pick: enforce `--keep-redundant-commits` incompatibility
  cherry-pick: add `--empty` for more robust redundant commit handling

 Documentation/git-am.txt          | 20 ++++++---
 Documentation/git-cherry-pick.txt | 30 ++++++++++---
 Documentation/git-rebase.txt      | 26 +++++++----
 builtin/rebase.c                  | 16 ++++---
 builtin/revert.c                  | 38 +++++++++++++++-
 sequencer.c                       | 72 ++++++++++++++++++-------------
 t/t3424-rebase-empty.sh           | 55 +++++++++++++++++++++--
 t/t3501-revert-cherry-pick.sh     | 14 ++++--
 t/t3505-cherry-pick-empty.sh      | 51 +++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh   | 32 ++++++++++++++
 10 files changed, 286 insertions(+), 68 deletions(-)

-- 
2.43.2

