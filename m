Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618511F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDXWq7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:46:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41148 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfDXWq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 18:46:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so10110125pgs.8
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2t4rm0rzM1jJEsnbjkaBbSB4SFaOkJ+oFURod14fMA=;
        b=XoWbeYNq93S45/obmj/Ggv+8sz5PUMJZLMxMeKuY+E9Y3KF+N9pYjxwTS0GtMcidnX
         mwx1caa6iEABtA8cz6VtmY8ys3fvHMuWbOj/UwWguVZcpRBEiz389lfyhdK2gdP+dwZu
         RI1PjfnxfFy86Z1mRowolgeKbxutcMrqLg0eJcYn6rqyhpJZrTay1RUC0d1+1WJ2pgDg
         S22pRsUfFwArb8SZeoeJBP4aNx8uInRot1kHeVGnXd5HZP8vSAr4CV1jekFSG1I3d6jv
         hWo29R6f9SMNlkk5rC9ZWPeR/OYBPNUQEthYuWnkwoFZgr8Ds1kiTqZEq/wWfH6RQWLG
         YsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2t4rm0rzM1jJEsnbjkaBbSB4SFaOkJ+oFURod14fMA=;
        b=gdF3wX1cMl3EVQ9ihisw1EFT2Dbq2dvRX/uo1gI1cpY7DJc2LQumG7Tg3RQmMMuT/8
         71uE0Ywb9SaIZATfxtXa7k7freQvVfXpbZbHyPmHci+Ti4oxLOfq7LvwHfjVcmph1hjv
         aWtjq/s7FkR7U2vGfiL43Efa7v3//+UMDzMN3MOpDFtnM2f6cqZ2GCK77AXhKIl8+bSm
         9pPqvuj0Z2euAEfI6xrdZoK/WFdgLMQqi+h/BXFAJ7iYSCMzCLcFKMyKcK9FNU6F30yz
         zg+2f7+710WmxBE51oITL7Ut5fpkj5NAD/VPfg6B33mCAp7foFKlN/usF6BwZ1960RAm
         hGvg==
X-Gm-Message-State: APjAAAU/tCyHtWhGSA92AbRZhOzn+pQ4mSiPReVLlrJmOCBLB9UEH5R7
        qfUT8zUKojJYRprVlq1+cK97uMY6
X-Google-Smtp-Source: APXvYqz314qyHC8CYAByEk0lUwcnpL2D1U7zGZO9Z9w4VE5hakjHpvjAozB+AnjFEFP/Jhh1Vwe4XA==
X-Received: by 2002:a63:3287:: with SMTP id y129mr33992527pgy.9.1556146017774;
        Wed, 24 Apr 2019 15:46:57 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id h189sm38640306pfc.125.2019.04.24.15.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:46:56 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:46:55 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/6] difftool and mergetool improvements
Message-ID: <cover.1556142510.git.liu.denton@gmail.com>
References: <cover.1556009181.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556009181.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Junio.

I hadn't thought about using the return code for `get_merge_tool` so
thanks for that suggestion. It should be a lot cleaner now.

---

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
 git-mergetool--lib.sh                |  32 ++++--
 git-mergetool.sh                     |  12 +-
 t/t7610-mergetool.sh                 | 163 +++++++++++++++++----------
 t/t7800-difftool.sh                  |  24 ++++
 9 files changed, 167 insertions(+), 91 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  9f9922cab3 t7610: unsuppress output
1:  c436765684 ! 2:  0f632ca6bf t7610: add mergetool --gui tests
    @@ -23,14 +23,14 @@
     +	test_when_finished "git reset --hard" &&
     +	git checkout -b test$test_count branch1 &&
     +	git submodule update -N &&
    -+	test_must_fail git merge master >/dev/null 2>&1 &&
    -+	( yes "" | git mergetool --gui both >/dev/null 2>&1 ) &&
    ++	test_must_fail git merge master &&
    ++	( yes "" | git mergetool --gui both ) &&
     +	( yes "" | git mergetool -g file1 file1 ) &&
    -+	( yes "" | git mergetool --gui file2 "spaced name" >/dev/null 2>&1 ) &&
    -+	( yes "" | git mergetool --gui subdir/file3 >/dev/null 2>&1 ) &&
    -+	( yes "d" | git mergetool --gui file11 >/dev/null 2>&1 ) &&
    -+	( yes "d" | git mergetool --gui file12 >/dev/null 2>&1 ) &&
    -+	( yes "l" | git mergetool --gui submod >/dev/null 2>&1 ) &&
    ++	( yes "" | git mergetool --gui file2 "spaced name" ) &&
    ++	( yes "" | git mergetool --gui subdir/file3 ) &&
    ++	( yes "d" | git mergetool --gui file11 ) &&
    ++	( yes "d" | git mergetool --gui file12 ) &&
    ++	( yes "l" | git mergetool --gui submod ) &&
     +	test "$(cat file1)" = "gui master updated" &&
     +	test "$(cat file2)" = "gui master new" &&
     +	test "$(cat subdir/file3)" = "gui master new sub" &&
2:  9f8e76a421 < -:  ---------- mergetool: use get_merge_tool_guessed function
-:  ---------- > 3:  ff83d25ff2 mergetool: use get_merge_tool function
3:  4847e64e46 ! 4:  e975fe4a8b mergetool: fallback to tool when guitool unavailable
    @@ -81,18 +81,18 @@
      	git commit -m "branch1 resolved with mergetool"
      '
      
    -+test_expect_success 'gui mergetool without merge.guitool set fallsback to merge.tool' '
    ++test_expect_success 'gui mergetool without merge.guitool set falls back to merge.tool' '
     +	test_when_finished "git reset --hard" &&
     +	git checkout -b test$test_count branch1 &&
     +	git submodule update -N &&
    -+	test_must_fail git merge master >/dev/null 2>&1 &&
    -+	( yes "" | git mergetool --gui both >/dev/null 2>&1 ) &&
    ++	test_must_fail git merge master &&
    ++	( yes "" | git mergetool --gui both ) &&
     +	( yes "" | git mergetool -g file1 file1 ) &&
    -+	( yes "" | git mergetool --gui file2 "spaced name" >/dev/null 2>&1 ) &&
    -+	( yes "" | git mergetool --gui subdir/file3 >/dev/null 2>&1 ) &&
    -+	( yes "d" | git mergetool --gui file11 >/dev/null 2>&1 ) &&
    -+	( yes "d" | git mergetool --gui file12 >/dev/null 2>&1 ) &&
    -+	( yes "l" | git mergetool --gui submod >/dev/null 2>&1 ) &&
    ++	( yes "" | git mergetool --gui file2 "spaced name" ) &&
    ++	( yes "" | git mergetool --gui subdir/file3 ) &&
    ++	( yes "d" | git mergetool --gui file11 ) &&
    ++	( yes "d" | git mergetool --gui file12 ) &&
    ++	( yes "l" | git mergetool --gui submod ) &&
     +	test "$(cat file1)" = "master updated" &&
     +	test "$(cat file2)" = "master new" &&
     +	test "$(cat subdir/file3)" = "master new sub" &&
4:  bc8cadaf55 = 5:  bc3e229171 difftool: make --gui, --tool and --extcmd mutually exclusive
5:  e5e4dc3dd2 = 6:  f39b15efbd difftool: fallback on merge.guitool
-- 
2.21.0.1000.g7817e26e80

