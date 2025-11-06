Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE34CB5B
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417357; cv=none; b=gvMTvfyBNTGD0p+yVZyavCQyJNXOcGoHrU5L7B7MrMcabjgHWMub+0CzMCaAb8VORX4CKJNQTjFwg9LMWfekq+5ZEOi1ltLIS/QLFOhK27M6B7ghrjbVcigjio3Mr9vAiHHCWBn7sgwsh7yUjtyGd9ttcIQd9Vex+MoRbF74eGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417357; c=relaxed/simple;
	bh=0oRuNZvgazNctBNf+sD3EZ7EiXFWsG/eq8HpXZadRWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ss4U7FktStPazBAhic8fXccoi9a1yAP4v0kXxrcFQEQWwOOvmsIOu1V9ALlIX+o/RrVt5VXL/NR9CL8Qwr8Z73phaXPedqPcrQSJpfmw9aVE3S0dFdtKgdBcuwWc2KUBF18VVS6LocUoHlZ+H9wiwAX09LvqD8a1z2ypAB8u7pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KucpIEnP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KucpIEnP"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7291af7190so70065666b.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 00:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762417354; x=1763022154; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWAqpX3DLF+zA54zLUshrFjxhTSKXwEmReE4F240CK0=;
        b=KucpIEnPpmMZ028k1SXhHY39IsIB02rvquTOZ9i9AGeuS4Af/p/9Pti+7Sh8bjB147
         BsaaQfy9isR2R5BgmO6lAaPReOy0imZNgcPAHvU0SmD01P+BSn8L9xMSGgN7+C2GqjF6
         sWKLWos3aFMLa8cxXdEOKSpJejtHQY2z37j5uEP1DhdsdsCvccWggxTJgyYFJl8XSmj4
         uHum+oqlfgycPNW+fv98qSDmnCoBHQtsWygriKTeDgWvxeeEAD146m8R5afNJ9xoNeja
         b8rVFyNd14hkmB5uZ3joGK6G6WqZOI2lx4HDr02/Wj9f3SlbnMOjL/haMNd80ONex+b+
         R/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762417354; x=1763022154;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sWAqpX3DLF+zA54zLUshrFjxhTSKXwEmReE4F240CK0=;
        b=VkbjX026+A7eTHsyAFUfxA0rt8iDgdmkr84dL9NIBrBdae8UuppYCGRmZtm9Wjy51l
         7Ctn0zeVLvY9D4ilO68Y13+kzikMPt7ABF76N5oeJBPpLk1HJ5iHp+t/pMtBWgQJLKug
         OggXdXEtZqXRU0B+TVhdB3IEWo1I3o/61aZx+7C5QoU4bgoyKHkzLpmXvrLuLQCamM2C
         jeW/teo9whRt30i9BBM2gI5H9sEVfFY0qSRHOx6RZMaZroZNKX1dY1Oi84EDitT5Y/LR
         wEaPmmoC78Ip2ES16TOuJGhcXuNWBU8hEXi2e4E7lsO+HY1sAf3oLgd95JE/0Pt2GVtn
         L95w==
X-Gm-Message-State: AOJu0YyDJ4RsAldbfVIDeTweobFCJJm9yA7F2ifUegcg7NHQncQji9aj
	aoORweIogpPxQah3P2aP8uiTSE+Atg9zdsTQlQQbvoFo2nlS30C349o7
X-Gm-Gg: ASbGncv2ObgwQr05a6/yQx6ZJ9iLo7Org8CNJ0KhaPT1bTQxagmDLTjrruuddoYEPUx
	pRNLBnDEtIul81leLV6r4oyWZ/5Pycv0gwTytqQVGtomQ7zgPXPECQ0GwelnOADOxgVSOKoJ+AO
	XJ/CwrzeskaRP/1jO3yp6B8sBA77wc0PtYLik/RShdew4EppREm8lyKCoV0EyxHdQnAE+c7ChXe
	UCVxMK8xaEBpJFkV4K2U27gXVtubpcQOZjnjDsTV6FYS4q1/QKPD5DVZFg4FI7BcY0km9Q7vOTc
	cNaWnMl1GDGDuqujR583rSBQM3x81roDrJ26ZgsKxkNpcpQsHVCWwbxg4zOcX+JqRirGwOW0SVw
	cLiWNbQT7t2N7pu9ZJtsFRvLe/vqD7DUPIVygoloDCp5H2LhxyJKPEIsM323a1U9bsQEoqYfz9c
	rFipNM
X-Google-Smtp-Source: AGHT+IHzK2TfqyaE1ZBbTgq4BmKSguFmDB7Q6YVIs8dNnq5amHC9pqu1in5TrpCXA2oWCUEOjyZlNw==
X-Received: by 2002:a17:907:97cd:b0:b72:1ced:f213 with SMTP id a640c23a62f3a-b72654d7449mr622403966b.37.1762417353461;
        Thu, 06 Nov 2025 00:22:33 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:107:48a1:df96:bd1c:78ca:785c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893360f6sm160577566b.10.2025.11.06.00.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:22:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/5] maintenance: add an 'is-needed' subcommand
