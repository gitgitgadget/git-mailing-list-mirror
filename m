Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3BC20958
	for <e@80x24.org>; Sun, 26 Mar 2017 12:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdCZMRB (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 08:17:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34217 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdCZMRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 08:17:00 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so2054901wrb.1
        for <git@vger.kernel.org>; Sun, 26 Mar 2017 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Eqq7IJ6EcJx7Hg3RVENvMKFcMXuHBP8KImpdJZfFzc=;
        b=A4bO/f1Q+mbNZfYJlaU1biym1TxabgRaHnrTkOdlNXN+Mr9MHrspqCNGr8pNj6+JE6
         C2YSYSTjGZyJ/FKr9vNw2+P+yfH9BCbug76DOsDKoQnrmc8i+yNKqOSdnF2wpqhZpAUA
         4rimdYIlQopBZ5XMcsyV/76XFuGR3y5kTguQ8ZnM04I3rpjpDT0U2rW14aUtFQO6wH0r
         0h/ZizNKhbup0fObgLStCQGU1A69mGLWwqGj/1CZcLhB4V6U+fXxtXDJO8LQ48SJtXmB
         x2DZpUc9ixJ/rVLMJZDgsYcOy53vGbS3ZzYoCKeSNPVXuHOU44ACt4lVQc5lLIqa6T8m
         C6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Eqq7IJ6EcJx7Hg3RVENvMKFcMXuHBP8KImpdJZfFzc=;
        b=J9jUrOxiX3dFrOCUfnhabEt9/kGZ44RpMNamv/LN9Qt5M6mT1wumiqDJT9JTJPYUFL
         WzMLa/6e8Jk9CKScfNxv29ZBzR0CvIb3wZq2MAE0vo6RNf/UT5yLnsMfUCVup4hh0/mR
         5YBW2gRI7PiaBcD4cKP6qLypFOyKcW7AoiH8saLsaQaAHcVECu5uZRYH33ZrH0F8yxIC
         ns+EK49toENUAVqRBNtYupSh2g8EVB6QFvArdJ1hlVjtDCDQuR2cAEoF0GlO/FVQmNpg
         lckrMklU34evAuiLFZNL/FriOQxnotpJAEUt3QpCfxFUoUOvvrsROXQFfcSiq3zx5JFk
         U6eQ==
X-Gm-Message-State: AFeK/H05VC6N+/4UEJVOi0014yu+86HlCNiiNudQfbnknRi0qOfcqhQQKgqL6jjza16Mww==
X-Received: by 10.223.129.199 with SMTP id 65mr3676810wra.118.1490530618402;
        Sun, 26 Mar 2017 05:16:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 134sm10167638wmj.6.2017.03.26.05.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 05:16:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] rev-parse case insensitivity & @{p} synonym
Date:   Sun, 26 Mar 2017 12:16:51 +0000
Message-Id: <20170326121654.22035-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
References: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v2 addresses the feedback on my "rev-parse: match @{u}, @{push}
and ^{<type>} case-insensitively" patch. I've split this into a 3
patch series:

Ævar Arnfjörð Bjarmason (3):
  rev-parse: match @{upstream}, @{u} and @{push} case-insensitively

Reworded the documentation as Junio suggested in
<xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>.

  rev-parse: add @{p} as a synonym for @{push}

While I'm at it why don't we have a shorthand for @{push} like
@{upstream}? Add it as @{p}.

  rev-parse: match ^{<type>} case-insensitively

Junio didn't want ^{<type>} case-insensitive "for now", so I split it
out of the first patch.

I'm not overly excited about it, neither is Junio, so this'll probably
be dropped, but I wanted to submit it as a standalone patch in case
anyone wanted to pick this up in the future.

 Documentation/revisions.txt   | 15 ++++++++++++---
 git-compat-util.h             |  1 +
 sha1_name.c                   | 14 +++++++-------
 strbuf.c                      |  9 +++++++++
 t/t1450-fsck.sh               |  7 +++++++
 t/t1507-rev-parse-upstream.sh | 15 +++++++++++----
 t/t1511-rev-parse-caret.sh    | 13 +++++++++++++
 t/t1514-rev-parse-push.sh     | 10 ++++++++--
 8 files changed, 68 insertions(+), 16 deletions(-)

-- 
2.11.0

