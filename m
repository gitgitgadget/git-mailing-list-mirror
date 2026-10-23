Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759688;
	b=ySwRucv1BUK5aW0hmBZwT/vEg50doaO+UwK/AmXjPFZX+Krj3I7TPOUrJYkEgAkvgRIr
	 Cn4lZoZgc0cfQbUmVqvuGQW/GCZNdqDrdZGKxTj3WSecLs87X+wUwvc3CSOvnRUFl0xII
	 zxayjHjEHiktPHhHMad/dR7kWGUwva2lHZz2qau06TT9yv0dOY/OZC/Ppvzz7Qfs/4zbg
	 KKKnl7dACVNB2ZJDsh3b2u7antv3u7Z9ORYa2jUN53uORVZwaLWupXdEirmoxhYbx03E+
	 +UXGfCkCUc6IQuCa3T+eogq06c09wjKFtunpCzjTAB9+6IBoHvByjW+OJS5rS69Qp8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759688;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=LTY6PB8o/Jo1xfMhNSZZDOSOeQqMsWwdNBaTo89lcbU=;
	b=ylwoHA5r9qq5wKOzdDE30njXcJEQnBSXZh9lYbZltalKsAOwzaEQrKxnVKVuqbzPrb5Q
	 mfDhWwGkoXGTUeDBR03XARMWpXPR8GC8kGdSNBRNh9PuR0CkuFX40zcJMOmriqRL7Vu7Q
	 XpEUnJpqYGgNzU5B+Uc2S+keMTfviLqD5JE6tIOybrB6a1ooBJaiC3BMF6WH5fmfl2qzE
	 WuTBqBLoMTSgGCFmlA9yIZCdhFlryLGJei5A/yLb113DlLxNv1RL2ZNrToW8d7xi38o0r
	 rQfP9dc1twlIv7jYMmkPtNAzTYOsZwNTMeJ8wwtKKOnIII0sjz8nuF8jo4+585n2+OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=NEFfdNbT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Q6azagUI;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD57606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DD57606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=NEFfdNbT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Q6azagUI
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 838F27A01E2
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:48:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 08:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759687;
	 x=1792846087; bh=LTY6PB8o/Jo1xfMhNSZZDOSOeQqMsWwdNBaTo89lcbU=; b=
	NEFfdNbTKdXQOHOKM54TnnAPyw/h7Rh3bEwYUwZ1pd7qmSa6pQsoqGUE+aYKt2sb
	dJf2tSBSwtX0LkbHk3okP8Lhv5FhbBf17cbLLm1mhkU8ULI2ZjBk2rOh6oWLkwPG
	dnLscXKs6zpENROUC7HzoTTtqNXCxZMymiBNxTS1i6xuiSKF3LQV1C/FwoPHvnOV
	+T2OYeXmc2Q6Qqzn93JkmUgXd2l5dr3+RISuqFfsjIjveeBOkQ9Ul//2WYl8HVkV
	bDIj0gVNKsx0c+5ceTx8dZbAqwLipuR6VShmZnUJXTfhS3kZM6gVP0E1azb8DIkh
	QBDvp2pZKZ3Gtnim9iU8/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759687; x=
	1792846087; bh=LTY6PB8o/Jo1xfMhNSZZDOSOeQqMsWwdNBaTo89lcbU=; b=Q
	6azagUIfRNiS9dFZ2QEd7jfFag0kalRMB+cBEw0OlL41qDLMKLubGQkEfAjWWRPQ
	XpRYRW7Dfc3ezkYLeUQfQ+Vcv2KWof8MMN2OMmH5E5VFdYFdx+rYsF6buKMiufnz
	2xdOgwucvtLccO5Q8QuZjVSC0/ruEbBc4zEcSviZM+ndfWQgUa+iSn/e6LOTTUOC
	1WmymTdz3o+DUtxoSkyzXW7IC+Ivi5x2Sm0UbhNdY/hQLz3kzQXUjX7nf/YqjgWe
	13Seo06uTB8JsM0Z5UJWvbRj33ufgbWBm52FEd90YDzqoQC7Y5xWS9knu98Ef7BS
	BaaNKyk1Haun61veOjoUA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759687; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SQ5pO0X8jPJiObjx3NG1zyGYvdOfgpMPQ6K1+ogNBW9WPWa
	pMyLCV7sHhIykvdE42aNVjxfNgnWHhMAzWuXbYgx9tWv3DU3XFuw6UM3uno12sSS
	dyQ4ZSp/k88gJ+SwrtugdcyTNeqFpyRrQgCyRrb0hm7nreqCK502wrUUnFmtEOMo
	+zmFxbHLz86aLIENqB4HQYPJL7kkAo/zMtRagXSLOZ9dYJyI1VeYlzunqaJg1U07
	m/+0gn1FsDfIZzyuJnsySTic6QyhfcJDb/73hdPWfoIQvXROiDOBiMn4N1WFRmlC
	5PX0dDe+cx6ZCG8ptZ8gJFRzLtqc9F6G6a+JWuQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4FuBBciB+cY14gtNybvMqmWJp2q62O7SLzkWiuLSAIU=:dZFzG2M5cL0lNbADjSbRxG9YHAZMOjg9diXWxpC1OT8=;