Date: Thu, 06 Nov 2025 09:22:29 +0100
Message-Id: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMVaDGkC/53OwQ6CMAwG4FchO1vTbUDUk+9hPIy1wKJshiHRE
 N7dQUz0zPFv2v/rJCL3jqM4ZZPoeXTRBZ+C3mXCtsY3DI5SFgpVIVFJKEoFhgjiswIbus54giG
 AbdnewNXQGecH9sbbdBrBMxMToLSGUVZ5iaVI3Y+ea/da3cs15dbFIfTv9Y1RLtOvqLeKowQEg
 5oKzepAyOcmLd73qUEs4qh+isR8q6KSolHnpTJHzpn+lXmeP79j3eRgAQAA
X-Change-ID: 20251021-562-add-sub-command-to-check-if-maintenance-is-needed-01cae01b4606
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7361; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=0oRuNZvgazNctBNf+sD3EZ7EiXFWsG/eq8HpXZadRWg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkMWse914POziz8oAKlESSVVRJLA4oo+WBPE
 2ysVfQGwOQl0IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpDFrHAAoJED7VnySO
 Rox/WkUMAJscizlyMd6ZTKDWjXunbaZKeh/CNGIDvr/Lr42gCfDxiofew5Qkl5+6fViOf5ZE2lf
 HNapQB9+cFx7rkVZBNUnQD37/QApdRZxSsbO4IljBfLl+Sm69fAqULke2mi4VOHaGVPABn7udnx
 oCr4iUXMrVRrofcUsEV/ZAUn/o5hsNscq8gwGL7xRq8AlzOP8KrGebaPnguus4KiaVIXqc7AQIj
 ePZuqFdCh4lhRsHJs1+zx9Iek9G5sldNz8fVi+nhSRZFTfWft6MBuYM7HzNenatsQF70/AvZZFr
 lZsZVFH3VCk6ytYqsYu20MlLnXAIfmlFfmho9M3jIfS0M//aLSqdfRn08ZLIoCYBoNiIAvjp8+0
 dU6hDMckQu9RQRCRbStNeH9qQ1QcKygXyuwtOERnXz7XQUajA3Pg4BkGuXGHcm/2IQYAuuhmckR
 51FwTkC7kBZKv7QGihaqYRn1EN/pawisw+YB4GB8TAX2oMSLyksKE1qRDWWCAQSom6bQQqDgsQ3
 Rw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Hello,

I recently raised a patch series [1] to add 'git refs optimize --required'
which checks if the reference backend can be optimized, without actually
performing the optimization.

Back then, we had decided [2] that it would be a better to broaden the
approach and add a 'is-needed' subcommand to 'git-maintenance(1)'. This
would allow users to check if maintenance was required for the
repository and users could also provide a task via the '--task' to check
if maintenance was needed for a particular task.

Ideally the subcommand will be used with the '--auto' flag which can
check the same heuristics as that used with 'git maintenance run
--auto'. Future patches can also add support for the '--schedule' flag
which can be used to check required schedule it met. However that flag
isn't added as part of this series.

This series implements that.

Commits 1-3 add the required functionality in the refs subsystem to
expose an 'optimize_required' field which can be used to check if
backends need to be optimized.
Commit 4 utilizes this within the 'git-maintenance(1)' code.
Commit 5 adds the 'is-needed' subcommand to 'git-maintenance(1)'.

This is based on top of master a99f379adf (The 27th batch, 2025-10-30)
and is dependent on the following series:

    - kn/refs-optim-cleanup
    - ps/ref-peeled-tags

Merges cleanly with `next`. I think those two topics are close to being
merged to `next` so hopefully this dependency tree doesn't get too
complicated. I'll rebase as needed to resolve conflicts.

[1]: https://lore.kernel.org/git/20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com/
[2]: https://lore.kernel.org/git/CAOLa=ZRdxm787nE4FSr2VUHDB+hW06Ggc6yUcKmeTKAb6B7YOA@mail.gmail.com/

---
Changes in v3:
- In patch 2/5 extract out code for deciding if compaction is required
  into a static function. This removes duplication of logic for deciding
  if compaction is needed.
- Link to v2: https://patch.msgid.link/20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com

Changes in v2:
- Added more documentation for `reftable_stack_compaction_required()`.
- Fixed some typos and grammar mistakes in commit messages.
- Clarify which tasks will be run when '--task' is not used.
- Move the call to 'usage_with_options()' to be with 'parse_options()'.
- Link to v1: https://patch.msgid.link/20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com

