Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	LIST_MIRROR_BCC,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3830F1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeGJS7L (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:59:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42319 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbeGJS7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:59:11 -0400
Received: by mail-pf0-f195.google.com with SMTP id l9-v6so5076553pff.9
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mYLnk57N0nJlWrATBt9vcY2dH28s+gXXeQpcs3dYjRs=;
        b=f5yEOfWrlVkF3fOReuU5iJQbiTVct3iBM44/evZSE5PlvSVd5sJTV3gJh4RaesoJYM
         J/I34swAQW1C8JAWacMI0rSWLGjW6H4DHMm0x6Ufkcd4iDto5rECnvWmdBLSwkQF7+Xl
         7qSalwv/Lhc5noMzQ6seYJHrWgkVdhYKxjYG6LXVZ83YB8kJExLiTdGwt43dlcjV6pKS
         DsFoXa3mK2UBbI1/xi/B6I7bMvbj+XDUpH+Srs61DAxiq5rihfrEwGzWZv1xC7oSn/wM
         nwo8Xmn8xBQ/RaNCY59hbcKCajGCj4copoAPoX6xefLLJyRYvPgPWYaL5txcry+ImyKL
         550w==
X-Gm-Message-State: APt69E1t85Y8GlPtq/9dJIv/4oWhBxuC+vBkOMLHPZeLkV80R/dF6Bp8
        tuyfY2wN2UElHpWTDkJjvDO42W6O
X-Google-Smtp-Source: AAOMgpdt6nn3lPXfiO7l37V3lVUe6Yi+TmJgSuh6CGo2++DPvqUGITomjdLaK+ZGjkv5bIFy3afPgA==
X-Received: by 2002:a62:e30c:: with SMTP id g12-v6mr27050130pfh.25.1531249129381;
        Tue, 10 Jul 2018 11:58:49 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z90-v6sm16027327pfk.85.2018.07.10.11.58.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:58:48 -0700 (PDT)
Received: by 2002:a6b:c8cc:0:0:0:0:0 with SMTP id y195-v6csp3885291iof;
        Tue, 10 Jul 2018 06:24:35 -0700 (PDT)
X-Received: by 2002:a1c:ee9a:: with SMTP id j26-v6mr13770324wmi.116.1531229075874;
        Tue, 10 Jul 2018 06:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1531229075; cv=none;
        d=google.com; s=arc-20160816;
        b=N4GaIoPXSYdivli/4cJ1Nh2XsTZc5sL27LEqp8uV2v2GxDUk2aUcnSEhqBxJpWc4aF
         NetxwLlHWJskDqZJNAIWJXiKgMKYskaWborOPlv5oZ6/6MciUwdPk9Ltv7wU3i9TEk5Z
         A0bTZ9I5CDVgNgYrki7Jw4ewIrdhRrDesCVwKzZBF3VB/omzDOJjXBe90our9+X7k1fP
         f2k58TJCQQrVyE1Vmz30Z9+8UzuGQCjga467+DokQvuXVGBXb46eg26VOUE6F4x+KbQJ
         MH3uDB1hMV+ddMxu7t/0Aw/0dIK9GdQSJnfZtwCxWUhSCyQJQ6GEJ9UpHvcNNT0rfXcI
         4POA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=mYLnk57N0nJlWrATBt9vcY2dH28s+gXXeQpcs3dYjRs=;
        b=jz/4aWky00dyfeUvIH9xedZWW3jqiyanTneP84XaoQrLFVYGoyDBL05kuG1ShF1J5b
         g8vRTa+f8DW1Dbqz4NXvTzw0z44VQUlsBihOrKmSIiXx+GxY0f/zMJQf9KU+sx9WEnKw
         AszMosKPTH4Yues8MRW6QtTblwFQdB2k3Xm+HmtMwzx+doPqY9lfAsquwnWna8RA56Ct
         XzTFdDxn+hsc+YfDaFX1P/8LYmJ7ZryQdpNzisQLJ3YAcALVwO97Zwzw7dgZijiYXcLm
         H4QYtBVgH5sUZImRzFkU1yZJCH5+Jhbo+yA1NuwsR5Kk81XMmv/XcDplk1nvg7ECA6OT
         1n5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as permitted sender) smtp.mailfrom=Johannes.Schindelin@gmx.de
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by mx.google.com with ESMTPS id h39-v6si15322283wrf.259.2018.07.10.06.24.35
        for <jrnieder@gmail.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 06:24:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyWAQ-1g70g53vfy-015sOg; Tue, 10
 Jul 2018 15:24:32 +0200
