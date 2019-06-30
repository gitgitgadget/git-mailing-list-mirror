Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6A1D1F461
	for <e@80x24.org>; Sun, 30 Jun 2019 09:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfF3JaI (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 05:30:08 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:46336 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3JaH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 05:30:07 -0400
Received: by mail-lj1-f172.google.com with SMTP id v24so10009473ljg.13
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YosS3o4Bm40ymZII5sLv5UukNx9COQ8pplQS8ySe2C0=;
        b=op6K3uuNqqawOUDSs/pbhxiwIqir0tuz0lXOKuW6LDLUJLD9Q1QUHaHSGobwRVoiot
         Y5UqHwnej6q47jcKbtVM9JD1MrYsxVjfpfjrXUXDFpMHDY9RJz8LFXjn35qz15c8smtu
         MPCkmWCbj45k5UwEEXeOsfYeVJuOdpybD35q6cQynmG9ZMAskUu9dhd6yIO1HXyXgwH6
         FV5cupzUt4yGKjrlt+VdaSb5Hogqqem1A0IzRaoWAe7FaBn0D2RRqimwmiKGWvhCsfWV
         W8C6UdT9Cfpv1g+lXnbiX9B9puOpAtr3cOboBnlZWiCw9/pjXtB69jqh9oMDIQ2NlTXK
         FKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=YosS3o4Bm40ymZII5sLv5UukNx9COQ8pplQS8ySe2C0=;
        b=NN0ZCVYZ1/ilXSrXs5ROHMEKBnaZUgUeteegfaG7KnDMRzNDEz1TrkSpq3H9WwXMqo
         MNxfHx02T0jmawmDLizrrvsC8vIgS3VclP979e39AbaeevIDZbYmx28PkcMYB0gGkYlw
         bkPHyYQNey7tUTfhGMYgeGTyPtgX18ycKm4xpZLorvlWZPyDi34Rjl+FZedkXiG8HHLt
         o7UQVF05Px7KX0sK7qIxo+aOKcUFQDk/Gc/7yxe5F+8LxSwWCClgbZs/8WZcut+vBD+j
         bZNCxqvZ1KjcX5TsQpd0h31zbKnzugBBdoyhp/SL9GWgesE/Ac2SZ2VM5sS7MPW/3NCb
         bTtg==
X-Gm-Message-State: APjAAAUooVuAXINVcCkhq4BiOTd4YRGt9+UAiJztMUazENe1xQpaDAB1
        b7oWXi/uedIXUZrNmOCjuxg=
X-Google-Smtp-Source: APXvYqwADRw/ZgOrAwyFFedikV5bUj9CAKBp3ZMrQuDpxNjJg+fpFoK2RQ1k9eOYPAVVbNOJdVWFlA==
X-Received: by 2002:a2e:5b94:: with SMTP id m20mr10818075lje.7.1561887005691;
        Sun, 30 Jun 2019 02:30:05 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.130])
        by smtp.gmail.com with ESMTPSA id b62sm2449711ljb.71.2019.06.30.02.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2019 02:30:04 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        kyle@kyleam.com, Heiko.Boettger@karlstorz.com
Subject: Re: [PATCH/RFC] get_oid: new extended SHA-1 syntax to control resolution process
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
        <20190626084139.30246-1-pclouds@gmail.com>
Date:   Sun, 30 Jun 2019 11:30:01 +0200
In-Reply-To: <20190626084139.30246-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 26 Jun 2019 15:41:39 +0700")
Message-ID: <86a7dz4e06.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bikeshed painting ahead.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
[...]
> The problem is we try every possible way to resolve a rev. Let's have
> some annotation to express that we only want to resolve a rev in a
> certain way:
>
> - <hash>@{hash} only accepts a full hash or a short hash. If it's a
>   short hash, it cannot be ambiguous.
>
> - <ref>@{literal} only accepts full ref. No turning "master" into
>   "refs/heads/master".
>
> - <output>@{describe} interprets <output> as git-describe output
>   only, not an object name or a reference.
>
> This gives scripts much better control over get_oid(), which
> translates to rev-parse and a bunch other commands.
>
> PS. The new syntax can stack with existing ones. E.g. you could write
> refs/heads/master@{literal}@{yesterday} or <hash>@{hash}^{tree}.
> Perhaps I should allow these tags at the end too, so you can enforce a
> variable like "$REV"@{literal} where $REV could be even HEAD~123

I think it would be better to use <hash>^{hash} instead of
<hash>@{hash}.

The <ref-ish>@{<something>} is used currently for information that is
outside the DAG, like @{<date>}, @{<n>}, @{-<n>} uses information from
reflog, and @{upstream} and @{push} uses information from the config.

On the other hand ^{<type>}, ^{/<search text>}, and the future
^{<hashalgo>} all use DAG-only information.

Though one could argue that refs information _is_ outside the DAG...


P.S. We have 'git show-ref --verify' that requires exact match (no
DWIM-mery), which can be used together with '--quiet' in a script.
But this doesn't allow for checking if an exact match, or a describe
output exists in repository.


Thanks for taking it up,
--
Jakub Nar=C4=99bski
