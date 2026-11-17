Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921879;
	b=iRsQgR3H2btlQSblrGgOFIIfVQi3AsPlwX6dbs5T1KGLsyoXGRZgs6vgNGTyRt+lsRGu
	 jvZdrMxpv7WLEJJrbmVhZXPkPAIhTaYsERFU/E7cqBNLBofexsvCtF14pCAFOwQ1SNd5p
	 9M3mv43WYlFdm/rY+tvq+m/jTrVHHZEfd945gl91qcpiHphOE/2mkPsSVj+/dQ6ZKmYOf
	 4vE8gvUgXq+QToKrHy0aMm8J+7rdqmvgGDFcvT3h3ZiJxkYlR7Q5Mhp6MeSwu79J3XXkS
	 OZAGdX/NvjilFlhG2P+PNpXcXpqK/rEkoHTN2pOU8m41ToNysU7nS67Fz4jND3dk4bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=z3Hhf5llbwauoy+0baboVipIseWUV8YNpzS17cUcjjo=;
	b=XSgIgScWEdgqX8tvU9ex38K3pXqXEOwbcUz2kQJsLbvOZSgkauib9raW3weYWUnXZLUV
	 ohjWlypQAR6NuIFymhiJg8xUT0qoB71aU9Mg6ef8RI4ttlZ6F1N60Ts2nv3kBKV0viLmL
	 U6BsmXfX4n4usQD8XZ5n689rrHGhoSpAdqNQnqz5OQ88ji1H50bKD7jPnsIeS8+xEZrsS
	 oP351W8LWaEattG3e8380hFDt1EJlj3920RAPuPK9mvAV6zU75YiGY2MZutrVrnNhwL1e
	 89fYfKxXu1cAuyMADlM98fbAzYfOJedUUio9kgUygM0XH8xnT+ouHucaBjfBKVfPjEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFgVsHmv;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256A606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 13:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0256A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFgVsHmv
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2efde3200c7so2951165ad.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794921878; x=1795526678; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z3Hhf5llbwauoy+0baboVipIseWUV8YNpzS17cUcjjo=;
        b=sFgVsHmvDX0F8peHyzvbMCFnCGgGjHkBkxnb5xDRBvIYzii5tSh0Y0AS5wBLaFJMqi
         J6onP+rljGv6AswrxpnBWQ/ZVTxYr4Yz0fu4laXD/0mBnWoLH1gZhiqIg6U6lKnn9Av9
         djTF6DVV1jKKM5QI8uIK0qfx4rYq8BiwbNLFHMldMBNglAB2OIU3IuoHlzt6nzAinFu1
         u1699KrxeylMU6Hs+xdEwtrkyELxjZK9IRXm62u3c8O47cimeqI0ghE6PgJ/on86wcUp
         eEmpih7HnDPu6SIBYPBDdmA2mvxOqUdHU2CJq+vpchsj8aZnuW9F0x7HXsSM3ooqfj5V
         neYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794921878; x=1795526678;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3Hhf5llbwauoy+0baboVipIseWUV8YNpzS17cUcjjo=;
        b=Pq2D67FMONAOhAW7qFxMfyN+uHQGUASigF5Odl1lNRjSqO5WtHEBiK4RTHAemhECIL
         vyGDkDYDij5cZ85CAin6hZL851XcV6R/d8z074M2lFBdY4kuUVkQcuigrkIknTSnpBbN
         7DNDHPOLoKduThX83nVCf6e3VCKpO+QvsG7Do5OssliUjha5G0T0FOHv4kqWgGk9CErV
         vwCy527IAJiSnwqUpPx4RguTqY7PUmXEbeAMYlLE9U2/v7Ev226Zasp3HAif+Au1+YkK
         StC1Uj7ooHf4q3vRY2m1eyq7x0weqGJX2TwmaHarvRoyw/cM3lgeMyxkfinGujXNhAG9
         Zssg==
X-Gm-Message-State: APuU4Z9QuBpBCBno5Por4ImFBiZC4ZyQiFLBk6J2u+3U2nBU6885Jo6s
	LLFlO8n8/SeLzEYUW4XccemegZAHiTEchDQ6j0LBegxehyr4q78pPMo6TGPYAA==
X-Gm-Gg: AZFdTZdBJZI05yiEyyvKskuYs9KSrYOq7zKFdxSB9wsIPRm1mvK58vu0c4595Yk8Yxu
	N2dJx/6YupqIXPOLD79/xvTfFtBIZD+OVEfZY554lYjDtMi9H7M+tZLTUFT1RyrIUb/ADfF3Cky
	4XKpKf/rq/TNW5IWAvY4XRv2UtvGMNQbVg1Lml7lpWUX4MNJDYSBZLzcpRiSTDlSAGD/i1LtrwN
	hD7f+FRKhI+ktgOwErRzDud27aij2FjkqaJv0dZ+cxiI/7N4Nx2XPSFmOVr4zyxMnjciCixvVEa
	MN+v/xy/nEpgR+XH6fmVIlfVRMkh65EP4CViWtheaM/jrUvRsqGwZbQw0iSI2G5QYaaCDtbVg/I
	0i/EdM61TTmLa29v3uMjVyOKRJ4HTPsSdHMyGejSNrpukXaPAWznM7MMNh4EdIrScJmEitIISDJ
	rNTlNy+XfmRMRabPszCKY0eKlBXy7L6v0nOegXVdZsdzOi/XxkvRzrsILLQ+sVynsPVg8pEJLzT
	1ae3+hf4kby3WPBxnMurridFae/EGsL4wS2YaRjT999sWJzmWuh7WFL2fK6vduUjS4OokzUH3nQ
	ZNDCYNKmWY7UL6jeE5LcX/MajtQif+fqOGDJm9JVxrqATAHDdwebbLc0wkL5LSt72vWMgNj5leY
	Mp3Y42X8s
