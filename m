Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B6C6FA8E
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 14:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiITOrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiITOqt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 10:46:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1995853C
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 07:46:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z13so4136553edb.13
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=W6flu7iABpZ56soqWXl6r1htuL8LpSzRPCrQIb62YME=;
        b=lA9o5sWVf1vZepibGYTIa08f5fSxDkvXyklj381LzgfMKumqz10FvfxgHtwN305XOY
         nDnfP0Fu+DsLqiR0Y4VRpm5ANc/t+UFozjM3rjkkUpWWS4XFaR0Vuvb6B2vVLHrAv9iy
         J0ZJ7FH6Kgybb+RAFIHyx2NUcy3/jS2YUNdmNZRjepf9FjcMxAppwihfTPPFhfg7jTKk
         Qy+UmJTdf+0o1KGGcR83ca1JLs97VPqVFzEPUIJSXpOuqO6ARn00VO1RHvUH7W3yy7kh
         h3wxkFCeMPsQ7/LW1S0dG6XlffDkZzECdV3A+cdjvcSGaxs3/3ALf/37KSE8heKFKYws
         p6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W6flu7iABpZ56soqWXl6r1htuL8LpSzRPCrQIb62YME=;
        b=yhDdIci3L9UhD1ZBIVR6hYm+EVEXnh+Asv92kyov6q3xk677EPYDcU/xPuGxY3Bf1l
         OzPyZ2mANLAMO97Y4tYbSeNt9hUIPaER/MW042zdpzrbJOOTmMd0mINqBOdrpU8pjZlt
         0PqqXvR29lNcE9t0JuxK0GP9nYCn1tQVVju7spVWJr61T5ynDpCMBgHW3OMGDIxRDqeI
         pe+i3Qd4zFsj/uAkI1JElvCECEYeozhD06l4WHGoHzgJhsFSAeBQJws+v63S55iFmqbr
         cgDM12moDKQRWksohVD5Nfybk9/0rLc3Yk3PlbPjXnAUa88afNubBfphF30ZMj3KUi/q
         f0ug==
X-Gm-Message-State: ACrzQf2MVapbH5RVOUyzKd7ySs3nSyhjr4LWwDNWQD3ZV+SiZS/q7IFR
        WKUIl9RpUAzmkQk2tRsEhSsQAG3lQ+XXIF6a3TA=
X-Google-Smtp-Source: AMsMyM6LLiP0QHiwqMKyjGUybymmsb57q5Zys4hAyN4dl7SWLQB/6mrCfVHtWrQ9NDrYn16OPG2Q0d+U//bkPv2Er3w=
X-Received: by 2002:a05:6402:26d3:b0:451:6ca9:bc5e with SMTP id
 x19-20020a05640226d300b004516ca9bc5emr20070255edd.325.1663685205878; Tue, 20
 Sep 2022 07:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <38ec2360f4fbfe65fa2d9f1e9cfb7d4944d1714f.1663609659.git.gitgitgadget@gmail.com>
 <b727c25c-469f-ca56-bbd6-82f82c762523@github.com>
In-Reply-To: <b727c25c-469f-ca56-bbd6-82f82c762523@github.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 20 Sep 2022 20:16:33 +0530
Message-ID: <CAPOJW5zxoaF2NWtNiYZT3ve_boR40yvg=-3WC7dkjy63a=tVjw@mail.gmail.com>
Subject: Re: [PATCH 2/5] roaring.[ch]: apply Git specific changes to the
 roaring API
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 12:03 AM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> On 9/19/2022 1:47 PM, Abhradeep Chakraborty via GitGitGadget wrote:
> > From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> >
> > Though the Roaring library is introduced in previous commit, the library
> > cannot be used as is. One reason is that the library doesn't support Big
> > endian machines. Besides, Git specific file related functions does use
> > `hashwrite()` (or similar). So there is a need to modify the library.
>
> There are a few refactorings happening in this single patch, so it
> might be good to split them out for easier spot-checking from the
> reviewer's perspective. I'll try to list the ones I see.

True, I will split this commit into two or three parts (as I mentioned
in the cover letter). I forgot to commit changes one by one while
implementing this part. That's why all changes are packed in one
commit.

> >  int32_t array_container_write(const array_container_t *container, char *buf);
> > +
> > +int array_container_network_write(const array_container_t *container,
> > +                               int (*write_fn) (void *, const void *, size_t),
> > +                               void *data);
>
> Should we make write_fn a defined type? I'm not sure I've seen this
> implicit type within a function declaration before.

I am not sure about that. This function is highly inspired by ewah's
`ewah_serialize_to` function which also has the same kind of
declaration. I have no problem if we make write_fn a defined type
though.


