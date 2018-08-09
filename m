Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6862F1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbeHITvz (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 15:51:55 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37907 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbeHITvz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 15:51:55 -0400
Received: by mail-yw1-f65.google.com with SMTP id r3-v6so5455226ywc.5
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MOHkxJtSc8zEox/yi8MT+l2BJ2b5th8ObL7uw4p9MkM=;
        b=Ve90+aPbVKLhqdRiMgClstlEqLiORfMILwi3474uogSChK5Z2rJVtLiijg/V5Vr25W
         MDmiFweAVJXAfWK0AffXRKCxC1jVjyLhyLks3o1Z9/CQOi/GsCQZM03O28YDQoailXPx
         YJT/l4S6OejYEZ1OtWuB7n8kizPdtXyQugbILJyrmOz4kEOupsmLEcObnCs5Bni7S5fA
         MNKOqlLlMuJo8y0P59AD5vmfGNW8foBQwPIK4UPfXx7CJzbkiyIU5UJ5w8KSsZGAa8C2
         AhN6W6Xut3fLv9+jh9gtc5LRmmCTBbiLklz4BQ+LhDLmFWe8XRqtZuooDNhe0W9N745c
         8i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MOHkxJtSc8zEox/yi8MT+l2BJ2b5th8ObL7uw4p9MkM=;
        b=bMzZIWXA9JYMMoURk9qUaQFXZbue9R/Jtt1QsWeWA405r7NAIOk3lCmyAuOIejrkUO
         tE0rQKkU4XlSpmdSa2dz7JlCsEB3I6tofyS90GPPU6bLPHgIPEMkBw/nlghpYr30lgci
         EeqqMiImw3/wn/vP0978X/z0058EcocStV/x2VUFMVRu8qxAUi1IUEVbjz6bBeLoxf+h
         6w5ZFXqe464nLbzWWlX07rq+wDE52hGLRTZDATkAfhOpSe3pTnhZdmfzkvNMKBT5B/Pv
         JxlCcHD+cWWp/BNCISuNt1RMWP6TrY5nOT16aXtIMxZWNl/ejlxW0SC9cD40d0lDJQyQ
         i+DA==
X-Gm-Message-State: AOUpUlExrckm+k7H3oR5/Dps0Ct04IwIeQ27nnbZDNu0OIoBceqO/EeO
        t1EgYQo3IEIg9y8Duk/IzMcK5xj5WDTvi2hhxrEoNfZfYZcMdA==
X-Google-Smtp-Source: AA+uWPwz/XsrJH/B+KAFBz9Uky+nttz8uDnipPI6mtMb5ZlbhfpV7BFF+p37hbKMduOcYbWMAMbgJ7w9AA1yBKmqvIk=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr1689740ybm.307.1533835563372;
 Thu, 09 Aug 2018 10:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com> <20180808221752.195419-4-sbeller@google.com>
 <CAN0heSqwGoFwn34nRp3i09ExnjDPSY8WD=81M9jN5OW-ccpiTg@mail.gmail.com>
In-Reply-To: <CAN0heSqwGoFwn34nRp3i09ExnjDPSY8WD=81M9jN5OW-ccpiTg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Aug 2018 10:25:52 -0700
Message-ID: <CAGZ79kYtKZJ0Dm0ejxrotnoaNERtR0J6=DMCgweCObdJr0K6-w@mail.gmail.com>
Subject: Re: [PATCH 03/10] sha1-array: provide oid_array_remove_if
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 12:39 AM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> On 9 August 2018 at 00:17, Stefan Beller <sbeller@google.com> wrote:
> > +int oid_array_remove_if(struct oid_array *array,
> > +                       for_each_oid_fn fn,
> > +                       void *data)
> > +{
> > +       int i, j;
> > +       char *to_remove =3D xcalloc(array->nr, sizeof(char));
>
> Do you really need this scratch space?

I don't think so, when we reorder the items while iterating over them.

I though reordering them later would be easier, but I am not sure anymore.

>
> > +       /* No oid_array_sort() here! See the api-oid-array.txt docs! */
> > +
> > +       for (i =3D 0; i < array->nr; i++) {
> > +               int ret =3D fn(array->oid + i, data);
> > +               if (ret)
> > +                       to_remove[i] =3D 1;
> > +       }
> > +
> > +       i =3D 0, j =3D 0;
> > +       while (i < array->nr && j < array->nr) {
> > +               while (i < array->nr && !to_remove[i])
> > +                       i++;
> > +               /* i at first marked for deletion or out */
> > +               if (j < i)
> > +                       j =3D i;
> > +               while (j < array->nr && to_remove[j])
> > +                       j++;
> > +               /* j > i; j at first valid after first deletion range o=
r out */
> > +               if (i < array->nr && j < array->nr)
> > +                       oidcpy(&array->oid[i], &array->oid[j]);
> > +               else if (i >=3D array->nr)
> > +                       assert(j >=3D array->nr);
> > +                       /* no pruning happened, keep original array->nr=
 */
> > +               else if (j >=3D array->nr)
> > +                       array->nr =3D i;
> > +       }
> > +
> > +       free(to_remove);
> > +
> > +       return 0;
> > +}
>
> I can't entirely follow this index-fiddling, but then I haven't had my
> morning coffee yet, so please forgive me if this is nonsense. Would it
> suffice to let i point out where to place items (starting at the first
> item not to keep) and j where to take them from (i.e., the items to
> keep, after the initial run)?

I thought this is what happens, just after the actual loop of calls.

> > +int oid_array_remove_if(struct oid_array *array,
> > +                       for_each_oid_fn fn,
> > +                       void *data);
>
> Maybe some documentation here, but this seems to be following suit. ;-)

Worth mentioning: the order is kept stable. (c.f. shrink_potential_moved_bl=
ocks
in diff.c which also "compacts an array", but without stable order).

Thanks for the review. I'll try to rewrite this to be more legible.

Thanks,
Stefan