Date:   Tue, 10 Jul 2018 15:24:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Christian Couder <christian@gitlab.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
In-Reply-To: <20180702195016.GA17102@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807101521060.75@tvgsbejvaqbjf.bet>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com> <20180702195016.GA17102@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wq+Q2nd7iq1jyDX+G4UGNaacmwlrQyd3Yep9w+//O1POm5McgIc
 aFcyCxXJO7qq0+7vYH3FWAyMI0oEInMdwBzUytFFWKZVFweTSmcR8CYck9qhxVInAL4nCVe
 13EzJT/bjFceATX+MaHap93nyb9ee7nMQooZzMQlTxAbDAN3kpKHdMOXDNdx+rKaw/45V2T
 y+qhgkCWnHY6e6UQaPMfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z2ajbqcgpnI=:kVFH1XUdS5btxSRXyUGRTv
 0BqLIr87bPQvKqT05lGAu0W1/gsinwGO5USsnTNWYvo/nHr2iYmdcQ7zfZwscz1K0uUs9sUcl
 eNqzF3cUjAD7yPqwL4/OH+VXxwm+oeJTlpPhz0zg+RE5AHy8jfLyGX1g2UbNdrqkMlrfTpiFp
 q7j6Xr1NPnyo48blFae3JPomghEmg25ktawfKn8nRs2XOkg0hvEIkCXWDnH5y5bt30WnkpnFi
 uOty1mbFwlpU5aUndtVCP5MdqMzzN9iJxmkdTWzpg1WOw/4G/+30p8Rv5ASkTQafDzrv4UIDx
 lGL+juEwCaca8ovxq7syFs46X6uGgYse7Fj2HTv2Qa568AZG0ISE5D13RBKsEEMWHMGuwOJJr
 WKlUuezMvrQlHf9upR7vOb04OBHx5MY/fASD2kX5Zp0Z4vXbna/2D61Btv34gT+QLnL8oV80K
 HKBDtPTOtTdAHRsd0NRc5XxLpSvy+pvF6UgVSaNmVuSDWgJvyY7b/Vq64QjAhVFzTMsu+6EuP
 YjDOvLJcy47sX5gwgFYNqzqYegmB0FJ2XTJyL1VyZfjhG4orIfcrbVg0r0MkQhrCECoU3cvnJ
 pq8hsFn083Ka7s8HjtxxIdXHdYS9dGQsAkBgeg1f8ag24XTnd2lM5hc/5vkQg1nrB98ZK3Ayx
 5dbFsFVYe62gJl9INPcumpEvbC+yjActHt83qLiGh9kSryQ10Miqt9pkjW81jsU1GU/6aBa8H
 v2ddoTgh4q6TzCllSae+ZdmygNGxdepSw85jmtER/p/ocYFnVPaee1ZxArXQPrCh1TmHB4wUS
 Mk6WnAE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 2 Jul 2018, Jeff King wrote:

> On Mon, Jul 02, 2018 at 09:29:41PM +0200, Christian Couder wrote:
> 
> > When people complained a month ago about the MacOS package on
> > https://git-scm.com/ not being up-to-date after the Git security
> > release, I got in touch with Apple people GitLab has been working with
> > to see if they could help on this.
> 
> Unfortunately I don't think this will quite solve the issue we had, just
> because people get their copy of Git in various ways. So Homebrew
> updated pretty promptly, but people going to git-scm.com to find a
> binary package were left without help. Likewise, this will help people
> getting Git as part of XCode, but not people gettin the package from
> git-scm.com.

Indeed. The fix for that would be to automate those official Git for macOS
builds. I suggested exactly that to Tim:
https://github.com/gitgitgadget/git/pull/7#issuecomment-403820169

Ciao,
Dscho
