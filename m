Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081352;
	b=YCyAiZxyfGHeVtt9IAARt/Tz4wES5yS3ZWFApz5wXkcesWv+jUMd05kb/eZI04fv/RAX
	 KZ63gpX4we92oY5f/02d6jdXLj6nktAM0RsGshNO0aWC4cWLNSds6eDiRjUoCItvm4XTo
	 N9r2EtAyuK1Ehs6iS5ShS9l97Ka3lxD1otmMvuAJH6dLmMp6lGCh5YSqcOYZiprOphXqf
	 0YOVLYsXGOy0XxkScQCZsrMwk7+v4VQRFL861ZWAbguDUhy7aSWMJsegUaZJJte9QY80l
	 0UbQyvRPNy6C/kOnwGpXgHrQYiFEX/U8UGbnIxAUddG5fMf1hZnfbuGN1zpUEdP23ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jRGlPvDenwRdqLI3I69Be4ZWzwlEnWKmkNF62cNcbUA=;
	b=mepI0mdqUHL+kTGjA4iVHW9meDAdqhteBq0FXuGvHSE/ySM6ElKg6EsRP7qh/GlZ8AZw
	 Ywp9obs+Dw3qRiK70T4r598GXpjnTUDsvl6hbpHUVDjrr+abM6hItVCwf4kLqfHiKxSLz
	 vO9vl4NBbD5zr4Suc3hwiTo1wlVPViEKX8JauLfvP7Z3BxQ2Arte0Z9aDRdmsk1AoPWph
	 g7mmHFqOKektbiI+Oon3T2yRJ6aFGV8JtVPWz5+rUrEtE54R/5agNW5oReYR9ieCIXV7H
	 odq3/mpYIUvjgaLa52PrA+sZEQVnwgiLro1Ie/CdaHa9kpm1leI1AEKpUnq52NuLlLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1vCYNui;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D0606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 19:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA3D0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1vCYNui
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e10a70540so15808f8f.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794081350; x=1794686150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRGlPvDenwRdqLI3I69Be4ZWzwlEnWKmkNF62cNcbUA=;
        b=U1vCYNuiS0XRGbtixYn8EeuNFCCg6khBM3bd3mHr5mSdCYeyM7wO6P+mTFpydbiaRZ
         mITYUZhOFKwOkOtzTKWCrDBgIdsmn7+KsU2QulFKz79fuksjR0qoAmRTjC3yUtCq0Beh
         LzG0kVtWiwUZUKw1CEZswHCoR1+7ZBGB/ZFOj7Gp5qk3IvFAGQtB27hlYjfEmfJua48m
         Y9fkYK2nBqeXZq9B8Wh+QgImScr3/JmH3YrGR+RQPXpcXp7+HFcLFrNyAUyPTNTfDj8A
         3Jt+FOn3PZIUnHJod4JHQQqA6f1SJZbfnpfk5Wwg22G7xVD5pc1ECPfFgeAAwQvmQ6DV
         FPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794081350; x=1794686150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRGlPvDenwRdqLI3I69Be4ZWzwlEnWKmkNF62cNcbUA=;
        b=I6EfpoVbe6rLNY0es3qI9r7lh0Tu8OyjSNxzRYSpn2FYbdK6VToReeI/plUaBwBBz2
         IwTcv/V2Aa41xigB6WVeDjIB+0h5DQ/ceLqCVG9i8vdI1VziL/5AkNnY8ZfjOOuKW/Cv
         cARAvcBFWBySQUnTtxf4UqSNFNsRMQ/K3XfklKu2HJvCHQ1+tOVsuUQztYagEHS0/O5a
         JOsnmi4Q4VtKbAOIUsZ24qWflm+Z2YykcyhpbhjhieaIGrQFK0i4umA11laasBfuwCsL
         oz3hJl08HgR5MR355aKBRV/gT52sr0QAE/NvL4x0sZyhiRV/GdaRHMF4fM6xSjUcIPPu
         v08A==
