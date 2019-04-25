Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726A31F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfDYJyf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:54:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38655 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfDYJye (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:54:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so10935095pgl.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zGmu0NH5G0xLDbj9wXpqanCYZl3gHKarp7OZrHIHS40=;
        b=adUiWC3q4BYH0GE2n2q3L3FsPx/S6VMIyrAdG7terwWwKm1ZljYzPixCurmUkjET/R
         Vn8PswtQLC6H5MmkngI48rCsZyiFBfn9+SEGvoi3PvR33lTMxdGVufTUqQftK+t5rHXL
         nl8syNzVgikXdtSEvBS0Y3jem0N8a91FgQwPeDtewQmvR02dRsqQdUt7NeLjWGokxzvJ
         L+WmcoJY0SVEm+H9XABKwQCgQxMhCTBB/9B3VAdN0f9alr2FoAEMvZlKCiYH44HS2Itj
         l8JPNqo2uW14qSSTDBEMqkWwop1mlesuhf4q8u2JG/snrQ81rp4Uede/CDD+JjshIbyo
         6EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zGmu0NH5G0xLDbj9wXpqanCYZl3gHKarp7OZrHIHS40=;
        b=I7rNwz6SoHK2r1vdXNLbChwe7/KNNNlfvZ+WDc8AxdwKFzMRTsWfX5jxQISchEoMTY
         Vbh4pgC1ePMrmpHPhPKK+ML0A9ImtFi+4h7AuHyVjnykzrKXpklkhRHDTheYeDkgAcG1
         8WBvDtN9HwIzcf0vQhLbVWrhdEu974tOyrRqTdOTwzaqyjq60KMolr6ZtM7igkhbM8R3
         UC60TL8aMCe7uwKk7tuDLDnOocV00CSYjPhK29bBnJ73VyrfZUofWBzJYY1PiBRDDgBZ
         9nM3cF4L6Vtxv5Uf/rYYY3mi/R/nulz7gspYbctTBD7p1ql+Tj0OL7FfJa+s0dk5aOdl
         iwZQ==
X-Gm-Message-State: APjAAAUBbVv3OlPSH7kShYpI4iafNWpxKsLsKO5tRul1wbdhOhIhv4M5
        AawLBu5tGInEeZcTmKDrZAdbUF7p
X-Google-Smtp-Source: APXvYqzla2Htt/ZoAc7YJmmrP8liddPENz1uhopiVpZJ/0cGq5sqj5zslcdTlq+6SdJ2JT14+HOfZA==
X-Received: by 2002:a63:4558:: with SMTP id u24mr34538040pgk.225.1556186073170;
        Thu, 25 Apr 2019 02:54:33 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id j22sm29531195pfn.129.2019.04.25.02.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:54:32 -0700 (PDT)
Date:   Thu, 25 Apr 2019 02:54:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/6] difftool and mergetool improvements
Message-ID: <cover.1556185345.git.liu.denton@gmail.com>
References: <cover.1556142510.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1556142510.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for another review, Junio.

This should basically be the same as v3 except I've moved the IFS
assignment into a subshell so its value does not leak out.

I'd like the change in 4/6 to be reviewed carefully. t7610 and t7800
run properly with dash on My Machineة, but I couldn't find a reference
on whether my usage is POSIX legal or not.

We do have precedent for using fors within a subshell, though, from a
quick git grep:

	t/t3202-show-branch-octopus.sh: git show-branch $(for i in $numbers; do echo branch$i; done) > out &&

Thanks,

Denton

---

Changes since v3:

* Move nested for into a subshell so that IFS does not leak out of
  function

Changes since v2:

* Unsuppress output in t7610
* Make `get_merge_tool` return 1 on guessed so we don't have to deal
  with parsing '$guessed:$merge_tool'

Changes since v1:

* Introduce get_merge_tool_guessed function instead of changing
  get_merge_tool
* Remove unnecessary if-tower in mutual exclusivity logic
Denton Liu (6):
  t7610: unsuppress output
  t7610: add mergetool --gui tests
  mergetool: use get_merge_tool function
  mergetool: fallback to tool when guitool unavailable
  difftool: make --gui, --tool and --extcmd mutually exclusive
  difftool: fallback on merge.guitool

 Documentation/git-difftool.txt       |   4 +-
 Documentation/git-mergetool--lib.txt |   4 +-
 Documentation/git-mergetool.txt      |   4 +-
 builtin/difftool.c                   |  13 +--
 git-difftool--helper.sh              |   2 +-
 git-mergetool--lib.sh                |  37 ++++--
 git-mergetool.sh                     |  12 +-
 t/t7610-mergetool.sh                 | 163 +++++++++++++++++----------
 t/t7800-difftool.sh                  |  24 ++++
 9 files changed, 172 insertions(+), 91 deletions(-)

Range-diff against v3:
1:  9f9922cab3 = 1:  9f9922cab3 t7610: unsuppress output
2:  0f632ca6bf = 2:  0f632ca6bf t7610: add mergetool --gui tests
3:  ff83d25ff2 = 3:  ff83d25ff2 mergetool: use get_merge_tool function
4:  e975fe4a8b ! 4:  c799e871e2 mergetool: fallback to tool when guitool unavailable
    @@ -6,14 +6,18 @@
         not set, it falls back to `diff.tool`. Make git-mergetool also fallback
         from `merge.guitool` to `merge.tool` if the former is undefined.
     
    -    If git-difftool were to use `get_configured_mergetool`, it would also
    -    get the fallback behaviour in the following precedence:
    +    If git-difftool, when called with `--gui`, were to use
    +    `get_configured_mergetool` in a future patch, it would also get the
    +    fallback behavior in the following precedence:
     
         1. diff.guitool
         2. merge.guitool
         3. diff.tool
         4. merge.tool
     
    +    Note that the behavior for when difftool or mergetool are called without
    +    `--gui` should be identical with or without this patch.
    +
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
      diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
    @@ -61,14 +65,19 @@
     +		keys="guitool $keys"
      	fi
     +
    -+	IFS=' '
    -+	for key in $keys
    -+	do
    -+		for section in $sections
    ++	merge_tool=$(
    ++		IFS=' '
    ++		for key in $keys
     +		do
    -+			merge_tool=$(git config $section.$key) && break 2
    -+		done
    -+	done
    ++			for section in $sections
    ++			do
    ++				if selected=$(git config $section.$key)
    ++				then
    ++					echo "$selected"
    ++					return
    ++				fi
    ++			done
    ++		done)
     +
      	if test -n "$merge_tool" && ! valid_tool "$merge_tool"
      	then
5:  bc3e229171 = 5:  7d7c936cd3 difftool: make --gui, --tool and --extcmd mutually exclusive
6:  f39b15efbd = 6:  b642ed3b1e difftool: fallback on merge.guitool
-- 
2.21.0.1000.g11cd861522

