Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F46D208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 22:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeHCAtZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 20:49:25 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37021 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeHCAtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 20:49:25 -0400
Received: by mail-yw1-f67.google.com with SMTP id w76-v6so269776ywg.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LatFHNsSdcNWd9WUkcP0gHCAABmPhmq4yPn9E1NhfmU=;
        b=jXubqJXhY6VSlAJ72aswy+NBj8S5fFKRqHAaJlVSk2AmXWDkq2xU4PFya1DpIeVlgR
         wgs1E5lG/N84DfFUlKWov3cF0auo+pnxF31OcjZ+3tkk0WO/o+78lKFn7pI2FAs/CaRZ
         TMNrIo3/a9dSpjeyWK6G0dgOSIyjgHFXR+OaM+3GXzvkoPCprUBI4yCgSJzNf8+Syg93
         tPhjNmewhbK6ymNG93zqUfqZhjeEx20/uBxa3e9NtyL1zbrCQsexR+GCAh5myDvmUn/n
         CU8TJfykWKvdTi0K7MpjFCYfhIaBp96oRnqwuPBKLN4rwcF7kKh9bn/658SfkR2oAIrn
         FKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LatFHNsSdcNWd9WUkcP0gHCAABmPhmq4yPn9E1NhfmU=;
        b=ixG6+VupTLXCkYY9E4Xd+ch1Vn1qvYRnToCZMZ+vNs6KvVp6OIlFlR2gqOQLgd3y3M
         vbkeJ/anOReXOLAH9hfx/1A7aDvNizs2/rQaiROIDpM/9RYLNe4YCYmIx2h45okn5WGc
         qg/j3WE1JQ+6bsuWjtPlgXGoqB5pRA/aXqoOdtF8yVlbFoJg/9tDrQj82vHn+B6GHMPg
         pBDgdK6en2J4z5SaO9pm0dPj8dtHl+LKI9c8LSKi7qeVa2tP5cIFALeUKXQMP4OaFGx0
         MrV9LncPgbJQaw9He37u4Gm0nNh/KTQWBETZoPpKLX2fta8VyzaKQRsKSSDdR4EBGodh
         QJwA==
X-Gm-Message-State: AOUpUlFYh8QSbLPNbN3xgxsY+YiM/ZEygedJ9SXqZTLwJvoz0Yt5fRlI
        79BIdfPBeppnoC3iZ4F9dQJsm6JAgtGCu6EF9yMCGuh//7JpXw==
X-Google-Smtp-Source: AAOMgpdYUOJ/e78EkyOrGqwK2i9aJKng87ONkcUgc5CFazLGlR9f+bAcsiMF0APNBvRFlHsGwkxGropHhOJCV4NhHts=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr829821ywk.345.1533250567001;
 Thu, 02 Aug 2018 15:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180802061505.2983-1-chriscool@tuxfamily.org> <20180802061505.2983-10-chriscool@tuxfamily.org>
In-Reply-To: <20180802061505.2983-10-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 15:55:56 -0700
Message-ID: <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 11:16 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> From: Christian Couder <christian.couder@gmail.com>
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 43b2de7b5f..2d048d47f2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2513,6 +2513,11 @@ This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
>  environment variable, which must be a colon separated list of refs or
>  globs.
>
> +odb.<name>.promisorRemote::
> +       The name of a promisor remote. For now promisor remotes are
> +       the only kind of remote object database (odb) that is
> +       supported.
> +

Can you explain the end goal for this? (I did not find it in the cover letter,
nor do I make sense of this documentation)

So from what I understand, this series relates to partialClone, which
has the remote name of the "promisor" in extensions.partialclone.
That is the remote to contact for any needs w.r.t. partial clone and
fetching on demand.

This key "odb.<name1>.promisorRemote = <name2>" introduces
2 new names, where do each of these two names hook in?
name2 is a remote, such as "origin" from what I can tell, but
which naming scheme does name1 follow here?

What makes the odb key different, in that the partial clone
feature only handles objects as well?

>  pack.window::
>         The size of the window used by linkgit:git-pack-objects[1] when no
>         window size is given on the command line. Defaults to 10.
> --
> 2.18.0.330.g17eb9fed90
>
