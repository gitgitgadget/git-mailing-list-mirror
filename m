Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651981F62D
	for <e@80x24.org>; Mon,  9 Jul 2018 03:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbeGIDNL (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 23:13:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37589 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932820AbeGIDNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 23:13:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so12729312edq.4
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJPkALoxD+ckgCWSrs5m7t9g/ZrN2WXfdnXJ4gi9PQg=;
        b=amgwqsiwjc+Y1iKVNHXgsolQlNJeOPNQ+vgtEBagVISddb+h37QRHhsXnUepCygjmm
         51XPWX7/E+ci+oJH7x7YnpyEbI3j02P2zRCkBebrSFEbRlBVZpk7rndA9WO39r8j/k6g
         699k4U1h2+VQDVSjy73Mstd0BZt0470R9tifoBNVpXDxcimPW26vWcp0bJtj2J/+3SFg
         CjATCu3xwHlDXSPulaLvN7ahckJYsbrEhWlIrnBpn+g7noT3ykgqMR0filsfeEZAkYEg
         RJNJe8FYgJ7uQE497wscE5Rg1IPVBQ4w99C/mO04xUmnNLv/zxR5/dlcrNIICVF3ImdV
         KjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJPkALoxD+ckgCWSrs5m7t9g/ZrN2WXfdnXJ4gi9PQg=;
        b=DDfyDU83d9AELkTKiC38qtupr5YN3bwuqI1agvXQc7tN7mZZyE2uWjISfNK19Eusw9
         32yCvdNrPE+qmYHEChkHnDXMjqEWtZdR4UsZljCT3cWEbR9uUegNWogGpM4LlwQgtT15
         V4p1viKO+YGYKyIjWoQ/mAk5d6Ifv7vh4zA2vCyPksS+skhekvgcLN4T80WdGsnWt6u6
         U/upZOTI08GKSulDPyo7jZUi7TpuSPrZO7Tb+zeQJm+lCltb5V+lnHfE6vyMk55dJB74
         hWSOp4a/n3o0rHQqnJytGe8feKNP/4Gjk/Ad3RQ/LWQ3qSGVNiTU4hNxywk1vuirBw6S
         mLRw==
X-Gm-Message-State: APt69E38bAumVLhp2nNAU98tJpj5L5R01ANaOV9vybuodsNP3p1QqSNW
        fZAaIt7o48LMQ5XJDfYO+XUfMc+XEDIrlYJ70OQ=
X-Google-Smtp-Source: AAOMgpfGFZuCzd12OOc/YLvu+LXRqjSKTI2qlkTYMhGfGod1CTlSixDnoIm96jgzPYZDGOwHMI1H9civMAa0dGnQeA8=
X-Received: by 2002:a50:ab13:: with SMTP id s19-v6mr20932083edc.133.1531105988404;
 Sun, 08 Jul 2018 20:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 8 Jul 2018 20:12:54 -0700
Message-ID: <CA+P7+xq9SeoZjYYWhM14-u4kGgwmNVPs6c+wFR2EbwK+_hVetg@mail.gmail.com>
Subject: Re: [PATCH 00/17] object_id part 14
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 8, 2018 at 4:39 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This is the fourteenth series of patches to switch to using struct
> object_id and the_hash_algo.  This series converts several core pieces
> to use struct object_id, including the oid* and hex functions.
>
> All of these patches have been tested with both SHA-1 and a 256-bit
> hash.
>

I read through the series, and didn't spot anything odd, except for
the question about reasoning for why we use memcmp directly over using
hashcmp. I don't think that's any sort of blocker, it just seemed an
odd decision to me.

Thanks,
Jake
