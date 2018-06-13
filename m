Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94CE81F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935710AbeFMVsQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:48:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37826 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935315AbeFMVsO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:48:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so8135022wmg.2
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6vG0FNQXnt6JmO7M5Id59eLolmR8zcU4hEulqCPpCrA=;
        b=GG4Pt5KZiOt2hjG4ghsCmqeZs+u8RInLxD9QQ/91dzL01ms3oVs6jdv9Vz4NLtvCxM
         IsGC4on7nNFnIONg1VMSHIscB6zlieNy0BvymEcmkCY052X973GkQffPnMx9Ng3Bo6yY
         pWjcsjvpzfgCj+bF74sEhHbfZndlQyKMNIUj0odF6XApclzPIB9Sevyga5LLcJxwKGDr
         +Gq/A2PqaiWgP5yTHFMnTyCRoPCqvOOpARzXBk6nonvvAMFYGUuyOtVmx9/4mCA+b0I9
         kMjt8BFVxvz7R0nnaL9GWT3InqueQIEMmwU8+fzjHp5gusmZwHOLeGL4mv2rMPJj4IQv
         Jlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6vG0FNQXnt6JmO7M5Id59eLolmR8zcU4hEulqCPpCrA=;
        b=Mg9aohyhvSBGsncvlpnToXKs2g3o3GCuS1bSOWIimEw/zcswKFA2OiBoTU+p6Fwsv4
         Ag9Y7gIAx7QfqVE70HGhDLLp2bWuhGDGPk1SVxUc8lu1KB3QvnVv2u8DfptCKQAafiSG
         2soBFKWBnEtrgudknucEH/nRHPxNKcsJqXqqNSU5fjaO3LsL3qyc9roZfE+aI3nQeEzG
         ZP1DVxwmukbuw8tivfVnAV9AstGxkbfC1tlLnzYdtbyqszjTj45gBxGKS3HSeJWjpwrs
         JGaNgCMGyGK8BqmDOgpc3cHQeNU9lMy93XHNT8ltX14OkJP8hzMQwqyn5AJ4Ik+YerxX
         8/PQ==
X-Gm-Message-State: APt69E2B+rh2jNIbFDkkjwvqjVtTvHj/Pzvih+AxJu9b+Z2SzSDD6YnR
        ELI9BDRh3G5tsNflCdIGiBzopa4HryAWLJ/8GKE=
X-Google-Smtp-Source: ADUXVKJkrGk0z/6CkDpjI2z6KXapTDwSvPV6ZRc6j7HEAhf47PM4EB0S1/uyfuqSiaDfEeEiojM+8PzSBM+W00geF/Y=
X-Received: by 2002:a1c:7192:: with SMTP id d18-v6mr4459503wmi.115.1528926493085;
 Wed, 13 Jun 2018 14:48:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:ca0f:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 14:48:12
 -0700 (PDT)
In-Reply-To: <xmqqtvq65y7e.fsf@gitster-ct.c.googlers.com>
References: <20180613142207.14385-1-lintonrjeremy@gmail.com>
 <CAPig+cQ1s7QFjEFrOHMYZR8qja5yTjV5D3ksUXXqFL61YthA3g@mail.gmail.com> <xmqqtvq65y7e.fsf@gitster-ct.c.googlers.com>
From:   Jeremy Linton <lintonrjeremy@gmail.com>
Date:   Wed, 13 Jun 2018 16:48:12 -0500
Message-ID: <CAEFTgix0pasg38cb2_qrN+iPgVuq-BX9b7q+qC5Ep9iFbS=Szg@mail.gmail.com>
Subject: Re: [PATCH v2] packfile: Correct zlib buffer handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jun 13, 2018 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +       buffer[size] = 0; /* assure that the buffer is still terminated */
>>
>> I think we normally use '\0' for NUL on this project rather than simply 0.
>>
>> The comment is also effectively pure noise since it merely repeats
>> what the code already states clearly (especially when the code says
>> "buffer[size] = '\0';"), so dropping the comment altogether would be
>> reasonable.
>
> Actually, I'd prefer to have comment there, but not about "what this
> line does" (which is useless, as you pointed out) but about "why do
> we do this seemingly redundant clearing".
>
> Here is what I tentatively came up with.
>
> -- >8 --
> From: Jeremy Linton <lintonrjeremy@gmail.com>
> Date: Wed, 13 Jun 2018 09:22:07 -0500
> Subject: [PATCH] packfile: correct zlib buffer handling
>
> The buffer being passed to zlib includes a NUL terminator that git
> needs to keep in place. unpack_compressed_entry() attempts to detect
> the case that the source buffer hasn't been fully consumed by
> checking to see if the destination buffer has been over consumed.
>
> This causes a problem, that more recent zlib patches have been
> poisoning the unconsumed portions of the buffer which overwrites
> the NUL byte, while correctly returning length and status.
>
> Let's place the NUL at the end of the buffer after inflate returns
> to assure that it doesn't result in problems for git even if its
> been overwritten by zlib.
>
> Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  packfile.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/packfile.c b/packfile.c
> index 4a5fe7ab18..d555699217 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1422,6 +1422,9 @@ static void *unpack_compressed_entry(struct packed_git *p,
>                 return NULL;
>         }
>
> +       /* versions of zlib can clobber unconsumed portion of outbuf */
> +       buffer[size] = '\0';
> +
>         return buffer;
>  }
>
> --
> 2.18.0-rc1-1-g6f333ff2fb

This is all fine with me, the original comment was an attempt to
indicate that the original null may not have been there anymore too..

Shall I resubmit it as above, or can it be picked up like this?
