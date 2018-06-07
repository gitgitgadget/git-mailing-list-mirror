Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB151F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934251AbeFGRzX (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:55:23 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35847 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933639AbeFGRzW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 13:55:22 -0400
Received: by mail-ot0-f195.google.com with SMTP id c15-v6so2718623otl.3
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qE3gh3laP/76gpkNQL95tuWOVCqkdRa1PVbAsGjodFQ=;
        b=bPtVB7ABsAJlk96v8gtqlI6KUQmAJaaMj8FhneRq0GdMB2+psPsUNrXYuLqLYvDS7S
         aaHDHeS1666NaOotj4YlczMCQSEmPgTwyVUsFbOmXVdszCTRXbvRfNIO+ZJZZmF+jHGp
         LlV1NLcEPEcanf/jsz9HIVhhUZRqbXCd+vYiFUrVDr8wnnvmEGzMpE6vy90uEpf9jxav
         Y3LREyTLcoQEIabf4cL1yTElrSzUk0F3Eb3//ws3K4/bwjFwgfhmhTAN8rkH0tk0rWlO
         DuneC8DXNg9w3OEtEfBE/xS/QnLp6ut7icNth4yVQn7IDEOCWDqK1R5QDvnHMW3vYo+v
         b/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qE3gh3laP/76gpkNQL95tuWOVCqkdRa1PVbAsGjodFQ=;
        b=gLt06cfUcBoASiiF2pFONi7YL7f7RP5Dw4gg/AKjcBj7gqX4ANQ+IqYKybbYhjy0br
         Re94B4Zjs1PgvGs4eK0VMoBPmboHhjvpiyA3WQ16MIQUxoU1ysneEyNRDjREAdLSXalL
         bny75yEuc547gvPtylksAdxrONddNzgSJiTiLeKMFdhHYw0ocyASh3baqbnv8mr6e0XV
         01711lOsI9jfvhgzWW5gQNWlXYoRjJXZYQyZGCdCIKWUqqmEfOFg+z5ZHOtIcBWJ3dDg
         JrRGuhF2nztb2BBeD2vnkWdjVBtH88uTHcGzKkaODe59LEYZ9kUkSeBPat2VFg57HOmy
         0a+g==
X-Gm-Message-State: APt69E3IzGUGgBAasdv+uLAq2sNemDmHdUQpTcNTRecsqdBxvVynpI3G
        WhesBVNXHkk5xKMjeJpb5bSn7glER3PeAc2zxZc=
X-Google-Smtp-Source: ADUXVKLpa3Gd+V7075y4sxXA8nieIjC1T+avNZnApdXMBr/iIWK8XEQHM+aOgsho6wa8Q8Wyy5DrnGABCEyKhQ460bY=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr1709145otr.173.1528394121816;
 Thu, 07 Jun 2018 10:55:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:54:51 -0700 (PDT)
In-Reply-To: <20180607140338.32440-7-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-7-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 19:54:51 +0200
Message-ID: <CACsJy8A3qVRXrQ9YiiN3Ggrcc5XFJWaWRrTbdO8E_48yRmzrqQ@mail.gmail.com>
Subject: Re: [PATCH 06/23] midx: struct midxed_git and 'read' subcommand
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
> As we build the multi-pack-index feature by adding chunks at a time,
> we want to test that the data is being written correctly.
>
> Create struct midxed_git to store an in-memory representation of a

A word play on 'packed_git'? Amusing. Some more descriptive name would
be better though. midxed looks almost like random letters thrown
together.

> multi-pack-index and a memory-map of the binary file. Initialize this
> struct in load_midxed_git(object_dir).

> +static int read_midx_file(const char *object_dir)
> +{
> +       struct midxed_git *m = load_midxed_git(object_dir);
> +
> +       if (!m)
> +               return 0;

This looks like an error case, please don't just return zero,
typically used to say "success". I don't know if this command stays
"for debugging purposes" until the end. Of course in that case it does
not really matter.

> +struct midxed_git *load_midxed_git(const char *object_dir)
> +{
> +       struct midxed_git *m;
> +       int fd;
> +       struct stat st;
> +       size_t midx_size;
> +       void *midx_map;
> +       const char *midx_name = get_midx_filename(object_dir);

mem leak? This function returns allocated memory if I remember correctly.

> +
> +       fd = git_open(midx_name);
> +       if (fd < 0)
> +               return NULL;

do an error_errno() so we know what went wrong at least.

> +       if (fstat(fd, &st)) {
> +               close(fd);
> +               return NULL;

same here, we should know why fstat() fails.

> +       }
> +       midx_size = xsize_t(st.st_size);
> +
> +       if (midx_size < MIDX_MIN_SIZE) {
> +               close(fd);
> +               die("multi-pack-index file %s is too small", midx_name);

_()

The use of die() should be discouraged though. Many people still try
(or wish) to libify code and new die() does not help. I think error()
here would be enough then you can return NULL. Or you can go fancier
and store the error string in a strbuf like refs code.

> +       }
> +
> +       midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +
> +       m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
> +       strcpy(m->object_dir, object_dir);
> +       m->data = midx_map;
> +
> +       m->signature = get_be32(m->data);
> +       if (m->signature != MIDX_SIGNATURE) {
> +               error("multi-pack-index signature %X does not match signature %X",
> +                     m->signature, MIDX_SIGNATURE);

_(). Maybe 0x%08x instead of %x

> +               goto cleanup_fail;
> +       }
> +
> +       m->version = *(m->data + 4);

m->data[4] instead? shorter and easier to understand.

Same comment on "*(m->data + x)" and error() without _() for the rest.

> +       if (m->version != MIDX_VERSION) {
> +               error("multi-pack-index version %d not recognized",
> +                     m->version);

_()

> +               goto cleanup_fail;
> +       }
> +
> +       m->hash_version = *(m->data + 5);

m->data[5]

> +cleanup_fail:
> +       FREE_AND_NULL(m);
> +       munmap(midx_map, midx_size);
> +       close(fd);
> +       exit(1);

It's bad enough that you die() but exit() in this code seems too much.
Please just return NULL and let the caller handle the error.

> diff --git a/midx.h b/midx.h
> index 3a63673952..a1d18ed991 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -1,4 +1,13 @@
> +#ifndef MIDX_H
> +#define MIDX_H
> +
> +#include "git-compat-util.h"
>  #include "cache.h"
> +#include "object-store.h"

I don't really think you need object-store here (git-compat-util.h
too). "struct mixed_git;" would be enough for load_midxed_git
declaration below.

>  #include "packfile.h"
>
> +struct midxed_git *load_midxed_git(const char *object_dir);
> +
>  int write_midx_file(const char *object_dir);
> +
> +#endif
> diff --git a/object-store.h b/object-store.h
> index d683112fd7..77cb82621a 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -84,6 +84,25 @@ struct packed_git {
>         char pack_name[FLEX_ARRAY]; /* more */
>  };
>
> +struct midxed_git {
> +       struct midxed_git *next;

Do we really have multiple midx files?

> +
> +       int fd;
> +
> +       const unsigned char *data;
> +       size_t data_len;
> +
> +       uint32_t signature;
> +       unsigned char version;
> +       unsigned char hash_version;
> +       unsigned char hash_len;
> +       unsigned char num_chunks;
> +       uint32_t num_packs;
> +       uint32_t num_objects;
> +
> +       char object_dir[FLEX_ARRAY];

Why do you need to keep object_dir when it could be easily retrieved
when the repo is available?

> +};
> +
>  struct raw_object_store {
>         /*
>          * Path to the repository's object store.
-- 
Duy
