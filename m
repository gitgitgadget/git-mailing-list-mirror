Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C00CCA0EC7
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 01:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjILBOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjILBNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 21:13:49 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37B1AF0D5
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:05:29 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68faf559913so2817215b3a.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694480655; x=1695085455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYf8n4QJuFH0KNqHGAgsz6yNwlGunyav3q2WZA1qPtI=;
        b=S8feB6OxwmvHav8MH0ikEN4hmQjEDed/xDkaCxZW1yb9CiWWZxOZALgitE6+RfsooB
         TGvh4KsgEkEy3ecCXP90foGQgxwXcrxPWVUbPrykhNv9J3/HPV2ZV+g2n+Fw0OgegIye
         JGiMrjQ+1EAGXyzigIl66KB3OnsIqeZw2OVP96Zz+XWEjkYsbvlLzLTTDwf9+rDNma9u
         gAgn8uAUUC/n7m4TfG7f2yowXlA7X7PPa4pQy+J5BBOEKX2qXZA+j1Kk+6p5K3rKRv6+
         KKhhXrCfItLZtfRt+tRhwEMmqho8Bu7zNNl3Q5H657WKj65lKfgjCUjb+4pBMZ2yMglD
         rU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694480655; x=1695085455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYf8n4QJuFH0KNqHGAgsz6yNwlGunyav3q2WZA1qPtI=;
        b=VZnwj5sd6FUqXBiKKxbO3nji8q1p4hbPdIPenz+fQmJInXqqScA3LDj2D8EH1F9drm
         DhLwNmzX8d0FdQOsp7YZXEg4/OzpCtdhjKhRRS7tmtz03D6PovZFO56dTZjNesbeyrS0
         vDLPxp6CIQTIILYUcbzUvVPgVngUV0vtQH7ZDyTAqhsNCLTLEn71ENmQmzHR4JsjyGKs
         19u31iHC8f6Or/pppVNSwc7fiLc/Lb2wczEG+r0z16VvUaQTTzHK5CPh7pIBoFvAPolo
         TXFK0nZJnjy/4mSPNN9J0Pdqdojjg1WjYcUz7qJyOJBKYgK774NnFjzfHPMVKoehEsg4
         wQHw==
X-Gm-Message-State: AOJu0Yz8Duy5glD3JWu8qthWOSSMsCJ8gqkpcipF3+3tB1nGTxB9GP8j
        UnLvMv62ar4wmLnvY/vMQ8HMJ3CTfyg=
X-Google-Smtp-Source: AGHT+IHj6hKhNkrzk5YQvPFgjU8+reJdzRXHobt1hGKiANiKAx/8xeY1ktRvSc2Kdx7tBSg2EMa38ptZgAg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:2c87:b0:68e:3053:14b9 with SMTP id
 ef7-20020a056a002c8700b0068e305314b9mr339335pfb.2.1694480655538; Mon, 11 Sep
 2023 18:04:15 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:04:13 -0700
In-Reply-To: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
Message-ID: <owlyil8gkxrm.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] completion: improve doc for complex aliases
From:   Linus Arver <linusa@google.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Steffen Prohaska <prohaska@zib.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The completion code can be told to use a particular completion for
> aliases that shell out by using ': git <cmd> ;' as the first command of
> the alias. This only works if <cmd> and the semicolon are separated by a
> space. The examples have that space but it's not clear if it's just for
> style or if it's mandatory.
>
> Explicitely mention it.

It would be even more helpful if you explain _why_ it is mandatory in
the commit message. Is there some Bash-specific behavior or something
else going on here?

If you are unable to explain why, then as an alternative you could
explain the error or buggy behavior (any error messages encountered, for
example) you observe on your system when you do not use the space (which
is corrected by applying the suggestion you are adding in this patch).

Thanks!
