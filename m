Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F9D1F576
	for <e@80x24.org>; Tue, 27 Feb 2018 09:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeB0Jj7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 04:39:59 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:44774 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbeB0Jj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 04:39:56 -0500
Received: by mail-ot0-f171.google.com with SMTP id 79so3184803oth.11
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 01:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9fWQc5CuNQU3ffBf70EvO2eXsRsk2RU6STzZ07QzkmU=;
        b=d7DIfk4BuSlG4c4iw0LfKvISbh/3WV8/fCYfAuJvU9sIVJt4USJpGgFdWd/zYNvSQa
         nFXpMIX5ErJoTPM2vK65wv5/4NWx4Zd4l9vrsWVkfohFKhnrmm+pzAuzTB/QJ/KS2jK6
         N5Obn7EjkqaQ/3XXel0BmPGDyfq4FRV6gTqzExXEybzP1gviR68qcxKp26Pf1y1vBhPK
         Bo5oqXSRDroT3BMh8bvHdyn60ztw0ooJ0ZZf5dbtDDRrNvrMl3ZDNBV+vsbi3v/URGEU
         SyOry3fnYggPHSw74mk2EN9fHJ95+5EO4agQ107Xlt1cxjOc23H5c9IEZxEiWpVwoa/5
         QFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9fWQc5CuNQU3ffBf70EvO2eXsRsk2RU6STzZ07QzkmU=;
        b=P91dtpX/AaT54blhByvvrsger2qmbHiB1Sqxk1ghXLhunbzL8ZY9JrGbr1TALTdUiT
         I8DUEeNBvw3+ya3V/RVLtvV/+lJ33d0yNWzpO3u8ywbUsPBLJbiaHLOd116K4/F/pATZ
         IU+nojcoc5qunSQnr2zTaebiBE/LL1eQAWV4PzDI/tZ8e5feP5FNyHK3LQlVqVpedSWe
         WJPvKm7Q43keJs8Det0YRxcMDd9nR6Oo2tbKGgicUF8RfF9EVfg0FCkpPRYp94qNcOQ3
         2JhO/z7vkKCTguae7JEDT/LETMSTxDHfARHZ4ItRJgc3cXwbdUfSmM8mhMCpOtfrK2Rc
         M66g==
X-Gm-Message-State: APf1xPDjk46foA5oAbHvlzkIEH55gnuSVJHq4uSlVi7efpgZlBNPMTZ7
        gp6aDSfbjIrWy/mbY+GGJ+COiTlvLTudyoJBaUE=
X-Google-Smtp-Source: AG47ELvMKKmdFAFy+rzr7HcspZXQQ9gEFyLeKQo8HVNiuUaif9POPq3BsSnjMFT+EXY3o6WBjHBaZfJUvuCRaqeuVBA=
X-Received: by 10.157.67.42 with SMTP id s39mr10449457ote.14.1519724396224;
 Tue, 27 Feb 2018 01:39:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 27 Feb 2018 01:39:25 -0800 (PST)
In-Reply-To: <CAPig+cRkEzN-dHh9R0cX5gOhsJ7X5evAMfpWuCnVp_QN3uz8ng@mail.gmail.com>
References: <20180214180814.GA139458@google.com> <20180226103030.26900-1-pclouds@gmail.com>
 <20180226103030.26900-2-pclouds@gmail.com> <CAPig+cRkEzN-dHh9R0cX5gOhsJ7X5evAMfpWuCnVp_QN3uz8ng@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Feb 2018 16:39:25 +0700
Message-ID: <CACsJy8BAsQPwgBMfK4BHB-GiKoknphuTT8n=QizU0rT6K5TB2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] repository.c: move env-related setup code back to environment.c
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 1:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Can:
>
>     char *old_gitdir = repo->gitdir;
>     repo->gitdir = xstrdup(...);
>     free(old_gitdir);
>
> be simplified to:
>
>     free(repo->gitdir);
>     repo->gitdir = xstrdup(...);
>
> ?

No because I think "root" (not quoted here) could point to the same
value as repo->gitdir, if you free that first, the second xstrdup()
will duplicate a freed memory. See 1fb2b636c6 (set_git_dir: handle
feeding gitdir to itself - 2017-09-05)

I will add a comment about this since it's not very clear from this code.
-- 
Duy
