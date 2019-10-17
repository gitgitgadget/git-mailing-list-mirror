Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42FFE1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 06:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404892AbfJQG53 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:57:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43649 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392711AbfJQG52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:57:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so1284463ljj.10
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2stNz/ligYjvCHQhbid9R0OxIjr8s5DzxuPE8sKj+g=;
        b=tHlbs5/EyVxhS6PVi/4qTLxvYpMudAWY3EJyO49IbkQl4JBMA1SEZ8EB9sQtiZnTuw
         tYEU1J6iT/JJznaZYjh4a4M8llzq42bgODZ93hh7bgFqZ8BtszJyEHrt5tB49Y63/qA7
         O54AKYDFbaFCLd1x0j6S9xCMe/QWbjXo1KgGNKjzkthp8M490AUI0DL6U310XzTQk9wO
         YEgbkTD+mV4HV5+1DV7ndcxUiXtJfgSxI+ks1FUozoyzxMawkoGAB1NtspkuvggrsAqo
         h0KEKuyKVT+ZshE8hiyZd1cV0+XtQFJ82CJ2JcGwug9vHPKITQZL0bHIWpzopG91ck0+
         4mIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2stNz/ligYjvCHQhbid9R0OxIjr8s5DzxuPE8sKj+g=;
        b=sDGRsNtynNLKcG9DH1tGWXdgvFQHpk7BvuG5vCCFeEGlt+0CNZLoL1lPCyrvyFnm0g
         7Tvah8DNZrLfWoMj27/jU+7BI/uqmyfrxqRmqJRamupR5J33JBq9UloU1Vi9+6Y9Tyfr
         UAnfi9JgK7u29oJyR7XxzUFw9+MHAE8i60aLmmBieDK5O/FXbQR8MbhuBgGumhTczZvj
         uTYOAq0GrlmcG7cAgy+iYAJb/3ucnpeMHaFib0PXrvFVKYy/SEmA2TWv3dkL7gTkcLZS
         6fA1De2ts/aTmJ04UPeJuSjryt9bGhmjaCBNaydUlXtCch19CHdEtTeOPWVJPmGgoRiz
         HQhw==
X-Gm-Message-State: APjAAAVnuPyj0FpMLU6Q4v3C3UN8GxIg6vKMHmWrVYPDADKFEGT2wSO3
        a8uNa8j4YxpQlrT5pB53zfY+CZLXR4yagz6yc1/pCZsX0b0=
X-Google-Smtp-Source: APXvYqy3b9H9be9Przm8wY0k2OHLeKmzdot8iB+n/ConN3V3FVvU4v4fCPtts0Ka7r2LKDVvNeZl8geK4VEe13fJajY=
X-Received: by 2002:a2e:a415:: with SMTP id p21mr1316910ljn.59.1571295446711;
 Wed, 16 Oct 2019 23:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com> <20191013202110.z3gyx7eikackvmzb@yadavpratyush.com>
 <CAGr--=K8beYCwRgjFdokyCkjguXTJu8wMoxMAMG_H7CVgmEA=g@mail.gmail.com>
 <20191016192819.5fxbwdediomj7gaz@yadavpratyush.com> <CAGr--=Ltx2JPexfVSWRrAdT0zHs0RWaZdS7OZD-TWJv2y7K-PA@mail.gmail.com>
 <86d8ea9c-f27e-8ab8-c7f6-b3fd1eb3895d@kdbg.org>
In-Reply-To: <86d8ea9c-f27e-8ab8-c7f6-b3fd1eb3895d@kdbg.org>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 17 Oct 2019 08:54:22 +0200
Message-ID: <CAGr--=KBSDjmYEprs6tvTTTv-7K-ApziQ4-xvJacMjNx+dKGPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: implement proc select_path_in_widget
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Thu, Oct 17, 2019 at 7:33 AM Johannes Sixt <j6t@kdbg.org> wrote:
> FWIW, I would prefer to experiment with the feature for a few weeks
> before it (or a configuration that enables it by default) is baked in.

Yes please do. Obviously I'm glad someone other than me will be
actually testing it.
(As I mentioned earlier) I'm all for it when it comes to using a
config setting, rather than having this as default behaviour. I
propose "gui.autoFocusStaged" as a variable name for the setting.
I'll be doing a re-roll once I get some more spare time.

Birger
