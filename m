Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90108C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiBVK0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBVK0l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:26:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F21598CB
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:26:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ci24-20020a17090afc9800b001bc3071f921so1949446pjb.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPGk7336xM8LsamJElYtRbQn4+rGbedVvX/oQYGiAQc=;
        b=RNKurib6UvaLdxHOC/kNxors8N8m6c0Lep2hOnA5qFUUzjOnD8eJ8xG8OQqg37ZnMF
         xygvV8sI5LJgirJK5K0YU2IJXOALJDMlFjHCeKnkJx2EAGFwWJoSJ8JFVsD1JgCBUUX4
         87niFptIbacKP+3vqs2ddYp2iHgfw+7Wrx23RES1RQyGuHK5elQmnOF1r9HZO07txaFZ
         ZaOAvOze5ggzY8ptXR9IezH9+d0diIVmh6P78ytFxmfJbjAmpYUI2kW7nKyjQaQQDuNy
         DuVKrTJSSzRv4socsGQ+hjdMRepY5vt/OADU9aGC9zr0T8a3PGq/tWcc7mDmNvZskzn7
         00ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPGk7336xM8LsamJElYtRbQn4+rGbedVvX/oQYGiAQc=;
        b=358X3bdLynq/yJuORaUGQLWOTNjwr/EYfHu9rPOtiU3wmqXM7ZSZx6t6BMaPsHO3+t
         fsXNTg16n5A849buwCPMn23YZYayT0V9fN2Cnus3jw6vKoP8K19ZJ4BNFnM/BP1qOzVv
         UJCOFBCoS4ntsOzs0j04i6lFVLsR3gOKMZD0CSK4LyGyvL/V6gUt7SEw0LawZvb2k+do
         1z8YQ3ODzlH7MdZ7ai3blxms1J1NHu5sLgWQK1Vx0hQNNQAbSyaQoZWhA7YDw872XUpu
         2nLPtZuyuLT1HrT1ffPyDQ+WW1LD0s0KNWSBgvkMF03UkEX7tm5+gqT75rdtK0P1O2wl
         BVVQ==
X-Gm-Message-State: AOAM531EVDogalonwaAwnTGg6ETmykr7uN5j3puNUShXoU8H5+Yey9U6
        M09+uh8XY4ycqQMuY53ieCJb5H/opylkqQ==
X-Google-Smtp-Source: ABdhPJwNFGJ3tgixsmvxFUEmHG3lI/J2oFt4Sg4Nk17T4Cbg2GTyO+EGNAaxFCkQ8XnHy1OUl825nw==
X-Received: by 2002:a17:90a:581:b0:1b9:b85e:94df with SMTP id i1-20020a17090a058100b001b9b85e94dfmr3410437pji.195.1645525575985;
        Tue, 22 Feb 2022 02:26:15 -0800 (PST)
Received: from localhost.localdomain ([202.142.96.56])
        by smtp.gmail.com with ESMTPSA id t3sm17159489pfg.28.2022.02.22.02.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Feb 2022 02:26:15 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage strings
Date:   Tue, 22 Feb 2022 15:55:36 +0530
Message-Id: <20220222102536.83705-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:

> But in this case there's really a much easier way to do this, to just
> extend something like this:
> ...
> See b6c2a0d45d4 (parse-options: make sure argh string does not have SP
> or _, 2014-03-23) for the existing code shown in the context where we
> already check "argh" like that, i.e. we're just missing a test for
> "help".
>
> Obviously such a function would need to hardcode some of the logic you
> added in your shellscript. E.g. this fires on a string ending in "...",
> but yours doesn't.

Hello Ævar, I have some query related to this method. I have implemented
the logic locally and tests are also passing. However, I think the test
you mentioned is only running against the builtin files and files that
are used in builtin commands (e.g. `diff.c`, `builtin/add.c` etc.). But
some files from `t/helper` (e.g. t/helper/test-run-command.c) also uses
parse option API and it seems that there are no test files (pardon me if I
am wrong) for checking `parse option usage strings check` for `t/helper`
test-tool commands.

E.g. `grep -r --include="*.c" 'struct option .*\[] = {$' .` command gives
the following output - 

./helper/test-parse-options.c:  struct option options[] = {
./helper/test-lazy-init-name-hash.c:    struct option options[] = {
./helper/test-serve-v2.c:       struct option options[] = {
./helper/test-simple-ipc.c:     struct option options[] = {
./helper/test-parse-pathspec-file.c:    struct option options[] = {
./helper/test-getcwd.c: struct option options[] = {
./helper/test-run-command.c:    struct option options[] = {
./helper/test-run-command.c:    struct option options[] = {
./helper/test-proc-receive.c:   struct option options[] = {
./helper/test-progress.c:       struct option options[] = {
./helper/test-tool.c:   struct option options[] = {

So, these files are using parse-options and there is a chance that in
future, usage strings from these files may violate the style guide. In
this case, all tests will be passing even if there are some style
violations. What do you think?

Thanks :)
