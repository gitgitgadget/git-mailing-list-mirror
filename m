Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813071F404
	for <e@80x24.org>; Tue, 14 Aug 2018 00:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeHNDj4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 23:39:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32945 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbeHNDj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 23:39:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so30708028oip.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 17:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGdXrptNi/zkZj+H3fym7AAklPKzc4uttKWtGXFY5c0=;
        b=YqiO2ddojUMQKP6/dbG8urM6O1kjio6M31BV6DlIrIU/H9ZCU5SIGrGDzG2uajeI5J
         /zKtnKztWNgWzudF4M9kQDLnwPh2INzISiBJijTYXx6wzpZPJdR44PDlwwmFv99oLlEz
         W6nmYCVryH1RxL5kGqyPlMuGRX6ef54zZzLWSMLeTqOTqp/yJLeMCrvAZtKYSeok/MQx
         qwW8c1zGwyqF+/bC4uys53jmhzKZey/mQEPMvf0DkeI2pT38bC/fl5qT2ZMUs5l8uT5b
         ovuRDtjx+ar7ivpSHk0ChvQ00BKYai118TneVaHmEUqHW6wJcuXSj8HuhnavQnnjNyEJ
         Unmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGdXrptNi/zkZj+H3fym7AAklPKzc4uttKWtGXFY5c0=;
        b=AiOzjOZ6GHQpiqPaUF9pIqbt54kRCm0ITGpBdevJsc58ay+pu9rLfQc3lMLd/3OIFy
         zaGAAGoYlsPgkKvJclNqKymirlADngpf6vHZBbNWfFGTX3dGSsCoX/CrFCiCGlEWuvn6
         LM7/AApMrZgjPOPAim4p0I6ojSQQHv6YFMftPg0n9ICLkmH7E8Fkn+y0w1iGS4uTTk3C
         z391pJL8b3w12lvzVw8O0oAYHLYbTLnRtLi78wVRvuEkBNV4n7e9xtnJ9p03ggaU9ZFa
         uz6EJ3BTdC0DjszRAtXE15PSP+BQAJAFU63Ze562VKVu77M9yJqrcw2ApDhc3OFrQMpk
         yCKw==
X-Gm-Message-State: AOUpUlEUl/C1pc0YtTaCCvbU7D6XjKfJYRu19OfEUAyYodMN0EhByaJW
        lYelm6v8VieL7eVqmIL+i/CDYY9p3+qhjclCvv4z
X-Google-Smtp-Source: AA+uWPwfGPI8W9XKj+1LIjb/IuEVw7XtWwbGMSDihn/ONXKCGrKhqX+v1mQBI7N6rbBM3y9xztZi2uFxbJdfHY8hpHE=
X-Received: by 2002:aca:be56:: with SMTP id o83-v6mr20759327oif.301.1534208113783;
 Mon, 13 Aug 2018 17:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <0af4ef64aa52d76a597b4e97c0626c70fb2a883b.1533941986.git.matvore@google.com>
 <20180813182950.15723-1-jonathantanmy@google.com>
In-Reply-To: <20180813182950.15723-1-jonathantanmy@google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 13 Aug 2018 17:55:01 -0700
Message-ID: <CAMfpvhLhC+e6JhA+H6WRh1kcPwCORrLhRfqoExTWh3Z36wJNjQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] list-objects-filter: implement filter tree:none
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 11:29 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > -     case LOFS_BEGIN_TREE:
> > -             assert(obj->type == OBJ_TREE);
> > -             /* always include all tree objects */
> > -             return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> > -
> >       case LOFS_END_TREE:
> >               assert(obj->type == OBJ_TREE);
> >               return LOFR_ZERO;
> >
> > +     case LOFS_BEGIN_TREE:
> > +             assert(obj->type == OBJ_TREE);
> > +             if (!filter_data->omit_trees)
> > +                     return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> > +
> > +             /*
> > +              * Fallthrough to insert into omitted list for trees as well as
> > +              * blobs.
> > +              */
> > +             /* fallthrough */
> >       case LOFS_BLOB:
> > -             assert(obj->type == OBJ_BLOB);
> >               assert((obj->flags & SEEN) == 0);
>
> After looking at the resulting file, I don't think saving a few lines of
> code (to add the OID, then return LOFR_MARK_SEEN) is worth rearranging
> the cases and falling through. Can you just add the OID-adding code to
> the LOFS_BEGIN_TREE case?

I've followed Jeff's suggestion of splitting up the functions, so
though the code is now redundant, it is ready for some future
improvements that are planned, and it's more clear and consistent with
the other filter functions.

>
> > +test_expect_success 'can use tree:none to filter partial clone' '
> > +     rm -rf dst &&
> > +     git clone --no-checkout --filter=tree:none "file://$(pwd)/srv.bare" dst &&
> > +     git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
> > +     cat fetched_objects \
> > +             | awk -f print_1.awk \
> > +             | xargs -n1 git -C dst cat-file -t >fetched_types &&
> > +     sort fetched_types -u >unique_types.observed &&
> > +     echo commit > unique_types.expected &&
> > +     test_cmp unique_types.observed unique_types.expected
> > +'
>
> We also need to verify that the resulting partial clone works - after
> all relevant tests, can you also ensure that:
>  - fsck works
>  - a cat-file on an indirectly missing tree works (i.e. if you have
>    commit -> A -> B and both A and B are missing, cat-file the B)
>  - fsck still works after the cat-file
Done - added it to t5616 in the last commit of the patchset.

>
> There is another potential issue about expanding the documentation of
> the pack protocol because we now support a new type of filter, but that
> is fine because the protocol currently points us to the rev-list
> documentation (which is updated). We probably need a way for clients to
> query servers about which filters they support, but that is definitely
> beyond the scope of this patch set.
>
> > +test_expect_success 'show missing tree objects with --missing=print' '
> > +     git -C dst rev-list master --missing=print --quiet --objects >missing_objs &&
> > +     sed "s/?//" missing_objs \
> > +             | xargs -n1 git -C srv.bare cat-file -t \
> > +             >missing_types &&
> > +     sort -u missing_types >missing_types.uniq &&
> > +     echo tree >expected &&
> > +     test_cmp missing_types.uniq expected
> > +'
>
> As stated in my review of patch 3, also test the other --missing
> arguments.
Done, mostly in t0410 in patch 3.

>
> Patches 1, 2, and 4 look good to me. (Writing this here so that I don't
> need to send one e-mail for each.)
