Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95540C5ACBF
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 15:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630B420777
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 15:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghFLBCxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCMP0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:26:45 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:41555 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgCMP0o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 11:26:44 -0400
Received: by mail-io1-f42.google.com with SMTP id m25so9734346ioo.8
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/f0XeV/0vbaP2Ccf3E6PoPDf85Q+A1nayWuIzJUNxok=;
        b=ghFLBCxTOvrNKQVjie5WgSme1Ld68b4N9LwBDzTlHavLWYl1ClU1/np0oCrRfpbm/t
         C/EoQ4od0aFRv+PzSB3KX3dx/a76fqCXPIU7CSeeFmpO1JNEle8Mg5aqBTNjHarjkm3V
         voqj019HtISswMKwBtverkB45ZKvcnJey/1ujXcFq9j+Kx/+WstaFFG4ehZBgDMNwwW5
         pHZPQf6HFNgh7SnXdxLkstK8MfQ2EBCIDTA5Yi3FrkuZzZFLiuwSYDzUl1kiIdMUBJAT
         q+iQcgNFbCev9GwKpqw7IKrEz/5MJRrT45P8lsfwn9zrBX8DymF46GsVEyisBopwMTpP
         GGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/f0XeV/0vbaP2Ccf3E6PoPDf85Q+A1nayWuIzJUNxok=;
        b=mEIQ5w4VpPYg+Be+uWMZl+laOHZEipciUbTraShxSvWeUezayn/Y5jmTLuIvuBLHhP
         UNuahjAnb8+79UHnpuKVu6kR0tZJlE1PXDt4xbB7et2dag/1fIJtUn3YRdTKunopb/eu
         tgShscvGL7bVihtfk7hR51NbGXbc8oP/RH7hEgG+VeSoV4yiMu41L3VVJ3MhhwIz8jR+
         CDBuDCA3RAgB1VsBWQNLkPbH9vPv/OC1J2Rob/r3UwcccnKDKCYQuXI4Aqj0RaJ6Gy80
         jlYysaDA1GQlOtj69jIosJ/LQ6jKpxuaKDiSbsxMMqzf0LC0RQ4lqMLMw9UU0LwC1lcP
         C/eA==
X-Gm-Message-State: ANhLgQ2wMTDLJ8wvc5E33DXbJqnW0xAGhbVRl5BovtTYoirYeWIPPezf
        DSnA0+v7Npk8DRzsSehX2KwSyeAk0RcJnTbvWYAQakwo
X-Google-Smtp-Source: ADFU+vtmg9sgQiYceshBPQWuc87jYugkq/5uZNN1YD7YyGMUVJL5ScNwnouSHxyq2A+XRBnZpG9KyYfKCU4EY9BC9Yw=
X-Received: by 2002:a5e:930a:: with SMTP id k10mr12945818iom.132.1584113203630;
 Fri, 13 Mar 2020 08:26:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 13 Mar 2020 11:26:32 -0400
Message-ID: <CAH8yC8knZEmKyYc7TwmXRCd24nK9YgDo3EYfvH58QWP61ZHpwQ@mail.gmail.com>
Subject: What is so broken with pull
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git pull' used to work for me. Then I tried to sync my branch with
upstream/master according to
https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork.

Now this is the shit I am dealing with:

$ git pull
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream-to=<remote>/<branch> android

$ git branch --set-upstream-to=https://github.com/noloader/openssl/android
android
error: the requested upstream branch
'https://github.com/noloader/openssl/android' does not exist
hint:
hint: If you are planning on basing your work on an upstream
hint: branch that already exists at the remote, you may need to
hint: run "git fetch" to retrieve it.
hint:
hint: If you are planning to push out a new local branch that
hint: will track its remote counterpart, you may want to use
hint: "git push -u" to set the upstream config as you push.


What is so broken with these workflows? Wht can't Git perform a simple
god damn sync? Where the hell did the information go? How did Got
manage to lose it?