X-Received: by 2002:a17:903:3887:b0:2ed:130f:8689 with SMTP id d9443c01a7336-2ee0dcc5b1emr111586345ad.61.1794921878177;
        Tue, 17 Nov 2026 05:24:38 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-125.us-west-2.compute.amazonaws.com. [3.42.157.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a11be4sm15536585ad.12.2026.11.17.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:24:37 -0800 (PST)
Message-Id: <pull.2425.v8.git.git.1794921876.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Nov 2026 13:24:32 +0000
Subject: [PATCH v8 0/4] branch: let --delete-merged find squash merged branches
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>

Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
never deleted by git branch --delete-merged, because their tips are not
reachable from the upstream. This treats such a branch as merged when some
upstream commit contains all of its changes, and names that commit in the
output:

Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).


Changes in v8:

 * Reword commit messages.

Changes in v7:

 * Added a test that --delete-integrated keeps a branch whose changes did
   not land.
 * Read the index once before the walk in find_landed_commits(), instead of
   for every file merge at every candidate commit.
 * The commit message now says the merge uses this repository's attributes
   from the working tree and the index.

Changes in v6:

 * Read the index before the file merge, so .gitattributes that are only in
   the index are honored too.
 * Renamed the diff_options variables from opt to diffopt.

Changes in v5:

 * git branch -h lists --delete-integrated in the usage lines
 * Giving both --delete-merged and --delete-integrated dies with a short
   "cannot be used together" message instead of the full usage text

Changes in v4:

 * --delete-merged works as it does on master again: it only deletes
   branches whose tip is reachable from their upstream
 * New --delete-integrated <pattern> also deletes branches that were rebase
   or squash merged, including those squashed after upstream changed the
   same files. It replaces --squashed
 * New prep commit lets delete_branches() take a map of where each branch
   landed, so "landed as" is printed there
 * Added Junio's test that --delete-merged keeps a branch when an unrelated
   upstream commit adds an identical file
 * --dry-run works with either option, and the two options can't be combined

Changes in v3:

 * Split into multiple commits, one for rebase merges and one for squash
   merges.
 * By default a branch counts as merged when an upstream commit has its
   exact version of every file it changed. This never reads file contents,
   so it stays cheap in a partial clone. It finds rebase merges, and squash
   merges where upstream left those files alone.
 * Replace --no-squashed with an opt-in --squashed, which also finds
   branches merged after upstream changed the same files by merging those
   files.
 * Add a test for a rebase merge, and check that a squash onto changed files
   is kept without --squashed and deleted with it.

Changes in v2:

 * Diff each upstream commit once and share the result between all branches,
   faster than v1.
 * Fix a branch merged with a merge commit being reported as "landed as" the
   merge when another branch was searched first, and add a test for it. Show
   the topic commit itself in "landed as" for work that arrived through a
   merge.
 * Use git merge --squash as the example in the commit message and mention
   GitHub's squash and rebase buttons.
 * Add --no-squashed to skip the squash search.

Harald Nordgren (4):
  branch: move the deleteMerged opt-out check into a helper
  branch: let delete_branches() name where a branch landed
  branch: add --delete-integrated to delete rebase and squash merged
    branches
  branch: let --delete-integrated find branches merged onto changed
    files

 Documentation/config/branch.adoc |   8 +-
 Documentation/git-branch.adoc    |  23 +-
 builtin/branch.c                 | 361 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 271 +++++++++++++++++++++++
 4 files changed, 633 insertions(+), 30 deletions(-)


base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v8
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v7:

 1:  25d2441ce7 = 1:  25d2441ce7 branch: move the deleteMerged opt-out check into a helper
 2:  18c3edb6e3 = 2:  18c3edb6e3 branch: let delete_branches() name where a branch landed
 3:  7bc634c794 = 3:  7bc634c794 branch: add --delete-integrated to delete rebase and squash merged branches
 4:  4b5485584e ! 4:  22658105ed branch: let --delete-integrated find branches merged onto changed files
     @@ Commit message
          kept by "git branch --delete-integrated". The squash commit has neither
          the branch's version of those files nor the fork point's, so the
          previous check cannot see that the work landed. This happens all the
     -    time on hosting services, where the "Squash and merge" button on GitHub
     -    lands pull requests this way while the main branch keeps moving. A
     -    rebase merge onto such changes looks the same.
     +    time on hosting services such as GitHub, where the "Squash and merge"
     +    button lands pull requests this way, and other pull requests often
     +    touch the same files first. A rebase merge onto such changes looks the
     +    same.
      
          For each such file, merge the branch's version into the upstream one
          and treat the change as landed when that leaves the upstream version
     @@ Documentation/git-branch.adoc: remove it anyway.
      +	of its changes, even if they were later reverted, and the
      +	message names the first such commit. It does not matter who made
      +	that commit. A file counts when the commit has the branch's
     -+	version of it, or when merging the branch's version into the
     -+	commit's leaves it unchanged, which reads the file and may
     -+	download blobs in a partial clone. The same rules for which
     -+	branches are kept apply as for `--delete-merged`.
     ++	version of it. It also counts when merging the branch's version
     ++	into the commit's version leaves the commit's version unchanged.
     ++	That merge reads the file, and in a partial clone it may download
     ++	blobs. The same rules for which branches are kept apply as for
     ++	`--delete-merged`.
       
       `--dry-run`::
       	With `--delete-merged` or `--delete-integrated`, print which

-- 
gitgitgadget
