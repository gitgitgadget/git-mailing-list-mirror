Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500771;
	b=Pwga3eur7pURKfOysoEfeOjAnbTyDbEBHib0yo2r2TO+MEDxLrmudOWp+MFgmqfO0Bkx
	 AC/OCK4c4BkUrzPLTvyh6u090mQKYlkospwTaYPm1BIQX3/1IRSO46Sa7IGhnt8JRr76Y
	 jtMOcZQYehxlHwSiXDTVTyeQGyS7M1RDsbwGP+RTVZEE0g71nEG8NQgcb0DUI6UWG8q/6
	 a+VS6/f1Up3zaxul/62GU/1XFjwxmite5h7zd42Hp9BzOJfow3+4dcGwOC+mcRTRTRXNp
	 fIc5kkjnHCS0ZDzrY+cTlUKRMXqXnJgEh0Ti7PfmZYww+vHEri2Kv516bi1q6Nx1saQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=GO+RXmN0WatPv52W0z4VCXVj6T05VrhBn4psGkYVQHw=;
	b=vpOf9WkHCzKu1f0evB1DGeSXNwPXPTJbK8P+3ZIHfkpUb5O3jQ7ezHjNzC1vLAvONW+B
	 iLAmrfS/XXV0peW2XGzsf3GPxOq1tDd2BOTDzf2DoTC0rsCPF9cDbXq4ftpCrBkzAqv9f
	 XaKMt3GbjvGkUjwsypuk6tsjp5xK6TAK7837fzjwCr97SzeKe2Aqtx4sPRuoPCGPPqRcj
	 2jnoNwB2IOWvEHxLVoLa58b9IqY0iMaIPGtZ7Z3SSLD8hJI6PNSGlgznWhvmr5C25DS46
	 hDa9jiSfjaCrGZ20+g25sUBU1aFOglMjw/G+QwNj6gofgHlJtQiznlG7qpgNm3QfR4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FooJ+2g5;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA3606A32E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EEA3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FooJ+2g5
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15dd124bbe7so3851153c88.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795500768; x=1796105568; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GO+RXmN0WatPv52W0z4VCXVj6T05VrhBn4psGkYVQHw=;
        b=FooJ+2g5CqIji+S6hcIAjT5XmbQthvJ16/x+caNMTYpMUGkadvE75ta/blosmDM8SS
         iKUtB0H58CkDUYcgwmJgwbCDTV13LvwTbzNNu+IGE7QGcOA1RIX9ms9AqeYSwweGmgZv
         ycgFft/vc0cDdzCH/zEuwFvGfkFKZhUNphj253LrrjSg7Lx3/O+ZzfApJG351uQLwUBu
         l2xQHz0TF1H+RB1T68jjWnwYlgNv1nPzy1SWgMgLaVtIhYSiOo7DOxfnR2j4GCCCsrjL
         GWsSnGXDjQakr9cKvavgZj5GvveAx3NF/HCm0Y1i7/jZZpazkZhMEixsIffO/Ezmmfvs
         rLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500768; x=1796105568;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GO+RXmN0WatPv52W0z4VCXVj6T05VrhBn4psGkYVQHw=;
        b=ks1tGt7RUTATPIemKkT6f+pR4N28814QeujCxSmBQd4B3c5uZVWaTeoppv2q7nRKhv
         VxQhH29+3Wl5D1pYaCVArAO2TaRnfIbEdLtttIhCfII7C+VKvLRhrvAf2GeaJrAn4DHs
         A9o5q6q0abfEP80ZYhfAzDQ050TXTXFRZMOaqmojiQ2fxFg/3+EhrENS4OGEdoQqCpxQ
         zPcfsLe5tFCagIB5Aqj2uPEDBDpObwudGhHvPKl+NBElOKYaBRj59UnwtSMQyf/y20Co
         4SQGHd4eUIVjyH0OUG+e4L38zFJ6cyaBIn4AxlZMcUi+aCuNxilal6aJT2uZCWVoANaA
         lTnA==
X-Gm-Message-State: APuU4Z8r+C8L2+8HZfix5Y8zMSGPst8fwOCijdES0+aASbRkP60yb+u2
	uLbfZmqJh/DTQ7EJ/ZBYY8aIM9c2zWsgHlNEsk/Tv6TW63KO5Itnf93M679B7w==
X-Gm-Gg: AZFdTZdswsjeztOHZOSKPAxsP9WQRpCmtRXdE3o5dUIVdcH1a23Y74ALrZU2l1r8zNd
	niKNyetl6nQgzD4/R4YeH8DeEZb7iTzu6Ww4s0lYxf/yP3p6l18GmZrliQbrl7hiow5kbVk6g2L
	TTnOKolrcSoBYB3svDtTirJk2X1gXWGT3RUaJrpqUNmdXH4QmEvaqKuGsnvFNr8vSkVcXroFftk
	14L61KCjJVCLasRSwbcl9oGrCbKwrbYlbGKU90fEZVV+n9iNVg1sH28KziCye14i8vAw+DSdP7C
	+o7DHMoBh3rS3QCD3Eo5uKTshVumUE+6J40a3rEuktoyWmLHWuVJP43fH+PB3+7HV1OFfJOzCUx
	ZPSA4bREwx6c0NDnyjr332U6C9x5AEDrwWWlEIthXS3spioa1bPbqFxXBizQKIJnbpGvfxOec7V
	z1NiD1dLlCm7fauzsgtWTN+GAbYTeEAW1oo+XxJQt78PxMHpjxnPt88ZLMyPhk1UV8/Z9cZjDjL
	NLe5dIZDQu35vvAvLfpzZvxOD57q3ag+BSHL1rrqg8y32BBZ2mjd8Q2DQJHSksvGg6v/ti8P89W
	kdGaOyyOw6U9Dl9vCKieE26NNI5UJA==
