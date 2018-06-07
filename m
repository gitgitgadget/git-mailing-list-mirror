Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D301F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeFGRgJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:36:09 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:45603 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933021AbeFGRgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 13:36:08 -0400
Received: by mail-oi0-f53.google.com with SMTP id b130-v6so9340435oif.12
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hMUSFtvxQfAeEYLsWC6X8SFagOEXbNbrl6rxj9jjnH0=;
        b=bRdcHAJ4JhxFPe6u478uYpqADb0TdOq6uH4LTNs13LwyNvQH/Gca00IluvXeebgUpM
         kOIg4HmXh7pBirsBCodemhVKftdx6wiYkkDiyK1GRYqZtjWoEQvd9mywwVCjjE6I1XaH
         rNan5yJKXK2Qso1M3/1YS650vq3QkJtlQDBNLlAuF6Pb8pSL0gl3b4oHD0hcB8K+ii9H
         5OOuVEf/wcOe/aTZZLcgSh2qlyFIiDnK/y4sX7MkPhJDyrd0ZnJo9Vn5YkYs8zuP5Mxs
         ds8NCwQyQGpdPCHvPigy7FNUA1U2MkTvuC5iIXisPaV//F0QqCDH3O/82zNaA3gAheaF
         vHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hMUSFtvxQfAeEYLsWC6X8SFagOEXbNbrl6rxj9jjnH0=;
        b=GMPegNVp7LPpKc61/07JjIB1z+AG9km/oBOVleA/4DpkePpmsxUqUyY9HOKluM+ikZ
         eR01iTqLVnFhc8bRQOmnlZyXqE7F20kY9MHhaSyTERiAT2zKAW/pGxEpYsWcqjj0XLeu
         dNnwzW6vu3tsHZ1yW5J43sLI/Ncg4RxDngINmT7VS3mYAJs3JBLa7tSjc/fqYgHrc4eK
         6Dh48RUdx+eULcYAfP0UtQhnE1T+3/QZDINb95eDkM9190rTrp59uZE8ASzoPk/tFiAV
         l0tXcNJfa5FBhCOZcCmXfXpGoq3jpk0AF339GJ+DBxorp0EGjenS7rGNMdlIbI5nwiHX
         mJSg==
X-Gm-Message-State: APt69E0OtMjtIXJowBfAowVuyu6FpWk04do/eAuwShZRsaSGq0JskAl4
        B1HfePyfh/e9bmY/RJmOiB2tu6/Jj1nx42SRTZU=
X-Google-Smtp-Source: ADUXVKImd7zwkDEPEQoMVNuqZyPZpMAOxJJpc5sSteDP3scusXEsWA9Elhcey7BDmziyfkjbMAZ7b1hQZCXtYaWG7Bg=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr1408542oie.30.1528392968140;
 Thu, 07 Jun 2018 10:36:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:35:37 -0700 (PDT)
In-Reply-To: <20180607140338.32440-6-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-6-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 19:35:37 +0200
Message-ID: <CACsJy8DZpe0=onuKxmM2NTN9SwKhwonv75E9T6vdB0S-WOdoDQ@mail.gmail.com>
Subject: Re: [PATCH 05/23] midx: write header information to lockfile
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
> +static char *get_midx_filename(const char *object_dir)
> +{
> +       struct strbuf midx_name = STRBUF_INIT;
> +       strbuf_addstr(&midx_name, object_dir);
> +       strbuf_addstr(&midx_name, "/pack/multi-pack-index");
> +       return strbuf_detach(&midx_name, NULL);
> +}

I think this whole function can be written as
xstrfmt("%s/pack/multi-pack-index", object_dir);

> +
> +static size_t write_midx_header(struct hashfile *f,
> +                               unsigned char num_chunks,
> +                               uint32_t num_packs)
> +{
> +       char byte_values[4];

unsigned char just to be on the safe side? 'char' is signed on ARM if
I remember correctly.
-- 
Duy
