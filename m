Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2FF3B9D95
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149118; cv=none; b=Ey0qH1g365McCC47TcwqZi+AjJAaZ459VQZr55RYfUC+czHfKfsY+rWkUFkTnc4fReYKbdWxGz9M0CN607pqthilTb6H9L60QxrMlYxNs6doz7NA40xQ/ATFG9LaLixbozYShptueU+9hhFfKcIkTd+K3jJNsefEgLjMrKC+zOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149118; c=relaxed/simple;
	bh=coaGVj96EwCtN6RFLqrlmmDAzC5xUWYjvORR0qd6Sk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWiifiOKdxHcm/RdclGalIwIbtw+x7mY/rs4235sqOfKZK65DZboicrDdFjuX9zHSFQzbIIA9jCmZmbERh3FXREY4cVwmvk7UJy+cEMQwSR9lSbN4UfN/FEKVCVqytyMOd7armwYAHPofusi0APq1FuiJ8LUl2znFrrQ8hQieQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PFpXGfz/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2CBk9bdE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PFpXGfz/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2CBk9bdE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7AF83EC0B07;
	Tue, 10 Mar 2026 09:25:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 09:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149116;
	 x=1773235516; bh=da5R/jUT6+N6lhyQU3qTHHbc6yfl39HJxEwq24i5eQo=; b=
	PFpXGfz/TAisel50zjYNr3hKzkfT6hWp97mKMsXZArR5YiruAmp9YVEr6mpnEjdT
	zp8shhs1UwmP3RAlvlrpaacPaFyAHBZerHtKm4wI6FTQDstlAY0Bao/71/K7x1Ju
	+/pXvfac2wiUtppMYtFHPsCSIVDeM/oVUJ1R7AKBDFtSvAGZMjMmOmbxau8hktGz
	zjyZdOFyTFxkz3krWBZbqAn7gbVI/gl3UaWZKB7valLPFVTMDk6G5Fp2jrzlQE47
	plmTXACv1KGCzvZVcliA1djK50m0jrSOfnBpSSVZ/pFnjzwaerMa/Dr/Q/cyDZc/
	wtcxUvyR3e5heg18x/71qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149116; x=
	1773235516; bh=da5R/jUT6+N6lhyQU3qTHHbc6yfl39HJxEwq24i5eQo=; b=2
	CBk9bdEoE39WPQzRuubxnzkbEkqu/2LQ0qIAyqTWVEV+DeGjsZYZnOmD+zipVoiD
	hIBaHalFWtN6LW9Su5ur9IQaMRuABLVC42hSKNKRTOPV6/6pITYpNBqH0hE30VI2
	mDGRAIUs7y/2RfhUMEx1csaUX0N8eDS57SokH+BO/eL5zSaHD+2I0MPf8fmedzmT
	qMJQxWxdXuLSIstDE1Af9K6RnopFHC7eLbUJAtFSeDevbV2FuyLmT4sNYc4g/v3c
	djFh1Rhz3Aj41f042cyfsroN4J7HbD5ff/mxVDtLzWJXthOtR8OdrFO1DdpMlWfw
	g24RO8iKch1o1RYOUVKeg==
X-ME-Sender: <xms:vBuwaRkJ6wNkFcfus9-i322_4paOnbYYhhbYiHbBZbtdWDt24Zq5bw>
    <xme:vBuwaTs8eAGEZQWZy5IR5EFiDUPykhepuKiHu6e2-VRaVow9COit8cX2fgmE9YPA2
    nB6DnczxIn2QYv5A0PpVVJtnKdVnF7SiGbDp7VOP6O-c5i1SCXUB2E>
