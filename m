Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E58B20248
	for <e@80x24.org>; Sat,  6 Apr 2019 18:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDFSZT (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 14:25:19 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33425 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFSZT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 14:25:19 -0400
Received: by mail-wr1-f47.google.com with SMTP id q1so11703681wrp.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2I/Bu00o9wGSSUfnLDkGCRWFkEawhxuwFh3jRuWJuxg=;
        b=MeMn3FzB7Zx/SbvjRhohp/WKKVf1SSxqmLgNeFk733/04FfsOa2TS6GHyC4xN/rRP2
         e4I3eLk8OoUhvj2EIL4d5ASYQyVUiv+LfaNUiXPvMDTdLZgcR1lexry/IDVdUctsIgcf
         XWFz9U9HJboXoX8I4YMQ3fkZVMFJnlnhlu/d91AgyzO/C+od9Rd4slGs5Ha85bKIEjpD
         4cw7OhEecz554GutBHz/GOSX2t/VepXWTGj8OLudSWjxWgqEzykpAIPau8EaNrQOIRHP
         y/psqyjkNfKClgaedaEZaijHpzPFlpTvN3E5WsOisGu6NkIZClKAXcGKU/AOfcPIFYn6
         ghog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=2I/Bu00o9wGSSUfnLDkGCRWFkEawhxuwFh3jRuWJuxg=;
        b=BeMLqsV28VtVm1z9z4lEGoYESPMGL5gOdai1uJdqdgin171b5ZGOCID+hGPt5EhHVf
         SwSYCwftyruQbQIylbmhWrKPVdR8JAvon86mrucjWg2fuIvkq5ITv/RJCglV84MlLJpa
         UfrxIQDpqjQPbmsCyfgum6kmpjAA49gORjWTzmkf9dDp2KZtmNsreBYvgcQ/ASzdO1qA
         2Ih8DQn3UZ/PGcgzo2/gyjJDKY7UPHcwde7wGcttxwQq6PJJw+7kGV3SWlqhvTbD/Bni
         Fl343CTXuisNjwTaR8tx64Tw2EbeWJYKYU6Mrcgm/AS+x6nvyevRR6XPKjr3SXIdbKoC
         mZ3g==
X-Gm-Message-State: APjAAAV7ktDFp8XpD+b6xpm59Ae/Sc2Byv1k3Ut47byetQG1yfBCXYLV
        YZR8yX7cQk0JSWJ+TALmDML2icRSzAE=
X-Google-Smtp-Source: APXvYqxzFMBrtTGZ2a6LimSol0pQzA/5PNYkEBhX1aHcjymxbUkAW1sKR8MaRoACNHeuy/iarjETAg==
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr12446659wro.170.1554575117025;
        Sat, 06 Apr 2019 11:25:17 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egm113.neoplus.adsl.tpnet.pl. [83.21.76.113])
        by smtp.gmail.com with ESMTPSA id 10sm4930089wmd.23.2019.04.06.11.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 11:25:15 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "commit --author=..." does not work if global email and name is not set
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
Date:   Sat, 06 Apr 2019 20:25:12 +0200
In-Reply-To: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
        (Piotr Krukowiecki's message of "Fri, 5 Apr 2019 09:34:39 +0200")
Message-ID: <8636mvng8n.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Hi,
>
> I have a repo downloaded on machines which do automatic tests.
> Sometimes I want to make a quick fix there and push back to origin.
> Reading git-commit docs I had impression that I can use "--author=3Dme"
> and it will work. But it requires setting global user name and email:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> $ git commit --author=3Dpkruk
>
> *** Please tell me who you are.
>
> Run
>
>   git config --global user.email "you@example.com"
>   git config --global user.name "Your Name"
>
> to set your account's default identity.
> Omit --global to set the identity only in this repository.
>
> fatal: unable to auto-detect email address (got 'some@default.(none)')
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> I do not want to set the default name/email, because I want commits to
> have real names, and not some "automatic test account" info. For
> pushing back to origin I already have to use a read-write SSH key, but
> lack of default name/email would prevent accidental commits (people
> WILL forget to use --author ...).
>
> Do you think changing git to not require default name/email if
> "--author" is specified is possible (and hopefully easy and quick to
> implement ;))?

As Junio said, the "--author=3D<author name and email>" sets the author
identity, but not the committer identity; you can work around the issue
with "git -c user.name=3Dme -c user.email=3Dme@email.my".

In Git the commit stories both the author and the committer.  The author
is the person who made the changes, the committer is the person who
entered the changes into repository (created a commit object).  You
might want to enter into your repository changes made by somebody else
(that you for example got as a patch): that is what --author is for.

Better though is to focus on what you want, namely to prevent accidental
commits without specified author, instead of how you want to achieve it,
i.e. using --author to provide both author and committer identity (the
XY problem).  On that machine with "automatic test account" set up
pre-commit or commit-msg hook that fails if the GIT_AUTHOR_IDENT
environment variable is not the "automatic test account".

Hope that helps,
--
Jakub Nar=C4=99bski