X-ME-Sender: <xms:h1fbas8i3kZuSUmk2FOEJrYjDxegcURvf7R0BG_IQUooNYO0Sm-Hwg>
    <xme:h1fbaqtrQjH3yNDN_lyEpBpP-8OCc0LBrb0R4J8PVftPFQNAlOgRFRuL_TsO0Zx75
    XBuJC7PIhf_OsrJAfwpDTPYusG9s69dPmK62fXOg6SsKfqeseFiqFk>
X-ME-Received: <xmr:h1fbavpv8GVcWUMxZmVenyyAS-nbsPVSz5Gik5_xYnhIA12njiSQg6xH33pHDC408NEU0w>
X-ME-Proxy-Cause: dmFkZTF/5wAOPTlcw+A7JqFj2QsnOBTLyEUqkSnXOKO6GZorUB1vdljFPOM+bwmPIPwV5V
    8Ws/d01WIjofWvLGaa/EdmC0tduIxNWWz7qGfCCy1Ugx1FL0V8KP+gZqIRc8dRcJx7moWb
    R5weM8M7mOmkAa5lO5sY/Qu/YgLcMaGYneTapE6sfOd/g/N/OoWZKBrWVOhK17ConmHFNy
    7FNrvPPPjhmue5PQC2rnNNRI+ZPZo2onkT06pCt29CKQcz9hUU1IgYwyBEgH4BsnZ85IFq
    qBfpao3lbKMWovBZ+gIrhTpmx72dAEIIM9uTWPBNky+JyRSi0yTMer5uRwRG0qCQsswJFV
    /gAtN1UlObcDE8nCuP8iTyX6mA+pFsG/sZ7cmkZ14slJnt1ewgazcP0KagHGqSe8ArK1jF
    JlArmGz4XTjarXc95dtNpjWHE4CwRqX9EAUNWI/2rHnkLvFHIWDDHRrjnuAUP3KLhGM26u
    RK91Kc/hiD/KmxGoOHGosCSQ3F1d4BA+VF/nEjaH1S8T3bPqDzaV6QGvn+Qh7mpSvaw22G
    iflEHrn3OzYJc+lv/F1xaAmq0xNXgKRPNvbSrj30gCgnXUvjCND62o0jcrikIif7w56/Lx
    MLDWRJ5cyuvSr5sOGjyiCXYoUBCWJixe/oFFg58tblH2bMckwu43v8bv/y3A
