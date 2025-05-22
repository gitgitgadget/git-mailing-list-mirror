Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F27126BF1
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929347; cv=none; b=ToSRbrMuGK8zFmtU9wby8+GBFZWW+l0m4EJIvj2KEaIucgYFxnt+orR4S4bircpvXp1bRR4kUPGK1dj5DxjzFSFvFfsDCJZsOhDkyLgWZ3RKpZfazqkgX/twmhHhJabMEJ6FlzvXgLHU0esI/99HWq5bLG1sTn8TNoiLgG7fgnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929347; c=relaxed/simple;
	bh=yyBh7gSx/8qmTB+CC3Ey1KRy64VwUEEmEqdXhPQ/b6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snThnG5CtMR0nbQ1oazcgiqqBDgopKfotEA8yYNieL1eFR6Oa8Jm/YLi7ZzsQpBDxrNgDLbSqIqT1nnojKamJJbxYi+DEw49dl6BqU7z/E0coXZbBknkPV9Efnxf4uDGFv0NFj1xYXfu2Cv3UjwhzedM+TkwR4LMuxx4rqgofEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkS4nAYN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkS4nAYN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so60803455e9.3
        for <git@vger.kernel.org>; Thu, 22 May 2025 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929343; x=1748534143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QQUTvmKXG37dx5K8q6YCOxfoyMDg7k5FtLiLVh17lqg=;
        b=fkS4nAYNM1XeoU5YBkT4WD3ZINKz5B8ucYxne5UAi4IxIXwI8LDAcm6Sf4seqN+cIp
         jU51FUk3eWPwJZVoHocncDGoAogZFSX3E5QbtWTFWeumF/v9pLWKd9OlFYyxcbQBUDaI
         fh29MGnvW6lCez7QzSzt2IZy+mGoOqinqLqmJLctLL8x16er5c095QsOPguFOKHryejm
         RbzHyQs/rvex3S03hjz7PwyZxFW260Mh6TopZQvixGNveTdTNDg9BpcIdkI/5mTggIj6
         J8IZmPEzP+d7NyPJ0t7m1RCfTdf3K/eSSyFVINQ82X3sgmuBle07L9XE6hddQltUZx1j
         K4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929343; x=1748534143;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQUTvmKXG37dx5K8q6YCOxfoyMDg7k5FtLiLVh17lqg=;
        b=t7aVPYT+h74nr5LAnvoLXtJcVEs5rX+FaD6OpZQTPI7OS5wnzqYUtdw3gZRYMjej1G
         fBWuZcAsrSXIva06+MLldSYynLIaEniSM2byagL8xYJEIAD8taU51l5ndnhqChMAzrsg
         9o3qi7q1J3WkUxRqdPUDec17re+jyvY5s/yClzS2pi5AUk0g28qROgik7Ex9CEMXstZL
         R8HSHH3m/xxN/ylVdAcPBtbl8t4zg3i4WEdZ5NKusBYdH/aSMio4J86enG1hmBrS8FU8
         24GkzKfQVj7o6DNJX/YYuaH/YkWgkHzonPx9OsLirgvHC4RYiwk1uWaSVMgJkmClI7al
         SlDg==
X-Gm-Message-State: AOJu0Yxt/cFv6azF6R5URBYctVRIaWrqn91zKVS/bfXycoPfrKPeEwMH
	UIav5E0lIRMxZtoAIF7lxTaaDlO6omvydWw3LZopYqPdjnBlZMalg4G8Basueg==
X-Gm-Gg: ASbGncvPG+AZTrdLbwKl9C5OXj+wEv8vEHoS1QnstnBe0vNtleIbfZeide0cvFS3Nuz
	PV7zabRBDuZd6JHccRHvh61SZNCr8peevNkPGgw/6KZgMiRGSjmNEYfjHVY/Wy7/oX34Pr+bc+O
	eE5yeHeh02UlNQJgU6h4eRGfsXT753OfhdX/b6B0EWgakFZhSSUcc4xdt71YYTUDEXpvswvB2de
	QHTctVwVAuwYBm8417BQvKMckbVh5Z8Oi91PoNpeaB52WYfryG3PUMm9PpPlgSefJBZefpznNy3
	fRoU1Sx5APy0ypRaonuCLkZ+ZIFTTA18NEZJW92pq2ZZycEqGsI1uu8odMrmBHlXw40=
X-Google-Smtp-Source: AGHT+IEDrP9Qg/kmLaIicAtQjuZ9hnwf9jP/l+nut7TMNuPqVQAbgJgN4fezOAhxysYK30n9BI/S0Q==
X-Received: by 2002:a05:6000:2304:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a35fe65fb8mr20835050f8f.1.1747929343330;
        Thu, 22 May 2025 08:55:43 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a369140048sm19253599f8f.57.2025.05.22.08.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:55:42 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 0/4] midx repack: fix overflow on 32 bit systems
