Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188482;
	b=dbEWfp5BEPy4Aic60apLX4xaNcD7p3/JvF+D7d8ZuwU7UdwBE4P3q6f67jkLR97GCTTZ
	 jw2R6U7Ui+TZNGwxT8hGWYv2FNQl5Quhdc4zRVwqlpX2lAXBr/ZHjiXr3+kLJq4ueEDuP
	 0yTWxLqLNIRr1V9mTA4np39Eqo3YyQdWo/Z6q8Uet2xzdFZh+52t5Z/i5B61wJWvI/qUC
	 /cwCtqWUi+WMF2Cyw8EenhJG36yV42bRFSCMdr39hEjdxsbQoE8X9GYQ4eQYH8+v3NG+l
	 QFbbU9iVCXCWdsZOV6zPl8dlHGCtTCmXIFxLgPe8ZNoTgr5a87d4WiUWqf7hObiJNww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I/kEvjD1oNEi9669FCZ70pSbteLi+Xov3QAeIn2UH/o=;
	b=fw2eVN+QsW9qcxQylcoTL+4o8FaP3YYMNiAuVWzaYNR5xwvEmL3tAbns8noyUQnvNmv0
	 KVizml7X7k5bZJegF0Xu92JX8xypalyQ/QBL5NqEoxVTvhhDud8E9LAr1DudCisIB2eE7
	 axn8n+rDCfEXZRnvdBkka/4dgFOaBY4j3zFc4C8D91E0TEN2GaWOlR7PAeTzb5Eb0uGUZ
	 pP5UfQTdz/phsgqNYsZJk88pttNRjjceBAa+8kHH9T8QGQxh2iyZZVi+t2bQZAe9gq5x8
	 UDr9NS4hLPpJzYL2nuv5J1Iupno4kvVXU6FxeRzwv6cZU4sSjk8K0fMJAl09pZ69vvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMeenu+s;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3F606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C3F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMeenu+s
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1931ff67a29so576917c88.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188481; x=1793793281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/kEvjD1oNEi9669FCZ70pSbteLi+Xov3QAeIn2UH/o=;
        b=cMeenu+s7PHm08gfl5+HyjXAKfGi1IlX89206XJe2cXYTcJ5xMcagFcAb+y0i387xe
         LYgGRTlNr3jywUF/LmigSIY4p8U3pWMeL3hj0Xev5uQCWvWSAhoNYm6+r0GSHVYlNRiP
         Mx5O7jmf6Cjf6BusgOnF3tf/5qXH3e7vDjO/MJyrDIbotfL05njpuiCmSJzsz0tjyF9R
         BJARsfQcaFl/FWL+R/eoeXnqCcgfBmwTxWyeM2x98eXXjf45T5vveyQfbfsDIsxWQ3V5
         Qhazqoowwmbigb+K7U1YJvrnFylL36TcwOLtfH1++OWOzGRx6HV0DMUiQQ18Qg4ytO17
         I88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188481; x=1793793281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I/kEvjD1oNEi9669FCZ70pSbteLi+Xov3QAeIn2UH/o=;
        b=SY+vxUpAgThCCZ30uRTFhnIoNhbPCXkBs+HDXrMHMqAehOrkLw6uATuQnZCuyTvOuu
         4LPrWG3YKTVU92hSyZCCam4DRdOU+i7R7v46ViGWKzrPqSptIRALemYIoJdw0dTnXEOT
         KvixIKXJpukYcRzC6jnQPX/NRJsB+yKfmsjqRkiTJ145qdWk9SJz0J7U0Kg96UOQSlkK
         2YA6OWqGtKtV5aaiJ9aylaHW0Cj6xQnI3tB4d6lzuJhHvWfGTFAD6q2vHNamsgJ4zaxj
         1XpBjOJa3g8Grmgm1SVBKsU8NB4igVeAsS5ac0eBxmVaFGT3Sn0Koi9Y2P4HJO+n4GdK
         YkJg==
