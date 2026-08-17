Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D03793DC
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992755; cv=none; b=RKwm6H8rBAlltZGmxoriBCpsIGwIXYjskKCMQPQC1pd/B9jT9WKYzI8n2XgAfxY5PTCTtJ77x1jKQfQqOGuEioP0RiaY9MApBHWZtZXB98fjQ5GrwSDxUTbVBPXiLar/Oxg/KTXEllrjLsQX8a2amZF3y3Y5FNP2FsvRnXjvHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992755; c=relaxed/simple;
	bh=TVP8P13HXV5ER9QzGpVV0X8uye0g1HAiADRQtdQyzN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGaA0WEG2oCHUo+JFC8U5ZC3NdKa0m9dcBWDdnSkueWhXJWU182AdhA+UdoKKKD0XYGXtLPudDHuIdKdbRGlmGnGCiZCNhDJ6X4Sx3aPKHfJ7uq8PgYzK5GFrIrXHcSynKhxz6LNyyY8eHrLntrBf1baIctW591qu46h+qtZSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NqBn3u6d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GfSj3swe; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NqBn3u6d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GfSj3swe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BADD7A00CD;
	Mon, 17 Aug 2026 14:52:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 14:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786992752;
	 x=1787079152; bh=2JCGG7pVgPWNdmQyONDglP1lLOrfpr+ZAigRZXKlBus=; b=
	NqBn3u6d7xzDzMT/vSZudOnnnn/ptbIRcOGpMa/LKLyZkxOCHhG/d+GZERoPsgVD
	+3uDI9Y3tQWcd31tcKaQ7/D18CrqkchYSb27V8/D0LqvOFMhaeYiaslu6DkjZESX
	TbYHsluJ9m22FKf9y8bDy6UpFbEcg37u7/8zCWxtlvfatJcGUSDQzC9bN39w2C4C
	53b2dlIOIVcdGforV1ZY3+EpIhkiMGHZ79EToASfr+b22UngO81wxP8G0Ofs8WH5
	+dbCcL6kc0qQsbw5Ow1twV8yRDVUEqAjOGqtuAKnDVcsQWYd0LgiI/v/CFCsSIJ1
	okPBDhCGx+IWNFidUGbTvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786992752; x=
	1787079152; bh=2JCGG7pVgPWNdmQyONDglP1lLOrfpr+ZAigRZXKlBus=; b=G
	fSj3sweouZtXfGqMFMGjbricELkyyzbouHmjYFYMsHtu8+m2REvm1o4YXbgItBjD
	j6eWqJZgniIvPxpXIO2R7ljQ3nCejD8LVvTb1ob2skmUoKlOnubn1pP4AV033QGj
	Kh9UPBPExozqGg+t0xfGUK3XDBJtp/xD5HrygVx2JPoQ7HW0PetvN6Apgpox33Ef
	aWZHuphV8yLK4qbLbX5u8auZM619TmmQ0oJ1E7LXDNFWzr3y+yRMNum783CPtb8L
	V+HK6XZobX3pkyy8rseCZ7IDMFMP6NLncLz1UT+vKWLZeLJasnJHkn+hNf1pgLK4
	aQD4dWVLhCGrcYe2mkV8A==
X-ME-Sender: <xms:b1iDaqQouqoAjWCJxb2QBnP5Cq3cPEWYe5TRmunR0AdtQy4PRap6rJ8>
    <xme:b1iDamxmJQTNRNzM2qDRyHzItjiBqtdJpSAfDt5fJcqVm1t7fu13JeriF8Z5oT2ZP
    HfNc51b8zcJPg7ytdffQaZy9LovbtGDx7-0JFVPKVTNAWK5-YhyHA>
X-ME-Received: <xmr:b1iDas2xa9_gonA9j50MLby8nCfu20zZaVcQRRXNVWwwkphTrAsFKi83fyyx9ZoWQlJDC2HFkATI6D8hedboI6BLZHF7AJF2ccwaXgUS4gxokJkaJkJt7sw>
X-ME-Proxy-Cause: dmFkZTGyRL5S5oNpoF6e3KZFS6fk3iX9E8GIhuqZcssxTPHRUad2hI0C1Af7/SloCf1JzC
    Ycg1/D+/v/9NdMwsJqa8RxFmbsFdYWNAzHvUwMhHGMWfnrCPQbj7vCUsFVxzx2Nao8dKcN
    H8fsye3U+Rr57XXQQ7Z6ayA1PlU0BkhsOSbSb48txr1hCf8I/+Bc0gpQ66OF9UnkP76eW2
    FJvcKl5KvtjH0N2RPPOmy6a5VvCAn3gonxcxEf5kun5pNC6TVMTEeSidKF80gWyTW2vINB
    SCJ7aX2htFmohTxUsvUkkJswblS7ECVw153GJ/hXtuiVL4Sy9NDPXZOsQrkYmjf+KpD7pr
    P96SOJFgGtVC4wdkM3hVYM1joR2/82m1a3qqHTDzGR4VTHO5e6zhBqTjdtdtpUXehIJWy5
    22SKnakUCwf2yKcBBED0foVUxbHnRspBTjZb/Q3j1vBlMXekPxihZGcapoIE6urxIH9Pnz
    wGyUi1heUGkIiZp1RqGkSz4Kiw+7RdNst9so4o3gQuVDFBIIng4H+p4I0NRScQr4YIsfls
    yVm0O3KnPqlqfr+jedsoFI2I4V2NWOYQCaMLY0zbMpEalU6GtWzrM6iDdBAQdQr1Z15fY3
    jqgxZrdPSpU+sGoQu+RVtBz2OT6BdtGdWOrCbpGVt2MWmpU4WM8uIJ+VbOVA
