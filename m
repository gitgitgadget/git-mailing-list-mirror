Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E41357D1D
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293812; cv=none; b=X+D/KnTkyMdzh23h0FJHQxbJuUnUXE3lKf242Z355IeBXfSoCcMGvR3JMDrok7y+oBzHSKWU7pCHjnhNOUj2q1K9TzVFbTSz+h8DUIBRH1Gv0uz1Z/6wI1j+3Wqd0WEgq542bpnv5FRnsnAC6bicTORLrnwFhPATbYwkqTUXFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293812; c=relaxed/simple;
	bh=fQEAgPtAuMOmQccvQNXrdJkz6/koI14Dv5deULfogxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=L02+NozsdWHU5B+XKf8UtrMWfjjcBTgPYgN4DwA2r4I1lYt3wY/yD9JV3MEf/F3SzCYt4WKa4kQGgbG64C+/ZSPVpIEhhcKtVchJuWX8+DBbjRhUv8hMHMBdMKvmFGtjAe97/Hs0UE0bgsW6OYjc6N7QlJLgkzpuada/PoYjQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CjMNPPLj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lx0N5U+m; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CjMNPPLj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lx0N5U+m"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1386514001D8;
	Fri, 21 Aug 2026 02:30:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Aug 2026 02:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787293810;
	 x=1787380210; bh=aD/cAZ+h4xn7mFJ5qg//YZF5RsH0Q7ReYXyYPTnaIGk=; b=
	CjMNPPLj7zr3rHAKP1HRh/PEspZF2ZyE5l/vs0S9EGQx/J73SR4Dz6wQ+QBSQ+Pc
	XXi64uFm6xtWtm6YOhguBVhMzYOHuphWjtf+9s/rclj4iwgCZljmiRWEXdjoYUU8
	sESkRWn4TLuYjEVfpQzL2+FfsaNJlU96wmn91JvmUaHvoQgIUWs2mZXjiVEXGUwY
	Fbc+psVhCthMtiV162CmmlUNuzlRgh4sEZFcw4qTyXis3e+dcGE9NqZ9q3/+O8NU
	H2AW1XuikpddKJKH7VvlFRDdMUjomzwQPOccvSkOIawOOu2MsB6cCn6I5WJ0Jvwa
	QeW28OLt5vK1nXO5sihPug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787293810; x=
	1787380210; bh=aD/cAZ+h4xn7mFJ5qg//YZF5RsH0Q7ReYXyYPTnaIGk=; b=l
	x0N5U+mPMuVp7ms56Gv5WkiAM9BnHe2NqbBiubiWO4cX1vVEythD+Gi1f/uGdTa9
	QnciCI2VD6QMiJViPOtQXXf7mhVtnyM3YnL+FBSbiM0Izx0HnnTuUtS8ARg/ho6i
	FkU04UPsUUJJLLsU/jq+5A2tn7Md2UU1DuGE5a5UEhRTSq4HYt0nu5E5xSapP1Lm
	eAsLdhbGNq7klRLc6dAWcaVv1lRsD9vZgE2UfTAjVOAb0QXPLtCCzQO0X521NL6B
	H68AAWKNZjttTM46bm5VZiJP00e+P2vvv977obivCOXjVqVHf22tkobBaY/MxWOV
	yf5KdRnmB0uD1/jKwZPxw==
X-ME-Sender: <xms:cfCHagdW-WKVnpKfMeUrPpuq6bymxktuUSeW9HhLYCl3-hggJVVKxQ>
    <xme:cfCHapHRFKM9OS7JZdVo_YeZEqpy__U7l00NlYKXPm40LvSF1rch4pWkvo50SiJ0a
    fcW804fwH38WwFlmVD21AcRlvaLo9Fidjmj5xdgUtUTMb2s3_YbmbE>
