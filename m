Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341002;
	b=EYPgHDHh9ua//87RE14jb/iSO/mRshJ3Bi4fnOR+sWnxN2pAHBqoBMQj6uUCLKRpN8SZ
	 TAY06Pn0368qMG7WBQDoVJvWgZJd+VgN5sfOuXdp80seKC1S69xbigmMkNgtQU0kte84U
	 jRCOBHmVvYJHOrLKH+OXlnVfIf39wE5/jZFR+5dyw2K/GVzXp2X5D0vrCXhWV/cw/Iw2r
	 KpjcGZzuxxQDCn85U2X4A9UmxuGZfz94o2UYLDSZ2bksnYcVNqVBOCWdoDzFcpOHiQJkL
	 8sg0dwPbYejAZZLFOWfczVDaeimqkncNAFNuYYVdWx7eyolzTgjAn7eb/s7AGAEkFKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Y1wg+ylM7N8dc5S1wUmNR0bS8Ss14y95Rcv7/AdVz9A=;
	b=qYXkzpuOaQRvqCn+FA0+M9gIgEJlLqA6N6g8ZNGtYbPb2lLKB95RuWf3FZEqLv1TgxhB
	 HGF/qVgaeezLz9SJnzj8cLcLq28GJzb7mRdeC87U+vfj2t2JSODQ+HaPIoot+v+MRyaFx
	 be1Uirq/PHUSY3JyEwgzT3lQPdnBWLtLdf2QjOuOkCxuA1ZWjT4fMbHa61kbwlHWvynV/
	 Fandtp2n/Cp8GXXY1o/LbhoYty+DPpTMAsDQiWyw++F4iAzZgxmCbK9+fzSA9nsLJTWH4
	 rei+PstE82KQVtF0I683Q+pBpddW71X2A7pSc+JXXXRmkiKRUA2zl5rD9xtz/+nAC1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nortesoftware.dev;
	spf=pass smtp.mailfrom=nortesoftware.dev;
	dkim=pass header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=c+TkWmIN;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE69F606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE69F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=c+TkWmIN
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-705cb6cedd5so1056197eaf.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1793341000; x=1793945800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y1wg+ylM7N8dc5S1wUmNR0bS8Ss14y95Rcv7/AdVz9A=;
        b=c+TkWmINTDqUH9eJ+8442Ry+6wdzYUqxqUXg5mw+YTb91smfU2yli4LZE1Ytwbxmp+
         d9OKOxqkK9yLcg0N0dChTQpUqwXwfAN8DGp1cGR552N5hXSX5+i5zQshAyJOlpGhu045
         1oYqiGnVljo39+945HslsyL5coT1/LjzzOtKDwjiPsibmFr/aNGn4gDqu/gGccyCqNW0
         cRBVTcaQTUMzRFtvO6EiOEvS3pzl43VMrcnqHMTi8sxt8CbVqMtone5BJq/GsQ6NdwII
         UW9Y6AeWDhv5tZvjcecyDzHPy2CqQLvzgf4rAvsHwaW2Te7NdQQq1RW2Pm1vwm0upC7E
         UB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341000; x=1793945800;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1wg+ylM7N8dc5S1wUmNR0bS8Ss14y95Rcv7/AdVz9A=;
        b=o1gpwOH7tUcBGi2dwl5/dfJwIb2gtucf268XvWGrUts2WzNHsIGfchJEO4obIXW3Dp
         s7sh5DWC4O3PVJixrY/TSy6G9MFzhEn+HVZUsEklnTry4Cl3TkgBxiWB2u2/iiirFQ4C
         WsZJYaGX6Fr90Kzh47zNsdIDjJE4wEHnOFGB6rFVFMXsDF5W9l5tz6466gzbIY1hjaLl
         SrQNV4g1HjB8zTo7ToCAWBh0gkvwXo1bKm4ISudaQOmRufVP4g2AxBrHHfWZDbAXSL2N
         CzW6vsLXkn3ejJgPpa2Rvo5HRmp5CHPkF0qCUHXv16eJglQ30VDZrFNwcEc6jYl7uDj/
         4ghg==
X-Gm-Message-State: AFq9FYJC8UgwS8Wzss1Kfak1i5LzoWEAl+w3lGD5iV2KmkTotbPcySjI
	KnsA0B/9sB83swMXyYoxLMFRuJpK+ZJYCetPUGxin++jl5Cj31Zpcd7jJ1LT1vXz5Kg7SwL2Aof
	bQgzYrA==
