Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703001F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeHMXbJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:31:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50547 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbeHMXbI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:31:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so10192302wmc.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMHQKe+If5LlRugcIHKHhE2LN+cl8Qgb7AjE3JCj+Wk=;
        b=QvX9lGU96KWxSk/Uc5Au2Rk2lA5qjaKRIl6Xmj7nSpQ3yQzfuTOhsci6gaWBgBXhsH
         05dd+sDr+a3gBce4RH1KX1okOUcz58BCr6hPbQuq2CFginZ0NRnaXFa8T3nQnXoPNOFJ
         rLyY3/DZIxyNA4Tvbe/JbtXGOUWdGIy8/ZTfkwvv7TJVn9FqIaGQoh4FVIQ2G2nO1gMr
         xzfexP3tuWMp1oms6bx8Oyeur1VpBLmOgVREBTdNVy/FMThn4MiRqvBDn0eYLio7JD+o
         b47wyoepadNQlGrZic+bp1myxzSdtMI5Cqz8GPeH+woAdbx8opQQYgX1Zv0t2ubB8sV4
         voOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMHQKe+If5LlRugcIHKHhE2LN+cl8Qgb7AjE3JCj+Wk=;
        b=gLugRTQS4P/26ZndP/vn3Ghw+DXl5uauGo34ZLV7hNMj09yTlpIPJib9rqJ4J7GEPD
         +tidRfTj1eD8CGIFz6l3P1WSCX3D17IKs8ypoPC0hZeQ0V1p2kt0vyYXNrQYn6oazZ8m
         EHX9G05rbYND8XsbYgVoDwkFWsIod8BrDZAA6nx127lc5j2aWkOR03LEZ68NU3lg/V5w
         FS0ohjeBcAfFOc5G7CIq1KU0WbHXs7mwGgnor4M4tVekl/RWP+qkDwmznt/l7fXJ65RW
         mkLdii+Ts46R01QtacWxRgvl7U2r5WaktvfqO3Voht465A/l4Z8uX8R+RHN+HsZNf0k9
         npOQ==
X-Gm-Message-State: AOUpUlG3s6NXBhu3n9oH3Am6iaYlw5LpR1BYJ25j49p4k5D3fqhX4CQA
        GnzyP8uyNJVj5tQODbAwhoq0nXT7
X-Google-Smtp-Source: AA+uWPxd4doBz2Z8upQFkJYZuVFEeyw8BqElm9hZCACqvjnBaWg0IBv4iizBPBuDRyTe8VbzTmYjiA==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr9718707wmg.50.1534193236323;
        Mon, 13 Aug 2018 13:47:16 -0700 (PDT)
Received: from andromeda.localnet (185.86.136.77.rev.sfr.net. [77.136.86.185])
        by smtp.gmail.com with ESMTPSA id e141-v6sm17481914wmd.32.2018.08.13.13.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 13:47:15 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v6 00/20] rebase -i: rewrite in C
Date:   Mon, 13 Aug 2018 22:47:07 +0200
Message-ID: <2126644.CIUTlRnjVv@andromeda>
In-Reply-To: <CACsJy8B=4kKa5ZjQ6dL2H9LToOGdu2OzmexwpWkS+Tayphv1XA@mail.gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com> <20180810165147.4779-1-alban.gruin@gmail.com> <CACsJy8B=4kKa5ZjQ6dL2H9LToOGdu2OzmexwpWkS+Tayphv1XA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

Le 13/08/2018 =C3=A0 18:06, Duy Nguyen a =C3=A9crit :
> On Fri, Aug 10, 2018 at 6:54 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> > This patch series rewrite the interactive rebase from shell to C.
>=20
> I was running some tests on 'pu' and ran git-rebase--interactive
> without arguments because a test failed and I was wondering if it was
> me. It showed this
>=20
> > ~/w/ztemp $ ./git-rebase--interactive
>=20
> fatal: ambiguous argument
> '(null)...97004f10c7e6d1e784eb8a62bebdf529cd3b81f5': unknown revision
> or path not in the working tree.
> fatal: Use '--' to separate paths from revisions, like this:
> fatal: 'git <command> [<revision>...] -- [<file>...]'
>=20
> The "(null)" should not be printed out because it could actually
> segfault on some other platforms. Just wanted to let you know.
> Apologies if it's already reported and fixed, I didn't really read
> this series.

Thanks for the heads up, I will send a fix soon.

I don=E2=80=99t know what you were trying to do with git-rebase--interactiv=
e, but it=20
should not be called directly.  Instead, you should call git-rebase -i.

Cheers,
Alban




