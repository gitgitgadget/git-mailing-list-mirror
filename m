Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D2B1FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 06:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeCNG11 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 02:27:27 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:55739 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeCNG10 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 02:27:26 -0400
Received: by mail-wm0-f46.google.com with SMTP id q83so1771901wme.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fU4CQd3NJzv1oiTiwnWjqfeGNaEPys9P7UzoPJrZpbg=;
        b=XebJC4K+Xpt3Q9ELxUd+RPyo3wH3m7Reo46cMt9LG6a1syOVHi9l0vrIweTwncpGNI
         HAk/WC3fWIM1fiEtYTYRDg6M4m2jXo9G63EzfTDie/BHnI+dNrqyDtiUvgl9IwErP8pR
         hGYEp0lYmHxxrY4bEH6qJgwA7aJnxx9kwf+8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fU4CQd3NJzv1oiTiwnWjqfeGNaEPys9P7UzoPJrZpbg=;
        b=ShEltCUq2ZW3mw5y8GT2/xmjErnm0FIMnE2Zi7HuOH84WJYdIwu+kc2HcpIOZ4ZyAy
         QGnPpBvlGI0ziNgsf8x1bDi7iEu5EZ00NuehW33x8ggacO5jfmDsOOqkrbatl1dq12vE
         zcv9kdfE7UZ5n6wO4tvxi7bP+cMi09qAr16B13l89kmNn1eKp8hcUeamTxm6ek+dRElz
         iphPmU/kL8kNyVlbBxybWpPlW6kPnQ8HA4Q/+HRO2v0J1pTNvZKC5S/kDciuZPimwPEp
         EXogW6g7FeAXEVAxgLcEZnrb/VILu4pz2536ii24bFk+OqPPyKrIlmrjE9qsfopg3jLX
         zwPw==
X-Gm-Message-State: AElRT7GaEnQc8cQGuh0RYZ0MkhGBQb7exyK/dbWCN7oQJi94utFLr/RR
        wSyQ7yMNcZoDPgDqDAJJLvxFrQnnYdk=
X-Google-Smtp-Source: AG47ELvM8HdaicPNxmx0YaYNhHwbtpMEw3cqzmEpWoDRdb3SS40LZkvUXd4wJfBz/49ziGKeQ8EqRA==
X-Received: by 10.80.245.73 with SMTP id w9mr1459997edm.230.1521008844442;
        Tue, 13 Mar 2018 23:27:24 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id d49sm1676706edb.78.2018.03.13.23.27.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 23:27:23 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id x7so1744851wmc.0
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 23:27:23 -0700 (PDT)
X-Received: by 10.28.71.204 with SMTP id m73mr544921wmi.111.1521008843068;
 Tue, 13 Mar 2018 23:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180309131136.219303-2-tikuta@chromium.org> <20180309132655.224308-1-tikuta@chromium.org>
 <xmqq606558k2.fsf@gitster-ct.c.googlers.com> <CALNjmMqBbZTFVRnc__wewWy3808n9J9xfgu8ZH-FWyWJKvqb9w@mail.gmail.com>
 <xmqqo9jr3lrt.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9jr3lrt.fsf@gitster-ct.c.googlers.com>
From:   Takuto Ikuta <tikuta@chromium.org>
Date:   Wed, 14 Mar 2018 06:26:46 +0000
X-Gmail-Original-Message-ID: <CALNjmMqqa1i0=ekqQfNZ5DmA+h7mOGzZcF-RB1A6+Rm8vw80pQ@mail.gmail.com>
Message-ID: <CALNjmMqqa1i0=ekqQfNZ5DmA+h7mOGzZcF-RB1A6+Rm8vw80pQ@mail.gmail.com>
Subject: Re: [PATCH v3] fetch-pack.c: use oidset to check existence of loose object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018=E5=B9=B43=E6=9C=8814=E6=97=A5(=E6=B0=B4) 2:53 Junio C Hamano <gitster@=
pobox.com>:

> Takuto Ikuta <tikuta@chromium.org> writes:

> >> During fetch, everything_local() tries to mark common part by
> >> walking the refs the other side advertised upon the first contact,
> >> so it is correct that the number of checks is not reduced in a fetch
> >> that does not fetch many refs, but the number of remote-tracking refs
> >> you have has no effect, so I doubt such a rephrasing would make the
> >> description more understandable.  "When fetching from a repository
> >> with large number of refs" is probably what you want to say, no?
> >
> > For refs existing in local repository, everything_local looks to be
able to find
> > corresponding object from packed or loose objects. And if it exists,
> > I think, cost of lstat(2) is relatively smaller than other operations.
> > But for remote refs, everything_local fails to find it from packed
> > object (this check is fast)
> > and it tries to find loose object by using lstat(2), and this fails and
slow.
> > My patch is to skip this lstat(2) to non-existing ref objects for
repositories
> > having large number of remote refs.

> This still does not make sense to me, and I suspect that I am
> misreading you.  In what sense are you using the word "repository"
> and "remote refs"?


Yes, I think I did not understand the terms correctly.
I meant "repository" for repository in remote servers, and "remote refs" fo=
r
refs shown by `git ls-remote`.

> Imagine this situation.  I have a local repository A, I fetch from a
> remote repository B but in my repository A, I do *not* use
> remote-tracking refs to remember what the last values of refs at
> repository B.  Now when I try to fetch a single ref from B into A,
> many refs B advertises point at objects A has never heard about, and
> that triggers many lstat(2) that yields ENOENT that is slow.  Your
> patch is to optimize this so that we learn these objects do not
> exist locally without running many lstat(2) to objects and helps
> repositories (like my repository A) when fetching from a repository
> with large number of refs (like the repository B).  It does not
> matter how many "remote refs" receiving repository (e.g. my A) has,
> and it does not matter how many "remote refs" sending repository
> (e.g. my B) has---whether it is refs/remotes/origin/foo
> (i.e. "remote") or refs/heads/foo (i.e. "local"), a ref at B that
> points at an object that is missing at A will cause the same
> lstat(2) at A without your change.

> That is why I think "When fetching from a repository with large
> number of refs" is what you meant, not "fetching into a repository
> with large number of remote refs" nor "fetching from a repository
> with large number of remote refs".


Thank you for explanation.
And yes, that is exactly I want to do in my patch.
Fixed description in v6.

Thanks.
