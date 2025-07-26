Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A823CEF8
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753548812; cv=none; b=qjI6WKOquhcBeNeVGasRlWN69XRVtIGBTCdJHA8h+RGspOurOgaHpz8UqJjarik7W3dssHWQGvpQjeqWwcZ9bPeIAVzOaGfnHOYd0SZpJP+zuK0TQ1sgl968dgGj+OcHbGEJG0qcqjtZCNbj3kCpou8nwhOwoIjHl+fm4iSsiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753548812; c=relaxed/simple;
	bh=UP/eOWsYceybwki6LGDFUAcf/6BAywK6mYRkIL7cbOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vlny4lrX7IeCw9JKqaIvDBeSWRc3xZa8H5S6NDsytBM2jO7zwYc5SdD5byyPycuW/9GbkM0ZNg9FELJZT83JTilEQUTrq7drtNhTxzzVWJFDvtlcPP6HdNpj+nIqboMJDX7IVwCxjkZPc3tna5EbfB21hUWu+RMhcIZqDlcLksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpadZjq1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpadZjq1"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-708d90aa8f9so31253457b3.3
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753548810; x=1754153610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V+UIF4fAS7WyetFpHuwVjQCQWwYlby34LCYqQdzzIvE=;
        b=DpadZjq1OZl/8Sv4j6nCUlUPqAgOkSywlzJ1SQBGwAXWcFADKuA8whYGNyXqNNXaEp
         exA//pGnfnyNy+J1NWPxzUIC9Iy9IutJz3WpmQJd/KLzOYMa4afxA2mSpJ+rgd2injDD
         1s+9BZvbn6kyPtC900fqhSFDfy6wNs2y6ePOJ4Au7i/Bm3nD9clFg5oEgUw1UIeFvCs+
         aNU8UabdqkVlSgSbn5oeX/tzHmNakCEEoZCg4FL/YJ3EcAzSBEJOnwWsxIVp5YQ/t5OX
         KNVqwzTNfxsWbtl4HM85RZ1xwNMawpIzHs5MN+ZaWglQsZCwmM1xUdVo1e8dxAIVEgUh
         yBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753548810; x=1754153610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+UIF4fAS7WyetFpHuwVjQCQWwYlby34LCYqQdzzIvE=;
        b=iSQUubEf9QHwtct0nOlosCp30tgitFgxKFjaeo0UeUtroC660ed/ZaQVreb9LEXrgB
         saqwPI1uvKPF0MDLp8WfdZfw0Oyi/Yw7fnDPrqgUFjb7Ahhz6js+i/7PXWXuv1ITMyoz
         6hL49mnKJxxqQ1A1dhgOugp1HOOS6YgFDQfE7f9wvAXQCHi51dp02fo42+ySJL4VaMRq
         Z+BJwBbdzTuzxhADVwHarBYZqYZD+zSKdLIMO1oiE1BHcCczE6KjcsAXGZF1osh4zhn2
         GhXBGy7N/SIPZeZuPfXvFTHUoxfoqP0boP9dCdYZiQQKEd+ze6uCn79UV/UH/NosnS1Q
         uQ/Q==
X-Gm-Message-State: AOJu0YzaMzXci9zqWDBMelKrQoiekJA3+FX8p6bu2vY6sZXj8Ox1vxMD
	VF4xDFrgFr/8T4Nb3UYzmw2Qu0OZDsQcA+oANKL2K1qTKK1c8ruq+sW/GDPiuRL2
X-Gm-Gg: ASbGncs2bjxBIvkh7yK+FnqzjmMo0nq7DBdNsrbcD6AQtH8TwYDy5u8sfl0l8Aktihc
	pSbMMZDBz8vUEWwnaokig7m20rbJSEDQSViEJzjwZ+g1A2hT1K232rCvsk8suBWFRAXaWkPBtgG
	IhGCivzMVzOT5Ru8SGnGN6MnxYTSl3kdrlGwKkqM7ySZ2oR6c8foutkiuWHwX+CmlKJlbvHwmjH
	Sm4m7uQpIlLFo3rR/wLUXaBuUGv+EUpOp0+yzkowN1rKizXrZBcRFMmffrVsHmMbOrTAbwCeGkD
	xKAmYtfvvkw7IH/W00rIeRxzoJZ0uIqTCzw3g7AMocK8C0i84NkTDYCg+SHzjpbpq89K4SNt0xE
	Z726wl9iN2ldSnqU6R5noQEvq/bFRklPlvyrkc5YV9lvVCZvTFxUZ2q1w9a96lOPhBD5eD0mhwl
	eDkezt1So=
X-Google-Smtp-Source: AGHT+IGiklgCRdTp41mNRusdKTuqelVk2Q9nUcz3lz/3DWHk1BliUFKALy6ojFcbqsx7p2EODCcnrw==
X-Received: by 2002:a05:690c:fc1:b0:712:c14a:a388 with SMTP id 00721157ae682-719e329b0f3mr70244207b3.7.1753548809857;
        Sat, 26 Jul 2025 09:53:29 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:2412:fdcb:5dca:324c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f2152de0sm4964067b3.2.2025.07.26.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:53:29 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH 0/4] permit -h/--help-all in more scenarios
Date: Sat, 26 Jul 2025 12:53:10 -0400
Message-ID: <20250726165320.4039-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series depends on ua/t1517-short-help-tests with some fixes, which show up
in the first patch. Merge that branch to a new topic branch, then apply this
series.

This series enables --help-all outside of repository contexts, and
allows -h with other arguments (without breaking existing ls-remote/grep
usage).

It consists of preparatory steps (fixes for a dependency branch;
refactoring to make an internal helper's arguments clearer) followed by
the main commits.

D. Ben Knoble (4):
  t1517: fixup for ua/t1517-short-help-tests
  parse-options: name flags passed to usage_with_options_internal
  builtin: also setup gently for --help-all
  builtins: show help on "-h"/"--help-all" with more than 2 arguments
    left

 builtin/merge-recursive.c     |  3 ++-
 git.c                         |  2 +-
 parse-options.c               | 41 +++++++++++++++++++++++++----------
 t/t1517-outside-repo.sh       |  9 +++++---
 t/t5200-update-server-info.sh |  2 +-
 usage.c                       |  3 ++-
 6 files changed, 41 insertions(+), 19 deletions(-)


base-commit: e4ef0485fd78fcb05866ea78df35796b904e4a8e
prerequisite-patch-id: ffce2dd036e61c8d36485a17321f858e454db874
prerequisite-patch-id: 52539022c824997adfc1be0bed8de6b1851d2187
-- 
2.48.1

