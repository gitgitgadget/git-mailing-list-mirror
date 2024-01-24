Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB057A714
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110056; cv=none; b=V39NVB0AbHNAwDpsPdq8DILEN7Mg3Fi6b3DFcEYrVmrsjawQ0pmbp/pqN4krsN0Wp9kR0oEUKEIpoAHUOvHqqAyNvKsvdHyzHbBTKLjkQpxohWe9tc1icuEE5HV9TCRdnWUsXJVbPV8K6yPLvFqfgDs4PF+TNFUuo/sawkPFtoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110056; c=relaxed/simple;
	bh=tLkBAWT4AQMIvV+3sQ1PaXuyUdgUksSqFpgD9d4CHsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glgCK3C4GSVHRcEfiLToNkxXOllfPcp+sX3JZc7O8eLskIU1jxqZXT7UcYFBCVmacajnetTwCDXsQDF1OR1SV7U4Xto9xBVxqz/SN4mL38R6/XVok5m/9iwxdRlm58zPzvUVioO6QmDqVyb4KcUpHQqnxN92ER8mQiPnaKuMxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDH+iGRr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDH+iGRr"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2dc7827a97so622616566b.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706110052; x=1706714852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqeSamTUcXwtR1W191ulvpVQ1FHhzYCkcNfqb+776qo=;
        b=ZDH+iGRr/ZPHDoCQer/giVGYuigLduYKLbYO8gkckvySJfug+WGbPSnvCxAafdgfVx
         XZQ1VIMWTqTafW8N6ZLYLQ4dBzdbpDzy22ABU3knXdrQJ1zoXJcTnz0fCQiBLHESZQnq
         n2lImjF9RjO132ndjeqK6JM3NbWUTnLJ9D6JU4hpms5k+z4J0McOzaRQSqdMc3GTQjJo
         QQPupn0JG2SLp3ASvesSuuQeGI67WoSj14lI9ATRSwtIkDdMb5SKAssdbsAvsCR12hjv
         y5NpNnlIFGUKba4p9L4ZZOO7ovcPdTKoWM9V02T0A3L23A/Ezm1OoBZn4C5kyymF30cp
         jKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110052; x=1706714852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqeSamTUcXwtR1W191ulvpVQ1FHhzYCkcNfqb+776qo=;
        b=ucsxoqjtSirVYOdOjcdWx+NdoKYgUtuzNGzxpeDSblm77j7mYAXvYpbBMeTlvkpY0o
         70yCpepLOqF+qiSk4coOxhD2mgYgjidITDpavfsWZnEBIwC8GcTi2r0fxBF7XOHbtQjN
         rhOq8mDC7opCH+ZMmv4c4ZdwvHmrN1URUEQ1A7mrB+KvTZVn3nAEsnMo8vuaK/fnjrQ5
         CmRLurBCo3zjkD8rUxh2/pOITkn+qgSgi81ttyiz9nWI3u2xnNBmJz1cI1WwpW3SaqwJ
         D8xMq0OrIv5EUXcN5PDviCnrp5ZR+hxPwuP0EmFSkYZPh40sFV1iuR/vJOyu+67qeYls
         Bf2g==
X-Gm-Message-State: AOJu0YyOyEvT7ZQQuS3rg3TjwWXMkT7dPbpRBWAhn810gPfM2CzaswYl
	8V5ze331+WH0emtPgml8RekPUVtnb8fwORhzcXXi3KS+/AuuRJnw6H1bpPlI
X-Google-Smtp-Source: AGHT+IFO4nEBMZHwrCFvqaCREYEnZlM5vxcTF3oD1JoZmqgVLWZahjDHK2XlEWZHZ5NpsXUbO/papg==
X-Received: by 2002:a17:906:3888:b0:a27:7c2e:420a with SMTP id q8-20020a170906388800b00a277c2e420amr996408ejd.8.1706110051841;
        Wed, 24 Jan 2024 07:27:31 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a2eb648cdc5sm8765225ejc.156.2024.01.24.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:27:31 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/4] for-each-ref: print all refs on empty string pattern
Date: Wed, 24 Jan 2024 16:27:22 +0100
Message-ID: <20240124152726.124873-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119142705.139374-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second version of my patch series to print refs
when and empty string pattern is used with git-for-each-ref(1).

With the upcoming introduction of the reftable backend, it becomes ever
so important to provide the necessary tooling for printing all refs
associated with a repository.

While regular refs stored within the "refs/" namespace are currently
supported by multiple commands like git-for-each-ref(1),
git-show-ref(1). Neither support printing all the operational refs
within the repository.

This is crucial because with the reftable backend, all these refs will
also move to reftable. It would be necessary to identify all the refs
that are stored within the reftable since there is no easy way to do so
otherwise. This is because the reftable itself is a binary format and
all access will be via git. Unlike the filesystem backend, which allows
access directly via the filesystem.

This patch series is a follow up to the RFC/discussion we had earlier on
the list [1].

The first 4 commits add the required functionality to ensure we can print
all refs (regular, pseudo, HEAD). The 5th commit modifies the
git-for-each-ref(1) command to print all refs when an empty string pattern
is used. This is a deviation from the current situation wherein the empty
string pattern currently matches and prints no refs.

[1]: https://lore.kernel.org/git/20231221170715.110565-1-karthik.188@gmail.com/#t

Changes since v1:

- Introduce `is_pseudoref()` and `is_headref()` and use them instead of
directly using `is_pseudoref_syntax`.
- Rename `add_pseudoref_like_entries()` to `add_pseudoref_and_head_entries()`
since it also adds the HEAD ref.
- Also check for the pseudoref's contents to ensure it conforms to the ref
format. 

Karthik Nayak (4):
  refs: introduce `is_pseudoref()` and `is_headref()`
  refs: extract out `loose_fill_ref_dir_regular_file()`
  refs: introduce `refs_for_each_all_refs()`
  for-each-ref: avoid filtering on empty pattern

 Documentation/git-for-each-ref.txt |   3 +-
 builtin/for-each-ref.c             |  21 ++++-
 ref-filter.c                       |  13 ++-
 ref-filter.h                       |   4 +-
 refs.c                             |  39 +++++++++
 refs.h                             |   9 ++
 refs/files-backend.c               | 127 +++++++++++++++++++++--------
 refs/refs-internal.h               |   7 ++
 t/t6302-for-each-ref-filter.sh     |  34 ++++++++
 9 files changed, 218 insertions(+), 39 deletions(-)

-- 
2.43.GIT

