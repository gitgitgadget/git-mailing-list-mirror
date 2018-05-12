Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E60B1F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeELJ0X (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:26:23 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36450 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeELJ0V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:26:21 -0400
Received: by mail-it0-f66.google.com with SMTP id e20-v6so5094499itc.1
        for <git@vger.kernel.org>; Sat, 12 May 2018 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hUI5fbUU7pfijoI86C1b97gDnIdvY6lm90ghdMqGzo=;
        b=CvWYxAvFSI5NurNn2rYnF/W8/PvuANL0BnVEaJAZlAiGUj2K7I3kYQSnDsEcEN0nXg
         7DcqGGkEmwwnrzEDT4ZgLAf729NU6fmyWxRQ18pwFlU+RgWZ2Y1KQF9TKyC7yvZaT786
         ti+nzlO/8ZjCVERLN5gNWTn9TM9bbVEkycEo8E0c7knVRIaeHQItVHOPTM7lwItelTWf
         ae20L4Yk8UHxWUmYRgyvRhEzlzX0Jq3eOMLHGLhfM3jnyIe8Z/5gESKoN7MGyRh/TxlN
         fX9osBOnQS2dIn1jxTr8qSZS9Bpxa1+1oj8tF9pKGmCcl0R5JJohCTC6lMfQE5+3G5tt
         FtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hUI5fbUU7pfijoI86C1b97gDnIdvY6lm90ghdMqGzo=;
        b=BFx2ZYcodMCRsmpzVC8sEJyb8Ck+tzaNLNK5rQH+7oaxV6ax+os5L+NdAfMYKfZ6O6
         aCQd+Xg2Cytovx3MTo9RKsrjcrjAJ3pzPm3sTD6md8ee9fk7OJmMDkzOIkCOz4SuXe8O
         fy/S4QTqWAv2bq+dMcFslnn/TesVZ3Dq282/KW4oYZAM6QBNAQDKicCTdDShdcfoTEvZ
         UWuQbigF7mHlzwSWeJHoEdBYxa5XbxCd0e9MP5wXCE5J4CxIDRfr/uijF8bdKhGEq63w
         9bqHOceyk1jiOHGL7jczU5u3xTZNR3HkK/5QBOB+W2k1+5cRdXEObXr4ZL0VZsedK+vE
         lr+A==
X-Gm-Message-State: ALKqPwfvemTdrglLaCC0eJLZOPAAxMTdjpVaxWZtllUV8fhVKt5r9Bq7
        GZAmpRQbRLQKP5GPPHuCqMQ=
X-Google-Smtp-Source: AB8JxZr7Cxg6p7b7HSJfhTy2Y9b674VueryKw4iPXKoaM/C4VmQ3fhn3lhNT0TuAjbNs5GNhBfq8JA==
X-Received: by 2002:a24:cfc4:: with SMTP id y187-v6mr1459355itf.26.1526117180813;
        Sat, 12 May 2018 02:26:20 -0700 (PDT)
Received: from lmm-notebook.localdomain ([2607:fcc8:ab60:f900:a617:31ff:fe15:270b])
        by smtp.gmail.com with ESMTPSA id y192-v6sm1633088itb.0.2018.05.12.02.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 02:26:20 -0700 (PDT)
Received: by lmm-notebook.localdomain (Postfix, from userid 1000)
        id 7C05C6F000000023F0D; Sat, 12 May 2018 05:17:43 -0400 (DST)
From:   Luis Marsano <luis.marsano@gmail.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH v2 0/2] Configurable GnuPG command for git-credential-netrc
Date:   Sat, 12 May 2018 05:17:26 -0400
Message-Id: <20180512091728.4931-1-luis.marsano@gmail.com>
X-Mailer: git-send-email 2.17.0.584.g3d5ba9c85
In-Reply-To: <20180509213634.5198-1-luis.marsano@gmail.com>
References: <20180509213634.5198-1-luis.marsano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated per Junio's comments.
- clarify commit messages
- explain usage placeholder style as conformance with main coding style
- drop Unicode dependence

Unicode punctuation was initially included for semantics & accessibility, since assistive technology like screenreaders handle … better than ...
However, character conversion between encodings is typically handled through Native Language Support such as gettext, which recommends untranslated strings in ASCII.
Therefore, strings remain in ASCII to ease extensibility in that direction.

The following changes since commit ccdcbd54c4475c2238b310f7113ab3075b5abc9c:

  The fifth batch for 2.18 (2018-05-08 15:59:49 +0900)

are available in the Git repository at:

  https://github.com/lmmarsano/git.git 

for you to fetch changes up to 62a76a1eb7906199b731858ae2d193cfdd3176e0:

  git-credential-netrc: accept gpg option (2018-05-12 03:27:45 -0400)

----------------------------------------------------------------
Luis Marsano (2):
  git-credential-netrc: adapt to test framework for git
  git-credential-netrc: accept gpg option

 contrib/credential/netrc/Makefile             |  4 +-
 contrib/credential/netrc/git-credential-netrc | 58 +++++++-----
 .../netrc/t-git-credential-netrc.sh           | 31 +++++++
 .../credential/netrc/test.command-option-gpg  |  2 +
 contrib/credential/netrc/test.git-config-gpg  |  2 +
 contrib/credential/netrc/test.netrc.gpg       |  0
 contrib/credential/netrc/test.pl              | 88 +++++++++++++------
 7 files changed, 135 insertions(+), 50 deletions(-)
 create mode 100755 contrib/credential/netrc/t-git-credential-netrc.sh
 create mode 100755 contrib/credential/netrc/test.command-option-gpg
 create mode 100755 contrib/credential/netrc/test.git-config-gpg
 create mode 100644 contrib/credential/netrc/test.netrc.gpg

-- 
2.17.0