X-ME-Proxy: <xmx:h1fbanmSTJqAnZD6woO4r8fXTX7ZPvjrs-6wj_HLWEBc_n1VtjqFvA>
    <xmx:h1fbajyRhV2iRvDYLIziPK0ypEgkdz6DksZo4m9s9F2Auvc94YppRg>
    <xmx:h1fbavmpQlvZR4NEpxRenVYR0nQpmhrIK_sNUZiFUIEZHWb9NR_lTg>
    <xmx:h1fbasfHODsIh_zkNKkH6vhb-Fqz1mNvArYFp_MDY_r-U1cfXPJZSA>
    <xmx:h1fbartyxtlTpS7O33VryxfgwvYGGS315h-2q98-1Etsi0XSqgNvEVgH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:48:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 666c2b2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:48:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] odb/files: reload alternates on retry again
Date: Fri, 23 Oct 2026 14:47:59 +0200
Message-Id: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6CMBBFr0Jm7Zi2aKOuvIdhUdpBRpGSthIN4
 e4WdO/yT97/byaIFJginIoJAo0c2fc5qE0BtjX9lZBdzqCE0lLIHQ73iN7V2HBHEQN13jg0XaL
 Qm5QvrrHaWZFZpSCvDIEafq2GS/XN8VnfyKZldiFajsmH9/rCKBfuZ1Pir22UKNAdSe51qcpDq
 c+5seUHVPM8fwB+pg0+3QAAAA==
X-Change-ID: 20261014-pks-odb-files-reload-alternates-dfc6dc010122
In-Reply-To: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

Hi,

we recently noticed that we don't reload alternates anymore when an
object cannot be found. This used to be the case, but broke with
5946a564cd (odb/source: make `read_object_info()` function pluggable,
2026-03-05). And while it's a rather uncommon scenario that alternates
are getting rewritten while a Git process runs we managed to hit some
such scenarios in production systems.

In any case, this patch series fixes that. In practice, only the second
commit is really needed to restore functionality. I was a bit unhappy
about the performance impact of this change though, as fixing the logic
regressed us from 180ms when looking up 20k missing objects to 309ms. So
the last two patches do some optimizations that bring us down to 197ms.

The series is built on top of 47fdf2208c (The 7th batch, 2026-10-19)
with ps/odb-files-alternates-cleanups at f211a3f0b5 (odb/source: drop
`local` flag, 2026-10-15) merged into it.

Changes in v2:
  - We now properly load alternates from the primary object directory
    again even in the case where a quarantine directory is active, based
    on Christian's feedback.
  - I redid how we deduplicate alternates as a result of that. The
    resulting logic is simpler now while still giving the same
    guarantees as before.
  - Link to v1: https://patch.msgid.link/20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      odb/source-files: rename alternates-related functions
      odb/source-files: always load alternates via primary object directory
      odb/source-files: reload alternates on retry
      odb/source-files: simplify directory duplication detection
      odb/source-files: avoid stat'ing already-known alternates
      odb/source-files: only reload alternates when the file has changed

 odb/source-files.c  | 187 ++++++++++++++++++++++++++--------------------------
 odb/source-files.h  |  21 +++---
 t/t1006-cat-file.sh |  32 +++++++++
 3 files changed, 134 insertions(+), 106 deletions(-)

Range-diff versus v1:

