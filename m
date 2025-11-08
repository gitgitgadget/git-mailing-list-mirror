Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75315667D
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762638727; cv=none; b=FNvxrf1NaCHix7Dap4rOCFEML75da3JOV5TgAjalkQBvM/1Obi8Wfk8nozni3kXFROAQ5f8msf1nbAvDJIhykdj8QeIj1xyc771xl/JRUkngUTfQ/iTGo2ynxKcvVrtdN22ZMIOheYbHPCijCow1WqHRr70L0TEofGBUDrkrEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762638727; c=relaxed/simple;
	bh=rWQ8xcz4oo7QskOW5NjIKs2YNitWwmZEmdLHzaelAJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=L8K6vqd0zW3XnFs6hVUD/FVG0On/NYm+No4w9A7aU/ICXVzcD8nob854diPHw/0u+zqnLWaCQfbJfdXfIwMYWzYWWVPM6g0F3FRTSaHYB7ZeG/L8mvJrNbOD5lPiAvxs7LXhJO2EslrVzvU4biOxO7wt97VnQb8h4ZM0jie3wao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0YaB/yb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0YaB/yb"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so3223509a12.3
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762638724; x=1763243524; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dTCMD0d4AICGdz2KqjYIXZF8K6cFVj9ZWBt6FM9jsU=;
        b=J0YaB/ybCI3hFRTnI47+JoufwbaE70p8URZmEtiTAoMKzghCZNb+ALqxTblE/iy8q2
         3NXzoDLRg1nLaGAKZJW+4PMRcYSy7WEM8Z78CovUZRcUTUF9fQa3OarWmfy2cOrtQgHt
         pNu53gr2zvdyGOvd3xXAQPJjzvmSJxtV/PV++aZbzBcMIccY/BxrRvOlT1HKIWf1rWZ3
         WstN8HOUZnv4zLUr5tOiUIjFkosK9HchYoh6QRH6wV+XgFz4I+kp2XkdBAnj3CEsxPlX
         UKK48LT03XP+qaM5KNt4AdD7jM9Eq6T6A/5uFJ7cYjYzOOCLh1gNBiotp2DK/2sokF06
         rYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762638724; x=1763243524;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dTCMD0d4AICGdz2KqjYIXZF8K6cFVj9ZWBt6FM9jsU=;
        b=sbld2s326hmCv5xzWl6vbeCzK0gujv7jWEwXlJfeXp7iLFtcHrf5SA9Y7wrr5tbkZC
         HmxcPwXXM7Yq6G0KUlw8e8FMVGvncWtscT5ONkAeoHGIh1BhWcbg/UXahIlgSg916gsP
         7Zh34qR8npGjwIBPMj3VU+2DcEO0okB/2hsz4sppzJ/YpoLJM5psHDE3oR1e5giNlH4I
         EbSg7kL/QkO2J2eiqLg5q+rt2AtjYMLq6c70yPNSD0v/IsqkT8OHorGo71jz1h9xDTKe
         C+/F5LhgUgQQ6HI5MUJq3Fj4OtYbgaXsa1KDOVFSm686WDWli81NMOeE4L92JOVErYlP
         rP4A==
X-Gm-Message-State: AOJu0Yya860/O5g2Fo+8ynuaHBW6l5sqH4kq3U4W69lmbVodaeTbrFfx
	YHn5lvb1Q149igN9xZY8FecLYr/a77Isae5M7sDsIw8/rwchUiEuphin
X-Gm-Gg: ASbGncsXRGOCnp8PvTLkVCm0xUhHWYUu4GyD8+KueZxgFqfz9Z2nBk42lGvi7xzzj9/
	AHKHax9Tobz+6ereyjjBpLTOV6j8y9mJ1NpbN/rWLSx3maa+KMUKtiW078TL8mhAbssvWUCccIM
	QdVV3qZEnaMjb13g1/vzK199qhgPOEi5qLsl+ief1Jk7L6ZpAt8KTq60o+2Dg0jrH6j9quDZzTP
	OSrMB8jk7cXbizQHFQP8SbT8mf/2Dp7YVtsonoI7pABBCs1cDcJss4Y4bpzULA9jIUxyWM4b4+E
	mhoMpKJQsOvpqZfSxD7PdwIQKhdJIJfaHhALho3O8X+DQ2efpQz0GIOW3ntNU435IfHuI5LgTmN
	stqD1UP+JmYgwtdiGlDraKGN4pad8zWXUsJNCWdvMrRW+jjSwdQQiOIOCNULt0H6vQmIeyywXmu
	upo0AHN/ntWq/AwZk=