X-ME-Received: <xmr:cfCHap0T5LYPo1uczB6Ve8UuQQIaWGaGFPUedPml3fB912wqBKJoAydnhGPRhWDh5Ytfur__q8iUvuvIupMIkmKmAH9ZQG0dKf18ZNWmnC3a>
X-ME-Proxy-Cause: dmFkZTELh9Sw83NwPUc3gPPrsTly9lV2uKfUj/XF/Y6hWwa4gXf2d/kfI0p1t04Fwyw4lD
    N9WhewxtcI2b2NWhCZ6nAMiQAnoYpE7Tk5Qbf9ANzyjbwfTf+XyzYJ49RZ5Xyy2NknPhCL
    0imARyVh7VEcbmj/lZA2vtWec4LxhSDNqqFMqTQitJIvNi8cEOVeFJVz/kbB88oAJF1iJ5
    +MPJ/Hiq6DpEPjkG2rkdkMnGTti6L1x1Njg205XA1GaJeLIKheMXkywsOa7WtmVaW8tG7m
    Coa1YSq/4fdlbHac9C2hUC28aUh/f6hgdIulSqOxN3KG+AuxSpPmlfTTlaf69DYLgMyok6
    XqE7vJEj60HK23Ogn+c98oH1PSxwTmaZRSPKGEd6MP8Iza6sGhSpis5wG4e/vPwuBrRE4r
    2CuCXAvMszuSqSsWjLF08KIr3e5pbtfZNJSxPHNXfC2rrvXcESMHVOb6Urqsl/6tsNkW5w
    aTfQFQABgfc/eNuV31NebTsNFCan/bgh3S6hLArG7qTT3eXutO0WY7p5ljtr+yiFreH2+X
    qRi9Xo6AXW4zEPBhGR/uGLv0Qn6bcKeQYbTHTQp7e1T6Sxt4yhKfDD+jkL7xo6RfrwhH//
    oU1fIgmDwZYGJzjAfDEVZnTYysGlgcZL23aoCq+emdojDWcGteYV17Cy3wFw
X-ME-Proxy: <xmx:cfCHahmSGImGesVj_sNkRx0P4SVAwKCho1VI0PY94vxwWZ-BlLpBgA>
    <xmx:cfCHap9n2gTRhhz1e1TCL5akJIjkfBX6jWx3tTTidnumfN09MLcXbw>
    <xmx:cfCHampSp7bORYgHRK_xUTJ_qTrTSGPvG9lLvzMzM0g6sM_gJ7F_Pg>
    <xmx:cfCHaimbOlU5pFPovePJy30Oql7_1eJUbznQKmQVYyUJrGofMN9uCA>
    <xmx:cvCHao0tIO6rJsUOqY_Y27iGpK_vV0F5aY7tmsSsaUTHm92spaeTkeaW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:30:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3581f450 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:30:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/6] odb: make packfile generation pluggable
Date: Fri, 21 Aug 2026 08:30:00 +0200
Message-Id: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NzQrCMBAE4FeRnF3Jn6168j3EQ7LZaBTbktSil
 L67aQXRS/E4MPNNzxLFQIntFj2L1IUU6ioHvVwwPJvqRBBczkxyWfANL8FqaK4JamfhRBVF0xI
 0Bq/gFfcWHXnlkeV5E8mHx0Qfju+c7vZC2I7e2DiH1NbxOX13Yuz9cdMJ4FA6Qq2EoRLdPvdW4
 cbGj05+KWJOkVnRuDHbAtE7q34U9aVIPqOorFjUUq6lL0Sx/SjDMLwAxpEtOFsBAAA=
X-Change-ID: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.15.2

Hi,

this patch series makes packfile generation pluggable.

Note that this series only makes those parts pluggable that are required
for the transport layer. The other parts that relate to packfile
generation as required by our repository maintenance is kept as-is, as
there is a bunch of options there that are way too specific to the
"files" backend to be portable. This should ultimately not be much of a
problem though, as maintenance itself is already pluggable in the first
place.

