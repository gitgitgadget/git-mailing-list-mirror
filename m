Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A9C1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 19:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbeKGEka (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 23:40:30 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:42618 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbeKGEka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 23:40:30 -0500
Received: by mail-pg1-f181.google.com with SMTP id i4-v6so6226963pgq.9
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=w4d9l0DXVxZV/OGcD5NlPEk3btmSrbfKIA1jNeUZUqs=;
        b=dJm8EgAtL9bHgkzr3hY/nthSMigQZwVCaAKcnl2Txd/XpCRvQ08S/zW97gckwr0vtV
         XKV0AKQvrNFM0KJy7BcNzDwabAaWOlao27S84fwJ2XmBGSzvdS2wTquvWgTevs5fgy4m
         j//7S8n8xpBui5A00vjbnzVYGnmqfgm5K4kztJ00WRybktr+qFm7AQYdkXv7Z9/awlYE
         xql+Fffcuhfq0RGSpNvgvmZa7syV4xBRXpmHw3p8txBrxX0UY1Bvw770ayrJXHZPeHVw
         VCwmIufM74YUL+l73RHbJ0aY5X2CEkkDv3KhbbGTGGjyOXE+BChMY/9kIfUczmYXBPoi
         OiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w4d9l0DXVxZV/OGcD5NlPEk3btmSrbfKIA1jNeUZUqs=;
        b=QZS/hFdaGA7v++6b9/u0sMoWmwPZVtJcfgcSm6R3/ToXqXSW9hvZpwOK0s/WmSyfBa
         F1YURLrNnWrerJb2aWByBrQ8tauE6Drb+rAvEDUfMDTVPQPDNw6TrVwO7Elrs4jeIb38
         4dz43IwyFGORnMl1WrNCRBcSjqga1rkCLV0k3PNa7Mii8UXjUIyoq/HjD76JMex+If5j
         BbOAAqiDAafnGYUeopLO36uR/no804A0RbXaiJyOhvfCx85g5YHrCQJUhDulwvYx4SGP
         Rn6Hc8xCUI3oXkL6KUeKz1LqgA6iOKs+15wOl4dtRoeWhW+woiOCDyI2avkPMpW38LDM
         qJPw==
X-Gm-Message-State: AGRZ1gI/NgSaDXvLvmezEOufAwTCkiG2vo9fQC0Ia3dwkCeJzqsNd7Fi
        GUeXWy7VUU3b19241V17fyigxM7zZ4Q=
X-Google-Smtp-Source: AJdET5dKfM3YUNyKthlA22tppLPYreTV3y1cLp8iERT3tj1QBykjjKKBc++oU9Q0JQul6H/Nr3BGDw==
X-Received: by 2002:a62:1d50:: with SMTP id d77-v6mr8822405pfd.87.1541531627939;
        Tue, 06 Nov 2018 11:13:47 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id t77-v6sm39530299pfj.79.2018.11.06.11.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 11:13:47 -0800 (PST)
Date:   Tue, 06 Nov 2018 11:13:47 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 19:13:43 GMT
Message-Id: <pull.68.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] send-pack: set core.warnAmbiguousRefs=false
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been looking into the performance of git push for very large repos. Our
users are reporting that 60-80% of git push time is spent during the
"Enumerating objects" phase of git pack-objects.

A git push process runs several processes during its run, but one includes 
git send-pack which calls git pack-objects and passes the known have/wants
into stdin using object ids. However, the default setting for 
core.warnAmbiguousRefs requires git pack-objects to check for ref names
matching the ref_rev_parse_rules array in refs.c. This means that every
object is triggering at least six "file exists?" queries.

When there are a lot of refs, this can add up significantly! My PerfView
trace for a simple push measured 3 seconds spent checking these paths.

The fix for this is simple: set core.warnAmbiguousRefs to false for this
specific call of git pack-objects coming from git send-pack. We don't want
to default it to false for all calls to git pack-objects, as it is valid to
pass ref names instead of object ids. This helps regain these seconds during
a push.

In addition to this patch submission, we are looking into merging it into
our fork sooner [1].

[1] https://github.com/Microsoft/git/pull/67

Derrick Stolee (1):
  send-pack: set core.warnAmbiguousRefs=false

 send-pack.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: cae598d9980661a978e2df4fb338518f7bf09572
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-68%2Fderrickstolee%2Fsend-pack-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-68/derrickstolee/send-pack-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/68
-- 
gitgitgadget
