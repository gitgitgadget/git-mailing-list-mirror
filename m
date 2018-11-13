Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799111F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeKNEzf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:55:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50937 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKNEzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:55:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so13152310wmw.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C85E1WdhPN3qVm7RjODMupHm6kywiZa9sk1cR5sxw3E=;
        b=JwlJTPhuvlw1ID3a2zJmMaYydpQAhipeL+y3zcqpehYMGpCRKl6qmUTedTB6M0GNIC
         gTSQ7nyHizCac6AcnJiSaPWSUjhGrc0i+U96Ttc5aGmsw0YtOEs2Eju/0qww6RZ4sPRY
         szCzi9tU95ivXJvIEqYkIHw26YSMHV7D7+rZwLVG7k35Q4y36ZO9TzcnKhx7wgEeTi8D
         vRU0E6KxCXYmPWOjoQceHvI9b2viBvuzfOJ8k6X35s7mW7R0qjtBHmY8FJNqbl2OFcxE
         cVg9jW7wCShJ61UsVJ7TqpQaI+l09fg+vVjWzMQdiCDbSZc1OZy5UyaZm1VZpbq9Oggd
         O9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C85E1WdhPN3qVm7RjODMupHm6kywiZa9sk1cR5sxw3E=;
        b=NYzjOOa6Vz5cwTRJJD0MsiD+XGdUYCekiNX4h4DBtOsRRMc7Ivqeo1Prfu1/Q3q1HT
         DxRQuMEP432591eoC4lzvyEKI4pyNAjFEMkw5n28EFhgxapyz5mWAKb23W8r/agISr5z
         dReOcMt187tjUaJQTrXtM8ExKutgJxhNKpTdW0it+OvwvQreTgmfZ6F12g1XBxDazQnX
         r3sqlFe3u8FSjPxQiF9zfpj/grouiK5Mw9MYCbUjgMJvV2fnj3VEup3ThvGC89BbNuuf
         Mwewm2K5dBPaSrNokJQkNQSFI1YVbTECYNVj522SauZMmEccMCvzcLOzi5rMV1lkomzj
         jMMg==
X-Gm-Message-State: AGRZ1gK9CwVtIU6SlBhzQpTivZ2WLeQBfsOVfiYmuNn9rapV34DLNO/X
        eHDr+AdoHg6cA232p/K3aDveSXBuru8=
X-Google-Smtp-Source: AJdET5c0xER1PHE07Wz3DBkqeDKQUkGyWQprMfecmx0eFrZx7WtWp1Oqeqm5f77/PrDxccjhsZcCTw==
X-Received: by 2002:a1c:d94b:: with SMTP id q72-v6mr4460434wmg.41.1542135367989;
        Tue, 13 Nov 2018 10:56:07 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y81-v6sm9908268wmd.11.2018.11.13.10.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:56:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephen & Linda Smith <ischis2@cox.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/3] range-diff fixes
Date:   Tue, 13 Nov 2018 18:55:55 +0000
Message-Id: <20181113185558.23438-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <xmqqftw73r9a.fsf@gitster-ct.c.googlers.com>
References: <xmqqftw73r9a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trivial updates since v4 addressing the feedback on that
iteration. Hopefully this is the last one, range-diff with the last
version:

1:  5399e57513 = 1:  f225173f43 range-diff doc: add a section about output stability
2:  e56975df6c = 2:  77804ac641 range-diff: fix regression in passing along diff options
3:  edfef733c7 ! 3:  ed67dba073 range-diff: make diff option behavior (e.g. --stat) consistent
    @@ -17,8 +17,8 @@
     
         But we should behave consistently with "diff" in anticipation of such
         output being useful in the future, because it would make for confusing
    -    UI if two "diff" and "range-diff" behaved differently when it came to
    -    how they interpret diff options.
    +    UI if "diff" and "range-diff" behaved differently when it came to how
    +    they interpret diff options.
     
         The new behavior is also consistent with the existing documentation
         added in ba931edd28 ("range-diff: populate the man page",
    @@ -36,7 +36,7 @@
      		memcpy(&opts, diffopt, sizeof(opts));
     -		opts.output_format |= DIFF_FORMAT_PATCH;
     +		if (!opts.output_format)
    -+			opts.output_format |= DIFF_FORMAT_PATCH;
    ++			opts.output_format = DIFF_FORMAT_PATCH;
      		opts.flags.suppress_diff_headers = 1;
      		opts.flags.dual_color_diffed_diffs = dual_color;
      		opts.output_prefix = output_prefix_cb;
    @@ -45,6 +45,12 @@
      --- a/t/t3206-range-diff.sh
      +++ b/t/t3206-range-diff.sh
     @@
    + '
    + 
    + test_expect_success 'changed commit with --stat diff option' '
    +-	four_spaces="    " &&
    + 	git range-diff --no-color --stat topic...changed >actual &&
    + 	cat >expected <<-EOF &&
      	1:  4de457d = 1:  a4b3333 s/5/A/
      	     a => b | 0
      	     1 file changed, 0 insertions(+), 0 deletions(-)

Ævar Arnfjörð Bjarmason (3):
  range-diff doc: add a section about output stability
  range-diff: fix regression in passing along diff options
  range-diff: make diff option behavior (e.g. --stat) consistent

 Documentation/git-range-diff.txt | 17 +++++++++++++++++
 range-diff.c                     |  3 ++-
 t/t3206-range-diff.sh            | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.19.1.1182.g4ecb1133ce

