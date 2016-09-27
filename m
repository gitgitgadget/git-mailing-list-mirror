Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47AA20986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbcI0Sbi (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:31:38 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35453 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbcI0Sbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:31:36 -0400
Received: by mail-io0-f181.google.com with SMTP id 92so23880360iol.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z13DMnJxz3dE5YiyjWjfThR09Z1NnTxefHWCaFll5jE=;
        b=IepwBsv+TVOzxHhxGCVD2FExNsEya36OE61Ww/QQzoH31EzuT8sUuOUNh/CBBljf5u
         hq0c9fmp8dTNg0gdD4Mz0qOyd0SMEJz6I3MNcz0S/82P9i7XDo39DckBOJGXdTFyHjYr
         hVp46vwiHAzA3objyKFPOP4UuqaEGNHRXYpw2nuu0cfClxiBpong0Zgf53tX2y768sdO
         Cgn+8fgmj1fxQLRVYCY/NJvLMRHvS8V8dQjGLJL4/4N4jvFDnlAd9hXykj/fy4USDiVj
         dh3hvwrKqtZ6GvRJgKQbbFRBuX1vukf/bDnvNhILIlj8I7tl3hFoGEmdXyKBkF+sJV0c
         aa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z13DMnJxz3dE5YiyjWjfThR09Z1NnTxefHWCaFll5jE=;
        b=X6S8sp9k/lkdcEDViuEw4LW8ksdTenD0iGKijqf11H8OLnz4saWvlhmM+oWTX8yb9r
         mOkSJH+TLFJqQTnzueqn/2mWsxDcDj6+y2R3wMyZmwfyB5E4OiNK9xVvO/opc/Hu8lJ6
         W3oeOsBt4rTa4GVu6arG9AHs/F2DO5FZsBpGdcKw+aJaIDbAmDiA1h4FpN3odPcqZ5Mt
         WX8j5rVoelGh5XNZqn2eStuqKZnN/Uxn6NLvWbC/ZqHQCVOiUtOdrbhNoaxV4KNC4FKy
         aA/b4pt26nHqw2RwjjbvSnr98KYVhDOkQSrQFYCZ/PTsFfcgpJD/kAalIXmQS+ObbNz6
         1bNA==
X-Gm-Message-State: AA6/9Rnnc6YVKpWZZl/FpvMJsUbU6KUhcOli/p6tkqOTyaG9Ueup9y0mAmQ5OY9jWMOiHEs17z+ZHYbzBHkVMC58
X-Received: by 10.107.180.11 with SMTP id d11mr36068564iof.203.1475001095902;
 Tue, 27 Sep 2016 11:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 27 Sep 2016 11:31:35 -0700 (PDT)
In-Reply-To: <3D863101-CA73-4718-A1E7-A1664A5BDB58@gmail.com>
References: <20160926224233.32702-1-santiago@nyu.edu> <20160926224233.32702-2-santiago@nyu.edu>
 <xmqqbmz9p7m0.fsf@gitster.mtv.corp.google.com> <15BEFDC3-81B2-47FC-A213-F37B4E6020D2@gmail.com>
 <xmqqponpnqyf.fsf@gitster.mtv.corp.google.com> <3D863101-CA73-4718-A1E7-A1664A5BDB58@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Sep 2016 11:31:35 -0700
Message-ID: <CAGZ79kYitOd5-Cxr0VzhRH70B=z2gh1q2aB5xiwe+HwHuU7dYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpg-interface, tag: add GPG_VERIFY_QUIET flag
To:     =?UTF-8?Q?Lukas_P=C3=BChringer?= <luk.puehringer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Santiago Torres <santiago@nyu.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, walters@verbum.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 11:25 AM, Lukas P=C3=BChringer
<luk.puehringer@gmail.com> wrote:
> Good, I will change it to 'Lukas Puehringer' then, when we send you the u=
pdated batch of patches, that address your latest comments.

No need to stay full ASCII. German umlauts are fine.
(See `git shortlog -s` for all the contributor names, there are also
other alphabets in use)

Stefan
