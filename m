Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E352022D
	for <e@80x24.org>; Mon, 15 May 2017 19:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965331AbdEOTfT (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:35:19 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34005 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932677AbdEOTfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:35:16 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so28112702pfj.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=drQXLtHrqWssaDx6CxRrDuD40GWMYqi0OttUEuR9604=;
        b=L31cXsJUsqWUaX6AB2EKGWjOQ4DWu2NZoDBTr1BfSE+3Bwa4qcD9CPNALKNmKBhZqK
         1fGJQcW8PPZUIYl/KZ/TFMitWlqoYB0SU4Ng+bKdQaf2oXb475TPfs8Vsr9UG28/GBDU
         J5cThqdahxqq4Od+V21/dcP39h+oNY5NRKleTQgVzYAS/ImDBMT42uwbjNsTBuNa3aLY
         YQe9AgXq52ZaRfMhBtTpQ3g2CGs64e+gakR5PdQ+Sx24XIloB6EbxF8X+2mjfOi/BgIj
         kLUUbp/PAuyfwAUA0heNAlnfz6QATE3kib8tfIIoEGEKKXdzwbAevCPYeo8E3F+nI/zO
         g8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=drQXLtHrqWssaDx6CxRrDuD40GWMYqi0OttUEuR9604=;
        b=Tpp2TcSsaSd8MaMn/ddjwzzJNdXEH9FCj19SaEl52iCmJfMpfwNDV5nPEpw+3oKJUD
         5bsIJZ5+OEZlptMinHwcFDcco3h2PIBX7bUCrk9Ft5Nx+OCnl9I40dKz+D9tlm4btCPV
         9IJQ3X9qXb/sdVhNUPbB2ZWcD6RDfvt1zZAuWvEmcahNM63wkEHVBO2IgJtz2rrVg2zI
         g/OmecQL5TkEpXQlTB2hQxS5lZNGMERvEBdMjalBfHGUUGuhrcNOg8hjNBUubA1YsKmR
         Zh9DSzexNFN7PdI/lWNI5pQEgcNbmIJZppzOIUjwe9uyz+E1rZHIUpr7tIyyNYMxo0ld
         7jow==
X-Gm-Message-State: AODbwcBDh/KqGW5ryezuZBAd004Yc0J/1hgsasPpilRD3Csr/HGPRelp
        NhNzDYc6oRpVaLukBSeJUxuYgkwtqaMTxMtT+Q==
X-Received: by 10.98.236.150 with SMTP id e22mr7973875pfm.48.1494876916006;
 Mon, 15 May 2017 12:35:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 12:35:15 -0700 (PDT)
In-Reply-To: <20170515192242.GB79147@google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-4-sbeller@google.com>
 <20170515192242.GB79147@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 12:35:15 -0700
Message-ID: <CAGZ79kZMHuk8g7wwwoDxBOG17Vo3P0s9v9bwzpwy5WnuNUogtw@mail.gmail.com>
Subject: Re: [PATCH 03/19] diff.c: drop 'nofirst' from emit_line_0
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 12:22 PM, Brandon Williams <bmwill@google.com> wrote:

> Does the order of newline/carriage return always the same?

https://en.wikipedia.org/wiki/Newline

There are operating systems that like it the other way round.
The BBC micro is no longer relevant (IMHO), but RISC OS
spooled text output *may* be relevant as they released a stable
version not that long ago.

But I would think this code would have issues with RISC OS
text spooling without this patch as well.

Stefan
