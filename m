Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC581F461
	for <e@80x24.org>; Tue, 14 May 2019 13:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfENNie (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 09:38:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51907 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNid (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 09:38:33 -0400
Received: by mail-it1-f193.google.com with SMTP id s3so4998540itk.1
        for <git@vger.kernel.org>; Tue, 14 May 2019 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5dxkG+6DEqJ1u5/i8h9z7umRyntsv/xbDdceAJ49kE=;
        b=Ky5kt64x3B1FBFqnbaOxULKHC68RAeC+P9X1bJ0HkkQa32uX/v820JmzYK93z19xAn
         lljSwQ7qEcrOiWpM70RDTX3rGKy7gJjHaWzNbZ/wYlzRAoXCrZnrBh1G0AsL4K/14RiY
         35m9PLMCFox+eCDNKJnMsLpY4As7wGGUlMmgJOHPGY26P2WLML99Ok4SYdZ+7ZLZm5KD
         +wrFP7l3qGfWiaxYhy1Fb16zfAsozf3hyDsT/TtONECQhHASZG/WH2hFyrvFIqb6rzlL
         S4qtJPn5PUn6wnEHNboAeRCZrXcswzZkhoXbEp5CBVdKSh0dDlnyumtqsDUMmfbdOTo4
         dRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5dxkG+6DEqJ1u5/i8h9z7umRyntsv/xbDdceAJ49kE=;
        b=eiSNfopOzDIbhnKooxPvf6n+Pe4iag3JOIfsWagW7xM4oUobiT0FeDUe8QH2D+EKo+
         nDES9je2ob52vY46r+yOHYQtAfKpjGYInsdaRJLzL85R12x6pl/jZ3KZ7kJ5ZAoU9oZF
         1sxLwNJeBjZqmXu6LxsIFKgHu8dioZYZbsP6iTciRMPkn3olJZFpRI3J18kKV1RoaYEs
         s009NgX7adBuiDAYKa7/WECw1KL6VyVWvWDR2BQ44GRtRB990Rs8vA2BwqnRthfBATgf
         X1xdbvDD12GLPN7HsexETDTPe9wRaAHf5oST782bR9kswBnaIOMRhUzPn28h4bZF2gy8
         9OKw==
X-Gm-Message-State: APjAAAXjqgFDJL8GnYOW9ZWW9eWtKz/4/VCpwyRB2HwDt2GLv0sk76st
        8PzlZcTKBWaQJ7TGmkZ9BWQNO5cTD+TC+06nn9Y=
X-Google-Smtp-Source: APXvYqxP6qMLlCasy0XWk4q9EmWAND3j9ftNh7Gyko7SWrFUXkNyvcHks/LkaTqfRdmRR+IT1AYPnbTwIV+ByeQdRO8=
X-Received: by 2002:a05:660c:34e:: with SMTP id b14mr3117636itl.10.1557841113096;
 Tue, 14 May 2019 06:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190514002332.121089-1-sandals@crustytoothpaste.net> <20190514002332.121089-9-sandals@crustytoothpaste.net>
In-Reply-To: <20190514002332.121089-9-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 20:38:06 +0700
Message-ID: <CACsJy8B-qn9Vqrm5xF4Eg0j+dfw=WqtnJK5-Jz4kDKvJTNv_tw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] docs: document multiple hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 7:24 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> +It is possible to provide multiple hooks for a single function. If the
> +main hook file is absent,

If I remember 1/7 correctly, if the hook "file" is a directory, you
ignore it and check for hook.d too.

Which makes me think, can we just check if hooks/<hook> is a directory
and use it instead of hooks/<hook>.d? [1]

The only advantage of <hook>.d that I can see is if we support some
sort of combination of <hook> and <hook>.d.

[1] Of course if you're really strict on backward compatibility then
this is out of question.

> hooks are additionally looked for in a
> +directory with the name of the main hook file with a `.d` appended.
> +(That is, if `post-receive` is missing, `post-receive.d` is inspected
> +for any hooks that might be present.) Each of these hooks is executed in order,
> +sorted by file name. By default, if a hook fails, additional hooks are not
> +executed, but this can be controlled with the `hook.*.errorBehavior` setting
> +(see linkgit:git-config[1]).
> +
>  `git init` may copy hooks to the new repository, depending on its
>  configuration. See the "TEMPLATE DIRECTORY" section in
>  linkgit:git-init[1] for details. When the rest of this document refers



-- 
Duy