X-Google-Smtp-Source: AGHT+IH91HULAaf55S3MDVbpZv+AsaThht1Pd3zWRPk2A/cZBnn2/srtqre+3qlr2HxBXxI+Sf9H8g==
X-Received: by 2002:a05:6402:5214:b0:640:9993:3cb8 with SMTP id 4fb4d7f45d1cf-6415dbfb3e5mr2772789a12.5.1762638723621;
        Sat, 08 Nov 2025 13:52:03 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415b69c366sm3056371a12.23.2025.11.08.13.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:52:02 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/5] maintenance: add an 'is-needed' subcommand
Date: Sat, 08 Nov 2025 22:51:52 +0100
Message-Id: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHi7D2kC/53OTWrDQAwF4KuEWVdBmj/SrnqP0sVkJMdD6nHxu
 KYl+O5VQqChSy+fkN6ni2kyFWnmZXcxkyyllbFq8E87k/tUTwKFNRuLNhBaghAtJGZoX0fI4zC
 kyjCPkHvJZygdDKnUWWqqWU8bVBEWBqScBOnoI0aj3Z+TdOX75r69a+5Lm8fp5/bGQtfpXXRbx
 YUAIaHj4MQeGOX1pIsfe20wV3Gxfwqh36pYVRw6H216Fi/8X3GPStyqOFU4EiVVQu7Co7Ku6y/
 bupdYxgEAAA==
X-Change-ID: 20251021-562-add-sub-command-to-check-if-maintenance-is-needed-01cae01b4606
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7359; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=rWQ8xcz4oo7QskOW5NjIKs2YNitWwmZEmdLHzaelAJU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkPu4EvUfEW5WEKMPdtI9HlFAp68DI5B5rv+
 K8rWJ3i1c0Q1IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7uBAAoJED7VnySO
 Rox/EZ4L/3YM687vVUnRdZvjonsl9N7hlvCcNJfqK4l72K71I8rDLaYfvGLx9kKSY8yx4KPHq6y
 F1XuZvc5POgnZigJ6pUmVJ5VLbhPNrBnYF2AA2dOhqDo6xIqzQenF/Jds37/8T0sPlQiRsTCdHJ
 WKSWJWrH7hDU2JPbq+pC0SEiawAKFM38gwtIStn3fsRnzgt3qK7EakN+jycuTEyc7dxLUMmDXW2
 C1IPb9r5zDC/3bCx6PZxeyTSfsmJXUZovBObinro2Nqk9KBB0hP0Lwa3GfVaww9p4yXTFglV0Nr
 RqlHxe6nbd/+RGvzmCz/cKBPdX7MyEvHIJzLpy7XShBlRef3isrwYwTMl7r1jvr0hGbA4G6+CeA
 mwKJCMVAsa7z8/30deJX0HJVPL4Bxhxl0+JHdl1zCvK3NDPW+Ce911jBf5d8n/LH4tc7jPBBuBq
 KHvhZ1QMsF8WT5OdpMLBD9IvEDdaUj7cvv88qa6e/KWrAOpCwxtUkUzxC1qugiJsZa4vVCXj/S+
 ak=
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
Changes in v4:
- In `update_segment_if_compaction_required()` change the argument name
  from `use_heuristics` to `use_geometric` since we only have one
  heuristic currently and this is much clearer to understand.
- There were a lot of discussion on how to return a bool variable when
  the function has a return type of int. We discussed both '!!required',
  and 'required != true'. I'm going to punt this discussion keeping it
  simple as 'return required' as in my first version, since even Junio
  expressed his thoughts in favor of it.