X-Gm-Message-State: AFq9FYK3xOUffPZfbqdMYZJQ6GMy74oICehb164DqUoT2ZovsxbIiHRa
	VbJ97BLK1WlGFF9YVSlGNsiQgbFTuJsCKNz8avmJTHWvKFWwjqlNw8l+AxU1Ww==
X-Gm-Gg: AYBFou25oc3ItZFVwn1NRsMELPBXpG88xGaVVk7rZTdDmqhRIPMCQHMRawWs2fDaBJT
	6Qm7mzgP7YEjK6TLUzMlEF46+9HTay4nsYVDJvDquVgVL2A79puvY9wErQPIlNrlhN2nL1n7mrL
	YR4zMih/wy64eoB8WibED/ZRQ4xFOw9UqyEq2EWMFkXlC2Qq1RnvdpDM9+JGJCMP8PUmesQHaIV
	xDXjPWYafgkDTz9xVTA6RCGOe5tL2YC0sLEfLunyFvhb6J6QV8DqXu3Wam+d1BJQ093l3CPgUE2
	Kdu4+ANjq7EHXp9agtC3d7JY7HVZWMHKA0/T3QNs0cWrYUo4fXvNWzuPp53qouoR6/Q8Z69vi0h
	Fwthdqw7wi9wYKDKy95wEYN6cHYTa9l7Z2iS3ocNJHqRW6krifQa8dVZutFq52lqQinxiN1HT0Y
	DmnxD5l4swtrQaEziQjVN8St6+F75wHqJyPWWGU2M7oEjRHda3owfOPve18aahBtv2yT2Hn+zmC
	mAWRBE2p3fsXxgIFqd07/Lu+s39kXjQgpH7IqxRFbGvVjqWHccpfSusCE/fy2Kolh/IZoRUDNrC
	8lklvac/lD5S7eqxFUfb+2fCdz4PctYDl5TkpigRC6xWu6PhU04GDofW
X-Received: by 2002:a05:701b:464a:b0:166:b307:5855 with SMTP id a92af1059eb24-1a6c24c4efamr3024011c88.0.1793188480685;
        Wed, 28 Oct 2026 04:54:40 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2406:7400:12b:66b5:b36d:2c4:846e:bbe6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f7fb28csm6350819c88.18.2026.10.28.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:54:40 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/5] Improve error reporting to mention how a Git repository is discovered
Date: Wed, 28 Oct 2026 17:23:58 +0530
Message-ID: <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.283.g7d13445134
In-Reply-To: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
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

At the moment, when Git gives up with "fatal: not a git repository",
it does not say which directory it actually inspected or where that
directory came from. This is especially confusing when a leftover
environment variable is steering Git somewhere the user did not
expect.

In v2 I tried to address this by explaining why the inspected
directory was not a valid repository (missing HEAD, HEAD outside
refs/, and so on). Junio pointed out that this is less useful than
saying which directory was used as the repository and where that
came from, since once the user knows that they can go look at the
directory themselves. He also pointed out that v2 was uneven, as it
named $GIT_OBJECT_DIRECTORY but did not say where the git directory
itself came from.

So this iteration takes that direction instead. The validity checks
in is_git_directory() and validate_headref() are left untouched, and
we only add information at the points where we are about to die.

