Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D1F1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 05:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeJ2Oon (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 10:44:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33709 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeJ2Oom (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 10:44:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so7277871wrn.0
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 22:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=abiDNfL5Hl0OUVaWHVcdefi1ArfqZeJgsanyF1Afan8=;
        b=sgC39S4uBDihHkgRaTiWvZHQBZmneBrMg0pEnvTZolSn52Y4/a8Is0c3vu2pSNBYs8
         CDy2zWnCgmcjNzjbeNqF7mm6d+VFbSwrwqW4i6zg1OT97FhzS0NDfZ4UP2rSFezU1DKR
         iAw1w5Zex8NMxLv9qK0SFLGqSU6DS7Egl8egduZvISo7R5Ha7ydHJjUigkdr5kejbIZa
         ivGn9UkD8aMBMKtjrnLiqn2JuwO22b5Ps1UFgDPDiGwOdLVGgHCGWK5c1BntD5x8mOO8
         NUN1Ex7vFjmtoubXBn/mZpwlYC96jXTm9QcQ2lhKRe2DlopbG2M6Nuiwft1ZNdWqLwWe
         q7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=abiDNfL5Hl0OUVaWHVcdefi1ArfqZeJgsanyF1Afan8=;
        b=BC4Uq5K5VtY2DIHiA2A8H80+58IBhfy9FZmPFbV65exo2gAfxA0dijahE0DvrB7ODO
         bHZ+pJ5DFK6/YCsqQHv5fLGUudCaIZ64iQHNVdviRSQGyFVSs2oSmsk0od9odYI27FuV
         QOELMpUDNmZWKMmLATz7WDwA8j55f5Wad4NpKwaiz/GExr1JHk9ZvM4V9yDXMvx09ufU
         wMdDQPDPZ/ySYb5/mlzsaGZ2mIoI0UxM9do2ihJMhp84dZbFTrpgPBgVG9ECDqtlY/P8
         VSzBh1c7BXU4F6F1ju0Tq2Q9SG50Y+e36IMmrA1vA9aypVcagOI+IKB3GsxdZGpDvo02
         PYpg==
X-Gm-Message-State: AGRZ1gIW6zsnYS9j93/Kx4BEUaf3hw7XRaolbrbEGYSXQtcOPaqtlO2Z
        2iR88fPuxv0sNqsWfQqremE=
X-Google-Smtp-Source: AJdET5fvuzIsNttfNwRH2WmnzFgTpVhYLQ5ioQBFd3h0aPMjxTr5FePZm7hNLTECmuoxhj0smrYuCg==
X-Received: by 2002:adf:9ecf:: with SMTP id b15-v6mr4244725wrf.164.1540792650889;
        Sun, 28 Oct 2018 22:57:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g8-v6sm23140980wri.58.2018.10.28.22.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 22:57:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com,
        f.francet@hotmail.com
Subject: Re: [RFC PATCH] remote: add --fetch option to git remote set-url
References: <1d1b0fe85ddd89cf8172e730e8886d5b4a9ea7eb.1540627720.git.liu.denton@gmail.com>
Date:   Mon, 29 Oct 2018 14:57:28 +0900
In-Reply-To: <1d1b0fe85ddd89cf8172e730e8886d5b4a9ea7eb.1540627720.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sat, 27 Oct 2018 04:09:07 -0400")
Message-ID: <xmqqftwp47nb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This adds the --fetch option to `git remote set-url` such that when
> executed we move the remote.*.url to remote.*.pushurl and set
> remote.*.url to the given url argument.
>

I suspect this is a horrible idea from end-user's point of view.
"set-url --push" is used to SET pushURL instead of setting URL and
does not MOVE anything.  Why should the end user expect and remember
"set-url --fetch" works very differently?  

If there is a need for a "--move-URL-to-pushURL-and-set-pushURL"
short-hand to avoid having to use two commands

	git remote set-url --push $(git remote --get-url origin) origin
	git remote set-url $there origin

it should not be called "--fetch", which has a strong connotation of
being an opposite of existing "--push", but something else.  And
then we need to ask ourselves if we also need such a short-hand to
"--move-pushURL-to-URL-and-set-URL" operation.  The answer to the
last question would help us decide if (1) this combined operation is
a good idea to begin with and (2) what is the good name for such an
operation.

Assuming that the short-hand operation is a good idea in the first
place, without deciding what the externally visible good name for it
is, let's read on.

> +	/*
> +	 * If add_mode, we will be appending to remote.*.url so we shouldn't move the urls over.
> +	 * If pushurls exist, we don't need to move the urls over to pushurl.
> +	 */
> +	move_fetch_to_push = fetch_mode && !add_mode && !remote->pushurl_nr;

Should this kind of "the user asked for --fetch, but sometimes it is
not appropriate to honor that request" be done silently like this?

Earlier you had a check like this:

> +	if (push_mode && fetch_mode)
> +		die(_("--push --fetch doesn't make sense"));

If a request to "--fetch" is ignored when "--add" is given, for
example, shouldn't the combination also be diagnosed as "not making
sense, we'd ignore your wish to use the --fetch option"?  Similarly
for the case where there already is pushurl defined for the remote.

This is a different tangent on the same line, but it could be that
the user wants to have two (or more) pushURLs because the user wants
to push to two remotes at the same time with "git push this-remote",
so silently ignoring "--force" may not be the right thing in the
first place.  We may instead need to make the value of URL to an
extra pushURL entry (if we had one, we now have two).

