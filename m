Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3D920248
	for <e@80x24.org>; Wed, 27 Feb 2019 15:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfB0PY7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 10:24:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33408 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfB0PY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 10:24:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id z23so773563lfe.0
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YcbfXXiHgtrvMIe2AD/rDP/GpCmsZQRvusOIDPrZF1M=;
        b=Ua3IJHQ39FfgKUNSYo+SKeChAwagtNI7g7KmfxSw99H1pEiDbboa4WwfndqNpfDY0B
         HzekPKscJZqVNtf5VSVgCwslZsikEkEN/QfMdEtuNRmKXSHlabChWTtAvuW4OLR4Zqbx
         I6CZ0z3ArbaM8lNLOR3h3znVmEBooLcgMrAqY6rB2gC2ccW79KOpxF9w1QOPB3yKysE3
         TwewQGzuhS8+Zj2FmkXeMbAcgrQKVl/xPHWcN58+Tv7WUDJEYQ0YSctM8qzJsZ+8uvsG
         fmpHfth2JNEMujYACN6zOfA3NSCa6kQNn+ldTFgWafMRu87wOT5E27xQ8ZLmi7ErF46v
         bEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcbfXXiHgtrvMIe2AD/rDP/GpCmsZQRvusOIDPrZF1M=;
        b=RqvBWi5cYBKIs6VJWlRgBi/WYqLiE54xLxlBCnFyP94aHB9pYgVSqAS6t3vHdLSHcd
         e67TRDXDLjiu9YMfwqr7k0g59qNGzKuLTDlIZZsWo+HcW1XUkeX7GJaj9qxZNr5GGu6x
         IqbR6lMsZ3CNhckXRf3holAeq4P9qU5Sk8itYVLof3B6PEeF1BcvEr8BBfaTL57XoYFh
         j6y8VyG3LQMTJiZzWkfbmmaHTUwqWhR9Dux8oepV32RXBRd3kgjYVPhoptDf7qv4DbMo
         FBIDK0hY7SHrSDm4qy12yJKQ5Ph9vKM9Lxez+LTT9uWW3rqEDI10kcsHA71u441fC3AS
         LKbg==
X-Gm-Message-State: AHQUAuYoht9apjJnH8WhH8OrHW4pxKcVLTUnnkeL2Oh6PNM0s5lFLCa6
        HrC0nx073PrJWEZXZbGB38+fqEOpUOYPZTCebbg=
X-Google-Smtp-Source: AHgI3IaR/qoQxPL/DCoq0AxGnxCHPCngNGGsCFKueNH8rDD6ZYAK2k+u13ufyVwBpXS8iO95us53iwbeczTTzT1jnoc=
X-Received: by 2002:ac2:5291:: with SMTP id q17mr1230061lfm.138.1551281097147;
 Wed, 27 Feb 2019 07:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20190226200952.33950-1-brandon1024.br@gmail.com> <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
In-Reply-To: <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Wed, 27 Feb 2019 11:24:46 -0400
Message-ID: <CAETBDP5pfuNP4JQDaxN613sthRziJT7CZd=tjhWLpMSME9JjOQ@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you all for the helpful comments :-)

On Wed, 27 Feb 2019 at 07:08, Duy Nguyen <pclouds@gmail.com> wrote:
> > It was discovered that the --no-gpg-sign option was documented
> > but not implemented in 55ca3f99, and the existing implementation
>
> Most people refer to a commit with this format
>
> 55ca3f99ae (commit-tree: add and document --no-gpg-sign - 2013-12-13)
>
> It gives the reader some context without actually looking at the
> commit in question. And in the event that 55ca3f99 is ambiguous, it's
> easier to find the correct one.

I didn't know this, thank you for the tip. I'll start doing this from now on.
I will also reread through the SubmittingPatches doc.

> > +static int parse_parent_arg_callback(const struct option *opt,
> > +               const char *arg, int unset)
> > +{
> > +       struct object_id oid;
> > +       struct commit_list **parents = opt->value;
> > +
> > +       BUG_ON_OPT_NEG(unset);
> > +
> > +       if (!arg)
> > +               return 1;
>
> This "return 1;" surprises me because I think we often just return 0
> or -1. I know !arg cannot happen here, so maybe just drop it. Or if
> you want t play absolutely safe, maybe add a new macro like
>
> BUG_ON_NO_ARG(arg);
>
> which conveys the intention much better.

I like the BUG_ON_NO_ARG approach. I will go that route.

> > +static int parse_file_arg_callback(const struct option *opt,
> > +               const char *arg, int unset)
>
> I would suggest you do the same for -F, i.e. collect a string list of
> paths then do the heavy lifting afterwards _IF_ we don't support
> mixing -m and -F. If we do, then we have to handle both in callbacks
> to make sure we compose the message correctly.

I opted to use callbacks here to allow mixing -m and -F so that messages
are composed correctly, as you mentioned. I did so in an attempt to match
the existing functionality of commit-tree.

>
> > +               OPT_END()
> > +    };
>
> I think you're using spaces here to indent instead of TABs.

Good eye on the whitespace issue. I'm still dialling in my environment,
so please forgive me.

I will address all comments in a v2. Thanks again.

Brandon
