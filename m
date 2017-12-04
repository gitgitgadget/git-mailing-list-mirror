Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AF620954
	for <e@80x24.org>; Mon,  4 Dec 2017 18:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdLDSI1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 13:08:27 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:41009 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdLDSI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 13:08:26 -0500
Received: by mail-it0-f43.google.com with SMTP id x28so14962319ita.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RhUnYk17WxId3OyGHVuxVmSVvq7sE7mS+43fAd4kdvs=;
        b=JM1G1Gl6Ms6FZ0CvUzn0WAORvne5lzCsdFuM9uBMHj9FeYel+N0MbN/SRXqXlSP408
         IloXG81Xxxh64FXq7RMOMODHz7GqNKovUtXq1zsu+CcHXFk7MCFCWpjwNEZmakddtx0K
         UCIPcKIdJj+SpOE+bLTu7FhyXzOIFHnbOuUsTouKoxjgFTLF9f9mQWDvz3N1tOVLyNtI
         YIsC58TGlnxuywrnTPdGh57MLLmejlctpg4PXf+Kj+6tGz0yNq1IjdqUu5qC4a0BOWFh
         uFfyxlhK5SLUQY4ZDP/MnoP0oWlswT0gn43ErEnINebQRAl/MUvjsODOpxAD65Otwo2v
         Nu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RhUnYk17WxId3OyGHVuxVmSVvq7sE7mS+43fAd4kdvs=;
        b=RAN81kWjnSbbZgrJII98yIfVy11KLL4Redif4vc4kRz79ZfYjOh/emVEUCDKXVvx6f
         4b9PsZYaoixlyBbq0BsjA8aTWD1iRRU2hOKFl0qix0BnXawrkPxH57QFsd4lC/hMSHcd
         N8ujPAJv73C3l+3jujpj41DO2DmAFS13Y8R9pQrO0jQaOxj6Y2GOhNOdex49hbv23dgg
         HbjPpr7TNY163LmfAPVCD8XJVkuOpMz2A65NT1dbLza5DfGQONqH1R6iIy9iCArTAEg8
         EHvKiSiKCjJJZTiyFeDKgSaXkdPpQ5nODjJXgz0P2/Lc2eOLUO3YrEASgcjTds9MWjuF
         sUyw==
X-Gm-Message-State: AJaThX4qJNVokio6hEcNGm9Z6YONEkt3dy1TR2hv4HnvHgHqqKhtuSt7
        ZJ8/GY0M33ZTo9eBO0/lwhGjto3GTty1l/sJUsQ=
X-Google-Smtp-Source: AGs4zMYFXIFlzEakC175+QCXLrnXoCGtJvpIXYVG01HXBJ5Lzfc0degkNkMI3bfLATDB5uvf+FgkV9QjmXCbkDRuFdE=
X-Received: by 10.107.6.81 with SMTP id 78mr25124840iog.204.1512410905767;
 Mon, 04 Dec 2017 10:08:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.200.11 with HTTP; Mon, 4 Dec 2017 10:08:04 -0800 (PST)
In-Reply-To: <xmqqzi6ympi9.fsf@gitster.mtv.corp.google.com>
References: <20171129195430.10069-1-avarab@gmail.com> <20171203115941.16674-1-avarab@gmail.com>
 <xmqqzi6ympi9.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 4 Dec 2017 19:08:04 +0100
Message-ID: <CACBZZX6mEzrTdD=B7gAeLSufPR-ZEj8wO8kXsJmrJFtSbT35yQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: replace perl/Makefile.PL with simple make rules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 4, 2017 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I did this immediately after applying; please double check.
>
> Thanks.

Thanks. Looks good to me. I'll incorporate that info future
submissions if there's more stuff to fix, but for now if you could
queue it like that that would be great.

> 1: da337670f5 ! 1: aeae85bdd0 Makefile: replace perl/Makefile.PL with simple make rules
>     @@ -27,7 +27,7 @@
>          So replace the whole thing with something that's pretty much a copy of
>          how we generate po/build/**.mo from po/*.po, just with a small sed(1)
>          command instead of msgfmt. As that's being done rename the files
>     -    from *.pm to *.pmc just to indicate that they're genreated (see
>     +    from *.pm to *.pmc just to indicate that they're generated (see
>          "perldoc -f require").
>
>          While I'm at it, change the fallback for Error.pm from being something
>     @@ -50,9 +50,9 @@
>             it could be set in addition to INSTLIBDIR, but my reading of [7] is
>             that this is the desired behavior.
>
>     -     * We don't man pages for all of the perl modules as we used t, only
>     -       Git(3pm). As discussed on-list[8] that we were building installed
>     -       manpages for purely internal APIs like Git::I18N or
>     +     * We don't build man pages for all of the perl modules as we used to,
>     +       only Git(3pm). As discussed on-list[8] that we were building
>     +       installed manpages for purely internal APIs like Git::I18N or
>             private-Error.pm was always a bug anyway, and all the Git::SVN::*
>             ones say they're internal APIs.
>
> :
