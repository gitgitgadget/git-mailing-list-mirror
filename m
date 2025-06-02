Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06AE2147E7
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875208; cv=none; b=gtA3yX2tPkd2y/5P7R+3dbkw7W/CoywE/8w4JnyoG+CLSaeHbHfhX3bRozZ4VxKADGWHlV2P4OzWGrJLHuqhsn9/npk3gB4FhWc1hu9BpNBeJ03zj92z+EqPsw0KAHI/EfM9QpFGYHSawrhDvXYgBX7TOq/5gaifQtehcJQ4O78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875208; c=relaxed/simple;
	bh=Sv9udurUOOEgkYR9aZPU/lQzsPCtR3yNPNe4FHPq1G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgQ2izZytos88lCJSXwA7NPvh3iNDgSSc3cj3xMAOD1KrjEqORl80xVGRtA1Wruoo3Xc77gzfrpBOsYWbAAtOlfg5/2l76M+wjahN3flkJnTG/DlOtgqYeKPsTqRvRL3TRamjXyBMsk3ajVHcG+tdwlyTgwSCaX0VwI6OTqCrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBDQUQ3g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBDQUQ3g"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234c5b57557so38978755ad.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748875206; x=1749480006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHMmuj04oa6ZMgBkAV0gvoMfYctCCeJUDMfDvrV2Cuw=;
        b=KBDQUQ3gTEdydLf7MSrnE69KNGU6oizl/yRv7otCN8ANciR3qMnc51xSMgR4H/gNI5
         EVKrcHWm8ICC+3+/gV4izOKjq9ElkcqRLIJoTn0mffxRH6XADgYn2lSjth5xUAXbvgQX
         CmrYn1xsUAHMxxnaDXuoZWtTbFKxqpzVaF+Ply/w9HtfwH4oFLZwoeL3+O6YpyXrki6f
         yOD/D4hVmkH/Z6d0sL4f29Ig888zdN4RU6o2VWdA/LUgvqjW0446B2B3PlPdxCUoFZ35
         tezgZqr92LDQcbQ28vqBdqPC1Ufz7Zm27fm0uZyht2iaJlvffHWTUdCAjVV/hWcUJcWc
         NIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875206; x=1749480006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHMmuj04oa6ZMgBkAV0gvoMfYctCCeJUDMfDvrV2Cuw=;
        b=WGCufqPSOlAmh49oGBQveZ1HrnT31GlHPfGQ62+fI/IGRUimavIUfGvf4HKQCtgcHz
         RBuj/IZcv5u7lqntfveothLqRIQNb2Et4ka49ZznOaTFc/rSzJbavdik63n6YTM9qe1y
         EQVOreLzW/NKJX3W5ijOkCbmq0BXRDCIao3ZVHU+i5Inr9FHXga0whnBJ3eTBmF8Kgaa
         pOzDr1edHmtnE3T/d4JTWRTMuJfLFsVFU1EMnpJYEbMnMLW4QRblFEpKPQkuF25ghqBC
         L1kzmcgfmrxSUe6YxH5ci5zF/DBkFocEmVMCeckifYmEd0dMYLuOjsbWfRNToEJa5woE
         bvOA==
X-Gm-Message-State: AOJu0YyOxCO5CNKGYWWlUTdo7tBgL7kvnp3ZQSodHSyNpiCS595PnlTF
	dsMk5ufAwCYJYddwOK+BpY4hWLF0zuugircgKWt/3rCs1A4xR4Kb1kDYt79f3Mv3
X-Gm-Gg: ASbGnct209lejxe+SIItXOYzXUf1IgedGhi08Jsn66/VmzRxKvw3dYrPZfwUetrDqvP
	Md+/swlorFLu91EtTINo8929d59ps6qkjoy/tbhbN9F0Kzur05uiaGHeQzeWbFdXe3fUcsc6iaM
	Jz5SpDga8dQYkLIEUSCyD/c5kNBa/Xw5g3T75jtMKuLt/CFbT5JZ0nt2xlqzA3CwzoGK50AQ47E
	bhhEzYCtgj4dk4Un9zgW861blO+++i25NMzT7cZtfQmaUkfsv6q6oZjhm0PfJmdbcSSIMTgfeIw
	C12YNCI8lY7fiwAJ89WMOBIyFKG6ZQIOvr1pJc5rb5L/D5o=
X-Google-Smtp-Source: AGHT+IGNo+CCmWHMKXQlpTtMqmxOfHso3hyHVi4wAY+EXJHI16siNarw8AigdabsEkVFRAisGLKLAw==
X-Received: by 2002:a17:903:3baf:b0:234:c8f6:1b05 with SMTP id d9443c01a7336-23539820556mr152383985ad.52.1748875205691;
        Mon, 02 Jun 2025 07:40:05 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cd7618sm71081345ad.152.2025.06.02.07.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 07:40:04 -0700 (PDT)
Date: Mon, 2 Jun 2025 22:40:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 0/1] [BUG] refs: verify does not work if there are v2.43.0
 or older worktrees w/o wt. refs
Message-ID: <aD23w6-szFjKQGSj@ArchLinux>
References: <aD2mhOlwl1LSYnpe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD2mhOlwl1LSYnpe@ArchLinux>


Hi All:

Changes in v2:

1. Update the commit message to incorporate the commit message that
introduces the BUG to better explain.
2. Update the shell script to avoid hardcode gitdir path.
3. Change "rm -rf" to be "rmdir", which would be safer because we should
delete an empty directory, which has a better semantics.

---

Changes in v3:

1. Use subshell for test style.

Thanks,
Jialuo

shejialuo (1):
  fsck: ignore missing "refs" directory for linked worktrees

 refs/files-backend.c     |  3 +++
 t/t0602-reffiles-fsck.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

Range-diff against v2:
1:  d949a8a646 ! 1:  e4c32971da fsck: ignore missing "refs" directory for linked worktrees
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +		test_commit initial &&
     +		git worktree add --detach ./worktree &&
     +
    -+		cd worktree &&
    -+		worktree_refdir="$(git rev-parse --git-dir)/refs" &&
    -+		# Simulate old directory layout
    -+		rmdir "$worktree_refdir" &&
    -+		git refs verify 2>err &&
    -+		test_must_be_empty err
    ++		(
    ++			cd worktree &&
    ++			worktree_refdir="$(git rev-parse --git-dir)/refs" &&
    ++			# Simulate old directory layout
    ++			rmdir "$worktree_refdir" &&
    ++			git refs verify 2>err &&
    ++			test_must_be_empty err
    ++		)
     +	)
     +'
     +
-- 
2.49.0

