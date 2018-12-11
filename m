Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65E020A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 17:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeLKRqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 12:46:47 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45290 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 12:46:47 -0500
Received: by mail-io1-f65.google.com with SMTP id n3so1760986iog.12
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkCuYWauDtWeLzv7Oghye0FtxRcnTVZN5nCkDJ5s2WU=;
        b=Y1QBySzVaA3OFYrQL7Qh7cwQEzMVDfuiewWyPBwbnunG8rSEjfO7FXoy9S0rFQesnG
         VM0+fnXQa1LuCTmLhV39zpP1WCgAqzX/I9ZrHvFUds3D7NckeCieWXZ91Hua2/F9ooq0
         zO/KH+Qrfq2l/6SKojjCQ6Y4ViDUAbCv1tZCeUOIEYzqUBFCPcFf07Sh+xaX8woL9SNq
         d/j9GtqJVOXxLAUIXzutVpk3bSwSHy1rXfcMIusX81qIpfE/CJ9Hu36CRCtYk9o4ht68
         ZVwJI39+vcuG/E+5+uI56JoDUQUTcMuG3UcXA3KqIkOykJeZxz3g45a1RUVbNeRWmPAh
         bgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkCuYWauDtWeLzv7Oghye0FtxRcnTVZN5nCkDJ5s2WU=;
        b=qK4lEURkGH0vP8EAAzbmls+injVnpTt6beAXdtO61IdrMdKKvGW19BQYPMpCn6GBFs
         +AmtrZlEe+ok4GX/ZATTr6CT/yYRfgrXJO+KFWQRNDi34cA4A6Ou+g7OroQJnvc7ZHp4
         fkdZTl13M+Ya5uB1x2aGD70BJDxrYs6QCQ9ymmrI5rEJFZUyreAM4OrQjN0wNPk0g+Eg
         2BH6v4hGAINP3U9LhtsI3ZBsOgtQ9/e5jeiYqRI5e6ZKLOsUh3lqq4QryEUy7EOAF7Ij
         ETCZQTej6lmhL9zR5II8elwVrwrgCJop5Qdsk/rEdsCDUgulrvJFcMvtuYysMTOwmz25
         Bn/g==
X-Gm-Message-State: AA+aEWbnvjUaI4cKzPvmZHekQjCgU8EoE+0/wgk0Ams1TRlr0GXTl8MI
        cHL4/7vURFx/bCeL9osjHkgk5f5cT2lwj1ldgMY=
X-Google-Smtp-Source: AFSGD/UVpYrHnnDcfJq3Uy4PnKAJRcLlDBBm7VOhWHGB8LNDhR8wPvdyrrg0kcqhFo/hVqJzjEDkHIWqKcD4DespDPA=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr11926175ior.282.1544550406483;
 Tue, 11 Dec 2018 09:46:46 -0800 (PST)
MIME-Version: 1.0
References: <CAKc7PVAzSOknfmy7p09zF4LOi4t66CBmd27ZuQ39_wKYWSiiUA@mail.gmail.com>
In-Reply-To: <CAKc7PVAzSOknfmy7p09zF4LOi4t66CBmd27ZuQ39_wKYWSiiUA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Dec 2018 18:46:19 +0100
Message-ID: <CACsJy8AjWXBycFEY-hmPB270BzcydxG6xQ6ox96VbK3K-sUnZw@mail.gmail.com>
Subject: Re: [BUG] Git 2.20: `git help -a' hangs if specific git alias occurs
To:     sgniazdowski@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 6:42 PM Sebastian Gniazdowski
<sgniazdowski@gmail.com> wrote:
>
> Hello,
> I've attached a screenshot for running `git help -a' that ends in a
> hang and ~100% cpu usage, for the following ~/.gitconfig (it's also
> attached):
>
> https://raw.githubusercontent.com/agostonbarna/dotfiles-base/master/.gitconfig
>
> So it's hangs on the alias `remote-origin-https-to-ssh'. One user in
> following thread discovered, that it's about lenght of the alias:
> "abcdefghijklmnopqr = ... is ok, but with abcdefghijklmnopqrs = ..."
> it will crash, "the problem occurs if the name of a git alias consists
> of more than 18 characters" (see the thread:
> https://github.com/zdharma/fast-syntax-highlighting/issues/95).
>
> Is there a workaround? Of course a fix is needed, but I'm interested
> specifically in a workaround so my Zsh plugin
> `fast-syntax-highlighting' can work without hang also with Git 2.20,
> without exceptions in code.

I don't think there's a workaround (except shortening the aliases).
The fix for this was sent out just a couple hours ago, maybe it'll hit
2.20.1

https://public-inbox.org/git/pull.97.git.gitgitgadget@gmail.com/T/#t


> --
> Sebastian Gniazdowski
> News: https://twitter.com/ZdharmaI
> IRC: https://kiwiirc.com/client/chat.freenode.net:+6697/#zplugin
> Blog: http://zdharma.org



-- 
Duy
