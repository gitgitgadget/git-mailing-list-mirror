Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B96336885
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499114; cv=none; b=TMswyysR4ZwL23rykZeix6uCaql+exMFxBQy4myHbAEigjCACUjVhyFd2HfwwdwOAoiGWkg9nS+iofAS1SjOkoghWjCEI4H/IfTZVH0rVzZtq/JT9/JzTkBpeW2HpDUuSdiGVHr/gMkRLfLAWz9G4QlZZZK+4jcfUNtLGtsxBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499114; c=relaxed/simple;
	bh=a2wwUNgeXOmUeZmABngoZRzyNhNN3Hleib3poxPfiJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lANZWQKswEYojEp/FjjSN2k4MwQ6pEJO6L4eAtt9K4IFsLBv6InKM32DbSNhFIdU/znK6ero3ls/uazVzZoHO3OZEq2f9+WfEOAR7GrjBeaialYACOY3AXFmrcffmHlv4jU5KrXTnI9iX2o5Z28o/BfbsYuZIll7Yu/1un0p6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic91dKcb; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic91dKcb"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca09f2056so2416168d50.2
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773499112; x=1774103912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwRsE5U0QzgXcCGouHN+6NnBawivyOGZJOQ3G8DOiFI=;
        b=Ic91dKcbKfFoQ2QnK+sv9itRvM+2WeCayYePqbcjKoWuDTvok2knxtFqjAliDvgfWx
         XHtxmyUcCoLzq/Yqt9K91qTjdC/djlAOyBetxxXW73dCMuJl8ZLCgNamhkDBLkAnBVJB
         G9dMv+K7aYJcWSWplYG8EQ5lve/2TP9F6nrY4gYsaEzdq+P4z/+f7rfgxSPoLS6kcJDQ
         OgjWJviqyFAQ5vTewYcwCttntJWltIWrh6L26b1Dhh003S/tDW8CFhR9NapZBBvatWeJ
         Ks7Ngd7rPkogkU+1eSnbud9WKbuBScCMSNl7/RzEM75Aj53qLh0wadnNPtiVdxEZPhzn
         gfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773499112; x=1774103912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KwRsE5U0QzgXcCGouHN+6NnBawivyOGZJOQ3G8DOiFI=;
        b=sS0FK/+JK6XRZ3awJtKtjPsQ7Zi8YDpIk5+Hz43JHnOLq6Q2/3rRGYUP4dncGKuJvR
         osBdhUAd9d0bZjC2A4T/RMft+jkYO9IFhXcvv5QOZyt4BuHtG1GmwJyYuUidW1xV5XHh
         k/ivc88LcLpAO/0BK26uwcJyOhY8tfhM7j0SUMJJ4t1OdzJtv/0Q/U3KL1SLdAWiCgVQ
         mZupjgp7ceaQB0fZzg2qNft8X0E9MMG6AJXdYHALFlHqGijyARk3Aed7mNoWuxySRZkU
         nWniVYqoisfto6vgdfY7z6yjHl3+6/hcQMg2QwR+di5rMQEHvBM+Ek0vORs3931C5PGo
         9f5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+j9YcOXa8y32/J6z8AhOk9HhMe41bOH9Wg/abtc+YXWtxvOVu+KUVxJXVjuK2YxYzlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiyL2dDPCwPGNuynK+CWjA/NDsQWCPhu8fU+4/iNPEhUdpo7dl
	vpSi+d3/AOPlAMez9dgBAQdlOHSGYS5QGAKthWXzD9J6NaAKhZNwNcgY
