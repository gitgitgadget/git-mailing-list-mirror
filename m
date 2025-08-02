Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B691EDA3C
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754172850; cv=none; b=mm1CjiMyGz1AsF+zMmb2WaFUnBIabtYNpE1BOEbI1U9zShKTxhdI2SYg2/Z59EtUFESqnDhAQykwPYKmoZ3DxqKVIONfZGhzaLdjlH+FFRZb9KqjI2Qd381fnbqiP+umwyWoOEum02I4eV3m1Cw22EnzI/UfrCIegaT93eAoFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754172850; c=relaxed/simple;
	bh=6MfeoI7IAXvr66Hupsc28kF8sUUBMmCar5z4O6U3ubc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxnrvTZVy6VDyzlsld/Azvfc03QiXt9b6ljHCHdhcyXo40/rWiWALYBCbCAtX2laEMyLWvBUIlAj0HoXaYSMNhF1eYP7L/ghA/uECHzuzz/KmyN6gofu8uEOMuGOW2R4THcvDjsSjQ9ZxtrX/zE0G8lGg+lolq6iZuQ8C8abbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4jTZ0v9; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4jTZ0v9"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-433f1f9718dso788180b6e.3
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 15:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754172847; x=1754777647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+bLXKJ6BXU5WTl7EAMRn+tucmDDbimnsPNXX3GGAac=;
        b=E4jTZ0v9FWTQd6ROTWLzBNqyl6mniTDJxjoEc/eOBhgT6LzdnEEkuTd8peQBdrs0uE
         xMkqCVuB648BmGgFoSwgAFaVHcjA0Xe22N8iPEkRdDQOQf6/9JRc3AZH+zppvQMtJqdJ
         mam+bhzsN2x/az6Byy7imHjttLXKEKQTWAd746GATkRVcBlM5nCEIErfwldQV1ZovXiS
         SeSa36njO/pnxp3eqNGZ7xxWc7rOhRN1PaE56KUubylzkp5F6hHL+zVJ7hHjyRXmczg9
         YQaeT7G+POCl5j3trllBT7XM6aAeCeKrMiKLpMluVOQxmw+dzra3qaKI06yl4/STqtKe
         AVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754172847; x=1754777647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+bLXKJ6BXU5WTl7EAMRn+tucmDDbimnsPNXX3GGAac=;
        b=oG1tN+eAIV78oCEpIJoLdntjRCbpB/vtTd3LXx5HFfH3BhfJ6o2C0b0IRVn3TdK7ni
         UwU8xXmoayaTNKmnsZ8FH77khqRWpXuOvrWRj/TqpEtmHnpnb6PtgRdIa636bdIPjt7m
         SYLja7cGlzH7uHGqvoUtAHZ2NJuEA0y1Q+KsvRoOa9cNFU7tW8/qm66geEeY2TRfddHs
         D9/ZrcA2YNp/C7zrEMnG2uL+0UvggdnN3uGav8yE5QkhoYVwsNmeVPQNcua1uko6MhT4
         bFNeGydA+ZVTGpCyHrj5UjmrrnAt59nvpde/yBsjjg6kZI4XHtTxtrkLdU8H0Qti9+W2
         zKhg==
X-Gm-Message-State: AOJu0YwybaZ189gU9/KoXf7Q+tHhdNhslqjmbkKIuZwJmOnpUguBaaXQ
	nNSkbzXWYjtyG0Pur9vKBoNLbgpGNhEzl7PGdPNq/622m1BvPiVrF/LGEpEoUw==
X-Gm-Gg: ASbGnct64+lE+1szbM9QppqarHW4UnsrIqHPy+jAE+8chsf4sxv8qoW9g+BzSoZCB+A
	4J8kNWC8q3XJk/xD8TzDl79jpvuQGgpFmzthmb6T8dvbChzjuh3xiJ3uS6DikdiWbZSpDCGvSzu
	pwANfD8Qsh/dl8MTQoqSAiN+jONbZQauiiV3tK2Kq5cGhc/LPr1blia7BWP4hIfDZBaFZqFLalI
	bxP/JcPe/qOP9+y1FIkMnBNj37vydqLgYWSy6UkK7GSJyeWfoMeY17dHZcFCSfv4PDN7XTikVaw
	4vLNF9Y69dliLORuatGSJRAG3W1A2erCghE0iHZZlxI/VgjYEgta3CHsClU46ACPrr7ad16L8C0
	A+yMLlFKcrePA4j++qkKeXYcGPwiwMQ==