1:  94a0d4298a = 1:  1094828c5a odb/source-files: rename alternates-related functions
-:  ---------- > 2:  909f28fda5 odb/source-files: always load alternates via primary object directory
2:  73e7fa850f ! 3:  b5de5bf034 odb/source-files: reload alternates on retry
    @@ Commit message
         broken for the rest of its lifetime.
     
         Fix this bug by re-preparing alternates when the object in question
    -    could not be found and then retrying the read. Note that this also
    -    requires us to re-read loose objects, which is an operation that we
    -    previously skipped on the retry. But we only need to do this for the
    -    loose object directories that are actually new.
    +    could not be found and then retrying the read. A couple things to note:
     
    -    Note that the result is still incomplete though, as we only reload the
    -    alternates of the local object directory. But alternates are added
    -    recursively, so in theory we'd also have to check whether alternates of
    -    any of the alternates have changed. But we never did that before the
    -    regression, either, so for now we don't care about this edge case.
    +      - This requires us to re-read loose objects, which is an operation
    +        that we previously skipped on the retry. But we only need to do this
    +        for the loose object directories that are actually new.
    +
    +      - The result is still incomplete, as we only reload the alternates of
    +        the primary object directory. But alternates are added recursively,
    +        so in theory we'd also have to check whether alternates of any of
    +        the alternates have changed. But we never did that before the
    +        regression, either, so for now we don't care about this edge case.
    +
    +      - It may happen that we reload when a quarantine directory is active.
    +        If no alternates existed before that reload we may not have lazily
    +        populated the map of object directories yet. So the assertion in
    +        `odb_files_dir_is_usable()` does not necessarily hold anymore, and
    +        we now have to populate the map with all object directories.
     
         Furthermore, this change causes a performance regression when asking for
         lots of missing objects. But that regression is basically in line with
    @@ Commit message
         benchmark demonstrates this when asking for 20k missing commits in an
         empty repository with a single empty alternate:
     
    -      Benchmark 1: git cat-file --batch-check (rev = 5946a564cd~)
    -        Time (mean ± σ):     282.8 ms ±   2.9 ms    [User: 99.8 ms, System: 178.6 ms]
    -        Range (min … max):   279.7 ms … 288.3 ms    10 runs
    -
    -      Benchmark 2: git cat-file --batch-check (rev = 5946a564cd)
    -        Time (mean ± σ):     180.0 ms ±   1.7 ms    [User: 55.9 ms, System: 120.3 ms]
    -        Range (min … max):   178.2 ms … 183.9 ms    16 runs
    +      Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~) (50 runs)
    +                      mean     ±       σ          min     …     max
    +        Wall Time    289.9 ms  ±     3.4 ms     285.8 ms  …   307.5 ms
    +        Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB
     
    -      Benchmark 3: git cat-file --batch-check (rev = HEAD~)
    -        Time (mean ± σ):     187.7 ms ±   3.7 ms    [User: 59.7 ms, System: 124.3 ms]
    -        Range (min … max):   182.2 ms … 193.7 ms    15 runs
    +      Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) (50 runs)
    +                      mean     ±       σ          min     …     max
    +        Wall Time    184.8 ms  ±     2.5 ms     181.5 ms  …   191.9 ms           -36.2%  (1.6x faster)
    +        Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB           -0.1%
     
    -      Benchmark 4: git cat-file --batch-check (rev = HEAD)
    -        Time (mean ± σ):     309.8 ms ±   5.3 ms    [User: 105.9 ms, System: 199.1 ms]
    -        Range (min … max):   302.5 ms … 316.0 ms    10 runs
    +      Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~) (50 runs)
    +                      mean     ±       σ          min     …     max
    +        Wall Time    189.1 ms  ±     2.7 ms     185.9 ms  …   196.1 ms           -34.8%  (1.5x faster)
    +        Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.9%
     
    -      Summary
    -        git cat-file --batch-check (rev = 5946a564cd) ran
    -          1.04 ± 0.02 times faster than git cat-file --batch-check (rev = HEAD~)
    -          1.57 ± 0.02 times faster than git cat-file --batch-check (rev = 5946a564cd~)
    -          1.72 ± 0.03 times faster than git cat-file --batch-check (rev = HEAD)
    +      Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD) (50 runs)
    +                      mean     ±       σ          min     …     max
    +        Wall Time    293.2 ms  ±     2.6 ms     289.3 ms  …   303.2 ms            +1.1%
    +        Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.4%
     
         There's no helping this though, with the regression fixed we will be
         slower compared to before as we have to do more work. But the next
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb/source-files.c ##
    +@@ odb/source-files.c: static bool odb_files_dir_is_usable(struct odb_source_files *files,
    + 	 * thing twice, or object directory itself.
    + 	 */
    + 	if (!hashmap_get_size(&files->dirs_by_path)) {
    +-		assert(!files->dirs->next);
    +-		hashmap_entry_init(&files->dirs->by_path_entry,
    +-				   strihash(files->dirs->abspath));
    +-		hashmap_add(&files->dirs_by_path, &files->dirs->by_path_entry);
    ++		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
    ++			hashmap_entry_init(&dir->by_path_entry,
    ++					   strihash(dir->abspath));
    ++			hashmap_add(&files->dirs_by_path, &dir->by_path_entry);
    ++		}
    + 	}
    + 
    + 	if (!odb_files_dir_paths_cmp(files, path, normalized_objdir.buf))
     @@ odb/source-files.c: static enum odb_read_status odb_source_files_read_object_info(struct odb_source
      							      struct strbuf *errmsg)
      {
3:  af6c6888db < -:  ---------- odb/source-files: avoid rechecking already-known alternates
-:  ---------- > 4:  4c5a11e534 odb/source-files: simplify directory duplication detection
-:  ---------- > 5:  0d1d468a21 odb/source-files: avoid stat'ing already-known alternates
4:  561c8ea547 ! 6:  fdaeeff929 odb/source-files: only reload alternates when the file has changed
    @@ Metadata
      ## Commit message ##
         odb/source-files: only reload alternates when the file has changed
     
    -    In the preceding commit we have fixed a regression where we didn't
    -    re-read the alternates file anymore when we hit a missing object. But
    -    while correct, this change significantly hampers performance, even
    -    though we're roughly at the same level compared to before the
    -    regression.
    +    In a preceding commit we have fixed a regression where we didn't re-read
    +    the alternates file anymore when we hit a missing object. But while
    +    correct, this change significantly hampers performance, even though
    +    we're roughly at the same level compared to before the regression.
     
         But the checks are unnecessarily expensive, as we always read and parse
         the alternates file even in the case where it has not changed. This of
    @@ Commit message
         stat(3p) call that the file hasn't changed. This significantly improves
         performance:
     
    -      Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~)
    -        Time (mean ± σ):     280.7 ms ±   2.1 ms    [User: 95.7 ms, System: 181.0 ms]
    -        Range (min … max):   277.9 ms … 285.0 ms    10 runs
    +      Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~) (50 runs)
    +                      mean     ±       σ          min     …     max
    +        Wall Time    288.5 ms  ±     2.3 ms     284.9 ms  …   293.7 ms
    +        Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB
     
    -      Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd)
    -        Time (mean ± σ):     179.5 ms ±   1.7 ms    [User: 60.5 ms, System: 115.6 ms]
    -        Range (min … max):   177.6 ms … 183.2 ms    16 runs
    +      Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) (50 runs)
    +                      mean     ±       σ          min     …     max
    +        Wall Time    185.3 ms  ±     3.4 ms     181.2 ms  …   200.1 ms           -35.8%  (1.6x faster)
    +        Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB           -0.1%
     
    -      Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~)
    -        Time (mean ± σ):     257.2 ms ±   3.5 ms    [User: 94.8 ms, System: 158.3 ms]
    -        Range (min … max):   252.6 ms … 262.1 ms    11 runs
    +      Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~) (50 runs)
    +                      mean     ±       σ          min     …     max
    +        Wall Time    262.7 ms  ±     2.7 ms     257.1 ms  …   268.0 ms            -9.0%
    +        Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.5%
     
    -      Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD)
    -        Time (mean ± σ):     197.4 ms ±   3.8 ms    [User: 66.9 ms, System: 126.7 ms]
    -        Range (min … max):   192.3 ms … 203.3 ms    14 runs
    -
    -      Summary
    -        ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) ran
    -          1.10 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = HEAD)
    -          1.43 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~)
    -          1.56 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~)
    +      Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD) (50 runs)
    +                      mean     ±       σ          min     …     max
    +        Wall Time    199.5 ms  ±     2.5 ms     195.4 ms  …   207.8 ms           -30.9%  (1.4x faster)
    +        Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.0 MiB           +4.3%
     
         We're significantly faster compared to the original state now and are
         almost as fast as the broken state where we don't reload alternates at
    @@ odb/source-files.c
     @@ odb/source-files.c: static void odb_source_files_free(struct odb_source *source)
      		files->dirs = next;
      	}
    - 	hashmap_clear(&files->dirs_by_path);
    + 	strset_clear(&files->dir_paths);
     +	stat_validity_clear(&files->alternates_validity);
      
      	odb_source_release(&files->base);
    @@ odb/source-files.c: static void parse_alternates(const char *string,
     -		free(path);
     -		return 0;
     +	if (!validity || !stat_validity_check(validity, path)) {
    -+		int fd = open(path, O_RDONLY);
    ++		bool successful = false;
    ++		int fd;
    ++
    ++		fd = open(path, O_RDONLY);
     +		if (fd < 0) {
     +			warn_on_fopen_errors(path);
    -+			if (validity)
    -+				stat_validity_clear(validity);
    ++		} else if (strbuf_read(&buf, fd, 1024) < 0) {
    ++			warning_errno(_("unable to read alternates file '%s'"),
    ++				      path);
     +		} else {
    -+			if (validity)
    ++			parse_alternates(buf.buf, '\n', object_dir, out);
    ++			successful = true;
    ++		}
    ++
    ++		if (validity) {
    ++			if (successful)
     +				stat_validity_update(validity, fd);
    -+			if (strbuf_read(&buf, fd, 1024) < 0)
    -+				warning_errno(_("unable to read alternates file '%s'"),
    -+					      path);
     +			else
    -+				parse_alternates(buf.buf, '\n', object_dir, out);
    -+			close(fd);
    ++				stat_validity_clear(validity);
     +		}
    ++
    ++		if (fd >= 0)
    ++			close(fd);
      	}
     -	parse_alternates(buf.buf, '\n', object_dir, out);
      
    @@ odb/source-files.c: static void parse_alternates(const char *string,
      
      static void add_alternate_recursively(struct odb_source_files *files,
     @@ odb/source-files.c: static void add_alternate_recursively(struct odb_source_files *files,
    - 	hashmap_add(&files->dirs_by_path, &alternate->by_path_entry);
    + 	}
      
      	/* recursively add alternates */
     -	read_alternates(alternate->abspath, &alternates);
    @@ odb/source-files.c: static void prepare_alternates(struct odb_source_files *file
      	struct strvec alternates = STRVEC_INIT;
      
      	parse_alternates(alternate_db, PATH_SEP, NULL, &alternates);
    --	read_alternates(files->dirs->abspath, &alternates);
    -+	read_alternates(files->dirs->abspath, &alternates,
    +-	read_alternates(files->base.path, &alternates);
    ++	read_alternates(files->base.path, &alternates,
     +			&files->alternates_validity);
      
      	for (size_t i = 0; i < alternates.nr; i++)
    @@ odb/source-files.h
      
      #include "odb/source.h"
     +#include "statinfo.h"
    + #include "strmap.h"
      
      struct odb_source_loose;
    - struct odb_source_packed;
     @@ odb/source-files.h: struct odb_source_files {
      	 * determined by "core.ignoreCase".
      	 */
    - 	int dirs_paths_icase;
    + 	int dir_paths_icase;
     +
     +	/* Stat data of the "info/alternates" file. */
     +	struct stat_validity alternates_validity;

---
base-commit: c8e565497cff47f6b23a6b96bef6fa82afa11667
change-id: 20261014-pks-odb-files-reload-alternates-dfc6dc010122