X-ME-Proxy: <xmx:b1iDak7wtGpsRmfek6mjLcCGWYYpg_Bxc_OIdaoTApQAkrlu9nUJjQ>
    <xmx:b1iDavWaGdhG7Q6lpmcB8ZvypbqQg00WA8gBlpiRVEJVRinL3GlsqQ>
    <xmx:b1iDajBmkaLQH-qMRCMqZnJQvzi4nPjnFA7YhAkYvaNFD8O54I4KXQ>
    <xmx:b1iDau614jVc1SZj6Lj3PdLUstD7EzKeru3bglwpREUsgXqVbn_d7Q>
    <xmx:cFiDagylcX0u0rK_s7ZKgoJIPAOA7ppK1HGYB61YX-akSWOnQO9iYXgC>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 14:52:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v4 0/2] doc: format-rev: use [synopsis] on code block
Date: Mon, 17 Aug 2026 20:51:47 +0200
Message-ID: <V4_CV_synopsis_block.b8e@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <synopsis_block.af9@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/format-rev-doc-synopsis

Topic summary: Use '[synopsis]' on block in order to highlight
placeholder properly. Also quote the subject consistently.

§ Changes in v4

Sorry about not reading carefully. An open block is not a code block.

(copied from the patch note)

Fix block: use open block, not code block.[1] This is what was done for the
synopsis blocks in commit a34d1d53, the commit mentioned here. I have
tested this with what I believe are the use-asciidoc (tool) and
use-asciidoctor (tool):

    make doc
    make USE_ASCIIDOCTOR=1 doc

And they didn’t give any warnings. And they produced the correct result.

  🔗 1: https://lore.kernel.org/git/xmqqfr0hqzvl.fsf@gitster.g/

Rewrite or flesh out the commit message to reflect this newfound knowledge.

Also remove the Ack since this change invalidates it.

§ Cc

(See v2)

§ Link to v3

https://lore.kernel.org/git/V3_CV_synopsis_block.b64@msgid.xyz/

[1/2] doc: format-rev: quote subject placeholder before and after
[2/2] doc: format-rev: use [synopsis] on code block

 Documentation/git-format-rev.adoc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Interdiff against v3:
diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index d6c2e4aec1a..c2268c92b56 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -97,9 +97,9 @@ formatted commit, i.e. the format `"%s"` would transform some commit
 object name to `"<subject>"` without any termination. Like this:
 
 [synopsis]
-----
+--
 Did we not fix this in "<subject>"?
-----
+--
 
 It is safe to interactively read and write from this command since each
 record is immediately flushed.
Range-diff against v3:
1:  c82aec7969f = 1:  c82aec7969f doc: format-rev: quote subject placeholder before and after
2:  b9a93c83c88 ! 2:  16d7bea804a doc: format-rev: use [synopsis] on code block
    @@ Commit message
         doc: format-rev: use [synopsis] on code block
     
         This code block uses the placeholder `<subject>`. Let’s highlight this
    -    placeholder properly by using the `synopsis` block definition which was
    -    introduced in a34d1d53 (doc: convert git-show to synopsis style,
    -    2026-02-06).
    +    placeholder properly by using the `synopsis` open block definition which
    +    was introduced in a34d1d53 (doc: convert git-show to synopsis style,
    +    2026-02-06). This renders the block like a code block but with emphasis
    +    styling on placeholders, just like inline-verbatim (`) in running text.
     
    -    Yes, note that code blocks since commit a34d1d53 can, on synopsis-style
    +    Yes, note that open blocks since commit a34d1d53 can, on synopsis-style
         docs like this one, be immediately preceded by `[synopsis]`, just like
         the command synopsis is:
     
    @@ Commit message
             [verse]
             'git name-rev' [...]
     
    -    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-format-rev.adoc ##
    @@ Documentation/git-format-rev.adoc: The mode `--stdin-mode=text` replaces each ob
      formatted commit, i.e. the format `"%s"` would transform some commit
      object name to `"<subject>"` without any termination. Like this:
      
    +-----
     +[synopsis]
    - ----
    ++--
      Did we not fix this in "<subject>"?
    - ----
    +-----
    ++--
    + 
    + It is safe to interactively read and write from this command since each
    + record is immediately flushed.

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0.13.g85d2d65e389

