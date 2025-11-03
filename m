Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA721D3F2
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179767; cv=none; b=Toc8FvfQTRBg3QIHRlDy9RUegJo2+8ifDk6w1OXgZTGPinnqInwOBcC/GvfDAybRxpIDYsJIQH5HGOb3nqKpDWNeezPUTz3eA49EBK+jttlzuX84cVvR/RAaKoOlAn63oVQ2N+Bl6T7FqasCVdaopjRDjiBe4L2ph8hlYSg+wnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179767; c=relaxed/simple;
	bh=0GGv0ekWFSZ2w2CEw6kz2clDJREG+V3TYosE/j0jFRQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WxdhI7MsJ6+LyHHXXm/4oWJ9F8fqJGYNWyqiPsAvA4ULJodci7gyq3eRL5ALzdPGa40+R27hQTkrdBBZNgoYyQy/yqDOaamD/2tGKUEXiEQurEQl2FJYcCbEDzJRTj/ug+SWErCg2kt+GSr2/mbcM7XaIYkHW1fudDZfIO4qbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud2dS/sf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud2dS/sf"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4433887b3a.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179765; x=1762784565; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wN7mM9KvNWutaWZlr+yByUPDAxbfEyoo0ESuuIXzq2U=;
        b=Ud2dS/sfeS39irFyiTZBwxlVIRIA08n9q2xRs8zwhhzKG6QyWtj72AyUcc1dqu0m/S
         nHvPW7JJgWjDfrauzyS+F+ozsTWQHbWMfm3BBnkv2JTMuzoSth01SWTgHJL9OqVSLzP2
         Hq0vJIng84+nJhwB3tMvLffON1yR2jzBCBno7NlP2oW/6ZaxNZGis6ssmKERWktQsh9T
         QPo6tt6TM1dkp7oHxyLmqffrwAQN2XCTs/vme5mAC5ge6FEEdb+H1WJxgu2mq5931QaU
         DW9V9exePu4+//S7vF/CVeiQxFvM52ux+XCIcsL9BQt/yyYy8vOG56PzZeK8MrL1uklf
         xDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179765; x=1762784565;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wN7mM9KvNWutaWZlr+yByUPDAxbfEyoo0ESuuIXzq2U=;
        b=KI/anleFi6I1L7PNPHsP7oC78/JsYBXbZxsQIBzKepwEcl6mMdag5YNFpG57Ni7/LD
         5NSPxQT5asrLSu/ro2ycXs31a9cNv9NLZhb3foI5H2EY2SMEiWb7opO+2PXjL9gPUX71
         1ERhb8oTcKCkLbkpX16sQYRAORQV4EHoXhqi/QZ/XUAEV4hjcOZg0BLhJdq20tSS2m7J
         QaBw08z5mRVmQ1DiR2AyVHeNWrYVudAzuxxhypqiB8illJcwPAWK7hToJbHCFOKxupcq
         9mTcTgeQCIvX0PbLgTYT6LGWRSrB2vNiWUIA3GmW3C1invNsnxfG6w8fUtaouv7Rwcjj
         MtwQ==
X-Gm-Message-State: AOJu0YxhhRkUGYtdTD4VFtKP5jhgvU7Ttdf8fQXTMycPsPSFvfsnzQuE
	hDx40cYc9WSrp88rzjvgS39pIN1sjOCaJsB1bHQQ4uXufh0wd1XusK3O52VzQVOj46rzwJYi06a
	VFjJzmE1GfXEZBNKX+hvgikWNic81NHy6xRALNs+dADm/
X-Gm-Gg: ASbGnct6vkoB/fRfQWKeUyZ7fUrqTzfdM7UzPOoM+f1YG8puj7envpwoyGBzW31L2/n
	ytAnvsJ8AgR8PuOiSEt+wYrwUr4chh5La8DEMrEgkG+JqR8OyzwyyfozYuOrl3Ux38PbSRj3LNd
	CRPtSG77MDrXlb3vJWxYZuFACy+U2gvCrYFnjry2tPzSluCfwkwkCO+O9DQRIaODw/02sqEW/Vh
	BO/7cBmydbbQlxe1aWWbnfBxKlFF/jKskPg2Qlg57gi4OvtJgciQeladLoVDE1OGq5vyxmeQcZN
	OvhG/GwUa3Fkv/UU60gk62YDzJ8fswIiZMZ5vq5ACc2+ryVM17D6N4qepWTaOJGlW26BKD1xwg6
	7pQleJf4IwvfD844/a5RGXlJLsieyBxxdEE8TTpnEJO+w4NNi8KWiB2aeDPBBWA==
