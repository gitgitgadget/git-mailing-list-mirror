Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC1720A40
	for <e@80x24.org>; Wed, 29 Nov 2017 23:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbdK2Xk4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 18:40:56 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33575 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbdK2Xkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 18:40:55 -0500
Received: by mail-vk0-f45.google.com with SMTP id q189so2367410vke.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 15:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ICmMTEv6hgVM80UcBovbwbpDI2GNNIuAVVl/elKdF5w=;
        b=tr/9+apcjHXJwu7fZ1PjNUQ+UusoAEn0J8qzqpJZ2uQHdGmg5at8ST3ZTGXatOLNYd
         m5OaD81Xo2VyGg72tFDJ3r5JNZoVMc8pnT1C7Crea2ogiFexzY7nvl5aKxyvBrtrNhas
         spbWOwO7mGOSgNBeFz+ra+emepVpXe10mNlQtP2kzz3XdrPrk9BHogoNIYHJtcTcOvu6
         6japdN1rYhlU4HnfgDmG3ZJMfmaQ4kizTJU5Q7jqAGbXGXBrQBQS579POanvlwJAgrM+
         SbDZ9ypzwKcQ6UjdXUXW9rJ3KsUGgyk1Fzz95GNfC8BeLqqd7MfsiV6GeWIoXl9VL+90
         C3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ICmMTEv6hgVM80UcBovbwbpDI2GNNIuAVVl/elKdF5w=;
        b=dv8GFiyYuBx5X3cGnrpEMspSuKc6UJX+CeQhjZSrbTvu5DJopPzf4seVQEQ8Yyf0pO
         zwkVHUVwrfMdncsf7Dtq3ImM/9MAdUUvTYCdmBl0FOPJBolcpHBxsiJEHvFggxwq2Bd+
         Dg+WsC7I+4ctOND7xDkQt1hH6JzbFsbAsaS5EMKMvUD3CJ/w1jNB6DABqiDfcJbRLmZ3
         AWJOYXQpSJuB68CUDzICvyMSW+O9RoAYB2H+pGVjnu3RUX4SyPJt7Yeqc0h1rX9r8Eto
         oTty38YI3tT/GuhxhzuniWJucgDFHZWq7PhBFGvW31AM9TIbTrbNyRuHIeJt1a7DmR4f
         mpxQ==
X-Gm-Message-State: AKGB3mKQswKgBgz7f3ssdNp7xhJ6tAmqZzhqFsseKTmbpWu33WWEC7v3
        fM1OmjhjwhOCjT12AEeb9uRqjX+dFFx+kgTiCcA=
X-Google-Smtp-Source: AGs4zMbw5zw6c3ZYG7vEE4RzD1ltXCyhLVPO21T3u1tz84KckQUmIlG7igpkE+9cwsRHyd7RU9CmUH9QgygHr/E9ctM=
X-Received: by 10.31.61.11 with SMTP id k11mr471967vka.153.1511998854051; Wed,
 29 Nov 2017 15:40:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Wed, 29 Nov 2017 15:40:53 -0800 (PST)
In-Reply-To: <20171129201154.192379-1-jonathantanmy@google.com>
References: <20171129183200.178183-1-jonathantanmy@google.com> <20171129201154.192379-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Nov 2017 15:40:53 -0800
Message-ID: <CABPp-BH3FWQjv_uD+ddUgKd7mFo+VHEGWy2LBBNDD0C0nSYVjA@mail.gmail.com>
Subject: Re: [PATCH on en/rename-progress v2] diffcore-rename: make diff-tree
 -l0 mean -l<large>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 12:11 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> In the documentation of diff-tree, it is stated that the -l option
> "prevents rename/copy detection from running if the number of
> rename/copy targets exceeds the specified number". The documentation
> does not mention any special handling for the number 0, but the
> implementation before commit 9f7e4bfa3b ("diff: remove silent clamp of
> renameLimit", 2017-11-13) treated 0 as a special value indicating that
> the rename limit is to be a very large number instead.
>
> The commit 9f7e4bfa3b changed that behavior, treating 0 as 0. Revert
> this behavior to what it was previously. This allows existing scripts
> and tools that use "-l0" to continue working. The alternative (to have
> "-l0" suppress rename detection) is probably much less useful, since
> users can just refrain from specifying -M and/or -C to have the same
> effect.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> There are multiple issues with the commit message, so I am sending this
> new version out.
>
> v2 is exactly the same as previously, except that the commit message is
> changed following Elijah Newren's and Jonathan Nieder's comments.
> ---
>  diffcore-rename.c      |  2 ++
>  t/t4001-diff-rename.sh | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)

Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks.
