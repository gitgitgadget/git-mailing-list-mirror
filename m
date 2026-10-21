Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607136;
	b=AteuItnzx6Agrpdx7Fbd5yzZlghasFE/CoKsqzInmu/ud4cIOMbC3+1XkiNGrqBvYbUe
	 CoZXaE/x1ciBLTiSOcWvRf+MsnDpUaahkz4NO+5OdaFgnTZPpKaJBYZ476+feyK1Ch+sp
	 +8xEXm1bnojyGIWtCKkKfdcKGO8GVKfLt+Dxg+N3uNdeabF1SqisWVbWMWn1SMpt2sWBh
	 duxxtmZy5FUmfG3jrT6m3TihnKYdJ01nnACV2j/EqzXK9kaz4ntY6bwklWK42LGEaoBVC
	 YwfLjDEZtc9PQfknOKzxHrfIJDXGjkxr0RnRxYpdr+sRMYROifNvfrw/sVserc6dASg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5pPyYDqKMTClFcLbFDbSVWwjT7PcSEtPzWAd1UF8Kik=;
	b=AwFSDg6aBtNbfROnvI8ypWA8KuSpmDjPNtn77DPq2Qfx2aBUZe1Gwa6DR8yjgT04xsz9
	 7Ct0UlMqS/T1ikK7jz3ExBKO1RpiXx/q5b0+MX05X3NrVxOliUpQp++rPSNFFykJyuwO0
	 KBpEM4NTEPOPEOt0/ORTanj4oCphHnmVk+/NsrJJb91SXuoXCPqfRN/4OpLPeFsJlOtav
	 8PYSsNDILUfeOhLwF9nzkssMP0uDu6B2NEmGyweEd/N/6n0GggdzIQrFwa9eydJSbpUwv
	 UcCMOatHeXtxlNCcTjZOLhE55c1iGxj6gQoP+dU9Ngb9VNKiq75yfxcKIgevWz1sM/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WnfvI5yE;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E7606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 630E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WnfvI5yE
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843cf077f10so1139527a34.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607135; x=1793211935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pPyYDqKMTClFcLbFDbSVWwjT7PcSEtPzWAd1UF8Kik=;
        b=WnfvI5yEn3hsRxUUDmEMCVasP6NmSwLHloQml48++j9LU9dFgnhzHGneu2Wqmh7s91
         9UFgRSFkdxnvHwrlr3upKwidfRyHdZH0zp3w4EF+xk22RkmhLi7jnIyf05OalyDrNi4+
         ARVd5Ae+WuAgxbnsV6vsqEkzadVd5uaicfA8msJ3qk9eOdsD3ypqu3HZt97j9Dz8N0Ed
         iC0CyxBeZ3FNssy/8koz2AbO5Eh7QUwMZGnyDqD6bCcr9tQmUcsZbf6rdvRoEq4iFihM
         ccC3MIeTmdiEdDgr/Q9kFGnqJF7acn8H8u1FmMVPkJref/2EGJ3DmKUL5We6SEN0mFND
         AaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607135; x=1793211935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5pPyYDqKMTClFcLbFDbSVWwjT7PcSEtPzWAd1UF8Kik=;
        b=tvPExP90SJw+0Y2zK5ir2VP2EbgS92DIl0c7mN1HgFWBfD4QWAKvns4efUttCPZ3Gq
         Ne1pW6Gj5T7d+cjJo96gM64xUYmqeXvPkjnL0mXKcbrOuQsUaqZgEvSWTjou67/u70I8
         QWH5pRWzJTwW6UCD+3LkWGoy+lSTVwnqQpVpXumR1EGl2plOrqs3Rbt73OMWvd5SaANQ
         qOcQneS+fAckBc1fzQMSYQQNPUfP7Ojr0AJyRBM0sRRjzJ7m5jzL+htZRQod5nEzXZQ6
         u2jENAhvkzSOMi/+5w4qiREz2t0/2ARL53RieLlH2x2Xid0ziz/MsRdoW/V2efuBPu70
         wbJA==
X-Gm-Message-State: AFq9FYJKBZrS+Z5Y5Wuwp8KWPja9hvXbH51SS+jBNo8eiLiCE/J8dnOt
	GkajagNSpt1KN3fdYXp+RRD+V6xSnbXfSK2r+WUTAnI89OAP8UGpEl1cm5mqOA==
