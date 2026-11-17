Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911886;
	b=TrCRkKwM0eEcXJvRCYjJppkm23HAQ19n+hzZXObP6Ka2OAx1Ox7hmSHiBnzM2i6U4Xbr
	 FtM1Efp8uilVINGK9ThlTENrslh1NIVgEWGEUWTXnN9kr7OhnjNgedVhAPWCTTwXxvAbs
	 RELnc2ewmvh5HZNuImv9zEZZ1n9GABCB0AUgOoGarUEHKxxyD2lBKhjjbJG2I3pUO0+dk
	 2PBV0qpJRAdbqdCRE+7G6jXAy+hAzCIXE7hC9Po8tJGx5IryT/Q4f8SUFMVKYfpLWQJYL
	 C0ll2tKC4qVvVD+4TfMNQOFb1F1hid+ecQNFw1KMPcDFcLkSw4hXQ4Kkcy5KeeBkoPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dKrpCbQlg9048e0tn+Ci19OTMv+/9H1v9FqHqUqS9uw=;
	b=OImeApRxwKIzuWWzvm4AYZad/ZEQCy163aJrFHrC+PB7Mj7sOJwhIaKIXo0jKYN8Ileb
	 5xwG3yM6H77+jON6SRgeXD2WaHNQnBBKBR73DTnkiBXz4+uIqOg3nNppWVFC5BIJHLH0g
	 ygZPwascylVtb2Z3zZSjC6t5jO75mUwMip49QXkvnZAX60Eqc8GOotNY94TH6+Xsi7AEb
	 KVli4kWtq9kgorexBSQRc6+K4rxNwC6AYFjxfuzGdBesZ9HRsoYGW+eq8NfI9FkudKBgd
	 SrWQSzLn6/piNdV3hcWqK0boxFsqTukvhPtK8shHNgxfkxsYn8Wu5faIJ+Zi36VKDaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Byl6cp78;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9307606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9307606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Byl6cp78
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so144623f8f.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 02:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794911884; x=1795516684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dKrpCbQlg9048e0tn+Ci19OTMv+/9H1v9FqHqUqS9uw=;
        b=Byl6cp785zXTvn/C4FGDylfli8SpQLNf2z2vRe4yi+aYGVmBki6bcXu694YE1fCoLy
         wBik7RyQGOzkSD7e1vIDCyi6a0V/HNmQ0iqsAjybmioA9m9+/gH5xm9+DuABrtAd/d/Y
         y625PfeZbzUY0U3Tf/2UN6XM7Ekxrtfqpo2Iat0UPUxnQpaVkq4khxdpxxcHl+dbqG/1
         rOPJSiGZlrRR/K210MvNF1ipogS1gDTkMYlyIH5JikAMtuKZYizdgRfSu3EZEgtr3Z03
         ytglv2nL9vzgN+6+GDaiboZEkg8JsbImLUsYtjh+kScDAqqofXAC0cQqh9UXNz5Ne99B
         Jyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794911884; x=1795516684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKrpCbQlg9048e0tn+Ci19OTMv+/9H1v9FqHqUqS9uw=;
        b=pUSHzFJSOgJWFtA9uuF6AZzrLS7YwLvnSmeTMcCKw+cTSV8KINkWMy3CcXn1K6dvZo
         sT9j/niW/zkmzgE9HYndR0iQwQ+w22LPL7NRmOnhlzFpdU3rLWd/OmEVSio2fCIDHG1Q
         WA6wxWB14lq1fRqoQUJzHfweFXA1upaFeBtmX0ET/ZYCQC4y8kjIl9iDkBO9vRLqW2tp
         P8wbMgiN9TW2jhnHVuyffC8TkR0a04nVLXbCw6RMJwe+3SMfrG7fcI4SgJ6NJMOAlL11
         uDriM70jR4m7smX6S3dhx/dCFvEPVFKUArvVzy4m6Pm3rUuWYrqY4XixfRxbc/8j5oBo
         HOEg==