Date: Thu, 22 May 2025 16:55:19 +0100
Message-ID: <cover.1747929225.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Taylor and Ben for their comments on V1.
Changes since V1:

 - Patch 1: style fix and clarified commit message
 - Patch 4: reworded commit message and documentation

Cover Letter for V1:

This series fixes an overflow when running "git multi-pack-index
repack" on an old raspberry pi and a couple of other small issues I
noticed while reading the code. I'm unsure how realistic the example
of integer overflow on 64 bit systems in patch 2 is. I'm happy to drop
it if people who work with large repositories think its not worth
worrying about.

Base-Commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fmidx-repack-overflow%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/cb96e1697...a140181bd
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/midx-repack-overflow/v2


Phillip Wood (4):
  midx repack: avoid integer overflow on 32 bit systems
  midx repack: avoid potential integer overflow on 64 bit systems
  midx: avoid negative array index
  midx docs: clarify tie breaking

 Documentation/git-multi-pack-index.adoc | 11 +++++++----
 git-compat-util.h                       | 16 ++++++++++++++++
 midx-write.c                            | 22 ++++++++++++++++------
 3 files changed, 39 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  cbc5e69b908 ! 1:  9a1e6c81688 midx repack: avoid integer overflow on 32 bit systems
    @@ Commit message
     
         can overflow as both total_size and estimated_size can be greater that
         SIZE_MAX / 2. This is addressed by using saturating arithmetic for the
    -    addition.
    +    addition. Although estimated_size is of type uint64_t by the time we
    +    reach this sum it is bounded by the batch size which is of type size_t
    +    and so casting estimated_size to size_t does not truncate the value.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    @@ midx-write.c: static void fill_included_packs_batch(struct repository *r,
      			continue;
      
     -		total_size += expected_size;
    -+		if (unsigned_add_overflows (total_size, (size_t)expected_size))
    ++		if (unsigned_add_overflows(total_size, (size_t)expected_size))
     +			total_size = SIZE_MAX;
     +		else
     +			total_size += expected_size;
2:  9f07da4fe71 = 2:  54303d96c31 midx repack: avoid potential integer overflow on 64 bit systems
3:  688b0273604 = 3:  5b6cfb9d212 midx: avoid negative array index
4:  29769df1c60 ! 4:  a140181bd57 midx docs: clarify tie breaking
    @@ Commit message
         midx docs: clarify tie breaking
     
         Clarify what happens when an object exists in more than one pack, but
    -    not in the preferred pack. If the user does not pass a preferred pack
    -    then the pack with the lowest mtime is chosen as the preferred pack. For
    -    objects that are not in the preferred pack the pack with the highest
    -    mtime is used. "git multi-pack-index repack" relies on this behavior. If
    -    ties were resolved in favor of the oldest pack as the current
    -    documentation suggests the multi-pack index would not reference any of
    -    the objects in the pack created by "git multi-pack-index repack".
    +    not in the preferred pack. "git multi-pack-index repack" relies on ties
    +    for objects that are not in the preferred pack being resolved in favor
    +    of the newest pack that contains a copy of the object. If ties were
    +    resolved in favor of the oldest pack as the current documentation
    +    suggests the multi-pack index would not reference any of the objects in
    +    the pack created by "git multi-pack-index repack".
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Documentation/git-multi-pack-index.adoc ##
     @@ Documentation/git-multi-pack-index.adoc: write::
    + +
    + --
      	--preferred-pack=<pack>::
    - 		Optionally specify the tie-breaking pack used when
    - 		multiple packs contain the same object. `<pack>` must
    +-		Optionally specify the tie-breaking pack used when
    +-		multiple packs contain the same object. `<pack>` must
     -		contain at least one object. If not given, ties are
     -		broken in favor of the pack with the lowest mtime.
    -+		contain at least one object. If not given the pack with
    -+		the lowest mtime is used as the preferred pack. Ties
    -+		for objects that are not contained in the preferred
    -+		are resolved in favor of the pack with the newest mtime.
    ++		When specified, break ties in favor of this pack when
    ++		there are additional copies of its objects in other
    ++		packs. Ties for objects not found in the preferred
    ++		pack are always resolved in favor of the copy in the
    ++		pack with the highest mtime. If unspecified, the pack
    ++		with the lowest mtime is used by default. The
    ++		preferred pack must have at least one object.
      
      	--[no-]bitmap::
      		Control whether or not a multi-pack bitmap is written.
-- 
2.49.0.897.gfad3eb7d210

