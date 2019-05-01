Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D261F453
	for <e@80x24.org>; Wed,  1 May 2019 09:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfEAJzw (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 05:55:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41306 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAJzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 05:55:52 -0400
Received: by mail-io1-f66.google.com with SMTP id r10so14455259ioc.8
        for <git@vger.kernel.org>; Wed, 01 May 2019 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HU/9+7PYSPht6Hqwg2noO5bB0VvqxpmVhcNVtHX6na0=;
        b=dGvD24XIFvq38QDFREtMMXEr/hsDtM4bPRLjitPNsiaxP9GBPF15V8AwDonSrZIcpH
         +Gn0plBAUHbaKyqbrsFeletc4H3+sBLTswpfOmDoAaPh2vjOmYuy8KYqVwfZd0zKtuD0
         qsOUkn7/ZQsiBGZrV0B9BtDjtRrSnJe+AQcgRuqAQ1Sh0GVXdNQ5u4ImZIMz2xSVavUR
         BnTT3RrmRZi8Mwv8+1Ta3Kq3vEvEWixYjBLqAPvQAY9HC7+dcUu6u8fD2caCFzGJgAo0
         MznkqLaRa6/c2elhfV7db7h/OtvaMKejoLVBvjF+9sKYOa4rXVcz3eNf7TdZLLBq4p72
         PouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HU/9+7PYSPht6Hqwg2noO5bB0VvqxpmVhcNVtHX6na0=;
        b=iS5z+UE9xGq1dtS9HGjycp96mjKyLNETlHh9F2zaBmjWpLv544zYWJk5RDGAATu2eU
         EoL+CiS4t9JP3ndzv8RU/RpciRNexDZd8LwgkQ5usm54DKw/6X0HQ2UpqBgBXVgwk0Dv
         E8IIHYI5ZCQ6iobsu8NzdiKgrxknHi5/gUk3eI5B9O6HZlRt63XvP4LXVTaiv9Id5AYs
         OdvGX6NeTT22KNyTjCki6tuBWCsCVKgUTI6xzZt+OpOtohyCWsXJPPD59ch4y6aZ7JQN
         j2TG8KxJaPRPUo8r/4l/yEGpRvw8kek1KYHjBOx3kmsw355qNfgT9VXxfXvv++eRc3A8
         JI2g==
X-Gm-Message-State: APjAAAXOHL4ovj4IxoM+B2rYt++V34ZeZtZJjpKLpMgRJkOe4YB3VOfm
        Eo5J3G6Li6hfCzk/dmCKg5C404CRTK5+Cf/0bmqQ1w==
X-Google-Smtp-Source: APXvYqw4CSequCg2COnzpDZreW68F0qtfWio4xeha7bAEmyGwgcmVt9lNMDyGxj5hhAUM6dehtNPF4NTMrLEAx/NPm0=
X-Received: by 2002:a05:6602:58:: with SMTP id z24mr2273353ioz.118.1556704551222;
 Wed, 01 May 2019 02:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181227155611.10585-1-pclouds@gmail.com> <20181227155611.10585-4-pclouds@gmail.com>
 <c8ff5919-5a27-8d1f-8583-241e94f0e196@gmail.com>
In-Reply-To: <c8ff5919-5a27-8d1f-8583-241e94f0e196@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 May 2019 16:55:25 +0700
Message-ID: <CACsJy8BK0WhbmfSkzdNfji2xtqJ3tobokMMDM81QjYf49tmEdg@mail.gmail.com>
Subject: Re: [PATCH 3/6] config.c: add repo_config_set_worktree_gently()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 11:40 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/27/2018 10:56 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > diff --git a/config.h b/config.h
> > index ee5d3fa7b4..62204dc252 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -103,6 +103,9 @@ extern int git_config_color(char *, const char *, c=
onst char *);
> >  extern int git_config_set_in_file_gently(const char *, const char *, c=
onst char *);
> >  extern void git_config_set_in_file(const char *, const char *, const c=
har *);
> >  extern int git_config_set_gently(const char *, const char *);
> > +extern int repo_config_set_gently(struct repository *, const char *, c=
onst char *);
> > +extern void repo_config_set(struct repository *, const char *, const c=
har *);
> > +extern int repo_config_set_worktree_gently(struct repository *, const =
char *, const char *);
> >  extern void git_config_set(const char *, const char *);
> >  extern int git_config_parse_key(const char *, char **, int *);
> >  extern int git_config_key_is_valid(const char *key);
>
> I know this is an old thread, but the patch is still in 'pu'. These metho=
ds
> do not appear to have any callers. Perhaps this patch should be dropped
> until there is a reason to include it?

That series was broken down to test the water before the whole
sumodule support on multiple worktree series enters. But since this
series is not going anyway, don't worry I don't think it will ever
enter 'master'.

> Thanks,
> -Stolee



--=20
Duy
