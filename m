Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8B1C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 19:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4675961B93
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbhKQTJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbhKQTJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 14:09:49 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152AC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 11:06:50 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p24-20020a170902a41800b001438d6c7d71so1618214plq.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 11:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ztCrLfANf9biEbDgLMqvMpT/g1CK58H38+H7lOjAZcs=;
        b=p78zpG8UXVR+GcIl/I3SlhadPbvaWY0X6vYJkhcaZrwR52X6Djn13PEZmYi172BIlJ
         /rWHuHSp8PCg2IM5+asx5ShutdNSnZ6p1NRdTiRJZpMa8N1eTcB1Lhlg6KEFiwqMs8Fg
         f3CFon95y5VMhzlHv3rcHa2QvJCdJU6qcNxkLlwnoYrY9YabaMfmHJHuunFgJWJrXqgN
         DnqZ5NtC5c3QQwXj/rhY0BplPEgGUBr7ZK9CLPIqulcbw4aBqlV2oBkDeM4WrS3FA6UQ
         DuKe9Y7jwpETtDNKc8wWQ01o8D4Wu6SZZd/4TZ+YzWoYMogeAJ4JkcoEHfUpG5kg7tLn
         kx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ztCrLfANf9biEbDgLMqvMpT/g1CK58H38+H7lOjAZcs=;
        b=svy15/vy2f/wVqvMxcpjVdHnY7l+ia4/JY10UZMKwF9l0h2Nb0T2aG7xZCiPjqFV/i
         iM6QnOsyoYyMUIK7phH2dbgH34gJzTSpcMJQgRZUMi2ggv5tawua7zBNAWclhpGgu4Kf
         olo6r1zC2UQuwBbEqVlohZh2TS6e+xVcqWERxHfPehGJp2FkJp14/dZBT9K8DJGK8fAS
         DLzJGyJhoQhAxSH74nUGPsM33bXV6kE+EbhjwlufjVaJz3AaO47pcziHwz8Uwwlundc/
         6kbXzyWFlmscIHpCdiSsiYN1NKm/MS6b0Wc8ioNBYZw3bduJ/IN3xM+GqC3aDUJ2PwV5
         +KkA==
X-Gm-Message-State: AOAM530+i11kGGM0qY6vWgOQ7iuK2tIHLGG7i8utdDkPCTRSGNAYyAZw
        Ly9pvtNbBm3clCm0FxXPRJJGEAjyKBbe7UgKtPJQ+RFjn87Mnh22Ng6LGJuUh58hGMY1PQ7yLnn
        FWEfoQ53iMtQTUlyiPVTBAA4wy6QyC2+RWn0O51pZikLUxS50TcOad+73zYvZdNc=
X-Google-Smtp-Source: ABdhPJyhwU85CYefpL9PUP/ez4UlX3kQcGBtRSguCrMJUs1xQV7o4y6e0NYQdg1RT8IsWRWpUsnl4lYsau8Kjg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:6a56:: with SMTP id
 o22mr7003800pgu.249.1637176009769; Wed, 17 Nov 2021 11:06:49 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:06:47 -0800
Message-Id: <kl6lzgq2ha9k.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: git-gui bugs due to dependency on system Wish on MacOS
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi! We've received reports that git-gui is showing black windows upon
upgrading to MacOS Monterey. It seems to be the same issue as [1], but
somehow it's only appeared for our users on Monterey and not Mojave.

TKFRAMEWORK = /Library/Frameworks/Tk.framework/Resources/Wish.app

* Github Issue https://github.com/Homebrew/homebrew-core/issues/39987
* git-gui formula https://formulae.brew.sh/formula/git-gui

$ brew install tcl-tk
$ PATH=/usr/local/opt/tcl-tk/bin:$PATH # This contains wish
$ cd /path/to/git/git-gui/
$ ./git-gui.sh

[1] https://github.com/prati0100/git-gui/issues/48
That said, Homebrew seems to have worked around this problem altogether
by including their own Tcl/Tk dependency.

I dug a little deeper and I was able to fix the theming issues by using
a different version of wish:

Note that I had to call git-gui.sh because that's the only entrypoint
that doesn't use the system Wish referenced in the Makefile.

Is this a fix that we should make in the git-gui project?
