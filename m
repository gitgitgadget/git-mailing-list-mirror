Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7111F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKSAVa (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41271 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id 207so3067314pge.8
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=40fgqpmrMKOI32ZIBmZnbT7iElTm0WcHAaClYapPB/U=;
        b=eAl9VUWjFQe55M5rq3Rl8n/Wy+RC9/a8C/qj+TV11grPOAhehw+cd9lqWK+1w/VbRp
         5tZarPX6yKWELbJvGrWX9Wyb7MhWnm/IMpxl3NkRtO3qqqnLARomv/QhCv9TSOofBn9t
         P5EXGUnldir95Dfpa6RMLrjENdpG93MOlpB9ZbfAaBBAO4XlNOjRnK0xTW1BkMUQz/e0
         C0JqgFcEdXzTvRbL3ZBcxMz8HJpMpNGa5Qja1+mmk2kD/9Rj5CFGs4k9dvSrsEtUHdfq
         w2ovJQ0HVNTI1yiEct3jtU891VQWSiPlUqqfWuKtdeAFMQS5kTbnWa5O6fkG5v3G8d7e
         xy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=40fgqpmrMKOI32ZIBmZnbT7iElTm0WcHAaClYapPB/U=;
        b=JkF/hncmzmdr99YJv5drvevs3M+OaHo+t25lcHveyz5soDBmXVlkQErmdv00Y/I8ER
         3RPMlGXsO5CPb+HQwEbwZjJx8aMhRk6KKPeN5I0GL4SjGqLQ4zXBnMyAFdMzjcJ7Ywkg
         r7koE7wvfM1hEtF9SESoNP5czAKU4kUA0OpJL8cPzOk7EtyU8CNvin+xf1yE7iYvI1lU
         ZGcFu3p1OsFu49B+/O7gDvLIGfOxmT9FFvUM8qw440zYn051wF0y15ELHis+rWJT9uZZ
         xmf95GmJ25d9HKJJC579b58oGIaawvZ28+JMxti1q5y+3eAzs+YpqAKfILGflAYBPN7g
         PO3Q==
X-Gm-Message-State: APjAAAXgnDVuonRut3rzV9PCAj3EDxa34KoqOl/4jY7pQuzxdI2VklBj
        pbORJCn0zhrybg7OXAT8sBDPp0b8
X-Google-Smtp-Source: APXvYqwFWQcd+6XubL43PtcQTCHSI2RHQM5x+upiifW76qTxUZO7qN0khGNRFRe8N5un6G+OAmF1kw==
X-Received: by 2002:a63:ca06:: with SMTP id n6mr2183050pgi.81.1574122888115;
        Mon, 18 Nov 2019 16:21:28 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id l21sm627843pjt.28.2019.11.18.16.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:26 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 07/11] t4205: cover `git log --reflog -z` blindspot
Message-ID: <78e4d75d2b1c22c7340f3794c88ab7b294402d5b.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite does not include any tests where `--reflog` and `-z` are
used together in `git log`. Cover this blindspot. Note that the
`--pretty=oneline` case is written separately because it follows a
slightly different codepath.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f42a69faa2..0335b428b1 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -134,6 +134,36 @@ test_expect_failure C_LOCALE_OUTPUT 'NUL termination with --stat' '
 	test_cmp expected actual
 '
 
+for p in short medium full fuller email raw
+do
+	test_expect_success "NUL termination with --reflog --pretty=$p" '
+		revs="$(git rev-list --reflog)" &&
+		for r in $revs
+		do
+			git show -s "$r" --pretty="$p" &&
+			printf "\0" || return 1
+		done >expect &&
+		{
+			git log -z --reflog --pretty="$p" &&
+			printf "\0"
+		} >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'NUL termination with --reflog --pretty=oneline' '
+	revs="$(git rev-list --reflog)" &&
+	for r in $revs
+	do
+		git show -s --pretty=oneline "$r" >raw &&
+		cat raw | lf_to_nul || exit 1
+	done >expect &&
+	# the trailing NUL is already produced so we do not need to
+	# output another one
+	git log -z --pretty=oneline --reflog >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup more commits' '
 	test_commit "message one" one one message-one &&
 	test_commit "message two" two two message-two &&
-- 
2.24.0.420.g9ac4901264

