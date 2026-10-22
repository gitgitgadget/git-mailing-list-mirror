Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694674;
	b=gqaYlTxI9Ok3DfE86GXv8ET2uPb0geqFq6Scb++NfwXRbCOYSx6LP/n26ZQLUrfwnuZx
	 8msYE39yrLDS9UeNFRP9lXcd1AYdW4uUvYCtRL5X0h1apMmHp/WBEA+JrwkezLE3kn6pW
	 +mCN64GQ/HjlQwLlHbaRgC7EDEC60nRA70dYD8JxtgtwQormVOOLOiw4y63K9kcbK88+i
	 SWCXJFY/dysoUzEaI1r17pPoKZHQwzS5UFn7VnAulVFL20F3cv0LUL6A2GnK2Z3Akjvns
	 9awpVj6gHyyEY+bKuBRjvG9SwRSzflpxNRdoPfCwbKbGIkE234zlolATZQFbZTNsvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wDHHrNdp3rnvAsTVrO9EaVOj83ZyuH1dSPc2HqpLoMk=;
	b=3mhVmp6QgaWA8KKvT6ZUYCo051YwoyszcpYa6UCLIVuq8sbQHOaW5gmvcIiwAtIGDdAW
	 LrNgblB+h2//0eA3seTK5gu8F8f7zeirRynZ0DaNZ821Vcy1rvBelzipgrsvvJP9BR+rp
	 YOCU+CkzgH37n/J5xgQAX446s/zH6H4JZTUkPPLntBYXy/QIuqFNOypKTftJyCCb9AfKs
	 PVfAlbxT9XSehRT7F2LMGg6I5eslSRLMpYLOluHbVGmT1KCenhLRVgq2IUtiiwq5xZfPn
	 CNEtKAkLvN805+idOOyOFmcSunwjWD/Fmav3YsotHo57JC4EN566dinZWMPU/Nm6YAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MLzmfyGb;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA9606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97CA9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MLzmfyGb
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5363316fa0cso380341cf.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792694672; x=1793299472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wDHHrNdp3rnvAsTVrO9EaVOj83ZyuH1dSPc2HqpLoMk=;
        b=MLzmfyGb+EV7YvvyCg1LgpFPa5tPiYcZA+brxIA60YSix2Q1hStfuzXe5peJgAPQ2D
         2ghgKRDqMbZF3jPN9HmXmmf+F7oeqqOcsA1yM9O5KYnEZa9xgHTmD5FQe7VYtbvi/hpZ
         zxocCXT06SSXPdLferUnFgeYWOLVekaCovHKb8RuPk6+Y6iHzohRTPdOcHJdZjwnCTDB
         qjG2jnYOCZXcfIak0f51GKSkO6U3P6xW4kVYMbfdMdStfhbjtXdU6WJOyRgrZz4gpgZ4
         00KaN2oiytXiLUjq2Cpscjv4fmRkgoHj0SnoXDgfngAuf4k4f6HIX0O2A2fgWU0/Du/w
         vhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694672; x=1793299472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wDHHrNdp3rnvAsTVrO9EaVOj83ZyuH1dSPc2HqpLoMk=;
        b=XfxhAXHgtVLyXgjxIXpbsmUEAfWy+RMtUtu5zEp+XWdw9D99wQumhnJqB7EVscOIUF
         k6lgzyB1EEDrGiPVHm58TSId2M9cef1eS4aoyvJoTHF/Q8Dybl8ed+uaCBprdJG66YFP
         YVkxZmWoRE8S7Tj+5EPnl8CFNQEyEBMZm7wnoUniaPpyLD2EpfwuAOEW0/RkfMNxPOTv
         7PWTjSN9Ll+vz/3w0NrkSFnmheI0+SxZiAF+0/8Dk9n2qTQ2gOOVQX6zqw+Iz8ErlXd9
         AgonScll+hQ90PwcIypyvQJvnw1ZmCMf885qMUo76ilic3by0FT6yujWDtgZ0BjvMNRH
         uDiA==
X-Gm-Message-State: AFq9FYJ4IkFjepANGrr0qktCvEZ383aOYQnrR1CGBfsEG7wMB4gGwhVF
	Nyopmw2PvdgwbrhpGmqv3nKUMN2vQ9RFeZEzshbgWr9BJ7mzthyyfvtEo8f6oVK5kWw=
