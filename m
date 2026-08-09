Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A913AEB29
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306155; cv=none; b=eKoSNeC/ZENk217gOiZsAo+Z8l0LdGEZpU2Z7AqcoKUC1skAoMRwuvcJUz+6ugAIVymCorAnMrmce788lrNdv1CAE3Yq/wC4GC46KCcR4fW6qDT0IEHochDw+mqnBSUc1PoMXw9SWbEfl6I3QVX/6EyxLh+sdEsPk0k1MdDkT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306155; c=relaxed/simple;
	bh=6bk9+isX6J6bNb7H2Nijd/CjyDWqFdDLgxcFaOMh4lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVG8aeC0deR8CRCF2Jv0iGAllvOrgv7KbSPY4Dkyr5lpmzkbb/COiYAOlQNFU9eXj9d+RexHf3uAkhsq4UmWBlwfWOZepyP9JG19k36VKAq7P3n1+wjrZFa66ZT+o5YQZq9Oc+O9KSr7RZesCAxSx9aG8ESh+T25BiamRpcLc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AVPKS6Zy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CnpJ3U8C; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AVPKS6Zy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CnpJ3U8C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69ADB7A0147;
	Sun,  9 Aug 2026 16:09:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 09 Aug 2026 16:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306153;
	 x=1786392553; bh=R2SdBQIkFOdAz4KtOvDLt9ZtoM0TdUaEgdCYHkCgDcU=; b=
	AVPKS6ZyuLyoTk6s0Gh/jAv4WM27h0hnNes14mmdGXc0qzhq8+wSHibNsYDv4jeO
	oLnNOzQLoBI3Xu8JmQ8kMlH9Yg0s421FNoQCkJTWvbjLcSz3hRZ7XUJDPEI1X/0f
	XoU8tZfwjTosC+C9xDx+H50G8c3Ihy3vTe0v/7Isk6ovrirvIN1x8cXEBhzQDNOt
	FjHItX2CxEW2b/UmIr6S81ZjSvl5yege2P4jTnfHze7NMbyWrSFxpIv8RKT5zV5D
	lVygtsquNEfTUNs7G+SpVPOCVaT5vRA5sx0a07rw2NDV81dE6ORD+Co2ZDyBOi+O
	BzPqguRtNsNYPAalWAJe2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306153; x=
	1786392553; bh=R2SdBQIkFOdAz4KtOvDLt9ZtoM0TdUaEgdCYHkCgDcU=; b=C
	npJ3U8CRxA59iycoE1joFANqXvLWWmyE5ZPLhLKy4abk6O/vsj+ylvXseHSuSij6
	hCEYEjRd5h2T+QRZ5s3gG+TN9lPPD03gYOLv3TY/vU6gvD7BrrFh9MWtVL784I4X
	xMnx8oC4K5NeSfogbBFboCJmnV+jqkOg7T7UIucVUF6W1VjV2BPVSEjYIRD23OqC
	ikyDTl0q1DNPUp6nRwYOxQPWSimtK7AqcWdH5sh4ROVOUvzg7afAQ2nrMjMEbq8x
	PyfgAKn42BJ8LPXpS9GH6ino3Rt8sTt1n4eaE9mXqZX75msZsS36bg0YWwBU4gpL
	MPihXwOPF0JBan2Db1UxQ==
X-ME-Sender: <xms:ad54aoSuKugk6qi7x66s8dtsZXO8Oagcov4umVKQ3E3gSUJLcUZpVH0>
    <xme:ad54aiq7xBPYNBXnVRpvc2J3ikK6X9BQX9MS8vF-_qvv02oI6Bu7ZWKn5PfIC4FU0
    F5e8rHUeKKQBQ8eNcM0rxKUZ2tLqrtQS9_xL4YYXBL-_VfzzvCApw>
