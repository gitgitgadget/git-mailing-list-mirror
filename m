Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D761F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIEXu3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:50:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33549 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:50:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so3926631pgc.0
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwVnbHJXDdrrGSq7mzblTdzy+TuY9jM1vnZrn6vDb8c=;
        b=CyHkUzcet89cdrjLMvqNZqQXsRUaq+xSasSRFC1pP0vX42iO+r3JwIvoH1xVBnyIEV
         NH4pq/J18KjpFXPwBneVD2eJ8Db16v6GG/EMzKpq3tlirU+SSw2KwhDIo0Pea7sBWaeA
         YqKFC1fqJ7CZoyh2tECBd2AgSxPLy5lUlOJlbrX++cSf15gyOW0o9oEI9gDSfEcJthoo
         3Ct8c1wSQKPcZCHByqVeoOuISMDm/s168fsn6qlMJl7gEhmTMIvbttL7VGRg/gHn4m+A
         UOpJM+u6PSYtCr2KpDerKThKD2tfpOdi6baAHTjCznPK9IMJ06/F0vyCa/99hndCLVGH
         FHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwVnbHJXDdrrGSq7mzblTdzy+TuY9jM1vnZrn6vDb8c=;
        b=p/tnT4SKzuapS0aT9LGzbtpy1LeoUdn6cGTkuHYfiVRNZp3SQIz17EwKCcivqhT/Fz
         HwU2byKfC7ax1Nwobn4YhEUNOwz3K7Mogxh3swc9qzsmOLn+w9e0Th0DMLA1VNEfyGsj
         Pr3/Usudf1VkIQdJhR5Ud6aqj1TmKSpSFfMREscwyKgNsBWUSlL+he4h/jroXbVI5rbQ
         m2flGpC+9Crz8/GpPr77yFhCt4NQQSAn8CNsM13IgV3uV+rsOuGmcyETGNE++/ABWmhL
         CWrGy6UuTz4mBDhHSgEi7hPF0JeXnA7FG9Eys+9ZWzjYDkaQXADmUpOpIJRZIgGC56EW
         UyYw==
X-Gm-Message-State: APzg51C+/oRmKSvnhlAaVnYqnh3MHKj1TTqdW+oKvZMA0Vz/wtLLqQkf
        piXePPcuaUkm3rbep4nKyVg=
X-Google-Smtp-Source: ANB0VdZ1QLiJueGWKJ+PkLL74q1PIeoyO7YmbapP/h6eZQeoCHkZW8wq8kO23XiMheyZErrrsIPA/A==
X-Received: by 2002:a62:50c3:: with SMTP id g64-v6mr41829772pfj.244.1536175135429;
        Wed, 05 Sep 2018 12:18:55 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t2-v6sm5716355pfj.7.2018.09.05.12.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 12:18:54 -0700 (PDT)
Date:   Wed, 5 Sep 2018 12:18:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule git
 directories
Message-ID: <20180905191849.GB120842@aiede.svl.corp.google.com>
References: <20180827221257.149257-1-sbeller@google.com>
 <20180827221257.149257-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827221257.149257-2-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> This is the continuation of f2d48994dc1 (submodule.c: submodule_move_head
> works with broken submodules, 2017-04-18), which tones down the case of
> "broken submodule" in case of a missing git directory of the submodule to
> be only a warning.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c                   | 16 ++++++++++++++++
>  t/t2013-checkout-submodule.sh |  2 +-
>  2 files changed, 17 insertions(+), 1 deletion(-)

I don't understand what workflow this is a part of.

If the submodule is missing, shouldn't we make it non-missing instead
of producing a partial checkout that doesn't build?

Thanks,
Jonathan
