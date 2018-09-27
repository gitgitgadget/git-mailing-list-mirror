Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C8E1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeI1AUb (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:20:31 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40259 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeI1AUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:20:31 -0400
Received: by mail-yw1-f68.google.com with SMTP id z143-v6so1460544ywa.7
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QOzqMwa/P6exufCnDQsMQhEFoFgH/vyP4gnrWJ4ARLc=;
        b=g1IeF7DdQmzOQ5UixngwZKUf8aRE/CvIpn3Hnz5Q0H1ATO+AhWioJ2AeOKPqsKKuNV
         PehdcjtMCS4is/xcIaqRrgw4IAQKtH69aYNlUEhN2hvMeszfoOJ5qIrpYxdDc2DBuMFN
         aRMq9cd1CuzsgIOWLTwB5iFLZO4PAieAXtFuydSeAw4RCB/btMe+g5shdWUxxk7RRn1G
         asyqkgUXgigPqWla9Qb5ArnNgiDDhPDNC3mc8aDSrSlovdH45Wjx7wPz9eBk5kGzZxAw
         5DAU+ke//Z6Nie2Kw2NBoBudhkudYdsBE57zF/mOn0XLs6bWCLnMV2U505zEpcVtvQyb
         R0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QOzqMwa/P6exufCnDQsMQhEFoFgH/vyP4gnrWJ4ARLc=;
        b=Ga4elS88J1Cav+T5Ft9RJx60rWVUfLGSjm0YEjKKuFdNZkt0eYF5SqtFKoOkFQxyCZ
         iT8IkfrHo5UY6R9uj8L5SSRmxCpZOTw5KlGWAElktsF+BoxniRQUkYenRHQW6hye9RLh
         cVNCRaS5ZMhaBu9IbKCeBVtQJcCP7VkiBps2fGiO8ATZjZDOJWyU5IgcLWWTtvMf0eDb
         Cls0FOWSYQJqffYa76qBCCUCCfXfHD3TuSkmTs6qd2GDZvq6UHGlbJuno4q33xpU3PWF
         ZDFtGsS87nSHc7bM3rumFdjFTqoi64hvTtOIEcb7yonC/+RGgSmey8fifO2upVM2d1fT
         7eEA==
X-Gm-Message-State: ABuFfohw8Gska4bdGyskLnLi7wpGmaecblJIA80COYg2bd2xR2Vkngc1
        oWF2hyMWsH9er82WJeqlf2dWhqBUVbsk9dxeQeDygw==
X-Google-Smtp-Source: ACcGV61OuF47HM5UUVg6bGQ/X8SaeN/qjxQVFej0ROO7bp6490CyoFIDyAwMmitQ2aZe/d3Cw/JiSCqxTea8lbTqYzY=
X-Received: by 2002:a81:a115:: with SMTP id y21-v6mr6396863ywg.178.1538071264039;
 Thu, 27 Sep 2018 11:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180917140940.3839-1-ao2@ao2.it> <20180917140940.3839-10-ao2@ao2.it>
 <20180918171257.GC27036@localhost> <20180924122031.9dbec6b4c2e2a8c1bff3365b@ao2.it>
 <CAGZ79kZaomuE3p1puznM1x+hu-w4O+ZqeGUODBDj=-R3Z1hDzg@mail.gmail.com> <20180927164415.44b1d00ee5f8e582afdaa933@ao2.it>
In-Reply-To: <20180927164415.44b1d00ee5f8e582afdaa933@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Sep 2018 11:00:52 -0700
Message-ID: <CAGZ79kYHLF0TVfVuVfKfe_A4D2QGziRCsrYpyh7wuHjdpPEkDA@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's
 not in the working tree
To:     Antonio Ospite <ao2@ao2.it>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 7:44 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> If you end up touching get_oid() please CC me.

noted. I am not sure I'll touch it anytime soon, though.

>
> Are you suggesting to look into super-prefix for any reason in
> particular?

No, I misread the intent of that part of your message

> >
> > So I think based on ff6f1f564c4 it is safe to remove all calls to
> > repo_read_gitmodules.
> >
>
> Thanks for confirming.
>

> OK, so the plan for v6 is:
>
>   - avoid the corruption issues spotted by G=C3=A1bor by removing the cal=
l
>     to repo_read_gitmodules in builtin/grep.c (this still does not fix
>     the potential problem with nested submodules).
>
>   - add a new test-tool which better exercises the new
>     config_from_gitmodules code,

Sounds good.

>
>   - add also a test_expect_failure test to document the use case that
>     cannot be supported yet: nested submodules without .gitmodules in
>     their working tree.

Personally I would want to live in a world where we don't *have* to nor
*want* to support submodules without .gitmodules in the respective
superproject.

We did support some use cases historically that I would make sure to
continue to support, but I am not sure how much effort we want to spend
on supporting further use cases of incomplete submodules.

Feel free to do so, as such tests help to document the boundaries.

Stefan