- Add a TODO for improvements to the flow when running `git maintenance
  is-needed` without the `--auto` flag.
- Link to v3: https://patch.msgid.link/20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com

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
 builtin/gc.c                       | 93 ++++++++++++++++++++++++++++++++++----
 object.h                           |  1 -
 refs.c                             |  7 +++
 refs.h                             |  7 +++
 refs/debug.c                       | 13 ++++++
 refs/files-backend.c               | 11 +++++
 refs/packed-backend.c              | 13 ++++++
 refs/refs-internal.h               |  6 +++
 refs/reftable-backend.c            | 25 ++++++++++
 reftable/reftable-stack.h          | 11 +++++
 reftable/stack.c                   | 61 +++++++++++++++++++------
 t/t7900-maintenance.sh             | 54 +++++++++++++++-------
 t/unit-tests/u-reftable-stack.c    | 12 ++++-
 14 files changed, 284 insertions(+), 43 deletions(-)

Karthik Nayak (5):
      reftable/stack: return stack segments directly
      reftable/stack: add function to check if optimization is required
      refs: add a `optimize_required` field to `struct ref_storage_be`
      maintenance: add checking logic in `pack_refs_condition()`
      maintenance: add 'is-needed' subcommand

Range-diff versus v3:

1:  48c877bbc4 = 1:  4026aad0e2 reftable/stack: return stack segments directly
2:  b2c0da304b ! 2:  ed2b307572 reftable/stack: add function to check if optimization is required
    @@ reftable/stack.c: static int stack_segments_for_compaction(struct reftable_stack
     -int reftable_stack_auto_compact(struct reftable_stack *st)
     +static int update_segment_if_compaction_required(struct reftable_stack *st,
     +						 struct segment *seg,
    -+						 bool use_heuristics,
    ++						 bool use_geometric,
     +						 bool *required)
      {
     -	struct segment seg;
    @@ reftable/stack.c: static int stack_segments_for_compaction(struct reftable_stack
     +		return 0;
     +	}
     +
    -+	if (!use_heuristics) {
    ++	if (!use_geometric) {
     +		*required = true;
      		return 0;
     +	}
3:  aec4861598 = 3:  4ac6fe6346 refs: add a `optimize_required` field to `struct ref_storage_be`
4:  36d9bfbfe0 ! 4:  e239f9d1d1 maintenance: add checking logic in `pack_refs_condition()`
    @@ builtin/gc.c: static void maintenance_run_opts_release(struct maintenance_run_op
     +	clear_ref_exclusions(&excludes);
     +	string_list_clear(&included_refs, 0);
     +
    -+	return required == true;
    ++	return required;
      }
      
      static int maintenance_task_pack_refs(struct maintenance_run_opts *opts,
5:  2fc7dcb38c ! 5:  2457e5ce0e maintenance: add 'is-needed' subcommand
    @@ Documentation/git-maintenance.adoc: The `unregister` subcommand will report an e
     +    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
     +    Ideally used with the '--auto' flag.
     ++
    -+If one or more `--task` options	are specified, then those tasks are checked
    ++If one or more `--task` options are specified, then those tasks are checked
     +in that order. Otherwise, the tasks are determined by which
     +`maintenance.<task>.enabled` config options are true. By default, only
     +`maintenance.gc.enabled` is true.
    @@ builtin/gc.c: static int maintenance_stop(int argc, const char **argv, const cha
     +			}
     +		}
     +	} else {
    -+		/* When not using --auto, we should always require maintenance. */
    ++		/*
    ++		 * When not using --auto we always require maintenance right now.
    ++		 *
    ++		 * TODO: this certainly is too eager, as some maintenance tasks may
    ++		 * decide to not do anything because the data structures are already
    ++		 * fully optimized. We may eventually want to extend the auto
    ++		 * condition to also cover non-auto runs so that we can detect such
    ++		 * cases.
    ++		 */
     +		is_needed = true;
     +	}
     +


base-commit: edd2018f5db39d68d55a7a4af42375b1a06b9406
change-id: 20251021-562-add-sub-command-to-check-if-maintenance-is-needed-01cae01b4606

Thanks
- Karthik