It's a bit of a shame though for git-pack-objects(1), which still isn't
usable with alternate backends. I tried several times to find good
solutions for making it fully pluggable, but due to the backend-specific
options it's an utter mess. I want to eventually address this though:
same as with git-refs(1), I want to introduce git-objects(1) to care
about all things ODB. And as part of that command we can also introduce
a command that generates packfiles in a generic fashion, without all the
cruft that git-pack-objects(1) has. This is part of a future patch
series though.

Changes in v4:
  - Improve an error message.
  - Sneak in a small stylistic fix while at it.
  - Link to v3: https://patch.msgid.link/20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im

Changes in v3:
  - Fix a use-after-scope bug on abnormal exit when child processes are
    cleaned up via `mark_child_for_cleanup()`, as noticed by Elijah.
  - Link to v2: https://patch.msgid.link/20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im

Changes in v2:
  - Mostly remove the dependencies on `the_repository` in "bundle.c".
  - Link to v1: https://patch.msgid.link/20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im

The series is built on top of 2c78326f81 (The 11th batch, 2026-08-05).

Thanks!

Patrick

---
Patrick Steinhardt (6):
      odb: introduce interface to generate packfiles
      upload-pack: generate packfiles via the object database
      send-pack: generate packfiles via the object database
      builtin/bundle: refactor option handling for progress meter
      bundle: get (mostly) rid of `the_repository`
      bundle: generate packfiles via the object database

 builtin/bundle.c      |  34 +++++------
 bundle.c              |  97 ++++++++++++++++++--------------
 bundle.h              |   3 +-
 odb.c                 |  21 +++++++
 odb.h                 | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-files.c    | 149 +++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source.h          |  33 +++++++++++
 send-pack.c           | 101 +++++++++++----------------------
 t/t5516-fetch-push.sh |  12 ++--
 upload-pack.c         | 125 +++++++++++++++--------------------------
 10 files changed, 508 insertions(+), 219 deletions(-)

Range-diff versus v3:

1:  4a56334af1 = 1:  33039a0ab8 odb: introduce interface to generate packfiles
2:  1ff0eaf6b7 ! 2:  7093fcee83 upload-pack: generate packfiles via the object database
    @@ upload-pack.c: static void create_pack_file(struct upload_pack_data *pack_data,
     -	 */
     +		oid_array_append(&opts.haves,
     +				 &pack_data->extra_edge_obj.objects[i].item->oid);
    -+
    + 
     +	opts.thin = pack_data->use_thin_pack;
     +	if (!pack_data->no_progress)
     +		opts.progress = ODB_GENERATE_PACK_PROGRESS_STANDARD;
    @@ upload-pack.c: static void create_pack_file(struct upload_pack_data *pack_data,
     +	opts.progress_fd = -1;
     +
     +	if (odb_generate_pack(the_repository->objects, &generator, &opts))
    -+		die("git upload-pack: unable to fork git-pack-objects");
    ++		die("git upload-pack: unable to generate pack");
     +	odb_generate_pack_options_release(&opts);
    - 
    ++
     +	/*
     +	 * We read from generator->err to capture stderr output for the
     +	 * progress bar, and generator->out to capture the pack data.
3:  22a19a9a70 = 3:  0a2ca04c01 send-pack: generate packfiles via the object database
4:  5d2275c90b = 4:  2d339ee7b7 builtin/bundle: refactor option handling for progress meter
5:  0f00e6d234 = 5:  3cf0210247 bundle: get (mostly) rid of `the_repository`
6:  ae6af210ff ! 6:  d3345e4407 bundle: generate packfiles via the object database
    @@ Commit message
     
      ## builtin/bundle.c ##
     @@ builtin/bundle.c: static int parse_options_cmd_bundle(int argc,
    + }
      
      static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
    - 			     struct repository *repo UNUSED) {
    +-			     struct repository *repo UNUSED) {
     -	struct strvec pack_opts = STRVEC_INIT;
    ++			     struct repository *repo UNUSED)
    ++{
      	int progress = isatty(STDERR_FILENO);
      	int version = -1;
      	struct option options[] = {

---
base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
change-id: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc

