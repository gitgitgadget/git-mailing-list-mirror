Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,TVD_SUBJ_WIPE_DEBT shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D169B201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbdBTMW2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:22:28 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33102 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbdBTMW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:22:27 -0500
Received: by mail-oi0-f46.google.com with SMTP id 2so12960611oif.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 04:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2GWGLJoEHFn/D4PSvQu3103rN5rSBW+oPu29F3XxMNg=;
        b=UKDBelSsFifGA3NLq05oHKXIO2zWFVaZ9YBssyIlasMSYCQf7pfj6q4OmWlTjwINJT
         t/inK9pdRr9MWdMWq8hn/ZjX8zrMwIGD1LL/5bd8u0Vo6pC/7FiCcWkqbcaIKj3aneqz
         67YkMSuuggke1uIERMbhYNmoEEZL3NH7okRHZURrVYSf6rCYysQtDDskn9+PCUhRmdKq
         20bpJSH5hWdwD9H+NbvLgoquabCxYD2k7IDDnm5/UxxCgwH9P66+tyzXEiphe2LQ8zbS
         I7ZoPkYS+JnzOSBn91RAnZW95yc82rMtChEBgRFICOHiQ55bBsRrb9mIqgnLuXKcBwB2
         Zxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2GWGLJoEHFn/D4PSvQu3103rN5rSBW+oPu29F3XxMNg=;
        b=V75JuyisaCckhso/j4UIBRDjLwMiO776KOyZh6ogMN2hChiAO+/tzubJe9rLGRofF0
         5rn26VHBw99iyY9X32FLuAJYI+YWYDZtJ6K0HV5uP0E4Q6qTwSyr8ILjwXpA8wTqfEYb
         wpDNsLEtKW488E7sZQhcXXXOHewZAnwvr5+RgJjdD30SK9NqyXd8CgT0DOi7NajgbwE+
         wlDVDyeIIt0IhisGsJcRXN5LPPKIRN30J+NZfvLGrBFhojMWfu3Zje8N3l+QR1Al0es4
         tCcK95BAV/TBx0Fg8NVz16RARKiy/tztW4/9QFgDf/1qfNnZljz3wcy1sF6D+vQkWfOS
         E/3g==
X-Gm-Message-State: AMke39l3PradO1yXbyhjXiS6Byt+OVtZfFp2GW/Z1+to7qJ0Vda/2cae0UtXOymU/HNwqBmVl/cXa7QyNLNq5w==
X-Received: by 10.202.78.214 with SMTP id c205mr11224801oib.65.1487593344893;
 Mon, 20 Feb 2017 04:22:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Feb 2017 04:21:54 -0800 (PST)
In-Reply-To: <25fcb527-595a-7865-41e3-ee7c4c1ad668@alum.mit.edu>
References: <20170217140436.17336-1-pclouds@gmail.com> <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-15-pclouds@gmail.com> <25fcb527-595a-7865-41e3-ee7c4c1ad668@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Feb 2017 19:21:54 +0700
Message-ID: <CACsJy8AZ27O-pxTqHOzYXRBuyv8dkxdGJ_5Z0u3eaxkNdnaEYA@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] files-backend: remove submodule_allowed from files_downcast()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 7:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/18/2017 02:33 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Since submodule or not is irrelevant to files-backend after the last
>> patch, remove the parameter from files_downcast() and kill
>> files_assert_main_repository().
>>
>> PS. This implies that all ref operations are allowed for submodules. But
>> we may need to look more closely to see if that's really true...
>
> I think you are jumping the gun here.
>
> Even after your changes, there is still a significant difference between
> the main repository and submodules: we have access to the object
> database for the main repository, but not for submodules.
>
> So, for example, the following don't work for submodules:
>
> * `parse_object()` is used to ensure that references are only pointed at
> valid objects, and that branches are only pointed at commit objects.
>
> * `peel_object()` is used to write the peeled version of references in
> `packed-refs`, and to peel references while they are being iterated
> over. Since this doesn't work, I think you can't write `packed-refs` in
> a submodule.
>
> These limitations, I think, imply that submodule references have to be
> treated as read-only.

Behind the scene submodule does add_submodule_odb(), which basically
makes the submodule's odb an alternate of in-core odb. So odb access
works. I was puzzled how submodules could by pass odb access at the
beginning only to find that out. technical/api-ref-iteration.txt also
mentions that you need to add_submodule_odb(), so I think it's
deliberate (albeit hacky) design.

> When I was working on a patch series similar to yours, I introduced a
> boolean "main_repository" flag in `struct ref_store`, and use that
> member to implement `files_assert_main_repository()`. That way
> `files_ref_store::submodule` can still be removed, which is the more
> important goal from a design standpoint.

I could keep the submodule check back (and replace the submodule
string in files_ref_store with just a flag). But I really think all
backend functions work with submodule. Perhaps add some tests to
exercise/verify that files-backend-on-submodule works?
--=20
Duy