X-Gm-Gg: AYBFou3g3xrDsoRLrikMq/hxw0oof6R/IC7Bi0H3y5Nh+/EWn+gKQ68da9+xTtG7vjO
	5hHEHLvYjY9oM+ZTfw1NoEs9eR7qDLCPbidCsoQOEODI7K9jGEmMbqOM244Or+Wacr7pUTJbQWK
	JmuLbwrvSxJk+acu/l6BmQYhPvDaihJJ2lbezfRLtEvKdLzpqQVyJracFa+b2wYjoyPmqhOErf4
	ItEsHeLyT9FUEHQ2VkleWG/ANug/YgMlHR/vVFQyTDFsGdA/g/2KVPGWZshPpxPjY2BwH9JNVMY
	Y0qPCCEs0E8nt5O+QzBge7lHxG3lu4gCdhKC7k5dqWc6HLg2nl/45jOMGkGbpdFlFcBxqZA3Lda
	YzPe5Yn2T8SalcSvBUJZrBkNUVJ9WWo3AIVX4ngf7q0scgo8H40bko3UMDI5Tv44/WWRw1Wsm7t
	uARKU362PpiX3w+n64SgwcOah+a361wGoTcBCjoeNAbYzlLcUgJoIzQtL7i9d0nShNZ614UWtxn
	4PzzGJSbzbxblSeg3L8fNtL2dS4lgMCth9ezsQ7oSIyZa3O/dTtT7QEBcD6Gx1dk63ofHv31Oy6
	ck7kEqVPkTaFfqlY2xsQs6nJcdOc42+bJWvanIgnvU+AFT66BwflW/nMvIJRBiokB3LGrlonpmI
	0mdbzZars1+LGrWAKF4aKj1tKG4NvbdamRT/8
X-Received: by 2002:a05:6820:f004:b0:6f9:59ee:cf96 with SMTP id 006d021491bc7-714f2942a06mr688950eaf.15.1793341000456;
        Thu, 29 Oct 2026 23:16:40 -0700 (PDT)
Received: from nortesoftware.dev ([189.129.139.54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2d16ef5sm1239848eaf.7.2026.10.29.23.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 23:16:39 -0700 (PDT)
From: =?UTF-8?q?Christian=20No=C3=A9=20Ramos=20L=C3=B3pez?= <chris@nortesoftware.dev>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] doc: gpg: say which date SSH key lifetimes are checked against
Date: Fri, 30 Oct 2026 02:15:28 -0400
Message-ID: <20261030061528.27901-1-chris@nortesoftware.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021030347.565306-1-chris@nortesoftware.dev>
References: <20261021030347.565306-1-chris@nortesoftware.dev>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The description of gpg.ssh.allowedSignersFile says that Git marks a
signature as valid if the signing key was valid at the time of the
signature's creation. An SSH signature does not record when it was
made, though. When verifying a commit or a tag, Git passes the
committer or tagger date to ssh-keygen with -Overify-time, and the
valid-after and valid-before options of a key are checked against
that date.

Say which date is used, and that the signer chooses it. While at it,
fix the spelling of "OpenSSH" in the same paragraph.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Christian Noé Ramos López <chris@nortesoftware.dev>
---
Changes since v2: Patrick's wording, which also says that the signer
chooses the timestamp.

 Documentation/config/gpg.adoc | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/gpg.adoc b/Documentation/config/gpg.adoc
index 240e46c05..d3713e960 100644
--- a/Documentation/config/gpg.adoc
+++ b/Documentation/config/gpg.adoc
@@ -70,10 +70,12 @@ A repository that only allows signed commits can store the file
 in the repository itself using a path relative to the top-level of the working tree.
 This way only committers with an already valid key can add or change keys in the keyring.
 +
-Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
-valid-before options. Git will mark signatures as valid if the signing key was
-valid at the time of the signature's creation. This allows users to change a
-signing key without invalidating all previously made signatures.
+Since OpenSSH 8.8 this file allows specifying a key lifetime using valid-after &
+valid-before options. Git validates the signature by checking the committer or
+tagger timestamp is within the validity time range. This does not provide any
+security guarantees as the timestamp can be chosen arbitrarily by the signer.
+But it allows users to change a signing key without invalidating all previously
+made signatures.
 +
 Using a SSH CA key with the cert-authority option
 (see ssh-keygen(1) "CERTIFICATES") is also valid.

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.47.3