X-Gm-Gg: AYBFou3drR1xOIeUC9RMbO5wuRV4MVO0lbjo5YCd/cVqZ4SipgudGpfIRm9Or7mlC+Z
	AjRqLr4tLLle+095kOWmRynBS4UmdvX18wo1t/bsPdbCI7tUcKInUcIW2MGZWWmYmuTCzB0i7ui
	W2z+azSiAOQa9UK5DTn2RzqwUjDdsaKzpXUadb3EiKWXJAlD5GU1G36QPkuVfNulNdwo5T6VuNm
	BI3V9Z7AovxNUWMNY6ProzA94hTqOUGv9+/sL7pyOomXCB5fI7uh1DMPpvQePbA/fJQk0Mn9Pwh
	noUL1oWMZyBCbdrRwihkb3Knzgyyify6o/9cfcMsnYKNNOVlI9UAekU6v0ij2+HgJEhQ5FjaxnA
	TMtHN7shykq8H8P+v2tKqmmBKrtmnoL/fNBv2OKODBlRxdTU5sBtwLerpsWB+l9hYryii+LLKcc
	cWLvA7PF3qsH+nimB3ACMggbLXlT+GlUb1YSAl38AhZrHaI496GsHuyYO/JMQcuhgQ1TOIqUvhs
	VDi9TKgcbx3KTIYkSu7V93f7dVnUSn5knIn50yNf7aJkldUvhMxaKAfJN6uVjRuC2ETgkypxtOz
	u7ngJGd7cSWMbB7Y2K0U8BQFK0uaIqNv3S6KOBUR5q79q14hSQ5VV4Z1BuXGEkim7IRQ2V94kpc
	tdyEifL0=
X-Received: by 2002:a05:622a:e197:20b0:535:2283:20a3 with SMTP id d75a77b69052e-5369b811333mr70590361cf.33.1792694672459;
        Thu, 22 Oct 2026 11:44:32 -0700 (PDT)
Received: from 3950x.home ([76.69.137.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c370fe729sm3956136d6.45.2026.10.22.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:44:31 -0700 (PDT)
From: Mihai Cosma <mcosma@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	stolee@gmail.com,
	quark.zju@gmail.com,
	Mihai Cosma <mcosma@gmail.com>
Subject: [PATCH 0/2] status: stop holding index.lock while collecting
Date: Thu, 22 Oct 2026 14:44:18 -0400
Message-ID: <20261022184420.3648771-1-mcosma@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Background "git status" runs from editors and shell prompts hold
index.lock for their whole run, so a "git add" or "git commit" run at
the same time fails. Patch 2 makes status take the lock only to write,
and only when it has something to write.

Patch 1 fixes a bug that patch 2 relies on but that exists on its own:
under index.skipHash (on with feature.manyFiles and in Scalar repos),
the check that stops status from overwriting a concurrently updated
index passes for any index, so status can silently revert a "git add",
also on 2.56.0. It applies to maint and can go in alone. There's a
reproduction below its "---".

This overlaps with Jun Wu's "Wait for the index lock instead of
failing" series, and the two fit together: his makes writers wait for
the lock, this makes status hold it rarely and briefly. They only
conflict on the one lock call in cmd_status(), which his series renames
to repo_try_hold_locked_index(). I'm happy to rebase onto it. On top of
his v2, the slowest "git add" in the clean case below went from 1020 ms
(one failure at his 1s timeout) to 160 ms.

Numbers on master, from a gcc checkout (124,311 files) on Linux, timing
200 "git add" runs while "git status" runs in a loop. "Active" touches
a tracked file before each status, so every status run writes the
index:

                       master      this series
  clean   failed       104/200     0/200
          p95 (ms)     114         128
  active  failed       123/200     47/200
          p95 (ms)     117         111

Failed runs on master return fast, which is why its timings look good.
In the active case status still holds the lock while it writes, about
76 ms for gcc's 14 MB index, and that's the part a short wait like
Jun's covers.

The script, run from the top of the checkout as "bash measure.sh clean"
or "bash measure.sh active":

  touched=$(git ls-files | head -1); echo x >measure-file
  ( end=$((SECONDS+60)); while [ $SECONDS -lt $end ]; do
      [ "$1" = active ] && touch "$touched"
      git status --porcelain >/dev/null 2>&1
    done ) &
  sleep 1
  for i in $(seq 200); do
      s=$(date +%s%N); git add measure-file 2>/dev/null; rc=$?
      echo $(( ($(date +%s%N) - s) / 1000000 )) $rc; sleep 0.05
  done | sort -n | awk '{t[NR]=$1; f+=($2!=0)} END {
      print "median", t[int(NR/2)], "p95", t[int(NR*0.95)],
            "max", t[NR], "ms, failed", f "/" NR }'
  wait; git rm -q --cached measure-file; rm measure-file

The skipHash tests turn split index off, because index.skipHash and a
split index don't work together at all today: with both set, "git add"
stages nothing, which Peff noticed back in 2023 [1].

[1] https://lore.kernel.org/git/20230629083859.GA585934@coredump.intra.peff.net/

Used Claude Opus 5.5, and Gemini 4 Argon for review.

Mihai Cosma (2):
  read-cache: verify skipHash index by stat data
  status: lock the index only to write it

 builtin/commit.c  |  14 +++---
 read-cache-ll.h   |   1 +
 read-cache.c      |  59 +++++++++++++++++++++++--
 repository.h      |   7 +++
 t/t7508-status.sh | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c    |   1 +
 6 files changed, 178 insertions(+), 12 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.56.0

