Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273B115AF6
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890560; cv=none; b=oBDou5a+ieTQ0fUYpMNPVHP9bjNYK3Stzeiyrs10ZxLXviB+qdR27E4vIN43+P/wvNuyK/poZ/ob8wyfpZcGxuhFj+JF6kpBRYl71HUOImjijsxoaCDfgv1wvgY23Z+oUf5z59lnyzPsk6/7/fbwGljjnaysciWETZZZE5Mlz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890560; c=relaxed/simple;
	bh=YHlkPzbw1bqcJZTYaYxxvRT3cE9SFsD0GAR4HK6dNXA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=K14ToS8DjFr+rN4WtSojs/gGwNCzG8m0yfCeuTpUfZG+6r609Ulodxxc6Hs8rqKOyQD1i8Q5OD/2YGSYsxSl0ZX2SGLIeUxPSjHGykHXzp7KQ0MEg6aG4H+9y08axTLu+xHXsDaycWg9gKItMMrHbHnTS7j7p+uF/eahAdfpxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg5SLSU/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg5SLSU/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d54214adso15499785e9.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748890557; x=1749495357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hBDpVfD6UqqxKOFFfF1BysL34P9ifDo3lWcSrIz8eh4=;
        b=gg5SLSU/4TeNGktWsfdxcGhvxE/l6jn9fNj7WKLVKY/P54x/iOS1VLzuGDG4pvxwKN
         XK5L6TTGFnzbIVB964x61JQW/wyuRrK7PodfBAy6EhT4QlsAwvh2z3pV5+irVyFCpxzB
         k3Ld56JyRifebtJ1jbFNwbBMvQf7YmeZcEDDnqxUXyQSV5Bx7zeJAnOCgtWsPU3U26aa
         RR0bIEgcKwRn+rULpKJJ75ifiJ5w4hVME+6vF3zV5cUx9J1zBmd0fHoy/OxnmP3OTUn7
         2ZA4OTReNNgP8/py5Vty0UlPPCgRV65wOn/xVBTd9aWnBL6heiIxo3r2pVOUM0y0eBO/
         3wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748890557; x=1749495357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBDpVfD6UqqxKOFFfF1BysL34P9ifDo3lWcSrIz8eh4=;
        b=f6vaPwDYuMU8GnJXf6DFSQRNECDF5QltbAayePrRBMxdyrx+/38UD/alNizRAlwEun
         qvCNhXmMDQQ2ZKfrWakf6hxWtp40VY0bW1TeLVcDIc2a5mqZLja7odG0/9YcoK3wKxgq
         4L6EUeJzzVKPHS/rA0V9nBbBaOYCY/swUWiMSnQCwM7IX9s2ts7Kn6/PXvzSb7mBffPW
         +Vy0zLfCS7LwUcv6MMEuxaucCidbyHkFHb0rK5kL9Sa0srnPTw07WNTF6EWgXdYN0J2G
         u2B42DOn2ri5cD0hbd1sV3o+T4fVd3hhBjvbcMsKHoArZ9yTdt74fx3c1za9LBWVmCxP
         ozKg==
X-Gm-Message-State: AOJu0YwxPocesSSbnbZohPx6bxQvBBVWryifT1ROi5PVyGRCI3DBVi5Y
	oLCRjqfJzKGOG/EqNbkp6rP4nJ2glFNJ0niMl3whejtgxzovRcgzYKYE7deGKQ==
X-Gm-Gg: ASbGncszpZSQYZEBX94TOKDEbl5sfWpReKPHAJFuyTDcK7IqJdUgDvDB8jARhELmlxo
	n96V/uqWhcLtJwsE8OHv9dLjISkpCISB0Dh7Cja2FoX8Ae3ACthjNJkCZyqi7dxDMcA4sTV9UHS
	2vrtXvbkDy3l6U3MptMcjMfxLB7vVcPAVJZljdzBcAqtuomYmdY1WbaMW0qxtjq47hJHt/vH1P3
	4P2yT7j+/BbvZvnRVBCRZOh4cojlTmbWGfdvBWGz3MTmNKp01W0KD2xMz87mOCwJO7S2Gan70b7
	ghUYuuTfoJf2B4SjAbFL4L43umC6RsOChElbQHVB9SM2MTAtF8UG
X-Google-Smtp-Source: AGHT+IHHpqf6XGRKcEh7KWF4UYVwQ6wWR92nsjBchsb7Onl5z+DQt71Tc7Dve/1f/IZjbrJdnn36vQ==
X-Received: by 2002:a05:600c:4688:b0:44a:ac77:26d5 with SMTP id 5b1f17b1804b1-450d64fedb2mr139498095e9.14.1748890556789;
        Mon, 02 Jun 2025 11:55:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a00d4sm16004209f8f.92.2025.06.02.11.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 11:55:56 -0700 (PDT)
Message-Id: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Jun 2025 18:55:52 +0000
Subject: [PATCH 0/3] cat-file: add %(objectmode) and submodule message to batch commands
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: peff@peff.net,
    gitster@pobox.com,
    Victoria Dye <vdye@github.com>

This series re-attempts the changes proposed last year [1] for extending the
information about tree entries available from the 'cat-file' batch format
commands. It also (hopefully) addresses the initial round of feedback that
series received.

The first patch updates 't1006-cat-file.sh' to test non-OID object
specifications. In response to the feedback in [2], I added more careful
quoting and a couple tests using paths with spaces. This change revealed a
(likely known) limitation of the '%(rest)' atom when processing object names
with spaces. To make that limitation explicit, I marked the relevant test as
expected to fail.

The second patch adds "mode" support. This is essentially unchanged from its
initial submission, save for some conflict resolution in the test script.

The final patch takes a different approach to submodule resolution than the
initial submission; rather than treat the entry as a "regular" commit object
with empty content, we now print an error message similar to the "missing",
"ambiguous", etc. cases, but with the tree entry's OID rather than the input
object name.

As for the motivation behind the change (re: [3]), the goal of this series
is to be able to get more of the information available internally about an
object in 'cat-file --batch[*]' -- in the case of a tree entry, the main
things missing were the file mode and the presence (and OID) of submodule
pointers. As Junio mentioned in [4], using a single long-running process to
resolve objects is far more performant than spawning multiple processes to
resolve tree entries with something like 'ls-tree', especially when
resolving entries across multiple trees or resolving a mix of tree entries
and OIDs, refnames, etc. The object resolution logic in 'cat-file' meant
that the mode & submodule OID information were already (mostly) available,
but we didn't have a way to output it.

The intent of this series is to make the new format options/outputs to get
those fields as unobtrusive as possible, but I'm happy to do something more
like the previous series if that would be preferable.

[1]
https://lore.kernel.org/git/pull.1689.git.1710183362.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/xmqqle6oo2ns.fsf@gitster.g/ [3]
https://lore.kernel.org/git/20240312221758.GA109417@coredump.intra.peff.net/
[4] https://lore.kernel.org/git/xmqq1q8fl05r.fsf@gitster.g/

Victoria Dye (3):
  t1006: update 'run_tests' to test generic object specifiers
  cat-file: add %(objectmode) atom
  cat-file.c: add batch handling for submodules

 Documentation/git-cat-file.adoc |  13 ++++
 builtin/cat-file.c              |  14 +++-
 t/t1006-cat-file.sh             | 111 +++++++++++++++++++++++---------
 3 files changed, 103 insertions(+), 35 deletions(-)


base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1929%2Fvdye%2Fvdye%2Fcat-file-mode-submodule-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1929/vdye/vdye/cat-file-mode-submodule-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1929
-- 
gitgitgadget
