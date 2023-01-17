Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98C0C38147
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 22:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjAQWbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjAQWaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 17:30:13 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F48455A
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 14:07:45 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b9-20020a170903228900b00194a0110d7bso2878394plh.6
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 14:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YH/ONakuSdVdAKDaUBuKqmfPHOtuKz4Gq9l1fAoB2Ew=;
        b=OIbJihNrtOMV1Y6tYTop6Dt/DUtV2OGKPUvwbJrbSqlpIUiwJ0cDg1flJS/iyxQaXq
         0ltc2Vopy4mlFlQmKy8iFA9bvqDsqD0evZPUYX1RL/K5e7X74zGFAxnKYV7LPAZ0+DTY
         0QoVVAHaC7dTXEyb1Sbwm5pz+Y4DmNmEXHhg8iQsE0UZxYy8Lj+26y3HlBfR0jx8FDBy
         ZV+be48IZKbluFumaBGaN2wrMFsQrF8xIA1CBNlNuLWk6bywqrYc1MjKLcDUGtU12yV6
         wRvJHJELbTDyKXMBIW9K3RYaYoeMqckGk5WwWiiuUJkPDgr+5R6h1TGpFXW8dOSv3op+
         rIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH/ONakuSdVdAKDaUBuKqmfPHOtuKz4Gq9l1fAoB2Ew=;
        b=6QPn7Pz6DmGZObDp3LtUOllh/5ayt7TEwLqKsfQNkhuZFowgU9GM78Z8rJeQem4KO2
         k+EOlSQoixFG/TDZcQmOqarjqLttV2A6mlJXAISNE0GC3qQsg8HeYn6E15UUQx5mGNUo
         yNLIMEipJCtSGvFAFlUOkWnr4EAn+tMAZB4Euy/cXbpUxNZZgrLokjvjmZakTUBdw6QR
         N/e/7Oa57wN5YInwMlma2po4iMMB6B5q4pFpGvjiLS3eLfKd+SMkNBlbWU8qSqyTywzA
         aBJoCwtZ+bumxG39B6bUFfxQLOZD8eAAle/3/xv9FCktMRPP9hRYOavC/3Ywddw9bGuB
         Rn2Q==
X-Gm-Message-State: AFqh2koVSsBZITdVpdvAECvIWBY4mGgJdeVfXDQ9O6cJszmTb8SCnhk/
        5zmpHWIT4GfktCwxqjfEHImpEy6UbnKDM4LCb8tpbVwBvNW4ZzfVkEMbc02wM7mKocXO8Ll0g0E
        Cq7WDb8B/NsKaju2N9GC1132LL3cqhrjNlBw7oaExfkaYFJ60CD7XtOOiHMqYI+0=
X-Google-Smtp-Source: AMrXdXtd9vycXmVmr1rae534oak3i6jMjvaeHkTjkh6AKe0TAYmmNoJEIy7FoqJ+QIlxjEh5Lrp6F4W6VsR8xA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:904c:0:b0:58d:9878:d450 with SMTP id
 n12-20020aa7904c000000b0058d9878d450mr448275pfo.64.1673993264894; Tue, 17 Jan
 2023 14:07:44 -0800 (PST)
Date:   Tue, 17 Jan 2023 14:07:36 -0800
Mime-Version: 1.0
Message-ID: <kl6ltu0oolw7.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club! (possibly from other timezones)
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone, and happy belated new year!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason's imp=
rovements to
the config API. [3]. Let me know if you're interested and would like
to join (off-list is fine), and I'll send you an invite :) If you're
interested but can't make that time, let me know too!

As an aside, I'll be working from a different timezone for ~1 month
starting next week. I'm considering doing some Europe/APAC-friendly
sessions if there are folks who would love to join but can't make the
usual time. Do let me know on this thread if you're interested! The
normal Review Club sessions will not be affected; many thanks to Calvin
for offering to conduct the sessions in my absence :)

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal=20
[3] https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221125T093158Z-a=
varab@gmail.com/
