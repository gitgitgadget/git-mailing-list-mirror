Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349DE1EA84
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100295; cv=none; b=ZQfxAxBZ61+e9ewdYcMIwdvIC4lq3EoAXjT1CMI7AUFc+v8mTeS+D3XBnyjhvzD1W3DGObfo6O1tzC2TVqI5Ps+D74x1U8888Dbdyv1PHncB52GnOut0v5DET5qdElrNsEqW1BFSgRYfTlMGy3bZfJtO0M924+1l45198PwBcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100295; c=relaxed/simple;
	bh=El4RHYpPgxrp33V1x/QughO2w4vfpqph90k6MkdQ8oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LF4OY/RXTnQnLyjX+dhVowuk/OLlnydEBax5/80qr/fPPLXkMe0i8Sx1jNAB0C0bJkdLQiCrYlO5ES9c0Rtxvgg4n7BL1xcjvewSZ+B8Fh3ODxyTeYu+F9y3A/bxAvj7bmZokTqqX8XSc3YHZ0c8BZEHOB2flVBdCFjvJH5vnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiIzbIsx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiIzbIsx"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7815092cd0bso48525267b3.2
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762100292; x=1762705092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zb5MtAjXFu/O3p5Ftt06fiKrI3E0EZW3k1tVl6dTIaw=;
        b=JiIzbIsx6hAE/RrU/dG2T7hDy7791yb3qLsY1odsykMxrWbvQIi7PJImN/N0u01CWB
         vQOlMq7DcM6Tw+KFX0BiKAMPu651WF924j+YbjKzDm2XIV2ox6KlWpiYAZzQQlaXroYi
         l7Z5oXzhcpmDxMlNkGJk4jsJl3yzkF0cCEOmdR+EfP0hmNE8073vDH+DOiuWM7jZ22SH
         ikk/wivwAbmjhpDuvWghAQCAs7PSaLyu91A97y7QVj3DZsH5kUqCuV9/Za6CHmiQ1AvY
         4fjU+otyRW88tPJ9yRNRK7JwQyCfP0IrF9xJM1p6CwQgkJcu0k2cTU875EiWn4h+Pa9I
         /MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100292; x=1762705092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb5MtAjXFu/O3p5Ftt06fiKrI3E0EZW3k1tVl6dTIaw=;
        b=fZCFbX5VpxMOllYVy/aq9fOWAGfE9C4K0jHSPgTX2lMQCyF9Ox+VU8UCE2BKohTR60
         ayDljmFEx4JrR2LK7pdZpbsayb8ikAo5Yvb87rtffoiEsGInRQUQUIrVvz4ShTy3hicQ
         VZ+juNJVZgZhfueWNgxBhWW+ojsj8jPDBThdlsHN4Jqqsx9D4O6XhZUVO6QwZfHhFZV7
         cmp8PKe2vdQMrnOkevqBc/KQQVQC4e1l1pbUoVtQ5hMkHtXhX9VE5sji5xrjYSbwS+fF
         dyfj4RgkjVcepR+meHWSqtBAVsF1GHmYANDuVeRr2x35AXDg6LA4wLH/oHhq0+OdN9FI
         OpJA==
X-Gm-Message-State: AOJu0YxmuKUNNUc7aqWZ5GYYP1kKnkXzsB6uvQ5FgkoqzyeguLlY5twC
	9gkhhuBi3Gh4urVZSEwEiF0WuanR87sMBRBA4ZGMHAixXQwl32K9bZ+NNbSJQYyj
X-Gm-Gg: ASbGncuf24fHOU4+oLWTI35QEp/zWxsv8szQSPhyHeiok+cDiV5VhwMUZcawMWG91xF
	jrysL13B/ipvPJdlFi1xHFSydDxcTwXMUnJsG7p/KbMirNvv76/3qkbs+DqfQuV1SOyutDzyyid
	Exy3bBIVQtV9QqvCrtOqnVHGV7+qNLA9smlbwRLP0VNayUymJMj69PIjWRzhhAmlsc/mpAd2LEe
	fxWLyDTK+6NvJnjkUVafLXP7QAXlJ/TkoCQ3pO7xVvEDKyYgjm8gI9JDWzrhKzLxOEFea6Ur20T
	u3W1w51zdvyL1e5tVKSrsYxs/b7Cd/5x5Phbld8quSaEi7tUNrzb7N3I9BgYGn+Cm7tE9lz/gGr
	/A9xyPqBDHFOggskU02QYsM3WcwzYX+jm402uehRc8XHT3OLVs2FSbqmX5XvRy71CVPZrw3fan3
	iF2TdYDOEYWuwwVoCQoande0NEEH29bh9cXBHnyrzPcgiS25Rl
X-Google-Smtp-Source: AGHT+IG3NUK4FmrIEWTSk1w96CI+FBBFqrH/NjI+pkaP97CP54hFaeWXcdiRREKiXb4sMiaDKeiP6w==
X-Received: by 2002:a05:690c:6a83:b0:784:9076:a0f5 with SMTP id 00721157ae682-786484df969mr155542527b3.44.1762100291709;
        Sun, 02 Nov 2025 08:18:11 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90a8:8b00:c038:e715:f394:297e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c6185c5sm22626967b3.32.2025.11.02.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 08:18:10 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/5] Fixes for :(optional) path code
Date: Sun,  2 Nov 2025 11:17:43 -0500
Message-ID: <cover.1762100242.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series has a few fixes from Phillip's review, set up as individual
patches. Justification is light, as many are hopefully straightforward?

The most important patch comes first. The rest are probably
take-or-leave.

D. Ben Knoble (5):
  parseopt: fix :(optional) at command line to only ignore missing files
  doc: clarify command equivalence comment
  parseopt: use boolean type for a simple flag
  config: use boolean type for a simple flag
  parseopt: restore const qualifier to parsed filename

 Documentation/gitcli.adoc | 2 +-
 config.c                  | 2 +-
 parse-options.c           | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
-- 
2.48.1

