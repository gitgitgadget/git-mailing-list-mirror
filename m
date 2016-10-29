Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFD52022A
	for <e@80x24.org>; Sat, 29 Oct 2016 12:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbcJ2MOU (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 08:14:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33982 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbcJ2MOT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 08:14:19 -0400
Received: by mail-it0-f67.google.com with SMTP id q124so1345460itd.1
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9T3JoTLNuwYiHpDK+87eJzJfM/OlrDmHvfK3pWjhyGs=;
        b=fbIGSO1TQaib/XF+Q+Xokemvkl/GVcc4B0ZmOndJbuZyfDLeYapvyN/lqexKmwmZR9
         3QZznOMi0H2/7sjExMjleBqYw0wxygVNxWOu6g3OTNDkpAdOuNEtNPsGgWPB0ZCFmX3e
         5KZmCoPZHiAzkrI//DCf0BifdVasCaTqt0/8ieNTJNeepXNOoeG53dpwZuhhfcroKDK4
         S/ZKFrMpZnLwWxb4auf4J4hWxjRKy30Ns4NbTkIJq3PtTYult/7cbSHID7dl1zvCsscr
         HJ+IqVU0PpcvXzObtuwg4U+CG/Y2KgClaM534kBE5i/sLHv1frar00BrlMyBbetJ26il
         6LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9T3JoTLNuwYiHpDK+87eJzJfM/OlrDmHvfK3pWjhyGs=;
        b=AE7LtUs9RQ5vPRJMDA1yzhxGHtlB4ojJ1qgiggSRJv880dbBIGZa2jpgAPE44JHqFl
         qRazBoOgbRVsPlxYmJ5I2+MIgBOkPDJwD4lRMHCsU9rIFgaWYDxn0NtAbtRrcIqDlI+b
         u+QNdbj9q4XPJakZE2BZRQcEQI3YUklQY8+yu3m+IkGnJI7i1kVGSHn6OH17JXu6MEVt
         +r39gbXzuQC7cSJZClVXKLLsOPceAnYN5mo94il4I4HSN6j5pNSpveVpLY3MNwIFuYEI
         OHDh8IXYgYx9pFWF7kfrNVE0Gp8wzMErDTkRRXvFuwV/LTP1DXyntKLjg+cvs7OZubJv
         sBvg==
X-Gm-Message-State: ABUngvc0XZbLIjOVcMmuKGfoOR0Uf2g0aPNrZR77BFSd51sVBg7COkSx96jzib5klaOyoZvnfIMZMAdGMlLloQ==
X-Received: by 10.36.127.213 with SMTP id r204mr2560308itc.8.1477743258457;
 Sat, 29 Oct 2016 05:14:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Sat, 29 Oct 2016 05:13:47 -0700 (PDT)
In-Reply-To: <20161012134727.28365-1-tboegi@web.de>
References: <20161009095649.1886-1-tboegi@web.de> <20161012134727.28365-1-tboegi@web.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Oct 2016 19:13:47 +0700
Message-ID: <CACsJy8C6=m9uKc+RcL+jJWmCcKQiPc7Qm92y3zd3aUFp+nOVFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] convert.c: stream and fast search for binary
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 8:47 PM,  <tboegi@web.de> wrote:
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When statistics are done for the autocrlf handling, the search in
> the content can be stopped, if e.g
> - a search for binary is done, and a NUL character is found
> - a search for CRLF is done, and the first CRLF is found.
>
> Similar when statistics for binary vs non-binary are gathered:
> Whenever a lone CR or NUL is found, the search can be aborted.
>
> When checking out files in "auto" mode, any file that has a "lone CR"
> or a CRLF will not be converted, so the search can be aborted early.
>
> Add the new bit, CONVERT_STAT_BITS_ANY_CR,
> which is set for either lone CR or CRLF.
>
> Many binary files have a NUL very early and it is often not necessary
> to load the whole content of a file or blob into memory.
>
> Split gather_stats() into gather_all_stats() and gather_stats_partly()
> to do a streaming handling for blobs and files in the worktree.

Maybe break this commit down a bit? the gather_all_stats and
gather_stats_partly() seem independent and can standalone. So is the
blob streaming, and get_convert_stats_wt.
--=20
Duy