---
 Documentation/git-maintenance.adoc | 13 ++++++
 builtin/gc.c                       | 85 +++++++++++++++++++++++++++++++++-----
 object.h                           |  1 -
 refs.c                             |  7 ++++
 refs.h                             |  7 ++++
 refs/debug.c                       | 13 ++++++
 refs/files-backend.c               | 11 +++++
 refs/packed-backend.c              | 13 ++++++
 refs/refs-internal.h               |  6 +++
 refs/reftable-backend.c            | 25 +++++++++++
 reftable/reftable-stack.h          | 11 +++++
 reftable/stack.c                   | 61 ++++++++++++++++++++-------
 t/t7900-maintenance.sh             | 54 +++++++++++++++++-------
 t/unit-tests/u-reftable-stack.c    | 12 +++++-
 14 files changed, 276 insertions(+), 43 deletions(-)

Karthik Nayak (5):
      reftable/stack: return stack segments directly
      reftable/stack: add function to check if optimization is required
      refs: add a `optimize_required` field to `struct ref_storage_be`
      maintenance: add checking logic in `pack_refs_condition()`
      maintenance: add 'is-needed' subcommand

Range-diff versus v2:

1:  16b447b66c = 1:  fe8977aefc reftable/stack: return stack segments directly
2:  b463d5c69d ! 2:  e73f672566 reftable/stack: add function to check if optimization is required
    @@ Commit message
         is no way for the user to check if optimization is required without
         actually performing it.
     
    -    Add and expose `reftable_stack_compaction_required()` which will allow
    -    users to check if the reftable backend can be optimized.
    +    Extract out the heuristics logic from 'reftable_stack_auto_compact()'
    +    into an internal function 'update_segment_if_compaction_required()'.
    +    Then use this to add and expose `reftable_stack_compaction_required()`
    +    which will allow users to check if the reftable backend can be
    +    optimized.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ reftable/stack.c: static int stack_segments_for_compaction(struct reftable_stack
      	return 0;
      }
      
    -+int reftable_stack_compaction_required(struct reftable_stack *st,
    -+				       bool use_heuristics,
    -+				       bool *required)
    -+{
    -+	struct segment seg;
    -+	int err = 0;
    -+
    +-int reftable_stack_auto_compact(struct reftable_stack *st)
    ++static int update_segment_if_compaction_required(struct reftable_stack *st,
    ++						 struct segment *seg,
    ++						 bool use_heuristics,
    ++						 bool *required)
    + {
    +-	struct segment seg;
    + 	int err;
    + 
    +-	if (st->merged->tables_len < 2)
     +	if (st->merged->tables_len < 2) {
     +		*required = false;
     +		return 0;
    @@ reftable/stack.c: static int stack_segments_for_compaction(struct reftable_stack
     +
     +	if (!use_heuristics) {
     +		*required = true;
    -+		return 0;
    + 		return 0;
     +	}
     +
    -+	err = stack_segments_for_compaction(st, &seg);
    ++	err = stack_segments_for_compaction(st, seg);
     +	if (err)
     +		return err;
     +
    -+	*required = segment_size(&seg) > 0;
    ++	*required = segment_size(seg) > 0;
     +	return 0;
     +}
     +
    - int reftable_stack_auto_compact(struct reftable_stack *st)
    - {
    - 	struct segment seg;
    ++int reftable_stack_compaction_required(struct reftable_stack *st,
    ++				       bool use_heuristics,
    ++				       bool *required)
    ++{
    ++	struct segment seg;
    ++	return update_segment_if_compaction_required(st, &seg, use_heuristics,
    ++						     required);
    ++}
    ++
    ++int reftable_stack_auto_compact(struct reftable_stack *st)
    ++{
    ++	struct segment seg;
    ++	bool required;
    ++	int err;
    + 
    +-	err = stack_segments_for_compaction(st, &seg);
    ++	err = update_segment_if_compaction_required(st, &seg, true, &required);
    + 	if (err)
    + 		return err;
    + 
    +-	if (segment_size(&seg) > 0)
    ++	if (required)
    + 		return stack_compact_range(st, seg.start, seg.end - 1,
    + 					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
    + 
     
      ## t/unit-tests/u-reftable-stack.c ##
     @@ t/unit-tests/u-reftable-stack.c: void test_reftable_stack__add_performs_auto_compaction(void)
3:  b9f44f61f2 = 3:  7d2428b2f9 refs: add a `optimize_required` field to `struct ref_storage_be`
4:  f94ddfdba3 = 4:  3c5f969d62 maintenance: add checking logic in `pack_refs_condition()`
5:  bc56849266 = 5:  bc2d3c26e2 maintenance: add 'is-needed' subcommand


base-commit: edd2018f5db39d68d55a7a4af42375b1a06b9406
change-id: 20251021-562-add-sub-command-to-check-if-maintenance-is-needed-01cae01b4606

Thanks
- Karthik