With this series:

 - An explicitly given git directory says where it came from:

     $ cd /srv/git
     $ export GIT_DIR=project.git
     ...
     $ cd ~/src/myproject            # later, same terminal
     $ git status
     fatal: not a git repository: 'project.git'
     this path was taken from $GIT_DIR (which can also be set with --git-dir or --bare)

   --git-dir and --bare both just set GIT_DIR, so by the time setup
   runs we cannot tell them apart. I went with a single wording that
   is true for all three rather than plumbing that information
   through. Happy to revisit if it is felt to be worth it.

 - The discovery walk says where it started, where it stopped and
   what GIT_CEILING_DIRECTORIES is set to:

     $ echo 'export GIT_CEILING_DIRECTORIES=$HOME' >> ~/.bashrc
     ...weeks later...
     $ cd ~/.config/nvim
     $ git status
     fatal: not a git repository (or any of the parent directories): .git
     searched from '/home/user/.config/nvim' up to '/home/user/.config'
     $GIT_CEILING_DIRECTORIES is set to '/home/user'

 - An unusable $GIT_OBJECT_DIRECTORY, which was the original
   motivation for this series, is reported wherever we die for want
   of a repository (explicit git directory, ceiling and mount point):

     $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
     fatal: not a git repository: 'repo.git'
     this path was taken from $GIT_DIR (which can also be set with --git-dir or --bare)
     cannot access object directory '/does/not/exist' set via $GIT_OBJECT_DIRECTORY: No such file or directory

Commands that are fine running outside a repository stay silent and
do not build these messages at all.

This series does not handle the following, which I think are better
done separately:

 - The gitfile case (for instance from inside a submodule or a
   worktree). A gitfile pointing at an invalid repository dies
   earlier in read_gitfile() with its own message.

 - GIT_ALTERNATE_OBJECT_DIRECTORIES. It never leads to "not a git
   repository". Its diagnostics are misleading in their own way (one
   of them points at .git/objects/info/alternates even when the entry
   came from the environment), but they come from the object database
   rather than from setup.

 - The "$GIT_CEILING_DIRECTORIES is set to" line is printed whenever
   the variable is set, even if none of its entries is above the
   current directory and the walk went all the way to '/'. The
   "searched from ... up to '/'" line makes that visible, and getting
   it exact would mean passing more state out of the discovery walk.

CI:

They seem to pass.

- GitLab: https://gitlab.com/gitlab-org/git/-/merge_requests/672

- GitHub: https://github.com/sivaraam/git/actions/runs/40676055975

Changes since v2:

- Dropped is_git_directory_verbose() and the HEAD-related reasons, as
  per Junio's review. is_git_directory() and validate_headref() are
  now unchanged.
- New: say where an explicitly given git directory came from.
- New: say where the discovery walk started and stopped, and what
  GIT_CEILING_DIRECTORIES is set to.
- Reworked the GIT_OBJECT_DIRECTORY reporting to ask once at the
  point of failure, and extended it to the discovery walk (ceiling
  and mount point).
- Dropped the test for HEAD being a symlink outside refs/, as the
  series no longer cares about it. This test was failing on Windows
  in v2.
- Reworked the t0009 tests to check the new messages, including that
  a command which does not need a repository stays silent.
- Kept each message as a single translatable string and added
  TRANSLATORS comments describing the placeholders.

Range-diff versus v2:
(This may not be very helpful because I threw out 3/4 and 4/4 from v2 and have 3 new
 patches in place of them.)