X-Gm-Gg: AYBFou0T3+lbkuKw2faTQmC/rCRVFw2b2DxrMguVjm2NyvMhdufmWmxizAeCnjcny9p
	EIPJK+Uj9rUj7GyYZtsKk180qLw2IaOU153z7ZfntOOUqbRPan3dI6UKZhVaQCd3c65pgHAQhrR
	YhXRd8l9sO933mhnYn+3RzjQOytWF4ErO3O25aKUiTNsBxwq0qfn+Dnbk3uidUm3FrdMsOjSKNJ
	kFAO/+25IvpralO4y8fvcKDDY0+onTPOsfilHIWXatpuWcVBMqc3AH4qEa+0WVoFhFGExX/nKXr
	uTV3qeOy6GrAqQ6PtUqGZv210VCLWZq1D1eK3aSQYZGmvsFCjMNoDgpKcpkGKZAZoIF/SM97Mcq
	j/Q0yVBaII5d66hFzwh1Xkz85TU3C1Fow/JxDuEYuZtw1vYroZjTd57gbgqh4UsxJrcW74D3OpR
	3hfNML8NRItsdNFJOxIrFiJE2ZDSvS5HwckNq2F6v/XmZ9QhmDXBSYP8p/CyYfSY5BACfVFbhd9
	ftR9kymwHKMtyN7XmkbdpCjCZwtV3wxOqnaikzTseyTt8XKWwHCwD3Urv3fm1g7YMLEThAgqn7s
	n6GQWq91efA4Sv+DiLI=
X-Received: by 2002:a05:6830:2811:b0:83c:1efb:6424 with SMTP id 46e09a7af769-84d05db2f8cmr1904135a34.1.1792607135285;
        Wed, 21 Oct 2026 11:25:35 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d3csm2831887a34.9.2026.10.21.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:25:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/4] object-file: fix ".keep" lockfile ownership in ODB transactions
Date: Wed, 21 Oct 2026 13:25:24 -0500
Message-ID: <20261021182528.3055494-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261020132900.1208343-1-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com>
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

Change since V3:
  - Followed Patrick's suggestion correctly this time.

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

 object-file.c              | 127 +++++++++++++++++++++++++++++--------
 pack-write.c               |  64 ++++++++++++++-----
 pack.h                     |  10 +++
 t/t5547-push-quarantine.sh |  30 ++++++++-
 4 files changed, 184 insertions(+), 47 deletions(-)

Range-diff against v3:
1:  b9197cbf3b = 1:  b9197cbf3b pack-write: make index-pack output comment hash agnostic
2:  e27679ac16 = 2:  e27679ac16 pack-write: lift and expose index-pack report parsing
3:  e7f72aa53d ! 3:  b8ccd78e0f object-file: explicitly write ".keep" lockfile
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +{
     +	struct strbuf lock_path = STRBUF_INIT;
     +	struct strbuf contents = STRBUF_INIT;
    -+	int ret = 0;
    ++	int ret;
     +	int fd;
     +
     +	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +		goto out;
     +	}
     +
    ++	ret = 0;
    ++
     +out:
     +	strbuf_release(&lock_path);
     +	strbuf_release(&contents);
    @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transactio
      			strbuf_addstr(err_msg, "index-pack abnormal exit");
     -			return -1;
     +			goto out;
    - 		}
    - 
    ++		}
    ++
     +		if (ret) {
     +			strbuf_addstr(err_msg, "index-pack failed to report pack name");
     +			goto out;
    -+		}
    -+
    + 		}
    + 
     +		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
     +			    (uintmax_t)getpid(), hostname);
     +
4:  046ff4741e ! 4:  5fea4b5a36 object-file: write ".keep" lockfiles during transaction commit
    @@ object-file.c: static int write_pack_lockfile(struct odb_source *source, const c
      	}
      
     +	*out = register_tempfile(lock_path.buf);
    -+
    + 	ret = 0;
    + 
      out:
    - 	strbuf_release(&lock_path);
    - 	strbuf_release(&contents);
     @@ object-file.c: static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
      	return ret;
      }

base-commit: f57c9a73884400380bddd172acc88b569834f909
-- 
2.56.0.173.gf57c9a7388

