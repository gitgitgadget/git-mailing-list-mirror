Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502950;
	b=g4RdCJ+QuryGAzkhPS/YPVch3E0ihdQTaXjdCrlEoTJg65Ro/gEdEhiRlGOwgos0Br2m
	 BAH8mhWLZ6Sew9LGPJBDhlkO51N7vlvOOkdnr3+P79VNKecWwlinESf5/i9Z1W9o+Wkif
	 7JGtNG/qAbjdsAF36PuYtOQuu/dgGJTWcBAfpjIMOH4zIv960u2TaIHoW+Ce4qRp+43Dq
	 LWdm9+8thBAeSPvZJGqZP8+3nnIcI9Tl/VeVFr1qic2m29mGsKVNHjenU3uK7DJ8C8EZc
	 55BEGQMnKzNUJnz0835yNHqLMxom2skF1qPGqxYIKMgRjwUpO7M9tKPwJjVd7L7FG0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7hU2KiZZ+KUK8qDwXMCP2jjBbbj0zDZ3giHmdMCLMlo=;
	b=srPbpAtC5OQr7K1trxubD/v0Kh2jSazz50KrJFcLsCGuwFuEPuIibDs1Tjp+AIYFCoq8
	 IPhGcnNCgZwR99Q1AN/15phXgp5hyEfxL0l1T0V1U47s8PA4U/YYX2GgR+10d+H9O63Wk
	 8iDUcjwgb5lRrhlGLwpTw4F2+5xSXYZCJo8Qn/+8FjinTE4O2XfZ1V8qsBLCFk32FAyoP
	 q/HlvO14yv6tG2jIDfEiEdkSyatikq5RR2PAG3mmcswdYtrVD9+Vw+KcBTldPkH44ScOQ
	 SnXgSnKSv1v3aD+daTmq/7FbMCukT7l52dFSOsJoivZTXDH37RMA6lkCV4sZ2dWUJBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dLu0Z8On;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B59606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B59606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dLu0Z8On
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aa9606ddadso2359062eaf.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502949; x=1793107749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hU2KiZZ+KUK8qDwXMCP2jjBbbj0zDZ3giHmdMCLMlo=;
        b=dLu0Z8OnDHAEElqRKy1udX1qIeqBb0BJE+cQV5Mo4hQfLTSgo3C/43MYE02Lc0EcXa
         pq3P80eit1mAEwj/tFae58rHMM70JPFFSxQXTpFLp9uxTqRWnisxmklsNGfwOjgtQXV/
         rNM901WIh0ow1pVsZfnIziHGycBYuQLDFSbNWWwl6sITMNmbGeP8iKlc+xhtqJ8iVTwc
         41w4iEiRgCeTL/5QbIaVQg9Hp/gp2lV+cpjXLC+AGt44br+1nuMC+gR/jwVlgO03foZ0
         my9j1iOQgZJIMZdz8SUew+XejUIjuyowc1J84Ay4vqdomiyvr6Zh7B2hiA0RLDf/tddK
         jccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502949; x=1793107749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hU2KiZZ+KUK8qDwXMCP2jjBbbj0zDZ3giHmdMCLMlo=;
        b=tokgNsLHS8l5GDuvnKnQEV9q80U2RL50b2DPRltdkdN5c1JNMY2cfNk5NgwKt6ACil
         oRlnnIN9vXNbI10xH0T/rTkKfTaYGBs/hwQ/CnIK/4Byv8ml7+7LnPYVayHGgu8EvBfd
         5zoisViT2mqF1Q8R/CoNFyu5pYtL5Etq5PhLzJeI3K9DY1aMvRZ/cvGfaxpD0bc6T1eF
         RRoyBK/8fr44kdxD6GVFg2xoxpOHNKs/aYD5Op7x/2Onnc92xT2etkhNRrHUwWZw3KVn
         M0Yu5zVeVzLf++ELPjhJv82WHsOpERKjzFecV3qDT/Cw07sAiH2bhrGQpRxvUf/PUKvI
         +tWg==
X-Gm-Message-State: AFq9FYI/JYjkOR6o+TRyqCzMehcOJ8zt/RASoeKhZlk4yOx1gaeFfD/y
	aLJ6+tf+psz3eIkhP2m2NsLBJyiT/mK0hpMUJ8CsGBJ+lUyqv23DRaVDabtFsA==
X-Gm-Gg: AYBFou2KShSW9hUGhu2xwMxwghkDMyQqeniU9oXo9SERo93Mu2DjLP1RxBfPWvsUNcS
	69eD8EnM2hiYyta2MQgDljzzLgbPhf1EZPTOy4G9NqSWLkP6qP3ovZ5tAeVQPDh5LKkreBxNn8l
	svdjmntPYSZzPgPGrqGLFH8o8GaY0XPcLsSR0Kselsnd27nHT3e4b/KddEcYFhlk1sxi/dhIwi5
	SNC8BoHo3enMRRVhkAsIo25eTrFd5nOJbLweADZt3JWyEFBhGeTEKk8prKb4C7a7FNWGCdbupoG
	y4q5YIlDbVWHSCspboifDkHxb7lJ7FhWTvlfGEfKOvxo8QezhKQAFX/dK1qtSG7TL/CKfgKxLvG
	oMzRQ+O1UysBEfnkAH6Vdcv7MWInUrxHcVJQP+PV1H2HH06RMUTxEn1JZT8345aMJa1pw6kQY4N
	VV85xC76CoKn8dMn0sLt2dSVsi/jIIpa1A2B3fj/rLNhLJiF2VjtLPzC6r61VX2d7rnXMNpAlNa
	DuEv6Vxz8yQc7csnmGVAxRMXBxY0w+OepQhTCjpE2WHukSc
