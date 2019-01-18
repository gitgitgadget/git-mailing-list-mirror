Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556C11F453
	for <e@80x24.org>; Fri, 18 Jan 2019 13:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfARNK1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 08:10:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46968 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfARNK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 08:10:27 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so10589861ios.13
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O25W8K8ZMybjZSBxq3hHsSP84+aERM9An4J7BP8J1mQ=;
        b=ofOzg8O/U2YdLJxBAhrCE7wAl/VtuO1pvCi5fhSNXv8NYWdfFvITd18j6ww/wnXFEb
         Yti7a75TvRW+d8b6ve9cNGVryn6o5z/8djYa3GHGlkVHKoeqhU6hKEzTEuQ6/v1GQAJS
         N7lx+CXKq7a4FKKF1U73gmgQ2DIOQZlZ9v/+uAUeVuZE0Wx1NYdAbuu/wEAAz9liPebG
         6rVufe97dNFZmjoPyGKyMC3I4rjG1AxAnG00PS5JBo823fSYdpQSqLXzW+UOs4zbGBnb
         oX9/WTi7ueiUwUjaLBO/yNLV8CkNZBb2PeGMZnWxf9xfeoOZj+hC3CD4EnfGRKqlwM3Q
         1NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O25W8K8ZMybjZSBxq3hHsSP84+aERM9An4J7BP8J1mQ=;
        b=AVEDebAvTOP2CVAs6hkUiToXWuXgvwYVffm2/FvyMNW3b+pZZwYSc4ZXryHdO2WUuw
         ulmwTqxv0QqMQeMQbhArJItmQ46C8G6i+GHlojdVki9KNWz/DdbgjgloZrq0Y6B8l5zD
         g0bY2Jp34VMofWmm5woCrbFiw+3SXvXvsHGEXd5HVW7vB87Daz43P1Qkiewt/vyUCELI
         cGdUNZD6YK4bKNq157y+yQ6PD0Bs9xnZk5kJAjEq7heA8pqKyEO2czyLO5vWpQFme5K/
         gUCBCFt/H0yxtl3Th0ZwCYt9W8DqdK1Ic+iYP23ipoLOClwLVfU9e7pzteEzB3sOLg4V
         grDg==
X-Gm-Message-State: AJcUukfdc+u15/6FiVbrha+IFQnJoIB/TWL7z0PyJ2DgiurvWCi48LmV
        Av7b1sk2Ry2dXM7cJTeeC2yZ0pBzJH+CghszWdA=
X-Google-Smtp-Source: ALg8bN7BGokzR3EDDwUwmEPlH0mVzgai7KcWpLRTcYxLKNOiHU1HUH/OrJu2AHqyfzrIs1RE9jBksrN59p9Ft3k+7Bw=
X-Received: by 2002:a5d:9812:: with SMTP id a18mr7464928iol.236.1547817025813;
 Fri, 18 Jan 2019 05:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20190118022736.36832-1-phogg@novamoon.net> <CACsJy8CRQdzMTZU0Khno+r+kqrzu-iG5J_fKnPfVMWe55azD2g@mail.gmail.com>
 <CAFOcBzmCWBjng_HqFthSrg3eKcEHpQLaa5buKAcm8JHt7EsGdA@mail.gmail.com>
In-Reply-To: <CAFOcBzmCWBjng_HqFthSrg3eKcEHpQLaa5buKAcm8JHt7EsGdA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 18 Jan 2019 20:09:59 +0700
Message-ID: <CACsJy8A-kk9DEPZKWR26ye5tUHjny_18xf69CUevpRLJrs19PA@mail.gmail.com>
Subject: Re: [PATCH] pack-objects.c: Initialize read mutex in cmd_pack_objects
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 8:04 PM Patrick Hogg <phogg@novamoon.net> wrote:
>
> On Fri, Jan 18, 2019 at 4:21 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> On Fri, Jan 18, 2019 at 9:28 AM Patrick Hogg <phogg@novamoon.net> wrote:
>> >
>> > ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
>> > 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
>> > introduced oe_get_size_slow for thread safety in parallel calls to
>> > try_delta(). Unfortunately oe_get_size_slow is also used in serial
>> > code, some of which is called before the first invocation of
>> > ll_find_deltas. As such the read mutex is not guaranteed to be
>> > initialized.
>>
>> This must be the SIZE() macros in type_size_sort(), isn't it? I think
>> we hit the same problem (use of uninitialized mutex) in this same code
>> not long ago. I wonder if there's anyway we can reliably test and
>> catch this.
>
>
> It was actually the SET_SIZE macro in check_object, at least for the repo=
 at my company that hits this issue.  I took a look at the call tree for oe=
_get_size_slow and found that it's used in many places outside of ll_find_d=
eltas, so there are many potential call sites where this could crop up:
>
>  [snip]
>

Ah, yes. I think the only problematic place is from prepare_pack().
The single threaded access after ll_find_deltas() is fine because we
never destroy mutexes.

> (Sorry if this is redundant for those who know the code better)

Actually it's me to say sorry. I apparently did not know the code flow
good enough to prevent this problem in the first place.

>> > Resolve this by splitting off the read mutex initialization from
>> > init_threaded_search. Instead initialize (and clean up) the read
>> > mutex in cmd_pack_objects.
>>
>> Maybe move the mutex to 'struct packing_data' and initialize it in
>> prepare_packing_data(), so we centralize mutex at two locations:
>> generic ones go there, command-specific mutexes stay here in
>> init_threaded_search(). We could also move oe_get_size_slow() back to
>> pack-objects.c (the one outside builtin/).
>
>
> I was already thinking that generic mutexes should be separated from comm=
and specific ones (that's why I introduced init_read_mutex and cleanup_read=
_mutex, but that may well not be the right exposure.)  I'll try my hand at =
this tonight (just moving the mutex to struct packing_data and initializing=
 it in prepare_packing_data, I'll leave large code moves to the experts) an=
d see how it turns out.

Yes, leave the code move for now. Bug fixes stay small and simple (and
get merged faster)
--=20
Duy
