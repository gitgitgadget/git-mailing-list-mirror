Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0B21F4FF
	for <e@80x24.org>; Tue, 20 Sep 2016 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755281AbcITQab (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 12:30:31 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37639 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754835AbcITQaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 12:30:30 -0400
Received: by mail-wm0-f46.google.com with SMTP id b130so44202798wmc.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8GUnCja+dg6wkxIPuiIpkc/Q1HWT5cr8adZ79DvTQrQ=;
        b=ks1wJ6Ymf2q9duVs6H3xNiHIh1zz4e33EPa9+n6NSaiGz9vxoKoYC49YXnk36FxTMC
         LgWb8qXxW/mxv/plQ8imu2rNB5/X/qzaDG01qz2H3y03k84tsG82f/aI3VJGVNbBQk/Q
         WwCsP1n38szj0gw73VOGv93quuHUI1b6tb+xsFwYrizFWOPnyZwx0bp4llnUmdv3d9gl
         G81jq3ybJeS4WYNhyeAYrVJEeNU/x/LnmALPvdUgEHu5GplSWo3GBL9RCJIA+rZY5SON
         ZA5j2oLzIJH02/j9MLI0dpgX7H5axu1x7iV1tEmtqU8qi0KRvK3JGJ7U105hIehA9N+j
         q9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8GUnCja+dg6wkxIPuiIpkc/Q1HWT5cr8adZ79DvTQrQ=;
        b=hy4RF/L7uGZsDlN/7kg3iNFC+TZ2/fUPVKAGAEVvm4T8Wqb47eOcq/ntlnNqdzRfVU
         HFVLLDTSQrYV5awaktc2ezw0uo3eoIk0S7TqR8BHvuU/9b4CSHtGNhh8S/aifEYEhhjg
         VVbp4oVPxLtImON9xZpGmsvRvGcLsYiEsBU0NZkrGNhziAaI/xKeBwawNaq3ngKurABo
         464PfyykfzbQ5ZfSACwTfN/Ex5Tpaniy5FcJn6LtyqSHzdeYbEEiKmCrQpcbd5grzDBq
         s/fiM7Tiz7FdVTsroPdU0KHSfzNUSBY06xj6v9pDiEMtjTCBztX5tMeb984Xg3Cfoox2
         QRzg==
X-Gm-Message-State: AE9vXwPs5lKgjybcqiWjCHJcus5/myQ4jXTAuIOWUFhvKdB0Jgf42FpjDVRwqin461KOyFWRdCkrST5l9fmPGYmh
X-Received: by 10.28.46.204 with SMTP id u195mr4420219wmu.57.1474389028289;
 Tue, 20 Sep 2016 09:30:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Tue, 20 Sep 2016 09:30:27 -0700 (PDT)
In-Reply-To: <xmqqh99bcw6m.fsf@gitster.mtv.corp.google.com>
References: <CAKoko1qrAuLhn6qQax-BSZFhEqbFdiBbVrip8TD3NVjD8Xzy0g@mail.gmail.com>
 <1474311151-117883-1-git-send-email-bmwill@google.com> <xmqqh99bcw6m.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Tue, 20 Sep 2016 09:30:27 -0700
Message-ID: <CAKoko1oU+QR61Vy0eSxaRe_w8u4q_bC9gx9H7oMqH=CwNzBVCA@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 4:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> As the previous one that used a wrong (sorry) argument is not even
> in 'next' yet, let's pretend that it never happened.  It is OK to
> still keep it and this patch as two separate steps, i.e. a topic
> with two patches in it.
>
> That means that this patch will become 2/2 of a series, and 1/2 is
> rerolled to use submodule_prefix from the get-go, without ever
> introducing output_path_prefix variable, so that many of the above
> lines we won't have to review in 2/2.

Ah ok.  Would you like me to resend the first patch with the desired
change then?

>
>> +     /*
>> +      * Pass in the original pathspec args.  The submodule will be
>> +      * responsible for prepending the 'submodule_prefix' prior to comparing
>> +      * against the pathspec for matches.
>> +      */
>
> Good.
>
>> +     argv_array_push(&cp.args, "--");
>> +     for (i = 0; i < pathspec.nr; ++i)
>> +             argv_array_push(&cp.args, pathspec.items[i].original);
>> +
>
> Please prefer post-increment i++ over pre-increment ++i when writing
> a for(;;) loop, unless there is a strong reason not to (familiarlity
> in C++ is not a good reason).

I had a compiler instructor drill into my head that ++i in a for loop
was faster historically
since it wouldn't have to create a temporary value.  Of course now a days there
probably isn't much (or any) difference between the two.  If post-fix
operators are the
norm in git code then I can try to remember to use them :)

>> +
>> +     if (item->flags & PATHSPEC_ONESTAR) {
>> +             return WM_MATCH;
>> +     } else if (item->magic & PATHSPEC_GLOB) {
>> +             return wildmatch(pattern, string,
>> +                              WM_PATHNAME |
>> +                              (item->magic & PATHSPEC_ICASE ?
>> +                               WM_CASEFOLD : 0),
>> +                              NULL);
>
> Isn't this last one overly tight?  I am wondering about a scenario
> where you have a submodule at "sub/" in the superproject, and "sub/"
> has a "file" at the top of its working tree.  And you do:
>
>         git ls-files --recurse-submodules ':(glob)??b/fi?e'
>
> at the top of the superproject.  The "pattern" would be '??b/fi?e"
> while string would be 'sub', and wildmatch() would not like it, but
> there is no way for this caller to append anything to 'sub' before
> making this call, as it hasn't looked into what paths appear in the
> submodule repository (and it should not want to).  And I think we
> would want it to recurse to find sub/file.  IOW, this looks like a
> false negative we must avoid in this function.  As we cannot afford
> to check if anything that matches 'fi?e' is in the index file of the
> submodule repository, we shouldn't try to match 'fi?e' portion of
> the given pathspec pattern.

good point.  Let me think about this some more.
