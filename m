Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE6C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 09:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDAJno (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 05:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDAJnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 05:43:41 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BBBA5D3
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 02:43:40 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i6so29934029ybu.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680342219;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+9IpREKF1Kz00q+ufVkv3OROTi2HCQ3YHNpEuzZq4Y=;
        b=nq4AJBN6FoqigHo9Akl7hI2T48IeqkfbrsMIZkdZ/QItr6Z+3iGkIndt+cEZ8MrjrC
         hF1vZ3gUKXn1u5CIWaPVX/rxjAwV+7NMLpverfZW4Sy62uVqdskGB1krPySjYAjWd6oz
         lTHgjNhEbYeIc7qW5WVUsxPesyDrYC4kmeFJ7ZrO+H+VA1cruz8/MVN8QIFFSLiiJnpQ
         UP1P8sfMaFra/Ysc0SsqGUHgFWL0ZykI2xLDSbKpZq19FgMH+OBc6YCfUBY4Yi5k+kLK
         zL/OwMFwKFWzINLJjr72sphSiPPl4kRB9LwE2kKjoqnkfz7TdnRrEmnNJf7MCdaPX2pO
         eztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680342219;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+9IpREKF1Kz00q+ufVkv3OROTi2HCQ3YHNpEuzZq4Y=;
        b=I5Acifdss2YohPA7VlH6gLtZobwN5a/nJxz3fFSdfgehh9rWWEmSqwMcbixLTCKOWP
         YJykt+FtFWK06stH1fuwjcm023mGjU7snRQOrtCwi4ODfbSjJbZDUC4hVaDuhPISQ2is
         1/awaaABAMPCEpXTw82I2+gfJmZK1FTSLSqE3aTN1DJak5B6ym3vQj8dUnOTyDniqn8r
         +cMd3Sb/GVaLBmPSslNu+0/ktjWTR+cImWc79x6ilF0rdbPooN6R5YO78b8b7kyKyqmg
         QVZuh8ieOsg8lJmBi7FYFDyQvfeysnyRpFDvZfFHLR0MQMos1EArJNTnBwOwwCZnFMMP
         6T7A==
X-Gm-Message-State: AAQBX9dFpDOjc0smOtIl29nm7R+luo8eVQdqF3BRvG+aOLeG2HNqW6OO
        Olh2QFoNkooYvej38Y5ocv1h5lpZC7PK1uRJTxiob+h+sik=
X-Google-Smtp-Source: AKy350bQKMsw8uR9LrJU97OL7EjoQNJyqVTuDHEOAJTGtCEm+hUxV60D4nKzKKeAmRzLhSuVLqGIcnWl8BB5+fsj6+A=
X-Received: by 2002:a05:6902:703:b0:b48:5eaa:a804 with SMTP id
 k3-20020a056902070300b00b485eaaa804mr16056485ybt.0.1680342219335; Sat, 01 Apr
 2023 02:43:39 -0700 (PDT)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 1 Apr 2023 03:43:28 -0600
Message-ID: <CAMP44s16HyCpEg0um0FhV7grhCqn4zS-MF9vBPL8qaaH1vdy0A@mail.gmail.com>
Subject: [ANN] git-completion 2.0 released
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

git-completion is a friendly fork of the official Git completion and
prompt scripts for zsh and bash.

The main goal is to provide a more up-to-date completion for zsh (I'm
the developer), which is basically just a wrapper around the bash
completion.

Compared to Git upstream, you get many benefits for zsh, but there's
also benefits for bash users too.

Since the last version, the tests for zsh have been simplified, the code has
been rebased on top of Git 2.40, and the internal structure of the project has
been completely revamped.

In total there are 51 patches [1] on top of git's master.

For installation instructions and more information: check the wiki [2],
but basically.

 * make install
 * fpath=(~/.local/share/git-completion/zsh $fpath)

And for Arch Linux users I've created an AUR package: [3].

Cheers.

[1] https://lore.kernel.org/git/20230401084626.304356-1-felipe.contreras@gmail.com/T/#m60780d9b6e03bed085ecb5b30c72f6bae67ff670
[2] https://github.com/felipec/git-completion/wiki/Zsh
[3] https://aur.archlinux.org/packages/git-completion/

-- 
Felipe Contreras
