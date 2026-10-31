Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446788;
	b=0hTWqccu/63vvUeuy+UEPV/6kAuk/J8+5YB1KQ4T/C5BAuvJbfV4sJ+5TMXvrfV562RL
	 kf2EIRaKuYNCHJTk5eJQPHi1rdFhnXgom884SfJEZ8asIlbwdP5WyXgvIS0YIwnbmGo6U
	 UEY9ltpH4FFvltf0RD5JzgzR+toXsJvNapM8HMjOabAUxLGPMUZYqePlJGUTUXVpd0RBF
	 wlsvJt+onGa1mLlU8jiNOsnEuQdA008+qiET22jCl92wd7eCzwFRI2kEuurcMEXU75LSW
	 Qs2cEogxFvHzwYTt5JprokFhq8rS4igHbjyiA4o6OIFYiDhNLxo7VDrm5S6dLH8R5NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0E3fCx9XCR8vCrn+9DeLShjIsItyc0sFuK5XQADgWpE=;
	b=XPUAUW3tNhwnZ5mDQH0chOpFOzYyNq4PX6YGgQOzrawxc8QWTc4oLtBXTmRja/zJtQIh
	 aOvlD2c5ZBV9VsiJMG+8cSQml3aV4mrBpq5/jRV8WbV2uL4IxAFTp2rv4OcwmdZjWn70u
	 f9vsfpS1G/iaFdv8iORzqjG9hBn/JcNfdzUTy/Uu/xagatAsgZT9zxAYMwOiSO085yj7A
	 tpEdnfrfTgzGHr1bldSf/ft19ATPdRoNWuIAeqiKrTGDK+xSKKrROPdTmnhRg+OEruPIn
	 ze3eT4Wp1bQjuoHM2T68CbAt2/NbHRor9KiLUwN6RwDXMuhXz5qp9iUEH2/WO6VNuxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oLjL+lgj;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE3606A32F
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBDE3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oLjL+lgj
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso11633375e9.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793446786; x=1794051586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0E3fCx9XCR8vCrn+9DeLShjIsItyc0sFuK5XQADgWpE=;
        b=oLjL+lgjMAHQ1L6Egon5UOhVNQfa0yaJ9WmkIiuLyTQbH7He7HksUG9r+4MH+CSemm
         IqbC/jRr9YQIsYgK+jTFfl3yE1EMB27clXXQPtS9J5jZnThadpsB/SJzGVQRyfekwL6i
         AZTmeeFn39NiRb3KtKBkidnKMhKZhXIdBgqEjkFNaSsy6fJHlpk5ajEax+wh9PTgnW+q
         0VuhvNCbSWuMkUt+dV/x7QpJsmXACDKolSpT0hN68bIk8YZ3XgqDgEO6QJ3NcW8nIHG7
         wg8AyiqWXCSjDTfgeAwgr7YkXfQeai7jlSOXYVoC13ZVNJaD2b2FG47I+EQdj7ApJKXm
         iL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793446786; x=1794051586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0E3fCx9XCR8vCrn+9DeLShjIsItyc0sFuK5XQADgWpE=;
        b=oC3BpxH2sL/lpwQ6kK6hBnCLlcgphjRw2UY7UW47GMKG0ATuErcq3O75dZGqXFUqfC
         ufA0lae1ISpHOfvAXVomLZBsW6fLBWk2Gie8oHUyLEFWaWWF5bGC4NEYHMbo/5fc2iiV
         /yeg4qawLaF/jHD57+SJ5dg66C6uPhlac5rXLUKn9kGxnjiyTJxcFw8W09is2sqkHvdx
         wNM787k0ZV25JvrssFIj7mBewHPsdSeK5Rugtx+qTp+NuxYQxWECx98bTFBp4FPSgoHT
         1xNdz32SLU1ztatsDZ5EL71L6aDBJL2LhRAAWWgV2nCYO1lUxEqxClBorlOD85uOKuwa
         9ieQ==
X-Gm-Message-State: AFq9FYIGErxkQcDhDL8Ba1oUFNQyP4A4u2/oiptfwG7dt0a2GcJN/Cg5
	NRZ84qCN2LDBzZWuh9JzhHOn3lDkM3e3jHWZDDopNHfMema5KIeG/dcdJ1+Kb1Bh
X-Gm-Gg: AYBFou3mKBnJh3iw6KumFuAlLMmI7obKxHoB78IV0YHxPHVrpd3m1kJ9c0WEiiV8TD5
	xRIc8o9I/oAcux47ybjTLVENI+oMIgGK09tR8sMI/i5HkwlsFz9G30iveOICm+RduGVbP7famZa
	kBbp/wfCrLba3KxC6WAW0BFPL1i6qL+n+plMZ030Q+A0Cgt9JBlRvDGf8uN/yjFDDUWKYiJ1dqE
	PX0Zl6AaRBemBF/7Mlab/4XM+Foqi3Qv5OpHfI0VxVYaS3q9UqrZsz7246nv3vqFtu9aQsmw3+j
	i6+dlCrUI3jR8zmYpnNbOv/1/L7NzmcpKsH2P+9dkFN2Lc8VzLZBjFJPpUfGXUZRM31u9Zvs60F
	IvkvQf+y78vQo14m/l2cHy+ZjkhcnFGDLx3kvifmbVnH+IcJube0hTVi9+Jd0e7qjDc8F94/OaP
	V+AGcwQTtmW0WjnjEv4FZTQLC3Yy/Am8YkoyHQ8L+coIDCEdDZElZKKD/qM361UR9CAm5naHXL7
	7jWkrVDlkQtx07MHuVc9tpNSlOG3D3kSqnVUxoxwWSp0wRAbZMayO9ba6ZkLClbsJV/fe8mg566
	9JpIL+6Yejr1ZW4dOsG7fPxnIylPiatc61AKxRh4N9DH+kMaoZNcHtBlQ1w12qE=
X-Received: by 2002:a05:600c:a4e:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4ac183d1edamr112082675e9.26.1793446785927;
        Sat, 31 Oct 2026 04:39:45 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm8345366f8f.23.2026.10.31.04.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:39:45 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] index-pack: use size_t in write_compressed()
Date: Sat, 31 Oct 2026 12:39:36 +0100
Message-ID: <438f7c6ba2ed76a782b8af6f5bc1edab1f3fb73f.1793446357.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793446357.git.gitter.spiros@gmail.com>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
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

write_compressed() in builtin/index-pack.c takes the object size as an
"unsigned int" and returns an "int", which are 32 bits wide on all
platforms. It is used by append_obj_to_pack() when resolving thin packs
with --fix-thin.

With a local base of 4GiB or more, write_compressed() compresses only
the first "size mod 2^32" bytes, while the pack header written by
append_obj_to_pack() records the full size. Later, when resolving deltas
against that base, unpack_data() encounters an early end of stream and
dies with "serious inflate inconsistency". Shrinking the parameter to 16
bits and using a 100KiB base makes "git index-pack --fix-thin" die the
same way.

Use size_t for both the size parameter and the return value.

Triggering this requires processing a local base of 4GiB or more, so
no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0264c18c5f..f65228468b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1411,7 +1411,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		    nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas);
 }
 
-static int write_compressed(struct hashfile *f, void *in, unsigned int size)
+static size_t write_compressed(struct hashfile *f, void *in, size_t size)
 {
 	git_zstream stream;
 	int status;
-- 
2.53.0

