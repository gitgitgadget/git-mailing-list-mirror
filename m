Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193143E083
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833157; cv=none; b=n1kP18h3L3GVlIidrlxb4II9+tXBO2KKcWbrnLmuBsiN04MgcgtuxpFeiFWRv9w+Q2LhwrzauA28i3WiDBMT/SL1gVOCqG687prOzWfUTMaVg00EySuz0ZPsCmxR/BVpE0QQjSu0IRBYQlRGb/sC7CMdof7vvaBaK4/ECnNLYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833157; c=relaxed/simple;
	bh=rA04ItxiSijG8cfDmx43Xc/2WbSR24kRvQp5gTljdI0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=QNIAmzy9gLtxig/D/eTarXDcUdlXu9YQzCj32o1WDFM8GTJptJi2DQnP0JOYbU+3I+/feezDzUIUsSe6NPEVxzkFSR2Ss91MJAzYv2zI9VTlOhnBtKAzJQvRWhhbcbcqPVCV5JkeW8rmZkcqisoDQziP49cTk4Esq2DKZWv/JD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TQ1xMd18; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSvbxEoy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TQ1xMd18";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSvbxEoy"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 583B914000F3;
	Thu,  1 Oct 2026 01:39:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 01 Oct 2026 01:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790833151;
	 x=1790919551; bh=bCoxT5XVl3Jj38l06X7sm4PwXl6agailfxLuS6fu/uQ=; b=
	TQ1xMd18F0RwSY9/N3FtNgxQlmPVYveGa3jk+tA+DKsDAHyVUcFTsJLscP4EDjHS
	DKfcTq/b28h6pBSs44KNEoWevryu707JGl+NL1AVkAJFoRVc7rWQGPA+9ASnv9VI
	P/aPgY+4dzGC21gtu2V68+08mSKPYjB+B+YaeIGy88CPOd2UoFfdlUPiTpfBT8Ye
	cNK/1Al13VbOYk5aLmXMhOT4Gqju6tfpA2jboMK0BFJ7gjSV6QiPqIGroVgUbhuH
	eB0u+gOqoTy825lTI5FH8BV8TvRQSAXO99ppCFeqa2Cupryr9H//vA1HBecprnmk
	T72VMf0lG/UIQkbcCiz5Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790833151; x=
	1790919551; bh=bCoxT5XVl3Jj38l06X7sm4PwXl6agailfxLuS6fu/uQ=; b=n
	SvbxEoyC+majna3qemdrB7SK91rIgZehRC90dMs28es1oCDuEvB8wg4dFrUVP37F
	JHXyAFcX4qRSJ6Qmtb46B5wph5prQ2IgbMZfGeu/xHELumxxeuEr5PFFflvDxgAN
	qZC8K5n4m+q1mAzexKnkECnCXF52u6RdNKKuLD9z2EZt77mErYkYyE1wqLtj7SMD
	yvNP5w20SX5hHMH8naHVmgD9VxOH22Pnya+8ktjduuWzfcR2Dx9zRQgdOQ6l6PlV
	qHxOAmE2zBTN3Faw5VZU+lk/byhPKMZ8cFcXmRHlY5YAaOAI0b0zxGwBFilhXbgJ
	rPQKg0ek/DwLggjg3yFiA==
X-ME-Sender: <xms:__G9arlc6DDYMyzPAeud5k75bdoMIAAmTtRZ3j0tZ4BhE_OHwYHq0w>
    <xme:__G9asq-6VeXNNtv1CIzDMlM7PQT8dyd8vKJC0O06gJYHTiVi1eX2QrXrrOFfNZ17
    H90uDH5va8KxM57Y1HrOjSx8mDEu3cdL1Ql6HgYA9fD2J40Xt_ceL4>
X-ME-Received: <xmr:__G9asHtaCv3AzkuhyBC9hFVuh1GrO2lz8lAmD57nmZhb2EDJ_9GPEQZV2DRBI8sCIuI_A>
X-ME-Proxy-Cause: dmFkZTGJweG3Rs01tMysYslnxwDGeMVG7xEf7VIu12BHqCLwSqvQ0kYpu3n5+5GFBolZgx
    O8ep6rTvVD57YXKAzRgtFd544Dlm/kj6NoQuurHZ27BJBc1+0SCv4FGkBoAF1gmiY4TWS3
    adl+ks7/qqwHUMh+LRKwDFylbKhm34xZpoyImlzCrCSm1/ZrA2/pJFUCSokzNatDg6T4zZ
    FYFDwh/0ZYDiblnx8/utCX6IF7V5SO7XH52L6ZaKs38CEBd7qruxBVjSkphYb5XMfwayhp
    AAflvqoaC4DVlNwefPoqq2b9TuAMwAlt4DDoYupPKs0mXz+3B359JNeiLZd1QjrjiADaCh
    7ZIq6VdrfAB0T2e664tjYbYSB+tZfWyRlw/BxxcHHqsUjctjlcUy1NfrW4GcnuCzT6xPQ8
    NUswtiP2NBC2vYflRUlmnfUZpoIVFH+6njQ1uJ2yGr2SQmVhNSU4PUbB2jlg2RQeeC+K+R
    VwgszpKHnGTUQeJxMxUOTCdtrOtBrPVU8/tyCiFqvD9Ba774YnGcvtpt+Zvk4dXmt2om/l
    P10iR1ID6UeUELMhk3amfagnwFyfR61DHI9HZExMQvFA3c1+gFltmbd+ecG7vSjeT6P1b+
    WRNc1AMQLECtvJ2I2XSiWQtTG2HxFoesg7f3wovroeRiVaTsbvc5tRnvq3Aw