1:  0b062456eb = 1:  b37136baa4 setup: normalize an if-else to follow our convention
2:  7e8dab0078 ! 2:  08f3584c3a t0009: add tests to cover more error reporting scenarios
    @@ Metadata
     Author: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>

      ## Commit message ##
    -    t0009: add tests to cover more error reporting scenarios
    +    t0009: add tests to cover more repository setup scenarios

    -    Introduce few more tests to t0009 to cover error reporting scenarios
    -    when --git-dir is used.
    +    Introduce a few more tests to t0009 to cover repository setup
    +    scenarios. We introduce these as we intend to do some change
    +    in upcoming commits which would benefit from this additional
    +    test coverage.

         Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>

    @@ t/t0009-git-dir-validation.sh: test_expect_success 'setup: .git as an empty dire
      	)
      '

    -+test_expect_success 'setup: custom git directory with missing HEAD is rejected' '
    ++test_expect_success 'setup: --git-dir pointing to an invalid directory is rejected' '
     +	test_when_finished "rm -rf parent/empty-dir" &&
     +	mkdir -p parent/empty-dir &&
     +	test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
     +	test_grep "not a git repository" stderr
     +'
     +
    -+test_expect_success 'setup: custom git directory with HEAD as a symlink outside refs/ is rejected' '
    -+	test_when_finished "rm -rf parent/head-as-link-to-garbage" &&
    -+	mkdir -p parent/head-as-link-to-garbage &&
    ++test_expect_success 'setup: discovery fails when GIT_DIR points to an invalid directory' '
    ++	test_must_fail env GIT_DIR="/path/to/does-not-exist" \
    ++		git rev-parse --is-bare-repository 2>stderr &&
    ++	test_grep "not a git repository" stderr
    ++'
    ++
    ++test_expect_success 'setup: command that does not need a repository stays silent for invalid GIT_DIR' '
    ++	echo x | GIT_DIR="/path/to/does-not-exist" git hash-object --stdin 2>stderr &&
    ++	test_must_be_empty stderr
    ++'
    ++
    ++test_expect_success 'setup: discovery fails when a valid git directory not found within GIT_CEILING_DIRECTORIES' '
    ++	test_when_finished "rm -rf parent/no-valid-git-directory-within-ceiling" &&
    ++	mkdir -p parent/no-valid-git-directory-within-ceiling/ceil/sub &&
     +	(
    -+		cd parent/head-as-link-to-garbage &&
    -+		git init --bare real-repo &&
    -+		touch garbage &&
    -+		rm real-repo/HEAD &&
    -+		ln -s ../garbage real-repo/HEAD &&
    -+		test_must_fail git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
    -+		test_grep "not a git repository" stderr
    ++		cd parent/no-valid-git-directory-within-ceiling/ceil/sub &&
    ++		test_must_fail env GIT_CEILING_DIRECTORIES="$(pwd)/../../" \
    ++			git rev-parse --is-bare-repository 2>stderr &&
    ++		test_grep "not a git repository (or any of the parent directories)" stderr
     +	)
     +'
     +
    -+test_expect_success 'setup: custom git directory with invalid GIT_OBJECT_DIRECTORY configuration is rejected' '
    ++test_expect_success 'setup: discovery fails with unusable $GIT_OBJECT_DIRECTORY and explicit gitdir' '
     +	test_when_finished "rm -rf parent/invalid-git-object-directory-config" &&
     +	mkdir -p parent/invalid-git-object-directory-config &&
     +	(
     +		cd parent/invalid-git-object-directory-config &&
     +		git init --bare real-repo &&
    -+		test_must_fail env GIT_OBJECT_DIRECTORY="$(pwd)/does-not-exist" \
    ++		test_must_fail env GIT_OBJECT_DIRECTORY="/path/to/does-not-exist" \
     +			git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
     +		test_grep "not a git repository" stderr
     +	)
     +'
    -+
     +
      test_done
3:  312b861c6c < -:  ---------- setup: introduce new helper 'is_git_directory_verbose'
4:  29191f463e < -:  ---------- setup: communicate why a directory is not a valid git directory
-:  ---------- > 3:  34a110da6d setup: provide hint about the source of the explicit git directory
-:  ---------- > 4:  9986739fec setup: provide hint about auto-discovery boundaries
-:  ---------- > 5:  7d13445134 setup: report when GIT_OBJECT_DIRECTORY is what we could not use

Kaartic Sivaraam (5):
  setup: normalize an if-else to follow our convention
  t0009: add tests to cover more repository discovery scenarios
  setup: provide hint about the source of the explicit git directory
  setup: provide hint about auto-discovery boundaries
  setup: report when GIT_OBJECT_DIRECTORY is what we could not use

 setup.c                       | 104 ++++++++++++++++++++++++++++++----
 t/t0009-git-dir-validation.sh |  77 +++++++++++++++++++++++++
 2 files changed, 171 insertions(+), 10 deletions(-)

-- 
2.55.0.1003.g10538fe699