X-Gm-Message-State: APuU4Z+1xjRFcN//UZCAVvvMIr4J24Twv8gFINJxLtHFXsPuFbLZOmk/
	ARN7dIp6A8HyPaDK0Gql7Atc0A9F1qfdBBuKBNMrNYfEEC9yOvSaYNYUYLzIjg==
X-Gm-Gg: AZFdTZcPSCoYbP0ebicNPlkZyUUy+Kj/BDH5S2OkLSrMGpDNMy0CMvrzoqTXwIhE360
	zkZanAtulHkvniv6rmNk5h/TJkz5Fiy9XU+tga/qbHG8fdgHQ456eg1Z33BCy9Dq2p9Wxo1srv+
	BYR2VUzsqQTs78koCv+leQEmXEh2wKo11nU+qyZQrd9wxDz7VmWWQ2y1svXr3XZDrcUD8o8kruJ
	IYa6OVz+L+tf3aRVbNRPI8K0+k5Pi9//0IKtEJKmP9/hlinG3HtoczgrFKgnF2ELYQpPgU490tP
	U9Qoz9HdxofCoYXF1s++Rj8gF6ZxyzEO7YxkLmehQA4nzDNOch9flOsfu1w9YJGAGueiJr7k8wT
	AfPTSChrPukag7X7lQ6+21s/tPCviX2LLItafF18qM/fd/9bNFAUFl0aGJnQl1fcTQ9slfC0QK7
	XJfmU5UqdxAtskNFUehIdbtEdmhcktdc6sviLBOatFoE7pHAbiEh98q1xtvd0HOwlh/cj02x+VE
	PTavcslogIZP3cMuR3Vs6pvZvhZtTQIvpqkFgryFMtFyUdgEKM2ioM6USxUASJkihreMiBedlmg
	RvZpgyD0FT/KTJcnAOkWut7Gr2Z9g0fgD6CNxy1kxQD/rOtMpkEsoDNgwsd/96Y=
X-Received: by 2002:a05:6000:2212:b0:493:f271:b622 with SMTP id ffacd0b85a97d-4a3783223aamr4830265f8f.31.1794911884219;
        Tue, 17 Nov 2026 02:38:04 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm44715932f8f.44.2026.11.17.02.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:38:03 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Neeraj Singh <neerajsi@microsoft.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/4] csum-file: use size_t for the count passed to hashwrite()
Date: Tue, 17 Nov 2026 11:37:53 +0100
Message-ID: <07baad46b153b255b6e70f2597f1bf41b9c48dfd.1794909894.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794909894.git.gitter.spiros@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com> <cover.1794909894.git.gitter.spiros@gmail.com>
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

hashwrite() takes the byte count as "uint32_t" on all platforms. When
pack-objects writes the entire compressed buffer of an object in a
single call, which can exceed 4GiB if the object is in memory, poorly
compressible and core.bigFileThreshold is raised accordingly, it writes
only "count mod 2^32" bytes, corrupting the pack.

This was verified using a 16-bit simulation, where "git cat-file" and
"git fsck" failed after "git repack -a -d" with "offset beyond end of
packfile (truncated pack?)".

Make the count parameter of hashwrite() a "size_t". The internal loop
already handles writing in buffer-sized blocks.

Triggering this requires processing an object of 4GiB or more, so no
test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 csum-file.c | 2 +-
 csum-file.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index fe18ee1de3..26aa662637 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -102,7 +102,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	return fd;
 }
 
-void hashwrite(struct hashfile *f, const void *buf, uint32_t count)
+void hashwrite(struct hashfile *f, const void *buf, size_t count)
 {
 	while (count) {
 		unsigned left = f->buffer_len - f->offset;
diff --git a/csum-file.h b/csum-file.h
index 6ed74d1637..f1c8a9df13 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -75,7 +75,7 @@ void free_hashfile(struct hashfile *f);
  * Finalize the hashfile by flushing data to disk and free'ing it.
  */
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
-void hashwrite(struct hashfile *, const void *, uint32_t);
+void hashwrite(struct hashfile *, const void *, size_t);
 void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
-- 
2.53.0

