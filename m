Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AEC1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 22:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfJEWoW (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 18:44:22 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41026 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJEWoW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 18:44:22 -0400
Received: by mail-vk1-f195.google.com with SMTP id 70so2230384vkz.8
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgpE4+I9CiL1sjX1vIhZnxoQrhyLqVBOpHvtan0iSu4=;
        b=sAkmD5vqYFCjbDABJl6QgbZeCGzeJJMTibz0KizOu02dTpoBCknXsEHDTf5YvXRiAS
         YK6CC12UxtMMlI9vyz9F29sScTmiFjVCs0bzrdwmQl8XeoHmF+SucPGbyg0PJYfWVO5s
         UZucbeTthPp9zE0V2eH+4+2VWDr230igSBOCAQruYurwgUwcCR3DiiaOmbjC+3TmEMoa
         F23N1+EPKw88cx982WUt91a4C4PNsMw5yhWzy9xLnDmvJeo/6R6EM5exbVC/rEMv+4h1
         gjFhuESW8qBCV5nhG4lWPqJWCDqqsTvZ21cLjfIDxjly/95tQx04SJNPV8opFOPuLnqr
         m0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgpE4+I9CiL1sjX1vIhZnxoQrhyLqVBOpHvtan0iSu4=;
        b=i2ZJ1P30mH/VT7zoIIEnB8JNrrdNA3ptFG23b7KZmXvJkhIsB0KHld0B6CB526DLQ/
         6KmWvrhtMz9mmny0b4u8z7mc2AUf8XHx0/sRjQ/hPYsr3EkffLaD2XemO36vc+PMFkqd
         CWkDBKGbWHDYENHHKS0uxHC3NvO3+K2K27dnwmpSoDD7EYCABv+21njFs3bGLOfw9qh+
         D4Ry0L8b3c+2JjDyZmoFTwT5Yf/P4WuBa34dLwzaBuocneCzOVKh58t5tZOC08uIsY2J
         4gu78bkdMCI7T29kvNcRiQoKJWoqQ9vt8CzacuC8T4Oy/WLekqbyQRjjEqoDXERf+xof
         dL6Q==
X-Gm-Message-State: APjAAAVXHjy9wNM9yJ0c8Ch+p0LGjn8nlarXCy+sZ8w/tREbfhghtgMR
        ohwZecxwLH+GuuLCw1LBctqXwdPQdVUfp5M/Db4=
X-Google-Smtp-Source: APXvYqz8QCZuxw4fxf6cpAVIRRg7TBkb083UE8YMznYptcLZ5qUwSn3EsoBZ1dkJ8x0uHrxsgbWrQuWPE0e7FRougaU=
X-Received: by 2002:a1f:d706:: with SMTP id o6mr11376304vkg.71.1570315461436;
 Sat, 05 Oct 2019 15:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <9a78f9ea0fe8d1988654f52a86a01031607621fe.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <9a78f9ea0fe8d1988654f52a86a01031607621fe.1568904188.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 15:44:10 -0700
Message-ID: <CABPp-BHB0UM1G2tHQ7igRX7Sn1O9ujW6mq_e-UGanGMONHxiag@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] sparse-checkout: 'set' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 3:07 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +static int write_patterns_and_update(struct pattern_list *pl)
> +{
> +       char *sparse_filename;
> +       FILE *fp;
> +
> +       sparse_filename = get_sparse_checkout_filename();
> +       fp = fopen(sparse_filename, "w");
> +       write_patterns_to_file(fp, pl);
> +       fclose(fp);
> +       free(sparse_filename);
> +
> +       clear_pattern_list(pl);

It seems slightly odd that pl is passed in but cleared in this
function rather than in the caller that created pl.  Should this be
moved to the caller, or, alternatively, a comment added to explain
this side-effect for future callers of the function?

The rest of the patch looked good to me.
