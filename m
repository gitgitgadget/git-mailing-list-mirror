Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084C020248
	for <e@80x24.org>; Sat,  9 Mar 2019 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCITRL (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 14:17:11 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44763 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCITRL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 14:17:11 -0500
Received: by mail-ua1-f65.google.com with SMTP id r21so293045uan.11
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 11:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I71CMByW9cFIFhLqFJyRtuEGIsiiiFMjE7Twmt1aAXM=;
        b=Bv3OaczXKKWRih2uDHGk99lkdUO1UfuWZaJtf6jENV4f0SmB8YyztZl4CYTiCKipg0
         3Yj2Nqu1SeQJSdIvNnnVEv95+qujmU/jfXUI1ZO8zjSVZ/w0VFeaOSdcdE0rixCLtiY8
         DxZPORW52jW8OfVTCQH63k+Z344tiBnjjNsLhdc0yaE0sJHog+uC3STPg9Kx9bnmcGBH
         yGs1xcPvC9rYRleGg7HkPwy0EIj4XbU9GK4tAw0Y4ZC13KDtqJfOU0Py6ZuU+IHLziNq
         S2J0MIyt7/hnztiWoYvsTzXMlDEjouTl7b6AxypUtIdMML8qtIzjoeTA9VFLpTFRAgBF
         ndUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I71CMByW9cFIFhLqFJyRtuEGIsiiiFMjE7Twmt1aAXM=;
        b=WVLmtuFHYkHNyYxxqEjRefQx9w3i1aLDbYwdw/ILoUhDFPTgCg9QrfkGlaHywY6TJj
         3n2XT5b6N3xGu6ZSuZ3v4p6NTHvHHnJVXu3nwHhTHo37z1Ii0MCymI6pbFT/Do6XXJE7
         +GZJw+dAMMr+Eoyj2BHdAy55vbHGtzc1oyFEKRxec7dVdSupE36aRc3j4rBDMuxDtC6c
         eVYPLnK85BgkgHABIeLAf049EwMD0ynC6vOcrDcxqXPydkIpk6pd4EfHX32Gv2dHrid4
         tZP7Qt2F/ZjmFPy4k+9N9HKIIF4DDxF9KXL/Ayf89AtMY8lLYKlf9WCkKJM6ok2Tepr/
         I4yw==
X-Gm-Message-State: APjAAAWQcntv3JZNx328Ffv86Q7k6NPEjwidNRqFuj0dX1ubmNyW9hGT
        RzXbeb1Mi5oQaMCdccj3RUPEyjPFIDPwTpDJ5L8=
X-Google-Smtp-Source: APXvYqzZAD8Ix76UOVj6gjk9aCvU4B56vZQbMXzhPYUMCGPii3qBXG+6CVkJtmkYZGaE8HQxSUAgUxhYMAV/gg8DRD4=
X-Received: by 2002:a9f:3205:: with SMTP id x5mr12389972uad.104.1552159030281;
 Sat, 09 Mar 2019 11:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-11-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-11-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 11:16:59 -0800
Message-ID: <CABPp-BGbqYUMEK0V_m0i7dpFb38Mm3sS-h0Ut-GSdvsKEZzRQg@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] completion: support restore
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> Completion for restore is straightforward. We could still do better
> though by give the list of just tracked files instead of all present
> ones. But let's leave it for later.

s/give/giving/

I'm slightly worried that due to using --no-overlay mode by default in
restore, having tab-completion include untracked files increases the
risk of accidentally nuking the wrong file.  restore is a destructive
command anyway and should thus be used with care, so perhaps this
isn't a big deal, but I thought I'd mention it.
