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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B841F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfKGC4a (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:56:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34661 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfKGC43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:56:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id e4so867004pgs.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KsJfnLp2l/N4Yf8Z4bsXEXEB/mtob7Oh26bRGT/CXg=;
        b=j09odh5e/06rVKEehbfOFSaXwj5GMdWmXHvs3ZqQ1MzN85UWXrgUiWVTAqMQ0AxjV+
         IRudCbrHuxBqvVS3TsT5ZjQLAq0VPS3NRiDKWKYaoWh/hYLl9lizacJU+m+ZShHIrOnB
         UukE8mklwumPPC60y6NTgFiP46Q+fo9rfGXv4T76+QZn8jVgHPrs2KaLHNrdbDFYaIE2
         xA0RcqK8SM1tyTp4EFLjR+haXDjgqh40kzqABT+Vug5/fS0bphFlTqCeJ1rekSFwnuR/
         m558cka+08yLYPe1oAd6HZiN2UscxBVtGEnrMX/9OWpiO0zAlETNQe5e7eHPVxYwErtb
         laBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KsJfnLp2l/N4Yf8Z4bsXEXEB/mtob7Oh26bRGT/CXg=;
        b=bWBah7K9WOU7dvLqJNcokF/y1R/Gz6xwAcNLO4a/bTdo/jGwInl8rt8Zq7ESOCEiKe
         6h+wb/RjywEGWxeO6gkdXSjhO+OLoCEIt9ZLHrQI3frlnFs6nvWqvjIanRRwuq4SzBxh
         8xWL4/thWJe9eZgnMwFVgF8JIg/dya28vmZ5JifTXVJlZHPM2DATj7+WJluLwTENp1/0
         HxRdcCNGfW+GHL04sPrSjoQJO8sU3g0zFoO31b8Bzhm8TTvDSk7/yiSAdC+q1uNVreQh
         5AcXNB4WZeJ74GvjhCu8Jttd/cohQ5OkDLwg3hbwacEBE52AsfsMTXXldxTszrBioZq+
         RvGw==
X-Gm-Message-State: APjAAAVwqlbcT+HNQXrrdXcgMW50avXyZ23yqnm+0uui4fVKI0XoqRVC
        LK510xQTbqfpi8dMxbjhHk62LoRSCgs=
X-Google-Smtp-Source: APXvYqzGpVBodYPVDph3Y5McEcB4zrxkkMBxx1C3HvZ8l3zbLvTROnsftS8EUEvhNmh1YyTRP9/3nQ==
X-Received: by 2002:a63:ec4f:: with SMTP id r15mr1492611pgj.17.1573095388607;
        Wed, 06 Nov 2019 18:56:28 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id n15sm393767pfq.146.2019.11.06.18.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:56:27 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/8] Correct internal working and output encoding
Date:   Thu,  7 Nov 2019 09:56:11 +0700
Message-Id: <cover.1573094789.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g36796e2b67
In-Reply-To: <20191031092618.29073-1-congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The series is shifting from fixing test that failed on musl based Linux to
correct the internal working encoding and output encoding of git-am
git-cherry-pick git-rebase and git-revert.

Change from v3:
- Fix grammar and spelling in commit message.
- Add mising semicolon (I ran the test with dirty workspace right before
  making last change). Everything is OK this time, though.

Cc: Eric Sunshine <sunshine@sunshineco.com>

Apparantly, I couldn't spell unusable.


Doan Tran Cong Danh (8):
  t0028: eliminate non-standard usage of printf
  configure.ac: define ICONV_OMITS_BOM if necessary
  t3900: demonstrate git-rebase problem with multi encoding
  sequencer: reencode to utf-8 before arrange rebase's todo list
  sequencer: reencode revert/cherry-pick's todo list
  sequencer: reencode squashing commit's message
  sequencer: reencode old merge-commit message
  sequencer: reencode commit message for am/rebase --show-current-patch

 configure.ac                     | 49 ++++++++++++++++++++++++++++++++
 sequencer.c                      | 21 +++++++++-----
 t/t0028-working-tree-encoding.sh |  4 +--
 t/t3900-i18n-commit.sh           | 41 ++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 9 deletions(-)

Range-diff against v3:
1:  b3d6c4e720 = 1:  b3d6c4e720 t0028: eliminate non-standard usage of printf
2:  f07566c60c = 2:  f07566c60c configure.ac: define ICONV_OMITS_BOM if necessary
3:  662e5bd545 ! 3:  ca869cef57 t3900: demonstrate git-rebase problem with multi encoding
    @@ t/t3900-i18n-commit.sh: test_commit_autosquash_flags eucJP fixup
     +		git config i18n.commitencoding '$new' &&
     +		echo '$new-$flag' >>F &&
     +		git commit -a --'$flag' HEAD^ &&
    -+		git config --unset-all i18n.commitencoding &&
     +		git rebase --autosquash -i HEAD^^^ &&
     +		git rev-list HEAD >actual &&
     +		test_line_count = 3 actual
4:  6a51fdd29c = 4:  15c33fc245 sequencer: reencode to utf-8 before arrange rebase's todo list
5:  d382e35e4e = 5:  304ac6c289 sequencer: reencode revert/cherry-pick's todo list
6:  340902eb67 ! 6:  97ab88e5d8 sequencer: reencode squashing commit's message
    @@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
      		git checkout -b '$flag-$old-$new' C0 &&
      		git config i18n.commitencoding '$old' &&
     @@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
    - 		git config --unset-all i18n.commitencoding &&
    + 		git commit -a --'$flag' HEAD^ &&
      		git rebase --autosquash -i HEAD^^^ &&
      		git rev-list HEAD >actual &&
     -		test_line_count = 3 actual
7:  7f0df0f685 ! 7:  f295d32d7b sequencer: reencode old merge-commit message
    @@ Commit message
         will be used as message for new merge commit (created by rebase).
     
         In case of the value of i18n.commitencoding has been changed after the
    -    old merge time. We will receive an usable message for this new merge.
    +    old merge time. We will receive an unusable message for this new merge.
     
         Correct it.
     
8:  69ec40bb1d ! 8:  36796e2b67 sequencer: reencode commit message for am/rebase --show-current-patch
    @@ sequencer.c: static int make_patch(struct repository *r,
      	strbuf_addf(&buf, "%s/message", get_dir(opts));
      	if (!file_exists(buf.buf)) {
     -		const char *commit_buffer = get_commit_buffer(commit, NULL);
    -+		const char *encoding = get_commit_output_encoding()
    ++		const char *encoding = get_commit_output_encoding();
     +		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
      		find_commit_subject(commit_buffer, &subject);
      		res |= write_message(subject, strlen(subject), buf.buf, 1);
-- 
2.24.0.8.g36796e2b67