X-ME-Received: <xmr:vBuwaf85xfkWuToMxyTf-ZcCujQc8KNLKS5rwp02xrmFCyb4zlv35lWX8oh9urwj7OxWgoWRWn-fQiI-hyG6XboAaeDdHNLqfepgic8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhlrggsrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:vBuwadP1yak5NIbl3hxpLo5Wa1yzhc-T-anZ1oeFo2hxWHREcBTN1A>
    <xmx:vBuwadH5covim7bziDWB2FCv0MDmJUfGke8T5YjEatVu1263vBDWcA>
    <xmx:vBuwabR9DjvcfM7TTJf55we88czMZpL8eDNRIncRdMmsZH5dugehgQ>
    <xmx:vBuwaauFRHr7cdCay_a92RdegF9ZjRuGCXAoCdg8mFBKFGW2SBmDNQ>
    <xmx:vBuwaftUCHcc151qiEBFPTVpsbvdCQbzmAb982LjE0SMlCy2pmcu4PN_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57ff4f8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:25:00 +0100
Subject: [PATCH v3 04/10] upload-pack: reduce lock contention when writing
 packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-4-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

In our production systems we have recently observed write contention in
git-upload-pack(1). The system in question was consistently streaming
packfiles at a rate of dozens of gigabits per second, but curiously the
system was neither bottlenecked on CPU, memory or IOPS.

We eventually discovered that Git was spending 80% of its time in
`pipe_write()`, out of which almost all of the time was spent in the
`ep_poll_callback` function in the kernel. Quoting the reporter:

  This infrastructure is part of an event notification queue designed to
  allow for multiple producers to emit events, but that concurrency
  safety is guarded by 3 layers of locking. The layer we're hitting
  contention in uses a simple reader/writer lock mode (a.k.a. shared
  versus exclusive mode), where producers need shared-mode (read mode),
  and various other actions use exclusive (write) mode.

The system in question generates workloads where we have hundreds of
git-upload-pack(1) processes active at the same point in time. These
processes end up contending around those locks, and the consequence is
that the Git processes stall.

Now git-upload-pack(1) already has the infrastructure in place to buffer
some of the data it reads from git-pack-objects(1) before actually
sending it out. We only use this infrastructure in very limited ways
though, so we generally end up matching one read(3p) call with one
write(3p) call. Even worse, when the sideband is enabled we end up
matching one read with _two_ writes: one for the pkt-line length, and
one for the packfile data.

Extend our use of the buffering infrastructure so that we soak up bytes
until the buffer is filled up at least 2/3rds of its capacity. The
change is relatively simple to implement as we already know to flush the
buffer in `create_pack_file()` after git-pack-objects(1) has finished.

This significantly reduces the number of write(3p) syscalls we need to
do. Before this change, cloning the Linux repository resulted in around
400,000 write(3p) syscalls. With the buffering in place we only do
around 130,000 syscalls.

Now we could of course go even further and make sure that we always fill
up the whole buffer. But this might cause an increase in read(3p)
syscalls, and some tests show that this only reduces the number of
write(3p) syscalls from 130,000 to 100,000. So overall this doesn't seem
worth it.

Note that the issue could also be fixed by adapting the write buffer
that we use in the downstream git-pack-objects(1) command, and such a
change would have roughly the same result. But the command that
generates the packfile data may not always be git-pack-objects(1) as it
can be changed via "uploadpack.packObjectsHook", so such a fix would
only help in _some_ cases. Regardless of that, we'll also adapt the
write buffer size of git-pack-objects(1) in a subsequent commit.

Helped-by: Matt Smiley <msmiley@gitlab.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 7a165d226d..9f6d6fe48c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -276,6 +276,13 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 		}
 	}
 
+	/*
+	 * Make sure that we buffer some data before sending it to the client.
+	 * This significantly reduces the number of write(3p) syscalls.
+	 */
+	if (readsz && os->used < (sizeof(os->buffer) * 2 / 3))
+		return readsz;
+
 	if (os->used > 1) {
 		send_client_data(1, os->buffer, os->used - 1, use_sideband);
 		os->buffer[0] = os->buffer[os->used - 1];

-- 
2.53.0.880.g73c4285caa.dirty

