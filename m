Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869CB1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 10:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfA3KHs (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 05:07:48 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:34906 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3KHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 05:07:47 -0500
Received: by mail-it1-f180.google.com with SMTP id p197so9643150itp.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 02:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xbXN2/fOZPQH317SDJgqUGjlZreakQoOqjhV1hoPAR4=;
        b=TOw+/lwUbHP+E9eeLMTZT2DBR63FKvWIqGrLNt83rmBKrNYXIpwGqbR9KYEiF9MWt1
         GJ0TLHgJj75dht1u9w5mNOxEoUdlk2aciLzJlxz3TOYXxrRCEpTi3l2NOi72qDf6Y3EI
         JEwAHjq4h/aHkPqvxXvyuvOwmyLN8SVk+k1xf8rzwz2L1wSYa/uvzqfSUnaO3wD6fcr7
         +o/TmhsBkAm1wUAmN+RDqvvsEMkKnWXnZr61QBZZPYlTp6F4R6/2lbjrdobsdzMH1P5d
         SSh33Lden7la+DGPg15Sp2FBYpT6Gh2DhTa7H/EAoAcrHNT7yJUGD+PVmIZIk61NtMCb
         DGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xbXN2/fOZPQH317SDJgqUGjlZreakQoOqjhV1hoPAR4=;
        b=GrrM+UP3hb+E6ULFYvOciISGDKifkQa6OXMZ+QWLmzV4jt1e+NrcVvx8JOjFvgmUvm
         xXoonddN0G6vEvGu6hM3lX9RFz6bE+gy3Mafa6dNFQ/aAsnQt6/OFW+1Ms9ALO1PkN4l
         jdv49em0E7rJvrwVzjm/mcGfu46pc7Tf5M7RGB5dbMnTHsDi7gdl9FM4aQD45A2X+7vh
         kcpkSr9irbovNQSDGZp8sY5idf0FpQzMjjdTSbYAup/lRzfjEgIYJGnnMApn17upc0e5
         KUhTjVp+0MeaTMDjwBGwlWis13tAPOREGpUpzMtK4eq/mPfIi73rki65GEHr7CkwN4oQ
         keOw==
X-Gm-Message-State: AJcUukcFqGKoqbDpnp0yWlKqml6TxNi+nk/V/6TZksyqo4kviWzSNplO
        vnp+2uymjiqNPfu40beDzSn/nOVcG/DU8WABXZY=
X-Google-Smtp-Source: ALg8bN631hEDZndpp2dleEf6mcvAEve8BigAemMEb3nqJNHVKgWhwNJLtZTcvFuQ3hsQh3ncc7YZmfV4dffw9ppeqwg=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr15274171ith.123.1548842866798;
 Wed, 30 Jan 2019 02:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20190130085855.GA24387@genre.crustytoothpaste.net>
In-Reply-To: <20190130085855.GA24387@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 30 Jan 2019 17:07:20 +0700
Message-ID: <CACsJy8AVoETLkB5rLft27Rz7V9xPFN9fk=8g9-fCR61fVi4vjw@mail.gmail.com>
Subject: Re: t5702 failing under ASan on master
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 3:59 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> It looks like t5702 is failing on master under ASan (output below). It
> bisects to the merge of my sha-256 series, but the error makes it look
> like it's unrelated. I'm wondering if we just happened to have a
> different memory layout with that series that's triggering this issue in
> combination with one of the protocol v2 series from Jonathan Tan, and
> the correct solution is something like this:
>
> ----- %< -------
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 577faa6229..c9dda154da 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1489,6 +1489,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                         rollback_lock_file(&shallow_lock);
>                 } else
>                         commit_lock_file(&shallow_lock);
> +               alternate_shallow_file = "";
>                 return;
>         }
>
> @@ -1512,6 +1513,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                                                 &alternate_shallow_file,
>                                                 &extra);
>                         commit_lock_file(&shallow_lock);
> +                       alternate_shallow_file = "";
>                 }
>                 oid_array_clear(&extra);
>                 return;
> @@ -1551,6 +1553,7 @@ static void update_shallow(struct fetch_pack_args *args,
>                 commit_lock_file(&shallow_lock);
>                 oid_array_clear(&extra);
>                 oid_array_clear(&ref);
> +               alternate_shallow_file = "";
>                 return;
>         }
>
> ----- %< -------
>
> This does appear to pass the testsuite, but I'm unsure if it's correct.
> It's also possible I've just broken something and am too dense to
> realize it, so please point out if that's the case.

If I understand ASan report correctly alternate_shallow_file memory is
already gone after the first fetch, when we update the shallow file.
But we're doing two fetches in the same process (the tag backfill
thingy), the second fetch reuses the dangling alternate_shallow_file
pointer and ASan caught it. Resetting the variable seems like the
right way to go.

But should we reset it to an empty string? We would pass
"--shallow-file=" to "git index-pack", which is treated as "no shallow
file" (i.e. complete repo). This sounds wrong because this is still a
shallow repository.

I suppose setting alternate_shallow_file to NULL would be ok. "git
index-pack" will just go back to reading $GIT_DIR/info/shallow, which
has been updated and contains correct info.

PS. No idea how ASan blames your series for this. Yeah maybe memory
layout and stuff. But it does spot a real problem.
-- 
Duy
