Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F30820756
	for <e@80x24.org>; Wed, 11 Jan 2017 01:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755907AbdAKB5t (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 20:57:49 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36729 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755909AbdAKB5s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 20:57:48 -0500
Received: by mail-qk0-f172.google.com with SMTP id 11so96084972qkl.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 17:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vjcQUa01a1xB9F9dWtRQ7BqHuzBu5hkGIyOQ9jJoBYM=;
        b=ArfGgYSck1F82XdLmV/4joA6spaMrdmIT0B6H4cC0G0XZIP56R8q/MJAr/xWDJdwKO
         H1oLUXhRpoo1SZyqPlJRXs6wgAg7C1J2b3aBjt2uVzUQDnUaNkeegx0pVR17g1OI8w+B
         rJBt18hysG56YIUYOGmjxEh1fstx0veDC8NJvqIVZHVGZHenmQY8HtxX0Hu56m4ITuxO
         CV4j/hZ8vGEvrRFIdVEdnmIZPJTQXimw/tfxHWNrQ691qq7JadYaRQMlfMChiUalHKkM
         AdDQsWuZoZ8ckZVYC2WWq+W6FoNBqMiQyQUZBjmm12wbIQIxJMdYFauys9t6mGgcJ2cy
         pDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vjcQUa01a1xB9F9dWtRQ7BqHuzBu5hkGIyOQ9jJoBYM=;
        b=RFCl1RQYvJnkjKvyQWgf0hUI2HY3fa/y3oEod2eg6srI3CMlC0nl6GudN69WhXUMFI
         6KKOohS785bsT00HOJKEX3RNRZIQIeEp1ZfRrEWhO6nzkQhqUlNk2f9uUf4fm4fxUXS8
         iibtU9ikX6KXfgmBj+q1IVPOk01QZJFCGXA2Q0PpKrCCOz6abjK0qAOXx7usDT/UE0fl
         aEApPddghyXlkF5Glh01TMMXWp3zzjMBGTlC8ol/Gv5qn/tJxTP907NhMsYkY5YQCIOF
         +7YWjtLlM4j4WiRQ9osuaPy2LhKR875OIBqF1peSLXdMQCPZLFrxnyl3O/OZE1pRkITq
         Y4wQ==
X-Gm-Message-State: AIkVDXJtBXRaEfwt0ol4mIjM+hcp2EOHnmiZ6ccsolM8X0JHrw/N0KvBkmY5TUY3sC4sFnFX
X-Received: by 10.55.66.73 with SMTP id p70mr6616754qka.63.1484099867398;
        Tue, 10 Jan 2017 17:57:47 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id d15sm2938570qtg.22.2017.01.10.17.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 17:57:46 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 0/2] diff orderfile documentation improvements
Date:   Tue, 10 Jan 2017 20:57:18 -0500
Message-Id: <20170111015720.111223-1-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110004031.57985-1-hansenr@google.com>
References: <20170110004031.57985-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v1:
  * Don't reference gitignore for the file format because they're not
    quite the same.

Richard Hansen (2):
  diff: document behavior of relative diff.orderFile
  diff: document the format of the -O (diff.orderFile) file

 Documentation/diff-config.txt  |  7 +++---
 Documentation/diff-options.txt | 54 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.11.0.390.gc69c2f50cf-goog