X-Received: by 2002:a05:6820:2917:b0:702:dd8d:3176 with SMTP id 006d021491bc7-7035258a3ccmr8019076eaf.2.1792502948978;
        Tue, 20 Oct 2026 06:29:08 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018f2e0d89sm9973129eaf.6.2026.10.20.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:29:08 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/4] object-file: fix ".keep" lockfile ownership in ODB transactions
Date: Tue, 20 Oct 2026 08:28:56 -0500
Message-ID: <20261020132900.1208343-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261016213716.593278-1-jltobler@gmail.com>
References: <20261016213716.593278-1-jltobler@gmail.com>
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

Greetings,

This series addresses a bug report[1] regarding a git-receive-pack(1)
process deleting ".keep" lockfiles of with the same name but from
another concurrent git-receive-pack(1) process receiving an identical
packfile. Deleting the ".keep" lockfile for another process leaves its
newly written packfile vulnerable to deletion by another concurrent
housekeeping process.

The root of the problem here is that the temporary ".keep" lockfiles are
generated and registered in the object quarantine prior to being written
in the primary ODB. This means that even if the ODB transaction never
commits and exits early, the tempfile atexit(3) handler still runs and
tries to delete the lockfile at its expected final location. This
blindly deletes any file matching regardless of whether is was created
by the process.

The first three patches are some preparatory changes so that
`odb_transaction_files_write_pack()` is able to start explicitly
creating the lockfiles without relying on git-index-pack(1). Patch four
migrates lockfile generation to happen during ODB transaction commit to
ensure the lockfile is actually able to be written before registering it
as a tempfile.

Changes since V2:
  - In `write_pack_lockfile()` the error is now explicitly assigned to
    `ret`.
  - Removed an added newline that was not needed.

Changes since V1:
  - Split out comment change into separate commit as suggested.
  - Improved error handling and logic flow in a couple of functions.
  - Renamed `write_pack_lock()` to `write_pack_lockfile()`.
  - Added better error messages and errno reporting to
    `write_pack_lockfile()` helper.
  - Adapted tests case to assert that packfile is not migrated.
  - Clarified some commit messages and fixed some typos.

Thanks,
-Justin

[1]: <932e8e425aecfbd33c1e5caf66c80a0226abacba.1789385483.git.gitgitgadget@gmail.com>

Justin Tobler (4):
  pack-write: make index-pack output comment hash agnostic
  pack-write: lift and expose index-pack report parsing
  object-file: explicitly write ".keep" lockfile
  object-file: write ".keep" lockfiles during transaction commit

 object-file.c              | 126 +++++++++++++++++++++++++++++--------
 pack-write.c               |  64 ++++++++++++++-----
 pack.h                     |  10 +++
 t/t5547-push-quarantine.sh |  30 ++++++++-
 4 files changed, 183 insertions(+), 47 deletions(-)

Range-diff against v2:
1:  b9197cbf3b = 1:  b9197cbf3b pack-write: make index-pack output comment hash agnostic
2:  e27679ac16 = 2:  e27679ac16 pack-write: lift and expose index-pack report parsing
3:  9236493740 ! 3:  e7f72aa53d object-file: explicitly write ".keep" lockfile
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +{
     +	struct strbuf lock_path = STRBUF_INIT;
     +	struct strbuf contents = STRBUF_INIT;
    -+	int ret = -1;
    ++	int ret = 0;
     +	int fd;
     +
     +	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +	fd = safe_create_file_with_leading_directories(source->odb->repo,
     +						       lock_path.buf);
     +	if (fd < 0) {
    -+		error_errno(_("unable to create '%s'"), lock_path.buf);
    ++		ret = error_errno(_("unable to create '%s'"), lock_path.buf);
     +		goto out;
     +	}
     +
     +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
    -+		error_errno(_("unable to write '%s'"), lock_path.buf);
    ++		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
     +		close(fd);
     +		unlink(lock_path.buf);
     +		goto out;
     +	}
     +
     +	if (close(fd) < 0) {
    -+		error_errno(_("unable to close '%s'"), lock_path.buf);
    ++		ret = error_errno(_("unable to close '%s'"), lock_path.buf);
     +		unlink(lock_path.buf);
     +		goto out;
     +	}
     +
    -+	ret = 0;
    -+
     +out:
     +	strbuf_release(&lock_path);
     +	strbuf_release(&contents);
    @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transactio
      			strbuf_addstr(err_msg, "index-pack abnormal exit");
     -			return -1;
     +			goto out;
    -+		}
    -+
    + 		}
    + 
     +		if (ret) {
     +			strbuf_addstr(err_msg, "index-pack failed to report pack name");
     +			goto out;
    - 		}
    - 
    ++		}
    ++
     +		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
     +			    (uintmax_t)getpid(), hostname);
     +
    @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transactio
     +
      		odb_source_prepare(transaction->quarantine,
      				   ODB_PREPARE_FLUSH_CACHES);
    -+
      	}
      
     -	return 0;
4:  c1a175e2b9 ! 4:  046ff4741e object-file: write ".keep" lockfiles during transaction commit
    @@ object-file.c: static int write_pack_lockfile(struct odb_source *source, const c
      	}
      
     +	*out = register_tempfile(lock_path.buf);
    - 	ret = 0;
    - 
    ++
      out:
    + 	strbuf_release(&lock_path);
    + 	strbuf_release(&contents);
     @@ object-file.c: static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
      	return ret;
      }
    @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transactio
      
      		odb_source_prepare(transaction->quarantine,
      				   ODB_PREPARE_FLUSH_CACHES);
    --
    - 	}
    - 
    +@@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transaction *base,
      	ret = 0;
      
      out:

base-commit: f57c9a73884400380bddd172acc88b569834f909
-- 
2.56.0.173.gf57c9a7388

