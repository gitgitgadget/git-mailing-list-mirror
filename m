Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B751F462
	for <e@80x24.org>; Sat,  8 Jun 2019 14:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfFHOnp (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 10:43:45 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:37194 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFHOnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 10:43:45 -0400
Received: by mail-ed1-f48.google.com with SMTP id w13so6916122eds.4
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FEeIqi5KGA6Y7GYeX9N19pW+1hKQrfkDd94BkgEd634=;
        b=H+wRBDsebq1662nii4xJuXAhX61NMYe3Hupd9eXD2SdOXtoQyz/UMoyaleFfVe71Qc
         N7a/G/eW61XuBuOPM3e5IciiqYdQv/HAG2g5PyV2j8KWR9BZ80pCKqp7DB0cIR6ascNq
         h6TU6IqaB5RTO2Cix7nzHoFUapP18/+VUdUWMhezuDaXEFU1XUS7u0aWIJWr8DhXg2DR
         edXhe7eUdVFr5C0wnSJFOiSFOgKWdAEkZ/GAcKQDq/VJD1Ew6EwjtsE9mZNeZWWi0zOh
         Tk2C0NDZ7HA6m8TuCFJFAuqniXgF948xlLE/YS6u67vSQmCggCTzchuEG6hlMWiSQ0Z6
         RPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FEeIqi5KGA6Y7GYeX9N19pW+1hKQrfkDd94BkgEd634=;
        b=YUMKasuKTPto0Nr1HXJEQ0sYXskOj94Om9ng5+Bf/Xq1fmzTsYLG89tG7EM0llk8QX
         2HvCPGMbFdRd9V2xW0K/wE8GqDicfZQ0V3I8E0mpZJyrGfwcSKWjRGeOAmj8I8pKBORq
         +9Wz0PmaRY7SCcue5IEdfWeXwD/mpD8zYdZLisbNR6PwJyZdQpQLwAzgKukkFRO0cxl7
         qThW+TD2nmlQ5wGuvk04UZZU7zOZAs/7BqBZiloFyjtPNC58nWJxkOQWsvqM3af+E8CK
         VrOikEqB/ftDGLvuCg5wc7LSO3MGzRVmZlcA9/QzU7yGqSfW6iyJ+D0JxGm8hjWzMEQc
         Mo/g==
X-Gm-Message-State: APjAAAVAw4PesvirrdJQThFwI0ujGiIBY3PDE3n3iBgqC/1qwD06Kd9R
        i+5oV5Eensk8FyykIcHmS9tLGKaL
X-Google-Smtp-Source: APXvYqy2NrFJ2wECtySxbccVeKh4c2RxHRV4YXLVW8JRY80EZBrogab4nI8JOT4U7xMl/wVGru8f2A==
X-Received: by 2002:a50:91e5:: with SMTP id h34mr16224845eda.72.1560005023656;
        Sat, 08 Jun 2019 07:43:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19sm1356443edt.87.2019.06.08.07.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 07:43:43 -0700 (PDT)
Date:   Sat, 08 Jun 2019 07:43:43 -0700 (PDT)
X-Google-Original-Date: Sat, 08 Jun 2019 14:43:41 GMT
Message-Id: <pull.151.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix a test on NTFS (and probably HFS+)
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

My colleague Jameson Miller once presented me with a nice puzzle why the
test suite failed on their system.

Turns out that it is possible in PowerShell to spell the directory with a
different case than on disk in cd <directory>, and subsequent calls to get
the current working directory will use that case, rather than what is
recorded on disk. And since case-insensitive filesystems are frowned upon in
the Linux world, Git's test suite was not prepared for such a scenario.

Johannes Schindelin (1):
  t0001: fix on case-insensitive filesystems

 t/t0001-init.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-151%2Fdscho%2Ffunny-cased-cwd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-151/dscho/funny-cased-cwd-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/151
-- 
gitgitgadget