X-ME-Proxy: <xmx:__G9agzvyptDG8ZllgszmC3HppcgcPwxPcxYHmfZgQhly1NweJJxPQ>
    <xmx:__G9apqjJ_cI21gH2Kj6nhJbmf4KAd-KLsyICAPRT5DBk98qOeKkKQ>
    <xmx:__G9aijrAVI0pY4MfJl-DSLDel4bQPWAWx2TDZoJ2NQbgSHvvmtziQ>
    <xmx:__G9auiiCcCPY-pyoXxe5RpAI2YvNLY0WtvZxh2wQuB7OGQg2vW7qA>
    <xmx:__G9alcPemqK4C_Zk_Yn9pR2OwSUAJ7-4HAzotqXO20wOY4pFlmCdazu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 01:39:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f4d9981 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 05:39:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] refs/reftable: fix on-disk representation of reflog
 timezones
Date: Thu, 01 Oct 2026 07:38:59 +0200
Message-Id: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOTQ6CMBBGr2K6dkxbgqauvIdhUehURoWSTiUo4
 e4WPIHLl7zvZxaMkZDFeTeLiCMxhT6D3u9E09r+hkAus9BSH6XRBoYHQ0SfbP1EBk8TJOrwE3o
 EH2JnE5gCGyfxZJVTIvcMWadp27hWP+ZXfccmrcWr0RKnEN/biVGt3j97owIJhfNKltaU6NQlZ
 w7UiWpZli91e8QH4QAAAA==
X-Change-ID: 20260929-pks-reftables-fix-timezone-format-93ecd0e7a1d1
In-Reply-To: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
To: git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

it was reported [1] that the way we store reflog timezones with the
reftable format has a mismatch with the reftable specification. While
the spec says that reftables should be stored as a signed offset in
minutes, we store them in the "[+-]HHMM" format that we typically use in
commit headers, for example.

This patch series fixes this bug by making our on-disk representation
match the specification. This will of course make us reinterpret old
reftables. But ultimately, the fallout caused by this change is somewhat
limited as we only ever use reflog timezones for display purposes. So
yes, we'll display a wrong timezone. But it's not used as part of any
kind of computations.

The series is built on top of v2.56.0.

Changes in v2:
  - Improve readability of one of the converted sites that now use
    `minutes_to_tz()`.
  - Improve test coverage.
  - Link to v1: https://patch.msgid.link/20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im

Thanks!

Patrick

[1]: <85f7daa8-d60b-4348-ac2f-b1a68628af7b@app.fastmail.com>

---
Patrick Steinhardt (3):
      date: add helpers to convert between "+HHMM" timezones and minutes
      t/helper: fix segfault in "dump-reftable -t"
      refs/reftable: fix on-disk representation of reflog timezones

 apply.c                    |  3 ++-
 date.c                     | 25 +++++++++++++++++--------
 date.h                     |  9 +++++++++
 refs/reftable-backend.c    |  7 ++++---
 strbuf.c                   |  3 +--
 t/helper/test-reftable.c   | 13 +++++++++++--
 t/t0610-reftable-basics.sh | 35 +++++++++++++++++++++++++++++++++++
 7 files changed, 79 insertions(+), 16 deletions(-)

Range-diff versus v1:

1:  91b9739506 ! 1:  4f950cf7de date: add helpers to convert between "+HHMM" timezones and minutes
    @@ date.c: static int local_time_tzoffset(time_t t, struct tm *tm)
      	offset /= 60; /* in minutes */
     -	offset = (offset % 60) + ((offset / 60) * 100);
     -	return offset * eastwest;
    -+	return minutes_to_tz(offset * eastwest);
    ++	return minutes_to_tz(offset)  * eastwest;
      }
      
      /*
2:  112e414c34 = 2:  9ef28821a3 t/helper: fix segfault in "dump-reftable -t"
3:  26eee10d6a ! 3:  c66e467554 refs/reftable: fix on-disk representation of reflog timezones
    @@ t/t0610-reftable-basics.sh: test_expect_success 'reflog: renaming branch writes
     +		cd repo &&
     +		GIT_COMMITTER_DATE="1234567890 -1200" git commit --allow-empty -m min &&
     +		GIT_COMMITTER_DATE="1234567890 +0530" git commit --allow-empty -m east &&
    -+		GIT_COMMITTER_DATE="1234567890 -0800" git commit --allow-empty -m west &&
    ++		GIT_COMMITTER_DATE="1234567890 -0830" git commit --allow-empty -m west &&
     +		GIT_COMMITTER_DATE="1234567890 +1400" git commit --allow-empty -m max &&
     +
     +		# The reftable format specifies the timezone as the offset from
    @@ t/t0610-reftable-basics.sh: test_expect_success 'reflog: renaming branch writes
     +		sed -n "s/^log{refs\/heads\/main([0-9]*) .* 1234567890 //p" dump >actual &&
     +		cat >expect <<-\EOF &&
     +		840
    -+		-480
    ++		-510
     +		330
     +		-720
     +		EOF
    @@ t/t0610-reftable-basics.sh: test_expect_success 'reflog: renaming branch writes
     +		test-tool ref-store main for-each-reflog-ent refs/heads/main >entries &&
     +		test_grep "1234567890 -1200	commit (initial): min" entries &&
     +		test_grep "1234567890 +0530	commit: east" entries &&
    -+		test_grep "1234567890 -0800	commit: west" entries &&
    ++		test_grep "1234567890 -0830	commit: west" entries &&
     +		test_grep "1234567890 +1400	commit: max" entries
     +	)
     +'

---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20260929-pks-reftables-fix-timezone-format-93ecd0e7a1d1