X-Google-Smtp-Source: AGHT+IHk0SfGdUUMJaUWV7Wi6iXrKiXSqlcQMKhl3RjOeXlt1/PqJg9mgKd4jSizHuwutgRGBAwodz3Qjo1Az2adWaU=
X-Received: by 2002:a05:6a20:958f:b0:343:5465:bb99 with SMTP id
 adf61e73a8af0-348b9f93e81mr16910689637.6.1762179765085; Mon, 03 Nov 2025
 06:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Solomon Akpuru <solobarine@gmail.com>
Date: Mon, 3 Nov 2025 15:22:32 +0100
X-Gm-Features: AWmQ_blHY1O4_esJGpYzNUW5DhfUDubXbsFUN7LK3WpihjXXoFScy9fBvBUm95Q
Message-ID: <CA+tvzBUr8ExMPLrNcppX9tiBvhrAG9RNwBU55evQgVvTrGzi4Q@mail.gmail.com>
Subject: =?UTF-8?Q?=5BOutreachy=5D_=2D_Proposal_Submission_for_Refactor_in_or?=
	=?UTF-8?Q?der_to_reduce_Git=E2=80=99s_global_state?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Personal Bio
Name   Solomon (Solly) Akpuru
GitHub  github.com/solobarine
Portfolio solobarine.netlify.app
_______________________________

Overview

The Git codebase currently contains several global variables,
particularly in environment.c, that govern configuration and runtime
state. This architecture makes it harder to reason about concurrent
repository operations and limits scalability toward multi-repository
support.

This project aims to refactor environment.c to reduce its global state
by migrating relevant environment and configuration variables into
struct repository or struct repository_settings. This will improve
code maintainability, make the behavior more predictable, and pave the
way for better isolation across repositories.
________________________________

Motivation

Reducing global state is a long-standing architectural goal within
Git. It improves testability, reduces hidden side effects, and allows
multiple repositories to coexist in a single process safely =E2=80=94 an
increasingly important concern for complex integrations and GUI
clients.

The project continues the ongoing modernization efforts within Git=E2=80=99=
s
environment and configuration management, aligning with recent patches
that relocated configuration options from global to repository-local
contexts.
________________________________

Technical Goals

Audit global variables in environment.c and related modules.

Identify variables suitable for migration into struct repository or
struct repository_settings.

Implement refactors ensuring all code paths properly initialize and
reference the repository-local state.

Maintain full compatibility with existing functionality.

Update and extend the test suite to cover modified logic.

Document the architectural rationale and the migration steps for
future contributors.

________________________________

Methodology

Study prior commits where similar refactoring was done (e.g.,
environment and config-related globals).

Use static analysis and grep-based search to identify read/write
access patterns.

Refactor incrementally, submitting each migration as an independent
patch series.

Collaborate actively on the Git mailing list, incorporating reviewer
feedback promptly.

Rely on Git=E2=80=99s existing CI/test infrastructure to validate changes.
________________________________

Project Timeline:
Dec 8 =E2=80=93 Dec 21, 2025 Studying environment.c, mapping globals
Dec 22 =E2=80=93 Jan 4, 2026 Implementing and submitting first patch series
Jan 5 =E2=80=93 Feb 1, 2026    Extending refactors, handling interdependenc=
ies
Feb 2 =E2=80=93 Feb 15, 2026 Testing, documentation, and refinement
Feb 16 =E2=80=93 Mar 6, 2026  Final submission and wrap-up
________________________________

Expected Outcome

Significant reduction of global variables in Git=E2=80=99s environment hand=
ling.

Cleaner, more modular architecture for configuration and runtime data.

Improved multi-repository handling capability.

Comprehensive documentation and test coverage to support future contributor=
s.
