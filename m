Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2719440
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqBcnemN"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A7FA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:34 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778927f2dd3so453485a.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744374; x=1698349174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0wq9TkbKro/3bWSuZr7rCyxJOjoPaRWMeDcfuiHf3I=;
        b=iqBcnemNa2o3zxJCFvqjl3Z7KyU01/o8C+KJljnTDypPvpPaYDdgYl1YmerhB70T5o
         EX/IJ/rJviaEwOuTRzyoXAwqkAxaak2t/hiiSSB1SAio3dO0JyVYAeFgkQw5wSj4acBx
         reItCw7xY/mf0OOOaqbMTTc0DLBKszNxfm+7M57YCoWK73gk5OoQHDUOPvcN4RMjCW2K
         xxjgNmOa+9I1QyyjqnWEZTMGhrGN5ITEHB6v1+Gv3qXwdBXjXzPsRWGRqNdPICT2CpSI
         gRvX3lskehs8AqXy+WjUQwSRdh5HFa6jDB5Gpal6QL4jxouU0uQLSoIQPcYm40PSweu1
         5Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744374; x=1698349174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0wq9TkbKro/3bWSuZr7rCyxJOjoPaRWMeDcfuiHf3I=;
        b=fwXvb3kTY2tTL7oXB4JGDiJRA/LeHOALcW23IB/HbMkL4HqNMOvmHxzWkskoHLo+6u
         7bfRdieMafgX9LallR0aLWA40fkgAZj+8DUWsXdxUCtE8pNOa9VeNDMSkP8NlEMdZBPl
         0KfJMy5S7uqs5TN4S+V1aGN1/HmewAvnaymf/5ZBJGeO9Otq+PMZEddUT1AhsTefvlZ1
         yjmbr7kQFFvlWm6GWbETkQaxSRphQpUv0WgRDCc4WNTARDKrNEUoUyfmzuTqS7nZVuPD
         hOB4YZKmEYsPbrGE2UukOY1IRHg44sMCD4ErEzErWnDgIQkX6x8AWG9tT2B1QUGv44Pt
         WmKg==
X-Gm-Message-State: AOJu0YzhNxzI3j4YXBRgow7h4ERpmv0+VkThWkf1xmm167VlZ125yIzc
	eG/5hhDULc8Vq5KUu/QEnGkbVsgOb4E=
X-Google-Smtp-Source: AGHT+IGjhhKSW0HHLrqYTe+BdKY9aDlKHu5rLvXDq1vAYrzPxRrS0AQ6Fjpn4jpsDlhRTvr5FwSr/Q==
X-Received: by 2002:ad4:5de2:0:b0:66d:3a89:812c with SMTP id jn2-20020ad45de2000000b0066d3a89812cmr3445780qvb.51.1697744373822;
        Thu, 19 Oct 2023 12:39:33 -0700 (PDT)
Received: from u.ad.analog.com (cpc99472-lich12-2-0-cust1752.3-2.cable.virginm.net. [80.2.214.217])
        by smtp.gmail.com with ESMTPSA id ph5-20020a0562144a4500b0066d0ab215b5sm99940qvb.13.2023.10.19.12.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:39:33 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 0/7] log: decorate pseudorefs and other refs
Date: Thu, 19 Oct 2023 20:39:04 +0100
Message-ID: <20231019193911.1669705-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231003205442.22963-1-andy.koppe@gmail.com>
References: <20231003205442.22963-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds three slots to the color.decorate.<slot> config
option:
- 'symbol' for coloring the punctuation symbols used around the refs in
  decorations, which currently use the same color as the commit hash.
- 'ref' for coloring refs other than branches, remote-tracking branches,
  tags and the stash, which currently are not colored when included in
  decorations through custom decoration filter options.
- 'pseudoref' for coloring pseudorefs such as ORIG_HEAD or MERGE_HEAD.
  Include them in decorations by default.

This series is to replace the 'decorate: add color.decorate.symbols
config option' patch proposed at:
https://lore.kernel.org/git/20231003205442.22963-1-andy.koppe@gmail.com

Andy Koppe (7):
  config: restructure color.decorate documentation
  log: use designated inits for decoration_colors
  log: add color.decorate.symbol config option
  refs: separate decoration type from default filter
  log: add color.decorate.ref option for other refs
  refs: exempt pseudoref patterns from prefixing
  log: show pseudorefs in decorations

 Documentation/config/color.txt                | 30 +++++++-
 Documentation/git-log.txt                     |  7 +-
 builtin/log.c                                 |  6 +-
 commit.h                                      |  3 +
 log-tree.c                                    | 60 ++++++++++++---
 refs.c                                        | 62 ++++++++++++++--
 refs.h                                        | 14 ++++
 t/t4013/diff.log_--decorate=full_--all        |  2 +-
 ..._--decorate=full_--clear-decorations_--all |  4 +-
 t/t4013/diff.log_--decorate_--all             |  2 +-
 ...f.log_--decorate_--clear-decorations_--all |  4 +-
 t/t4202-log.sh                                | 23 +++---
 t/t4207-log-decoration-colors.sh              | 74 +++++++++++--------
 13 files changed, 216 insertions(+), 75 deletions(-)

-- 
2.42.GIT

