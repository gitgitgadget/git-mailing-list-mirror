Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4593A1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 03:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeBXDpC (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 22:45:02 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:44309 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeBXDpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 22:45:02 -0500
Received: by mail-ot0-f170.google.com with SMTP id 79so9021737oth.11
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 19:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=n3KFcD3DC9v6ZdmEgwKoP6OEWuP0KaPft99vtRB+hp4=;
        b=qo/ISGLdnsF3K30lUF0dk6bzTlBTHZrvgWKAR8AUabLmUNIpBFjWOFE69UzGQqRck6
         TC54I9VgY2oP0kxBx6T5vS3deIsCNrOrDEqMLjJt2rKZZduKZzrHC8+XI12aAt9gGN+x
         4vjSo0DhYHDRBVI4qJ+vJj7hhRP6hHrVNLaa1zQEgvDgqM0IxN4S8VTCIAnD45Uck0vo
         4C9JvZ+UUsbKQ34Md7yK44U8za5PLRbjRQ5e5GodXw7uwQsiLfXOqPYDDCCiabjRwPmm
         fDPfeWFVQV3xPGpL2wUCta/siJdvW8wLSJY1+EHnPUAFMNcj1oeLwKjNaE0o5aVjmXhS
         igcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=n3KFcD3DC9v6ZdmEgwKoP6OEWuP0KaPft99vtRB+hp4=;
        b=BIn9Qia38Z7WWx1irIjMgg2KVMrqMOhApaabDzU9F5PG0OaRugfr3h+lglhUG/QBWy
         1KLYXzVtuwTOFiZ4RtYbrf0J7kqnd7nQ1B852NB870ip++LRdXhtVrtqu914054KM5BG
         7Bn2jTZjVnSshWHznCChqtfkrF0Dr0smHB+ohLUllDH3ZpEjgZ3XB4a6EWrO/r0cQLpT
         dOzs7PqzJunLt/BsefG1xCrHBZkL3afdaZy0Bvvqtft/zxXhUOY9SAQM+Zm4bOZQzm3m
         XuGOo59hpxVW2KkBEXUDEVt4rANv1d5C8rMYfa0IHXDL0Ye4/vWenZPx1pRYGocWcIwL
         H2lQ==
X-Gm-Message-State: APf1xPAUwWRk8QwFdrNFl0vgf0B/BllAvqeEqchoQhGHfMndKYxFroDx
        wnTYmPLzEv0n6tazSfdJ9R85dyoSaNNXjkxoxX0=
X-Google-Smtp-Source: AG47ELvSnKxgJeeBa5wnlXjZaQO5Cs+XWzLOaX3pNAqfMn12w060ni/yYONt+n7zG8hVaBa6NGbXKavMw1BP/zTGCM0=
X-Received: by 10.157.85.214 with SMTP id z22mr2749797oti.75.1519443901369;
 Fri, 23 Feb 2018 19:45:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 19:44:30 -0800 (PST)
In-Reply-To: <20180223222950.GK6619@genre.crustytoothpaste.net>
References: <20180214180814.GA139458@google.com> <20180223095640.25876-1-pclouds@gmail.com>
 <20180223095640.25876-3-pclouds@gmail.com> <20180223222950.GK6619@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Feb 2018 10:44:30 +0700
Message-ID: <CACsJy8AUvAv61wM5hnvhyCaOd_oKmMbhAyDGJ9pmkiSu_WveZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 5:29 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>> @@ -40,5 +41,8 @@ int main(int argc, const char **argv)
>>
>>       restore_sigpipe_to_default();
>>
>> +     if (getenv("GIT_HASH_FIXUP"))
>> +             repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
>
> I'm lukewarm on adding this environment variable, but considering our
> history here, we had probably better.  We can always remove it after a
> few releases.

Yes that's the intention. But after writing cover letter for v2 and
sending it out, it looks to me that this thing must stay until all our
code is converted to using the_hash_algo (I don't know if there are
more to convert or it's finished already). So an alternative is we do
the opposite: default to GIT_HASH_SHA1, but when an env variable is
set, reset it back to NULL. This env variable will _always_ be set by
the test suite to help us catch problems.
-- 
Duy