X-Gm-Gg: ATEYQzxjrrmVIpRF790hPoLG3chnATh/1dGqb9ecp/p4WtPyBHD3d9TligH5MnF5b4u
	SZi7SlWd9ha+Z33mgeL5GdBduaRJ79v3DdYZF1BipO+vhknGTS9KHnQRYIhrnmMma4q8JU27Z64
	pj4cF70f/mTl8RbyR6NWe4rTU6cDDmrz8xoxkDB7/cS+GsAT4s1Q2QlfdG6Ukof8fUcSG+252TW
	EunTkUsTnUxEzVThfnqQDMLacKBlB86mInyo/8LHmLrmp1rqVXmvgd2oC1f8ce7kg2zRzUYS4W3
	uU0YDlCR3e7/Ci33fUgibZfM1kqUfFnedRjB2iCBuQ1W3umh8bDw17WAWMUYWpw5+qasBZJ7B/V
	hgoYfG3s1yKaYlQUww5ZG4YOck29IoazoKB/d1a9loCuXEqL1zgcW1DzE8543UXJsjmNQGo0lfQ
	tNQJEQMwSJDPdhS6aZitvFAuwFH8idCCDySaGR8b1ZdXtdkvFIftLbQ+7qmHqbWlA0wSgKCvitC
	tXAdk9KhKpUUeD/0y9d3NXV8+ZSfoiQqxkfbw7i/wkVEYiVLdCvSqRnVzsTMI5fJk2hqAQzNwAF
	8wDz7/SDWEk=
X-Received: by 2002:a05:690c:6f0a:b0:798:980f:66f0 with SMTP id 00721157ae682-79a1c1ac305mr76847557b3.33.1773499111625;
        Sat, 14 Mar 2026 07:38:31 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f0846csm65264207b3.39.2026.03.14.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 07:38:30 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v3 0/5] docs(l10n): AI agent instructions and workflow improvements
Date: Sat, 14 Mar 2026 22:38:09 +0800
Message-ID: <cover.1773497547.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

## Changes since v2

- CI: Fix trailing spaces that caused check-whitespace to fail.
- Size: Trim po/AGENTS.md by removing unnecessary examples and compressing
  wording so the file stays smaller and easier to follow.
- GETTEXT JSON: Use a single `msgstr` array for all translations instead
  of separate `msgstr` (string) and `msgstr_plural` (array). One element
  means singular; multiple elements mean plural forms in order. This reduces
  redundancy and model errors.
- Workflow: Rename the final step of translation workflow to "Only after
  loop exits" so agents do not jump from the merge step to the final step
  before the loop has exited. Simplify the review flow by using one pending
  file for entries awaiting review instead of multiple review-input-<N>.json
  files and file-selection logic.

## Introduction

This series introduces AI agent instructions for Git localization (l10n)
workflows to help localization contributors quickly complete drafts and
use AI to check translation quality. The changes focus on:

1. Separating agent-specific documentation into po/AGENTS.md for
   targeted optimization of AI-assisted workflows
2. Providing step-by-step instructions for update-pot, update-po,
   translation, and review tasks
3. Simplifying location filtering for PO file commits via .gitattributes

AI-assisted translation is optional; many successful l10n teams work
well without it. When used, AI output serves as reference only—human
contributors must review and approve before submission.

## Performance summary

Benchmarks use the Qwen model via git-po-helper. The improvements reduce
API costs and make agent workflows more efficient while maintaining human
oversight of translation quality.

| Task        | Before              | After                    | Improvement                           |
|-------------|---------------------|--------------------------|---------------------------------------|
| update-pot  | 17 turns, 34s       | 3 turns, 8s (range 3–3)  | -82% turns, -76% time                 |
| update-po   | 22 turns, 38s       | 4 turns, 9s (3–9, 7–14s) | -82% turns, -76% time                 |
| translate   | 86 turns, ~21m      | 56 turns, ~19m           | -35% turns (git-po-helper JSON batch) |
| review      | N/A                 | 22 turns (63 entries)    |                                       |

## Testing

All changes have been evaluated with the qwen model via git-po-helper
agent-test and agent-run. The po/AGENTS.md instructions are designed
to work with coding tools that support file references (e.g.,
"Translate po/zh_CN.po by referring to @po/AGENTS.md").

## Changes

Jiang Xin (5):
  l10n: add .gitattributes to simplify location filtering
  docs(l10n): add AGENTS.md with optimized update-pot instructions
  docs(l10n): add AI agent instructions for updating po/XX.po files
  docs(l10n): add AI agent instructions for translating PO files
  docs(l10n): add AI agent instructions to review translations

 po/.gitattributes |  36 ++
 po/AGENTS.md      | 872 ++++++++++++++++++++++++++++++++++++++++++++++
 po/README.md      |  70 ++--
 3 files changed, 946 insertions(+), 32 deletions(-)
 create mode 100644 po/.gitattributes
 create mode 100644 po/AGENTS.md

-- 
2.53.0.rc2.20.g532543fa46

