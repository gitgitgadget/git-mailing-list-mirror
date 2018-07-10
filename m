Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1192A1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 14:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeGJODQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 10:03:16 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34246 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbeGJODO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 10:03:14 -0400
Received: by mail-oi0-f45.google.com with SMTP id 13-v6so42808353ois.1
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIxvV13wtP333s3sHs6ndVTYdMDhw7/OUoDc9p3E9I4=;
        b=s3XhADqHUklOkWDjWaoG3uSsfxNOyRv8oYUWoZ21dUeMYu7OnLhcyzXrpCLxBK1rXJ
         9BfPaRdGG2UvZcA+D8xtQTVVGSE42859h/QlQkBKuXGXRbJOCqxl58c5HaTiFJnrpLWi
         NlnqUnJLTs5qPoAB9vAH3eELcxVx/jzb0eJVIOli8f/SkI9N8XOjcqg7gAK8qjkxy5v9
         iSjf5fiI1eC7AWOvTaJmqemQS9mMWpjqtkFULUPkLJaXWFitvT4bk5SkX0cwhXuY2jUu
         AewUssdzqo5nJ9kU1ivqlvxb/NvAc8Gk6sVHeeceLVV3hOEa75NVLipjB3SXfASu4BeR
         ZC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIxvV13wtP333s3sHs6ndVTYdMDhw7/OUoDc9p3E9I4=;
        b=B0mayd3bu16hdSU5CrqyDg3wjWQnzd/D0cu3FWiXxKqDpGovnj3FH9KuSOz4c7l5aq
         QLsqwzaKyeWMpyR03u7+mW6wZnEaPp7i/EG+wRcZJzVX3lM0H/l3mAt0c5Z8aQcrSoKs
         fqobWJSmkFzW8ACF9jJm9/1pVmdTvui4E6iIS5DPGyIYvi4XzH3YYdjzpiiQBt2absQm
         xeKVyQc2xxPHjRagfXWuILfDAq4DtV7X1KR5nnupRdKo5oT0sIzAvLRtGwZihzTlKvKn
         uR8a/l98UNLwJQdZP93ZNmxTz9h/tHF0PQYQm/EcPb01u+Fna18GzhWJ8jaYezQ0y6i6
         +o6Q==
X-Gm-Message-State: APt69E0fHGeMrZ87zKshbzTvtmmyej80Km5sTkjWuqAkSpWk2sXEUI67
        gXojOJ6QiTcaYeKVy5HC82tkCxoKzcl3YLN8ke9sz/XJOZM=
X-Google-Smtp-Source: AAOMgpe/5Qx6VEY9JN5KPV9zG/zSXEFenY7jukrQph5kjfpR62po32Ts9bsKuk07QGGyIGpxOuxh/XZNoPg+7VCU8SQ=
X-Received: by 2002:aca:d44a:: with SMTP id l71-v6mr29498838oig.199.1531231393110;
 Tue, 10 Jul 2018 07:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet> <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet> <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet> <20180709195822.GA9000@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807092225120.75@tvgsbejvaqbjf.bet> <20180710022141.GC10248@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807101339370.75@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807101339370.75@tvgsbejvaqbjf.bet>
From:   Daniel Jacques <dnj@google.com>
Date:   Tue, 10 Jul 2018 10:03:00 -0400
Message-ID: <CAD1RUU8pT-3GKN4qRjysi+re+AKF4eB+VEDr+GzMW_4=E4uftQ@mail.gmail.com>
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perry Hutchison wrote:

> If we need /proc, wouldn't we _already_ be unhappy inside a chroot
> that didn't mount /proc, even _with_ fallback to static paths?
> Last I knew, the whole point of chroots/containers/jails/etc. was to
> prevent access, from a process running inside the container, to any
> part of the FS that's outside of the container.

Yep. The code also allows for use of "argv[0]", but that has its own set of
problems. These were previously covered in the discussions leading up to
the patch landing, but to summarize, "argv[0]" can be completely manipulated
by the calling process, whimsically or in response to constraints such as
links, and is wholly unreliable for self-location.

Other kernels have their own behaviors with respect to path self-location,
and none seem to be straightforward. This link seems to have a good
rundown of the details and differences:

https://stackoverflow.com/questions/1023306/finding-current-executables-path-without-proc-self-exe

All things considered, I think executable path self-location is markedly more
fragile than using static paths, both with increased dependencies and added
inconsistent behavior and limitations, and should not be the default
on any platform.

Both Johannes' original RUNTIME_PREFIX implementation for Windows and the
Linux/etc. expansions that I did were written to serve constrained special case
deployments. In that capacity, they can be really useful, as the fragility is
managed by their respective environments.

My particular use case served the purpose of building Git once and deploying
it via archive on other systems. This capability requires the additional work of
building portable versions of Git's dependencies and their associated
resources, and statically linking everything together.

This is a lot more portability than the conventional user requires, and also
necessitates a significantly more complex build process. However, making Git
itself portable via RUNTIME_PREFIX without similar work on its dependencies
limits the usefulness of that portability, since it's still bound to
the system's
libraries and their resources.

Cheers,
-Dan
