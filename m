Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5627FC38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 07:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJXHow (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJXHo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 03:44:29 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD76561D66
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 00:44:02 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id q127so2209156vsa.7
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=56vilAbJlrYRRvfkJ8zXzvNesVY2lnPetLjWvBT+Zi4=;
        b=hQuIWzpC3ddWtGPE4I/jrMifVUO25ngsxGv7BnSaCWp2EFkQa+bw3hW/8mqYuM4qmz
         XmMmuTCOlXIKbIRn2unkR/omqW9uUSdmmeQw+DQIY6+eOuhoq7GcC0PxOinCUnR441ZG
         6Jn5Sanj9B+Jp9Yl34xlNatZybpZjO76Iexr9qpFJmh9DaJlcLw75DP18vqCAKzWhoDT
         luiI6TFxvJm3T6dOsY3cSJ5BctagsDcNXwGS6g4s1qVIUTAIRMMHUgOSnsKboHUXFvhZ
         +zBSK+2XVTntVF4OaXhDniOZyj0At+1+miIfzGQ6gmef1VrAxIZxVUUgnloI1pvbcDqq
         yVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56vilAbJlrYRRvfkJ8zXzvNesVY2lnPetLjWvBT+Zi4=;
        b=pd3p6jXuEBWevPIudH1aq9kAtyYeSRTnDQbVUOhpU+6LeWaCIewXcoU7i9oY2H/qhj
         xpRDNjxLul+Wb5q5BY0iiEgE8UWQdu9vSrZGD4rocnDPH6PO925W+1P5eBUlM9ARJVOK
         i0I/iNx6dB3XMwI/0cfooQ6dARgISTnYljvf4Eg373/o5N7m6w+lqCRXMPKAtumVcXFR
         ZuhhFJYOK7whi9aUNcfi7Fl7W8+6zHMSwq8Vw8+d/4iWPOz5kERySh7K7aFO8LWbI8Q9
         vdn6o3cCMCa6EGoNl+YYVp/uRVzeGPZB/2GaPpr/wJ7NHZabzqTFusAssVmb2RzciAD5
         XZtA==
X-Gm-Message-State: ACrzQf1K9percI28nPUIKfw1qBXSAuc8emZ1AfGNO9ejbkBCihtt64nA
        Cq5T8ozopIQkTzKVnkP0X8WLU8fUAB6IaUvDJYU=
X-Google-Smtp-Source: AMsMyM5RUtz4mJ+3CvMpOWUIuAUyCkgSrc1Hq5rRFQqX60/YpWDHKFWOaK8VQXFKjuQU9f+syl6+9m0wAoJoAgBhfLc=
X-Received: by 2002:a67:a409:0:b0:398:a30e:156a with SMTP id
 n9-20020a67a409000000b00398a30e156amr17783005vse.38.1666597436984; Mon, 24
 Oct 2022 00:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <20221022222539.2333-1-philipoakley@iee.email> <20221022222539.2333-4-philipoakley@iee.email>
In-Reply-To: <20221022222539.2333-4-philipoakley@iee.email>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Mon, 24 Oct 2022 13:13:46 +0530
Message-ID: <CAPOJW5zmYC9q8+aXh9-kZnvT28GQ1ud3LenFi9qxV4DVdCWKxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] glossary: add reachability bitmap description
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Philip,
Glad that you're working on this :)

On Sun, Oct 23, 2022 at 3:55 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> Describe the purpose of the reachability bitmap.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  Documentation/glossary-content.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 97050826e5..3d67b452aa 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -508,6 +508,14 @@ exclude;;
>         <<def_tree_object,trees>> to the trees or <<def_blob_object,blobs>>
>         that they contain.
>
> +[[def_reachability_bitmap]]reachability bitmaps::
> +       Reachability bitmaps store information about the
> +       <<def_reachable,reachability>> of a selected set of objects in
> +       a packfile, or a multi-pack index (MIDX) to speed up object search.

Looks good to me. Initially I thought that we could explain it more
but as you already linked the "reachability" here, we don't need to.

> +       A repository may have at
> +       most one bitmap. The bitmap may belong to either one pack, or the
> +       repository's multi-pack index (if it exists).
> +

Small correction here - A repository may have multiple bitmaps (one
for each selected commit from the preferred packfile or a
multi-pack-index) but it can have only one ".bitmap" file (as of now).
Bitmaps for the selected commits are stored in that ".bitmap" file.
So I think the below lines (or similar) will work  -

    The bitmaps are stored in a ".bitmap" file. A repository may have
    at most one ".bitmap" file. The file may belong to either one pack, or the
    repository's multi-pack-index (if it exists).

Feel free to rephrase it accordingly.

Thanks :)
