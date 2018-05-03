Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF13200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeECQEA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:04:00 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:46923 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeECQD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:03:59 -0400
Received: by mail-ot0-f179.google.com with SMTP id t1-v6so21206063ott.13
        for <git@vger.kernel.org>; Thu, 03 May 2018 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7WMNp+JRwO0oR1JN1Irk4B0byd7TnUgB8nxBfx8CTOo=;
        b=NBVCkHat7GoKhiAh0zy8mGIuplCh1TDMfrcVBk5lxKwY2EAojdQxDaWcKw+OP7wjIL
         LP5o2bFnPisT3n6XJors/xaNy41+LufCxngnNTZOm2I1UX9VGUuISMYFWjnlJl9Dlu/y
         Hm6ZT+rnd+F5P+mqSELwdb9zpcYovEpe6i4DRNRDrbk/gyqfUAehwhQ8NrB5noYUNRUQ
         tmAKyX49Gds7+6wSfGs3zY20JNheb6sL9M6Kj+78O+zk133F7yhOjNpPp02kvAuHokHC
         PQsvrB+MDKepZlLWooGQMmYLbbuBbOYVRreoNj6nJO06wTxkiVw/kWXw/kPoGVjxv/Dv
         ChdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7WMNp+JRwO0oR1JN1Irk4B0byd7TnUgB8nxBfx8CTOo=;
        b=mf4xEDPmw3k6xLihzFaTXXylnrEW6IQEAmlNauq6W8o7Rg+KLhTyUn0w7eV7Wyflcy
         RKe0V12ylZdGBaO+t/Dv0pwICYlY6GT6A1LK2xx7XlTxqVM6ZYICLgpoOQF5Ak4Ih2ZJ
         4b/wAx2acRXXb0tPr9y07FztiWAI5KBR1JPvwJVk1TNRiiNZ4X51Iz0LKiH0IUuuA4W3
         XDNr/bUJpVj0uM2vKuCStLjl/SpKu7RaaiF6lBIiaAKAcDB0Alj6/6fbRJF/vqusEvMN
         94W3BclY03M6g6W824BNewcmawKK2YS4QnLesNIQFD8Pzhi4c+oPZieY+BRBapvhLtku
         3PqQ==
X-Gm-Message-State: ALQs6tDvJLwPaPlUXmw/SQLHWxFdPvE1NS7fnDbD10lSBZblQvS+8r4c
        fPDVZ9EpAYm6kU73IqRhGKRITQkL84Yymx7Hc2g=
X-Google-Smtp-Source: AB8JxZqQWUs7PuXuLsSOS54NkUzcrZoaNMAgKxpSdL7Ff/eO1NDUnxCcSCTXcEyQE/RLRP0t/RdplxHPwoZvc8EkpV4=
X-Received: by 2002:a9d:3bf5:: with SMTP id k108-v6mr17417481otc.308.1525363438659;
 Thu, 03 May 2018 09:03:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.162.133 with HTTP; Thu, 3 May 2018 09:03:38 -0700 (PDT)
In-Reply-To: <20180417183334.GA9802@syl.local>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net> <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
 <20180417001212.GC14631@genre.crustytoothpaste.net> <xmqq604qwqbj.fsf@gitster-ct.c.googlers.com>
 <CAE=pOyE5oqtPZLQ7d9EHU3uPC2eG+2_6APFirRvHqywE=4dGpg@mail.gmail.com> <20180417183334.GA9802@syl.local>
From:   Ben Toews <mastahyeti@gmail.com>
Date:   Thu, 3 May 2018 10:03:38 -0600
Message-ID: <CAE=pOyGy70kodr3DdR=cMggR8mT+yFvme672zkzztDsxuxDBRg@mail.gmail.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 12:33 PM, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Apr 17, 2018 at 12:08:20PM -0600, Ben Toews wrote:
> > On Mon, Apr 16, 2018 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > >
> > >> If we just want to add gpgsm support, that's fine, but we should be
> > >> transparent about that fact and try to avoid making an interface which
> > >> is at once too generic and not generic enough.
> >
> > [...]
> >
> > My motivation with this series is not just to "add gpgsm support"
> > though. I've been working on some other CMS tooling that will be open
> > source eventually. My goal was to distribute this tool with a wrapper
> > that emulates the GnuPG interface.
> >
> > To me, this series feels like a good stepping stone towards more
> > generalized support for other tooling.
>
> I agree with Ben's assessment. A stand-in tool for gpgsm support will
> not be useful without a way to configure it with Git. I think that
> treating this series as ``add support for _gpgsm-like tools_'' is
> sensible, and a reasonable compromise between:
>
>   - More generalized support.
>   - No support at all.
>
> Thanks,
> Taylor


Any more thoughts as to whether adding support for CMS tooling is
worthwhile as a stepping stone towards supporting more general
tooling?