X-Gm-Message-State: APuU4Z9jy8qWfV3cyG8f6vl9VaFzVLajGP6ca6xdVzV+4TAPMVC3A4YY
	M0s0UmhBWCd5+BKj3OqkPDLBHWoympOyQYmL6tU8F9T5NBA3Rm9QD0NtaWBhtSlQpH4=
X-Gm-Gg: AYBFou3sJR2OALevq4yEgG+A4ZL+InI7YdwH1ixAnTiv2fH16+tBmWCljPKpvwINdM3
	Qi906I8niLmr/TbKTE1/1TqzJ2b2b0p9B/bF5RSNXb0Ll4cz2jYnB7z7OBIl18Bt3pIjBEkX10S
	GMF+VnY2siWddgfoAtP5GHv9Op+aoZOQIzkUDQ+lEvNimCyjnPMfB6wvZ2SkUPyg5qjoVTAK6JH
	Ge0CTpCtfwaAHVhLLevw3XSMFt00NDURdruArr2ZGyr5ufzFa0PMJPjkmLrMKgeI9NjfDg9trcq
	FH7pwfJ0tAkrTQfdGYGIijqF4LAZU3xbui1e0mFSDQQPsv2I0flUTeZiMYJJOfFIsujjJWLrVm9
	FEeNDONXwGat+WV9xJUrbFX2iaNYbzRIA4SNWX5OovKy2mi7L1R2CGyBQgnKVJkDE1qwVxP9KE6
	q6dsw814bW2OVyEMpkMTFnk8hNdQFnncapZdkVyR84xup2DRxb4QenZ8MuyqElhGPnIDwko3VTw
	Cx4pu1LRkcEc2+7w89W/YFL3+2oZlDVT8KIwtxiRHBz2nbiOik3Rmh6Grcu4Z7PAuMW5T7qj17m
	tAqUzcRG68ItEBtNZ2OvZNnhj5qZBXid0DWlDinKEnJ3tvLEiI3legEtuGDl6Tt19till10MIe7
	8y3fQgJUyAj8a626jk0kFH5Kr8DiaqkRJWQgWN49+ozeVQW3/dm1H/w==
X-Received: by 2002:a05:6000:186d:b0:493:690c:8364 with SMTP id ffacd0b85a97d-4958083084bmr163448f8f.3.1794081350050;
        Sat, 07 Nov 2026 11:55:50 -0800 (PST)
