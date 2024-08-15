Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB84AEEA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743078; cv=none; b=k/cJQylCHWYxCLx4mkHnac5mBrt+1mRekkCXsTgsO5X0myGkrlmxBNlcf95tjQlouVE1aj3fSZc4d+OVs3g89qteoBsdIYwXOBm3CInBrZf9nZ2HsYCzT0MTVgAIea6TT/DW1JEBm182cCoCOGUfFEK/takgs1VcimZRySNY4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743078; c=relaxed/simple;
	bh=Nr5Z2kew+QpEn3+4VLaZQPLpjx5mYN0DeYGK6magg6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7NjvKVHWaf8WE9AhC4jiArtEf4MiI4WBFsRWMBwJfax4PPMCpkzOSROk7L0MxDBHrVFNNRAWUxJa3Auc3LVRFo1sR4DOUPQu5ogzFnOyE19e0obnKZ/5du1dd0eHKHOcjrRARBGs84zFHMlR0dovPwkVn2DPZZDpT0hLXsl1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=A8DJLF8T; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="A8DJLF8T"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e116ec43a4aso1155399276.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743076; x=1724347876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4/kWMUw2xb5GB9hIUG4yLHC04UvXICmVmSy4PuVeIE=;
        b=A8DJLF8TVIWqjmn5bguoykf6LbBj2g6QM2yiQQEtXk95YnAS7yP13vC2n1m4f/mDKM
         Zw/x1RgYhBnIo5ebsOB62qOvqkzpG6q/X4zAK7fekmo7AZYnsdfWpANJjw4AuNjFiItW
         gohA/h81rN7PnvAA9VEcA5X7Js5WaQ7iepHKOuL3GVha+mJCBQsEnH1qicEuNLwVvRJl
         vhHaaCkXVMVvCEVU96Gqoy4hxLbGLqrB3jlaBav6KMne2V2bZxB8yFA8IfQvT31Q0pRR
         XTdNcPgGXdZmAqQ44WO3rOkdGIv+s/4u6wAjKMMLK7po/NQfxR8vwR4YzrpVxU2ILi7y
         TbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743076; x=1724347876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4/kWMUw2xb5GB9hIUG4yLHC04UvXICmVmSy4PuVeIE=;
        b=kQsnZsoAvi0W8db71i2We07vYayy7DzoTS/BOxkiwwKWgGNxkjWiUb1WL7Id2gcP5k
         PKqTmxo68SvyE6hzLxuV29DMKWlBMxuml0/PZYgtfZBz6Pe2hf5xeE4PLaHMS3XjmWms
         Gz10tgeMozN2vrP5u1yRMHtt3dmsxthhzHIFkZgQgWpvy1vq+gaoNRKElLhIQ16PVkmX
         4AwdeA/krAsptIX4TDQRDs5fZ02cbJuTuVq86HyLYRbI0IZh/74O9te91C64Q40FSwo+
         a4lxdxFSGh9UP9FogRy/jgdd4XV0Cx/QUHui3cVW+7GyKZGjRpY6zr2YTLWFSxuAknl8
         zUCA==
X-Gm-Message-State: AOJu0YzBUCVVwRMgl0v5WtBx1C9jf64oPW+3SIDTzjUIy42DqYHcUNNr
	J3lDQnik5F8ULG2/dGKno0sarMGrsfLY/EuuXVVk6GCA9moVv1i9mgwoxC2826B+T/N5p3te0+a
	O
X-Google-Smtp-Source: AGHT+IHCZdvWMkRd4fDkgXFuxADH13+UR5mgr5KQgRNjysWX9QYTMtazaoVDFvin1069RP6ptEXcDw==
X-Received: by 2002:a05:6902:240a:b0:e11:7e70:a9b2 with SMTP id 3f1490d57ef6-e1180fa47bbmr573343276.42.1723743076181;
        Thu, 15 Aug 2024 10:31:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e09693sm388320276.4.2024.08.15.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:31:15 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:31:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] t/t5333-pseudo-merge-bitmaps.sh: demonstrate empty
 pseudo-merge groups
Message-ID: <228553e412fc3020a6f24eea601c47a08d70a2bf.1723743050.git.me@ttaylorr.com>
References: <cover.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723743050.git.me@ttaylorr.com>

Demonstrate that it is possible to generate empty pseudo-merge commits
in certain cases.

In the below instance, we generate one non-empty pseudo-merge
(containing commit "base"), and one empty pseudo-merge group
(corresponding to the unstable commits within that group).

(In my testing, the pseudo-merge machinery seems to handle empty groups
just fine, but generating them is pointless as they carry no
information.)

This commit (introducing a deliberate "test_expect_failure") is split
out from the actual fix (which will appear in the following commit) to
demonstrate that the failure is correctly induced.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5333-pseudo-merge-bitmaps.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index f052f395a7..0288691340 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -390,4 +390,24 @@ test_expect_success 'pseudo-merge reuse' '
 	)
 '
 
+test_expect_failure 'empty pseudo-merge group' '
+	git init pseudo-merge-empty-group &&
+	(
+		cd pseudo-merge-empty-group &&
+
+		# Ensure that a pseudo-merge group with no unstable
+		# commits does not generate an empty pseudo-merge
+		# bitmap.
+		git config bitmapPseudoMerge.empty.pattern refs/ &&
+
+		test_commit base &&
+		git repack -adb &&
+
+		test-tool bitmap dump-pseudo-merges >merges &&
+		test_line_count = 1 merges &&
+
+		test 0 -eq "$(grep -c commits=0 <merges)"
+	)
+'
+
 test_done
-- 
2.46.0.54.gc9a64b1d2a

