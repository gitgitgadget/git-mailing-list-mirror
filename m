Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2920C1F454
	for <e@80x24.org>; Tue, 16 Oct 2018 14:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJPWum (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 18:50:42 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53805 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPWum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 18:50:42 -0400
Received: by mail-it1-f194.google.com with SMTP id q70-v6so33496382itb.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/0nEqqtdREinB4T8goYv0AQjF+bW8neKftU9YjUPFNI=;
        b=FSyZ8EGhPAcJGjsE0Y+4q1b+qP+vuYP9NTPPF+j1Z5iUI13kAhO+xNJqm20f1Sx/Wn
         8RvE4IKgNR9DtSYDFMki0TUiI0ofrL2dpT8wHlw0GiJG5gawKNK8QcQhKOLX3sSHZp1o
         vYgkoxBZYDtnj90+SByH684DaS7GU+GgVf9zQgYppWJ0pEJXScOJr/PlMuYVU2ym3Tf4
         uVBVIeJ7V15RCVqqQCsR9SDUjW4nXF2GLK9Nf/YXsSZqx2CJ/OPpbBdGl3UU5gNXunBp
         zmLJXFnRHDLHaFKt6rqYWaw8hZIYcgx/PzmpzbHqwinSL8lbAFWLRxiYU7rpqiuYgglh
         XMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/0nEqqtdREinB4T8goYv0AQjF+bW8neKftU9YjUPFNI=;
        b=PYglNAB2y0oanA+fNxtoAbaBBDW3bcqyymbf9ZGUha2aXXk+S1VrfoTrUg7lqLW3d9
         Faw2Q3g6U49tQwhSPogVj/ktiNkYG3tq8UDcsg7rHKFFD1SGNp25pSk4pGmX8dGx2uIF
         cOskv+EfyieBnfZF/ffQFynoSo+p+R7d5MSSc1As0WCsMimqzg/leKBuFOExkmRp3r1P
         mLWacw3AO7tt7+lc1qUZE0BNaRslrO+nwbZGBUw7Rw18Dk5DxTJvl+LWgDZJEifSwoAT
         j9ChRwOZgmwHSJkvcRfHpwSYSxmF9GUKJ5x6szLYkoW26f9Ln39eUVq87DIO4DJWGiju
         HHvA==
X-Gm-Message-State: ABuFfogd0HutE721LQpS6qlBo4Asb8vvQwCNGRySBO4odmWnO7ifoxAn
        ZKTREDaqW9JdyrZldao1PLyIf2dQoN1VRp6E0as=
X-Google-Smtp-Source: ACcGV63IY+D+3hSj9VbAHhMLBN1RDb//J/Xkb3kOQ09v+AvY1u++PmEJbwvH/T3rNGU8j/C+BNrRCJqrLOavPtmAbUE=
X-Received: by 2002:a24:a343:: with SMTP id p64-v6mr13972886ite.10.1539701991296;
 Tue, 16 Oct 2018 07:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-11-sandals@crustytoothpaste.net> <CACsJy8AOu-SdLu+MQKOzVLEy0SM0r45TjwZYkD_S5W756hWRpw@mail.gmail.com>
 <20181015233035.GB432229@genre.crustytoothpaste.net>
In-Reply-To: <20181015233035.GB432229@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Oct 2018 16:59:23 +0200
Message-ID: <CACsJy8D_9cwE_Xf7d3rWj_aq8uNUY0wpz8ydLLgvdpV0rQYbrg@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] Add a base implementation of SHA-256 support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 1:31 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Mon, Oct 15, 2018 at 04:59:12PM +0200, Duy Nguyen wrote:
> >  On Mon, Oct 15, 2018 at 4:23 AM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > SHA-1 is weak and we need to transition to a new hash function.  For
> > > some time, we have referred to this new function as NewHash.  Recently,
> > > we decided to pick SHA-256 as NewHash.
> > >
> > > Add a basic implementation of SHA-256 based off libtomcrypt, which is in
> > > the public domain.  Optimize it and restructure it to meet our coding
> > > standards.  Place it in a directory called "sha256" where it and any
> > > future implementations can live so as to avoid a proliferation of
> > > implementation directories.
> > >
> > > Wire up SHA-256 in the list of hash algorithms, and add a test that the
> > > algorithm works correctly.
> > >
> > > Note that with this patch, it is still not possible to switch to using
> > > SHA-256 in Git.  Additional patches are needed to prepare the code to
> > > handle a larger hash algorithm and further test fixes are needed.
> >
> > At some point I assume SHA-256 will become functional and be part of a
> > git release without all file formats updated to support multiple
> > hashes. Should we somehow discourage the user from using it because it
> > will break when all file formats are finally updated?
>
> In order to activate SHA-256 in the codebase, currently you need a patch
> to force it on.  Otherwise, the code is simply inert and does nothing
> (other than in the test-tool).  I've included the patch below so you can
> see what it does (or if you want to play around with it).
>
> Without this patch, Git remains fully SHA-1 and can't access any of the
> SHA-256 code.  I have some very preliminary patches that do wire up
> extensions.objectFormat (branch object-id-part15 [sic]) but I haven't
> picked them up in a while.  (I need to finish test fixes first.)

Ah, I thought that extensions.objectFormat and setup changes already
landed (I think I saw that series on this list). Sorry for the noise.

-- 
Duy
