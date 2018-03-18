Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224E01F404
	for <e@80x24.org>; Sun, 18 Mar 2018 23:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754409AbeCRXCD (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 19:02:03 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:46504 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbeCRXCC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 19:02:02 -0400
Received: by mail-qt0-f173.google.com with SMTP id h4so10424703qtn.13
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=f6MSU7Mjp+i6fbu9UCMonxQPA56HqHRVR8SS3NqrNf8=;
        b=eRCvwmDuMwYFyCcMfHk+Dvfzhqt1VbmTyhPotgsWAbJ1ZNqV7Ve3iD6qrvJziHUnpl
         Cifn0PU6c0M0uLMFgHrWcQFH5ILHTli6tBDmBFeqJwX+YT0+OvslIguaNWyYO10oO8k0
         X443PqXA+sR6LUYvvxZC4bfRSOjAzfVfnAfljTiuhlgza/PX7DDo+iz1FP20KAam+Hvx
         1XUFlkwVfBd+wr26d1wBBLSXL5eUmuCGeEy9RvBQZVwkwK0zW43rmkoGkqk+WVlaAmYP
         Xr0JRMGnILfgzV5473Vx6QeHddJ+3WMd9fAA9bltz5sp8r2acNXsOy3UUzwcNXMlK64i
         2BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=f6MSU7Mjp+i6fbu9UCMonxQPA56HqHRVR8SS3NqrNf8=;
        b=G2pwCebdZCT9XsNqYIrvf3NhNHUDvstvgRFDdisZDqsVCpizokFCzsojvb3GoT+xuc
         qlIsSWGvTR8hkkdvpxJquJoymCeaPZu3Ah6L10sD7R2JwtYdQbHymuOK1yz4oVVkNgcQ
         aTQHbWCsqFhx7B7yrg2AlSxWHYG+1Emgvb/yjYtl4R4Z0mD8/BxpFkHOUez2IGor4Xwo
         2EjOz9vcono+NZd/8FswgwbkpatMdLQ6lxy2nHKWH3XkJ6JV5t+ZS2FEOfmnc0RkvRWy
         eNVZcWAeAj1WQkoinoenwdF3B0GMOO8ug2BGmm5DN1qT+BYfUyz4Kg0hW9a1QWkclDrc
         FrzA==
X-Gm-Message-State: AElRT7Em8ZTSk1Hp2Jvw6YW43L5qnEwuojkZKB/CMtKnHlJAmbwCgenB
        BYO7RRBoYbqyHJKDAGJVZdp04ACdKx/4BzsHe7U=
X-Google-Smtp-Source: AG47ELtQxn9rIk2ahTMaovNCVQi5VdTX+i1L1SwmwrxJTtj4FXO19zv7MTU5IR1eTlen9czdCHBFqYcbixpD+ZznjW0=
X-Received: by 10.237.56.136 with SMTP id k8mr15753227qte.154.1521414121487;
 Sun, 18 Mar 2018 16:02:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 16:02:00 -0700 (PDT)
In-Reply-To: <20180315164412.14697-1-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com> <20180315164412.14697-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 19:02:00 -0400
X-Google-Sender-Auth: krkp6Wy0q19eXkULsrEZAHAuofI
Message-ID: <CAPig+cSgmpXdSiEGLGTZaSDKFXsWoH76OCJnf9xu3XWZJxUfRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] git worktree prune improvements
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 12:44 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> v2 fixes comments from Eric and rebases on 'master' since 'worktree
> move' has been merged. Commit messages are updated to reflect this.

Thanks. Aside from a couple minor commit message tweaks (not worth a
re-roll), I didn't find anything else on which to comment on this
version.

> There's one thing I didn't do is moving the new paragraph up [1]. I
> still feel this it's not right to put it there since it starts with
> 'gc --auto' introduction, then goes to loose objects and packs.
> Inserting a note between the loose objects paragraph and the packs one
> does not make much sense.

Fair enough.
