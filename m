Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C306E1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 14:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJQW1p (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 18:27:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39094 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJQW1p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 18:27:45 -0400
Received: by mail-it1-f194.google.com with SMTP id m15so2699443itl.4
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wkEUXkwSKCyrh7qx6s+u4ZqI6UUjH0eOck2vCsmwV+U=;
        b=iAEm7EzvvlRuGM9dCuXU4zFfwaOMcKvixw7TVltuILnh3yrJxh+2INwLPFOgshocpO
         vfPTyeNxqTDoYXHm8gVGGoGvayXeosIE/AOFJD87lrZy0/q8dkpiK+RF0vlP8flcBLXg
         OwtPnh4CBDkKtMSD0YzBgCyO9yw7aDoUnGNYaUGH4V4ef2Qrt2LGvsOgKV6KFVkpp7b8
         c2OJYNUfBNGPNY1T/vNadV7wuTajSn1CPSC+dkjmgxuZkWgiTvSVYIXbhJyia3f6l4DY
         j0TfetKFw3y8iREPpBd1Oj93XVszFGJh4RjVwRU/vo1TzSHsquKFZDMONe6Oqpmyn0kY
         VO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wkEUXkwSKCyrh7qx6s+u4ZqI6UUjH0eOck2vCsmwV+U=;
        b=Thx8GoI9DBawIhVqw1Mve2j1ZJnJDwCPaxH6eonY+2zUnkiyewNe0HBAok94JIwCUe
         /g2L4m081vjR7nsL+vdtxGzBA2jq8H43AzEVxNCYiexDvJWro6IFQhMfpJEcVArl5l0w
         NPR9dshbAtqLv9Fkc994rhTGS2UGv2uu3ilFDQBN53eyEcWRcDdeqj7QSohSSM96PTRI
         3Xv4ynzCmbtjoNzVu/+5bd7YUFnH38hYZQVwAS2hDkV8lFeap7M436K0O2Ldw5X/Ks9Y
         HANhtzKQXlRlcZuQblS8+fsMqdDSMKNHMXtYfSEFzPlBba1GqF4HWKJv/cURwvkS8Ju6
         FpiA==
X-Gm-Message-State: ABuFfohBoYZtt95hjsCPVeeWIbBx9KKeOENciK0kzHyCPCpIf9xR99iT
        yFTN3sbQZznB1mn/uwS/MzzKEDbg6EQRb1EHrz8g9g==
X-Google-Smtp-Source: ACcGV63f38PQ7C10n2cNytMHbUjAqsXx9Lw15dNZX+iwK6jnRc3gYE2kCjxtvOCyif8jDzWJtchGtfElqGII5hDIlSw=
X-Received: by 2002:a24:a343:: with SMTP id p64-v6mr1606728ite.10.1539786706352;
 Wed, 17 Oct 2018 07:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net> <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
 <fbd59390-42ee-8c06-74b7-1e7081680913@gmail.com> <CACsJy8Bg6BpQp4dDXzs8Y_d6RHW9ti4+FLqnAqGwW8F-SWUnPg@mail.gmail.com>
 <20181016224404.GD432229@genre.crustytoothpaste.net>
In-Reply-To: <20181016224404.GD432229@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Oct 2018 16:31:19 +0200
Message-ID: <CACsJy8C9nySzG0Uqs6_5V2rXHkAKr-ShXU7N9sPp4N5z=D0zQA@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 12:44 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> > > >>   static uint8_t oid_version(void)
> > > >>   {
> > > >> -       return 1;
> > > >> +       switch (hash_algo_by_ptr(the_hash_algo)) {
> > > >> +               case GIT_HASH_SHA1:
> > > >> +                       return 1;
> > > >> +               case GIT_HASH_SHA256:
> > > >> +                       return 2;
> > > > Should we just increase this field to uint32_t and store format_id
> > > > instead? That will keep oid version unique in all data formats.
> > > Both the commit-graph and multi-pack-index store a single byte for the
> > > hash version, so that ship has sailed (without incrementing the full
> > > file version number in each format).
> >
> > And it's probably premature to add the oid version field when multiple
> > hash support has not been fully realized. Now we have different ways
> > of storing hash id and need separate mappings.
>
> Honestly, anything in the .git directory that is not the v3 pack indexes
> or the loose object file should be in exactly one hash algorithm.  We
> could simply just leave this value at 1 all the time and ignore the
> field, since we already know what algorithm it will use.

In this particular case, I agree, but not as a general principle. It's
nice to have independence for fsck-like tools. I don't know if we have
a tool that simply validates commit-graph file format (and not trying
to access any real object). But for such a tool, I guess we can just
pass the hash algorithm from command line. The user would have to
guess a bit.
-- 
Duy