X-Received: by 2002:a05:693c:805a:b0:376:a6d7:8f51 with SMTP id 5a478bee46e88-3856e63bbe9mr17062924eec.12.1795500767951;
        Mon, 23 Nov 2026 22:12:47 -0800 (PST)
Received: from [127.0.0.1] ([57.154.4.118])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm37981042eec.13.2026.11.23.22.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:12:47 -0800 (PST)
Message-Id: <pull.2219.v5.git.1795500766.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "qeesung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 06:12:43 +0000
Subject: [PATCH v5 0/3] repack: don't lose objects to a ".keep" that appears mid-run
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>

"git repack -d" could lose objects when a ".keep" file appeared on a pack it
had already decided to delete. repack now tells pack-objects which packs it
may delete, and pack-objects ignores ".keep" files on those packs.

We hit this in production (a ref pointing at a missing commit, on git 2.43),
and it reproduces on master:

 * repack scans for ".keep" files and decides which packs to delete;
   pack-objects scans again when it opens the packs;
 * in between, a fetch or a push brings in a pack identical to one of those,
   and a ".keep" ends up next to it;
 * pack-objects then leaves that pack's objects out, or does not loosen or
   keep them for -A, -k and --cruft, and repack deletes the pack anyway.

v3 passed pack-objects the kept packs repack saw at startup instead of
--honor-pack-keep. That missed -A, -k and --cruft, which skip packs with a
".keep" file regardless of that option. v4 goes the other way:

 * 1/3 fixes a stale kept-pack cache in the cruft walk. It reproduces on
   master, but under --honor-pack-keep any ".keep" file happens to hide it,
   including the one the race leaves; 3/3 takes that one away, so this comes
   first.
 * 2/3 adds pack-objects --ignore-pack-keep-from=<file>, which treats the
   packs named in the file as having no ".keep".
 * 3/3 makes "repack -d" pass the packs it may delete that way.

Each fix has a test that fails without it; the race is reproduced in t7700
and t7703. The full suite passes.

Known limitations:

 * Unreachable objects of a deleted pack are still dropped by "-a -d" and by
   the expiration options, as before. A pack written again under the same
   name keeps its old mtime, so objects a push brings back that way can
   still expire. Freshening the pack on such a collision would help, but
   that is for a separate series.
 * The cruft walk now goes through the packs of an alternate, as it must
   (see 1/3). On a "clone --shared" fork of git.git this took the walk in
   "repack -d -l --cruft" from about 2ms to about 3.3s, which is what master
   already does when a ".keep" file is around.

This is based on current master and merges cleanly with next.
jt/odb-keep-lockfile-fix, Justin's fix for the receive-pack side that v1 had
a patch for, leaves the race as it is.

Changes since v4:

 * Rebased onto current master to resolve a conflict in t7700 with
   ds/path-walk-tagged-tree-revisit, which added a test at the same place.
   No other changes.

Changes since v3:

 * Redesigned as above. v3's 1/5, 3/5 and 4/5 are dropped, since nothing
   passes --keep-pack any more; 2/3 and 3/3 are new.
 * 1/3 (v3's 2/5) also lets the walk go through --keep-pack packs while
   still leaving their objects out, and its message explains why the walk
   goes through alternates. There are tests for both.

Qin ShiCheng (3):
  pack-objects: reset kept-pack cache for cruft walk
  pack-objects: add --ignore-pack-keep-from
  repack: tell pack-objects which packs it may delete

 Documentation/git-pack-objects.adoc | 12 ++++
 builtin/pack-objects.c              | 55 +++++++++++++++-
 builtin/repack.c                    | 23 +++++++
 odb/source-packed.h                 |  3 +-
 packfile.c                          | 18 +++++-
 packfile.h                          |  7 +++
 repack.c                            | 26 ++++++++
 repack.h                            | 14 ++++-
 t/t5329-pack-objects-cruft.sh       | 98 +++++++++++++++++++++++++++++
 t/t7700-repack.sh                   | 86 +++++++++++++++++++++++++
 t/t7703-repack-geometric.sh         | 39 ++++++++++++
 11 files changed, 375 insertions(+), 6 deletions(-)


base-commit: 77904e546de3bd940621092ecec47a88d0cede5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2219%2Fqeesung%2Frepack-kept-packs-snapshot-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2219/qeesung/repack-kept-packs-snapshot-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2219

Range-diff vs v4:

 1:  8cce2b6eb5 = 1:  228b7a690f pack-objects: reset kept-pack cache for cruft walk
 2:  91ffbdf4fa = 2:  6641abfa49 pack-objects: add --ignore-pack-keep-from
 3:  001875455b ! 3:  95c7bcab92 repack: tell pack-objects which packs it may delete
     @@ Commit message
      
       ## builtin/repack.c ##
      @@ builtin/repack.c: int cmd_repack(int argc,
     - 	existing.repo = repo;
     + 	string_list_sort(&keep_pack_list);
       	existing_packs_collect(&existing, &keep_pack_list);
       
      +	/*
     @@ repack.h: void pack_geometry_remove_redundant(struct pack_geometry *geometry,
       	REPACK_WRITE_MIDX_DEFAULT,
      
       ## t/t7700-repack.sh ##
     -@@ t/t7700-repack.sh: test_expect_success 'pending objects are repacked appropriately' '
     +@@ t/t7700-repack.sh: test_expect_success '--path-walk keeps blobs from tagged trees at already visite
       	)
       '
       

-- 
gitgitgadget
