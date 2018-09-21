Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0771F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391440AbeIVCJy (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:09:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33693 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391251AbeIVCJy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:09:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id n11-v6so2762142wro.0
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5odBn9rpe2auE1ueUsDwmEvVn5QVngT/AHrS9h5lZ14=;
        b=XFwTiqEM85ED9ui4ZZKoxmfBLpNktAPV+Sx7EIjBvg6rpzseAEo+su9LhFLgQz1Aaj
         B+7heoNZxoFsf8IrdUNDeLJ7oqx5AIC81nEIfap+9heDrgvjWG2bS7qK2AQwsEIn275b
         vfOm8/enasHCaEUpDKbYAgyMRXbGcxKPy/vYwxy4QcLlXy+Hnxp/23voz3UuJPLlC4aK
         k3+FHFpXxMCe9/9OWmhebz7i1D59j5fQ4wH/QkLbUIhJTuByHGx6I7Ro5hVrnRggOBI/
         yFH8GXoTaIUjfXD4OGZ4Dvu392rds/UafUdJG6qfJpFczTLYXjJK9ZrE2M29g/Krf8VF
         pldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5odBn9rpe2auE1ueUsDwmEvVn5QVngT/AHrS9h5lZ14=;
        b=B/Tr38Kmsh52pUnqCB7QV4Ut29H98jpAMICFW2jNntkKzKGe1BP+cE7eDq67qP+yil
         syBCuVYfWiz/3UiZoja0oozEpwNUicf+c+TGp5mup9UAPtH9yWWqm7FLGb/5iOD5ySp7
         H9m26urzTIx28a8fL70AkBggxC0op6mzC7PhHSDXVYanNWnHy2ewd+7wdvXc8zB05IxP
         BO+C55PEDwDwD3RwcytvVunp68+knd9Bs83APP7v2l3M5qXi636IWjN6WzgrFQZdXqM9
         Hq818yf/wbE2jNRwENrL8cd661tOgmcFIzy+WG+YREcr3dkmFdju7K7PlJgvgk1Tb3s2
         +vsw==
X-Gm-Message-State: APzg51AkrplLFlLZ43i8LbZ0gVmtXFixti5gxPxvjwwQI3L9jDkrh251
        laGppvhThlpTU7e4KnsZcHI=
X-Google-Smtp-Source: ANB0VdaUdEFxMypXn7KY4442MdObEXAzWQFwU4dh5w0i4sO5R4NL68ppDrn2qimaezGdfQ7GyzY8tw==
X-Received: by 2002:adf:db51:: with SMTP id f17-v6mr38839245wrj.212.1537561163845;
        Fri, 21 Sep 2018 13:19:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 75-v6sm9432027wml.21.2018.09.21.13.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 13:19:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] connected: document connectivity in partial clones
References: <20180920184843.20898-1-jonathantanmy@google.com>
        <cover.1537553700.git.jonathantanmy@google.com>
        <14153be920095f5fc8c11da33d5d27469e3a0f39.1537553700.git.jonathantanmy@google.com>
Date:   Fri, 21 Sep 2018 13:19:22 -0700
In-Reply-To: <14153be920095f5fc8c11da33d5d27469e3a0f39.1537553700.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 21 Sep 2018 11:22:37 -0700")
Message-ID: <xmqqmusavc1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In acb0c57260 ("fetch: support filters", 2017-12-08), check_connected()
> was extended to allow objects to either be promised to be available (if
> the repository is a partial clone) or to be present; previously, this
> function required the latter. However, this change was not reflected in
> the documentation of that function. Update the documentation
> accordingly.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  connected.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Very much makes sense.  I think this is sufficient clarification to
allay your earlier worry of having to have a huge in-code comment to
prevent the "must exist" loop from getting removed.

> diff --git a/connected.h b/connected.h
> index e4c961817..8d5a6b3ad 100644
> --- a/connected.h
> +++ b/connected.h
> @@ -51,9 +51,9 @@ struct check_connected_options {
>  #define CHECK_CONNECTED_INIT { 0 }
>  
>  /*
> - * Make sure that our object store has all the commits necessary to
> - * connect the ancestry chain to some of our existing refs, and all
> - * the trees and blobs that these commits use.
> + * Make sure that all given objects and all objects reachable from them
> + * either exist in our object store or (if the repository is a partial
> + * clone) are promised to be available.
>   *
>   * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
>   *