X-Google-Smtp-Source: AGHT+IGHX888hjbnBKccZfmrD3pKP4wF2NtZvhaPm0EV1bgpn26Chiv9j9EixFHfrZQN8KzdsEtXEw==
X-Received: by 2002:a05:6808:1a23:b0:40b:121b:865c with SMTP id 5614622812f47-433f036a15cmr2613177b6e.36.1754172847483;
        Sat, 02 Aug 2025 15:14:07 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-433ebb185fcsm811283b6e.29.2025.08.02.15.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 15:14:06 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] archive: flush deflate stream until Z_STREAM_END
Date: Sat,  2 Aug 2025 17:08:03 -0500
Message-ID: <20250802220803.95137-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.50.1.214.ga30f80fde9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `archive-zip.c:write_zip_entry()` when using a stream as input for
deflating a file, the call to `git_deflate()` with Z_FINISH always
expects Z_STREAM_END to be returned. Per zlib documentation[1]:

        If the parameter flush is set to Z_FINISH, pending input is
        processed, pending output is flushed and deflate returns with
        Z_STREAM_END if there was enough output space. If deflate
        returns with Z_OK or Z_BUF_ERROR, this function must be called
        again with Z_FINISH and more output space (updated avail_out)
        but no more input data, until it returns with Z_STREAM_END or an
        error. After deflate has returned Z_STREAM_END, the only
        possible operations on the stream are deflateReset or
        deflateEnd.

In scenarios where the output buffer is not large enough to write all
the compressed data, it is perfectly valid for the underlying
`deflate()` to return Z_OK. Thus, expecting a single pass of `deflate()`
here to always return Z_STREAM_END is a bug. Update the code to flush
the deflate stream until Z_STREAM_END is returned.

[1]: https://zlib.net/manual.html

Helped-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---

Greetings,

At GitLab, we received a report of a user getting the following error
when generating a zip archive of their repository via git-archive(1):

        fatal: deflate error (0)

I've so far only been able to reproduce this issue in the chromium.git
repository with a specific file:

        git clone --depth=1 https://github.com/chromium/chromium.git
        cd chromium
        git -c core.bigFileThreshold=1 archive -o foo.zip --format=zip HEAD -- \
                ui/events/ozone/evdev/touch_filter/palm_model/onedevice_train_palm_detection_filter_inference.cc

In the above example, `core.bigFileThreshold` is set to a low value to
cause more files to use a stream as input while being deflated. This is
the codepath that produces the specific error.

I've tested the patch against this specific file, and it fixes the
issue, but I'm uncertain how to reproduce and test this issue more
generically. I'm open to suggestions if anyone has some ideas :)

Thanks,
-Justin

---
 archive-zip.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index df8866d5bae..29e7c9f5e3f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -492,14 +492,22 @@ static int write_zip_entry(struct archiver_args *args,
 
 		zstream.next_in = buf;
 		zstream.avail_in = 0;
-		result = git_deflate(&zstream, Z_FINISH);
-		if (result != Z_STREAM_END)
-			die("deflate error (%d)", result);
+
+		do {
+			result = git_deflate(&zstream, Z_FINISH);
+			if (result != Z_OK && result != Z_STREAM_END)
+				die("deflate error (%d)", result);
+
+			out_len = zstream.next_out - compressed;
+			if (out_len > 0) {
+				write_or_die(1, compressed, out_len);
+				compressed_size += out_len;
+				zstream.next_out = compressed;
+				zstream.avail_out = sizeof(compressed);
+			}
+		} while (result != Z_STREAM_END);
 
 		git_deflate_end(&zstream);
-		out_len = zstream.next_out - compressed;
-		write_or_die(1, compressed, out_len);
-		compressed_size += out_len;
 		zip_offset += compressed_size;
 
 		write_zip_data_desc(size, compressed_size, crc);
-- 
2.50.1.214.ga30f80fde9