Received: from HP ([102.0.122.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d770248esm11585063f8f.42.2026.11.07.11.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:55:49 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH 1/2] apply: do not keep names from an unused "diff --git" line
Date: Sat,  7 Nov 2026 22:54:28 +0300
Message-ID: <20261107195429.96842-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
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

When a "diff --git" line is followed by a line that is not a git
header line, such as a blank line or an indented "new file mode"
line, parse_git_diff_header() stops right after the "diff --git"
line. find_header() then treats it as an empty git header and keeps
looking, as it has done since 206de27efa (git-apply: ignore empty git
headers, 2005-06-12). It finds the "--- /dev/null" and "+++ b/<path>"
lines and reads the rest as a traditional patch.

But parse_git_diff_header() has already set old_name and new_name
from the "diff --git" line. These names stay in the patch.
parse_traditional_patch() sets is_new for "--- /dev/null", but it
does not clear old_name. So "git apply --check" dies on the assertion
that 5c47f4c6e7 (builtin-apply: accept patch to an empty file,
2008-05-17) added to check_preimage():

  check_preimage: Assertion `patch->is_new <= 0' failed.

The stale new_name causes the same crash when a deletion with such a
header is applied with "git apply -R". The stale names also break an
empty "diff --git" section that is followed by another section. They
do not match the names in the next section, so "git apply" fails with
a "bad git-diff" error.

Free the names when the "diff --git" line is not used. A new file is
then created, and a deletion can be reversed. An empty section is
ignored, as 206de27efa intended. As with any traditional patch, the
"new file mode" line is not used, so a new file gets the default mode.

parse_git_diff_header() has also set is_toplevel_relative. Keep it,
so that the paths stay relative to the top of the repository, as
before.

Reported-by: Gingrspacecadet <jackrawlings2011@gmail.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
This fixes the crash reported in [1]. While looking into it, I found
two more ways to trigger the same assertion: an indented "new file
mode" line, which this patch also fixes, and a "---" line before
"new file mode", which 2/2 handles. Git 2.43 crashes on all three.

I based this on maint (v2.56.0), since the crash is in released
versions. It merges cleanly with master, next and seen.

[1] https://lore.kernel.org/git/CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com/

 apply.c                    | 10 ++++-
 t/t4133-apply-filenames.sh | 90 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index f00b7ba4d3..b56b363963 100644
--- a/apply.c
+++ b/apply.c
@@ -1651,8 +1651,16 @@ static int find_header(struct apply_state *state,
 								size, patch);
 			if (git_hdr_len < 0)
 				return -128;
-			if (git_hdr_len <= len)
+			if (git_hdr_len <= len) {
+				/*
+				 * Not a git header after all. Do not keep the
+				 * names it took from the "diff --git" line.
+				 */
+				FREE_AND_NULL(patch->def_name);
+				FREE_AND_NULL(patch->old_name);
+				FREE_AND_NULL(patch->new_name);
 				continue;
+			}
 			*hdrsize = git_hdr_len;
 			return offset;
 		}
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 3cab1038cf..727c36e7ea 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -60,4 +60,94 @@ test_expect_success 'apply diff with old filename missing from headers' '
 	test_grep "lacks filename information" err
 '
 
+test_expect_success 'apply new file with a blank line after "diff --git"' '
+	test_when_finished "rm -f f" &&
+	cat >blank_line.diff <<-\EOF &&
+	diff --git a/f b/f
+
+	new file mode 100644
+	index 0000000..d00491f
+	--- /dev/null
+	+++ b/f
+	@@ -0,0 +1 @@
+	+1
+	EOF
+	git apply --check blank_line.diff &&
+	git apply blank_line.diff &&
+	echo 1 >expect &&
+	test_cmp expect f
+'
+
+test_expect_success 'apply new file with an indented "new file mode" line' '
+	test_when_finished "rm -f f" &&
+	cat >indented_mode.diff <<-\EOF &&
+	diff --git a/f b/f
+	 new file mode 100644
+	index 0000000..d00491f
+	--- /dev/null
+	+++ b/f
+	@@ -0,0 +1 @@
+	+1
+	EOF
+	git apply --check indented_mode.diff &&
+	git apply indented_mode.diff &&
+	echo 1 >expect &&
+	test_cmp expect f
+'
+
+test_expect_success 'reverse a deletion with a blank line after "diff --git"' '
+	test_when_finished "rm -f f" &&
+	cat >blank_line_delete.diff <<-\EOF &&
+	diff --git a/f b/f
+
+	deleted file mode 100644
+	index d00491f..0000000
+	--- a/f
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-1
+	EOF
+	git apply -R --check blank_line_delete.diff &&
+	git apply -R blank_line_delete.diff &&
+	echo 1 >expect &&
+	test_cmp expect f
+'
+
+test_expect_success 'ignore an empty "diff --git" section' '
+	test_when_finished "rm -f g" &&
+	echo 1 >g &&
+	cat >empty_section.diff <<-\EOF &&
+	diff --git a/f b/f
+	diff --git a/g b/g
+	index d00491f..0cfbf08 100644
+	--- a/g
+	+++ b/g
+	@@ -1 +1 @@
+	-1
+	+2
+	EOF
+	git apply --check empty_section.diff &&
+	git apply empty_section.diff &&
+	echo 2 >expect &&
+	test_cmp expect g
+'
+
+test_expect_success 'blank line after "diff --git" keeps paths relative to the top' '
+	test_when_finished "rm -rf sub" &&
+	mkdir sub &&
+	cat >sub/blank_line.diff <<-\EOF &&
+	diff --git a/f b/f
+
+	new file mode 100644
+	index 0000000..d00491f
+	--- /dev/null
+	+++ b/f
+	@@ -0,0 +1 @@
+	+1
+	EOF
+	git -C sub apply blank_line.diff &&
+	test_path_is_missing sub/f &&
+	test_path_is_missing f
+'
+
 test_done

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.43.0