> >  /**
> >   * Reads the instance from buf, outputs how many bytes were read.
> >   * This is meant to be byte-by-byte compatible with the Java and Go versions of
> > @@ -1801,6 +1805,9 @@ int32_t array_container_write(const array_container_t *container, char *buf);
> >  int32_t array_container_read(int32_t cardinality, array_container_t *container,
> >                               const char *buf);
> >
> > +int32_t array_container_network_read(int32_t cardinality, array_container_t *container,
> > +                                  const char *buf);
> > +
>
> Both of these functions are creating new implementations instead
> of modifying the existing implementations. Is there any reason
> why we should keep both of these in perpetuity? They are likely
> to drift if we do that.

No, there is no reason behind this. I thought it might be a good idea
to have the existing implementations. But it's just my thought.

> > +static int container_network_write(const container_t *c, uint8_t typecode,
> > +                                int (*write_fn) (void *, const void *, size_t),
> > +                                void *data)
> > +{
> > +     c = container_unwrap_shared(c, &typecode);
> > +     switch (typecode) {
> > +             case BITSET_CONTAINER_TYPE:
> > +                     return bitset_container_network_write(const_CAST_bitset(c), write_fn, data);
> > +             case ARRAY_CONTAINER_TYPE:
> > +                     return array_container_network_write(const_CAST_array(c), write_fn, data);
> > +             case RUN_CONTAINER_TYPE:
> > +                     return run_container_network_write(const_CAST_run(c), write_fn, data);
> > +     }
> > +     assert(false);
> > +     __builtin_unreachable();
> > +     return 0;
> > +}
> > +
>
> This similarly is a copy of an existing function. Instead we
> should probably make all writers/readers expect network byte
> order (for all multi-word integers).

Ok, sure.

> > +static size_t ra_portable_network_size_in_bytes(const roaring_array_t *ra)
> > +{
> > +     size_t count = ra_portable_network_header_size(ra);
> > +
> > +     for (int32_t k = 0; k < ra->size; ++k)
>
> We have not loosened the restriction on defining iterator variables
> within the for and instead would need this in the outer block. One
> possible refactoring would be to move these definitions everywhere
> within roaring.c.

The problem I faced with roaring.c is that it doesn't follow any kind
of style convention. E.g. in many functions, variables are declared in
random positions (instead of initial lines). This is causing errors
like "forbids mixed declarations and code", "git log --check failed"
etc.

> > @@ -8603,16 +8981,16 @@ extern inline void roaring_bitmap_remove_range(roaring_bitmap_t *r, uint64_t min
> >  void roaring_bitmap_printf(const roaring_bitmap_t *r) {
> >      const roaring_array_t *ra = &r->high_low_container;
> >
> > -    printf("{");
> > +    fprintf(stderr, "{");
> >      for (int i = 0; i < ra->size; ++i) {
> >          container_printf_as_uint32_array(ra->containers[i], ra->typecodes[i],
> >                                           ((uint32_t)ra->keys[i]) << 16);
> >
> >          if (i + 1 < ra->size) {
> > -            printf(",");
> > +            fprintf(stderr, ",");
> >          }
> >      }
> > -    printf("}");
> > +    fprintf(stderr, "}");
> >  }
>
> This change is confusing to me. I epxect the printf() to print to
> stdout, and this might be used in a test helper or something. If
> you really want this to go somewhere other than stdout, then the
> method should be changed to take an arbitrary FILE*.

I think it's better to undo the changes. I was using it for debugging.

>
> > +void roaring_bitmap_free_safe(roaring_bitmap_t **r)
> > +{
> > +     if (*r) {
> > +             roaring_bitmap_free((const roaring_bitmap_t *)*r);
> > +             r = NULL;
>
> I think you want "*r = NULL" here, if you are intending to free
> and NULL the given address.

Thanks for pointing this out!

> This method seems separate from the network-byte-order changes.

Yeah, I will split them in the next version.

> > +size_t roaring_bitmap_network_portable_size_in_bytes(const roaring_bitmap_t *r)
> > +{
> > +     return ra_portable_network_size_in_bytes(&r->high_low_container);
> > +}
>
> Does network order change the potential size of the bitmap?

Yeah, network order bitmap size is 4 byte shorter than its non-network
ordered bitmap counterpart.

>
> > +     size_t bytesread;
> > +     bool is_ok = ra_portable_network_deserialize(&ans->high_low_container, buf, maxbytes, &bytesread);
>
> Declare all variables before your logic. I think this will fail if
> you run "make DEVELOPER=1".
>
> > +     if(is_ok) assert(bytesread <= maxbytes);
>
> nit: break lines for if bodies.

I copied it from the original one and as I said before the coding
styles are bad. Anyways, I will modify the original ones.

>
> > +/**
> > + * Frees the memory if exists
> > + */
> > +void roaring_bitmap_free_safe(roaring_bitmap_t **r);
>
> And nullifies the pointer, don't forget!

Oh, thanks!

> In general, I think this change would be a lot smaller if you took
> the existing implementation and inserted the proper ntohl() and
> htonl() conversions. Git will never call the other versions, so
> why keep them in the tree? Why require re-checking all of the format
> logic here instead of only the places where we write multi-byte
> words?

Got it. Thanks :)