X-ME-Received: <xmr:ad54alkiMC9en4UIrne2PVwb8oI31qcqVVdPOMZWsytGV_2PZIQPM0Yd9Qca4YbonZIOTnPVWuYFXVReRCjoAMxGw6Az1ki8rPQ_CDYZtB2xADUyYq4QohU>
X-ME-Proxy-Cause: dmFkZTEP/LelQ0EwybSPCfvWHdaccRMlsXYgA7Sv69s6JpBWYIo4rp5C+5TH+ZteGuixm+
    XpH8a9JNVfKgSq1+v9atvn5e85j9ir4ARALZAYueOFZMMFWLqREeTgLxGOK5R7SQrA+FiE
    LfNDGIoqGMkjl6Jvno+Nu7VUkcCIDj+Ro7QzSKm+gzscRkqf364tzHIu8kzfLpOfvmUl/M
    DcDkwY63OZHVLx26VIFTyFxueHkaLyobJ8c4wuFj8/cxZkpIVaspF0Ps8Towva+SpjPq+n
    MlDzbDYJHhBIyOAZ+UqYJjngFbVyooohUtVCijd19AQUewaxoEJKvdOLF9GdJvSwTRx8hR
    nrhpMHJyAd+Ovvkzb2Zf5UtvXBhLF/dy064Hkmq2mGNW13u15Vy9So4KDz/cS+fa+DA3n5
    sw55sdk26rWhQsj9pzrmZfQpakTkyaoDy+A5YsuDHM73+kOQ/1focy6R8a1amGbc0abCIj
    s4pAbxxRLRchUmxIC6T9mI7inhLNfPJqu2kZjKei+tMFKox6NRZkNtiRjGAtOwIO0PiKW4
    HBFO1Z97rpCsjn5mQslk2CYd4E5VzB8wKCYEcXRefCkEULsLQAJs8bPb3KcQl2lfdGLSH9
    SGidlayjXmCQVbD1WMoEeKTfYoMXDyA9Zs3cmD7X0lNoUwL8iv6AHRyu8klw
X-ME-Proxy: <xmx:ad54arfF5q90vLJg1VI6uGh0KS5UlueKjwmaRg-eUoGzpQQNf_tFEQ>
    <xmx:ad54ahpPOkNYqmre3igtISNP9KlkoQPVVRHH3_mdtkhGKEqS-apnng>
    <xmx:ad54alMG5EPw6-44TTQOwljC-jndvukJIonheZT1st6cx5Ud1r3Wfg>
    <xmx:ad54akgqFQxwVZjvjdp_auSLxoRFLbDOHti0nKCdBKiXPmArO8D2sQ>
    <xmx:ad54anUTnF306V-uQx8RUWTyYPAGTNZzVavjO7UwmzOfcqsWSTobKln_>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:09:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>,
	Brendan Jackman <jackmanb@google.com>
Subject: [PATCH v5 06/11] doc: interpret-trailers: explain key format
Date: Sun,  9 Aug 2026 22:06:30 +0200
Message-ID: <V5_trailer_key_format.b2c@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

A trailer key must consist of ASCII alphanumeric characters and
hyphens *only*. Let’s document it explicitly instead of relying on
readers being conservative and only basing their trailer keys on the
documentation examples.[1]

The previous commit provided us with an appropriate paragraph to
describe the key format.

† 1: Technically they would then miss out on using digits in them since
     all of the example keys just use letters and hyphens

Reported-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • PS: Reported in https://lore.kernel.org/git/CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com/
    • Remove the “paint by numbers” reference after review (unclear)
    • Add apropos footnote
    • Tweak the paragraph about how we now have a context to describe
      this format
    v1: [had a note about code spelunking (isalnum(3))]

 Documentation/git-interpret-trailers.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 109059f11ed..fb503cbe952 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -18,7 +18,8 @@ Add or parse trailer metadata at the end of the otherwise
 free-form part of a commit message, or any other kind of text.
 
 A _trailer_ in its simplest form is a key-value pair with a colon as a
-separator. A _trailer block_ consists of one or more trailers. The
+separator. The _key_ consists of ASCII alphanumeric characters and
+hyphens (`-`). A _trailer block_ consists of one or more trailers. The
 trailer block needs to be preceded by a blank line, where a _blank line_
 is either an empty or a whitespace-only line. For example, in the
 following commit message
-- 
2.54.0.22.g9e26862b904

