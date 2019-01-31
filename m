Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84301F453
	for <e@80x24.org>; Thu, 31 Jan 2019 10:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfAaKtQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 05:49:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34910 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 05:49:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so2948649qtc.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 02:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KS9ydw7OSchIk2E7/JNsGNV12i/JbouNdtoDqqvhIXw=;
        b=hBER+/w5xEbav5CcCzvyHhcqgFT2NoROTIKGYm7MpcNjzwVV21WggyimD6MkTEecCy
         L9tPPPxd9FJnM1O/G2+8NVD26kNPfIfvhdXQIIaQA8Jy8jSDL12EzTLAzARMQNo27TG8
         NxxUwLEg3/JZRFm1kSf7FJfwg4X80O++Ub5itlKBmfvWRYCprZpZ3fce49gEssWwqp69
         gNPOXW4FMLT+Br2gCMYgtQfagYgyuVpvIfX0tAONKnFNZkwhz3W098E85S/omSM9sFdS
         X4T/i4wStWfG5nclXf/PxoSI+fe8q8cOO6/aNdo7XwlDyJgLwyNv1Sz4uB9Ks05Ptk7W
         smfg==
X-Gm-Message-State: AJcUukfejtDNHdKLK4OyjNoRme2TApk0si3kk7IrRzy+ZcI1z20gqrNj
        lqBFucWjvtvVi4NtPwU8VamSejHWY6J2eY4QLHA=
X-Google-Smtp-Source: ALg8bN7ja7QQoJZjS0OhbUcelxg1ahDuwFEX1CtZCw5hxUO77V4BJlX2lt1E3oSoLVCM62OMIePmE5TZUCLiDRd6CeM=
X-Received: by 2002:a0c:d29b:: with SMTP id q27mr31955956qvh.62.1548931754939;
 Thu, 31 Jan 2019 02:49:14 -0800 (PST)
MIME-Version: 1.0
References: <CACsJy8C2fx-+NxS+ahmmHDgLrwtyiCV6WEEfpmYwfcPM3kYVvA@mail.gmail.com>
 <20190131092112.6197-1-pclouds@gmail.com>
In-Reply-To: <20190131092112.6197-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 05:49:04 -0500
Message-ID: <CAPig+cSzDSeJ7HypXTjMpn26LYygH_UFYwcPzthGLoEQYDNLcQ@mail.gmail.com>
Subject: Re: [PATCH] git-commit.txt: better description what it does
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 4:21 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> The description of git-commit jumps right into the commit content, which
> is important, but it fails to mention how the commit is "added" to the
> repository. Update the first paragraph saying a bit more about branch
> update to fill this gap.
>
> While at there, add a couple linkgit references when the command is
> first mentioned.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> @@ -17,16 +17,19 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
> +Creates a new commit containing the current contents of the index with
> +a log message from the user describing the changes. The commit is the
> +direct child of the tip of the current branch. The branch is updated
> +to point to the new commit (unless no branch is associated with the
> +working tree, see "NOTES" section).

Okay. The information about the branch being updated makes sense.

> +NOTES
> +-----
> +If a branch is associated with the working tree, 'HEAD' points to this
> +branch. When a new commit is created, the branch is updated to point
> +to the new commit. As a result, resolving 'HEAD' still gives the new
> +commit.

I'm not sure I understand the purpose of the final sentence about HEAD
"still resolving" when you were, just before that, talking about the
branch.

> +If no branch is associated with the working tree (i.e. "detached HEAD"
> +as described in linkgit:git-checkout[1]), 'HEAD' records the object
> +name of the previous commit directly. When a new commit is created, it
> +will be updated to point to the new commit.

I'm having a hard time figuring out what these two paragraphs together
want to say. I _think_ they want to say that HEAD is updated
automatically to point at the latest commit, and that if a branch
points at HEAD, then the branch is is updated along with HEAD,
otherwise if no branch, then it's a "detached HEAD".
