Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FAB6208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbdHOSo1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:44:27 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33442 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbdHOSoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:44:25 -0400
Received: by mail-pg0-f46.google.com with SMTP id u5so10719951pgn.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M7QI2Jj6JAKC5IOszgnJ+fHJmajppHka1oivLZKBFZw=;
        b=FBcQn2ID0JpMTBUZrPQqKgoVdcmK3faPCM/49JPpI3dJ2PfaPrDKoofEyreSZ8ldql
         cOH9qYmPTem5fEuEEane+49obcxZvLRcoC7uTKTsji/aPxnU9S3+3awVnznOEnPnfFCh
         xWf6P+28I9C0RCIh+9yCTE3b1uoMKbudohAd9KO5KrjziZ9+jzMJbwKDzBD1IBg7j8mE
         GtMkQY8f1ETgrGPEB4eki44sedUS4I29Gqcl03fgA6M7EnBYicQf5LczEvXewNKyaotG
         7Yo0vnhKwrBi/nwCx7UNNlSGzsBihA03MuyH6e/lHcqxvmNyeZofc1E2nKA8xIPfNhVN
         fVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M7QI2Jj6JAKC5IOszgnJ+fHJmajppHka1oivLZKBFZw=;
        b=soRWDfn0NEz0oCh5WC/+ohKEV2Y8fa9QsT703SnSlHpEgBnWE0S1Utk1kwdRY7YN6U
         Eif/k3/wsAAMmt1/qlsOYPKzPmwe5LDVwAfPjBYzPajfHAgKTSuknkFdTk7EjXpaaG3C
         Y97qooMylZgX+s4e6wbuJieG9D9EzCUB1qYuMXKQL/7dzJixmMBXgT9TDkrlEmQYwl1u
         DR4l4MKMhtK+eCluDw/YvZE63HPMsMKTdThC3QJRKjZBVWGjBDGtFoiGtPujFI4eR3AE
         uAbjivb44q9x3lqX8pN8PnvYA3syJhPWK/oeJPVk9dtGdgmHXen6tTH4AcFmnDXPlCKq
         4KRA==
X-Gm-Message-State: AHYfb5gBC4pXeo9uu9iE4XaI7JbyqzVLNaJXUjnWMCUjkoJaFRecJ1mz
        67qcUPPanTZ1EGVEAyfNhTlgS2IRKpoY
X-Received: by 10.84.133.45 with SMTP id 42mr32692200plf.389.1502822665427;
 Tue, 15 Aug 2017 11:44:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 15 Aug 2017 11:44:24 -0700 (PDT)
In-Reply-To: <CAGZ79kYbPvmqV1PR_NjxLbp2vqC6=JdP+-hzdwQvUmVLZU_Wtg@mail.gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <939b37f809dd9e1526593c02154fae14b369c73a.1502780344.git.martin.agren@gmail.com>
 <CAGZ79kYbPvmqV1PR_NjxLbp2vqC6=JdP+-hzdwQvUmVLZU_Wtg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 15 Aug 2017 20:44:24 +0200
Message-ID: <CAN0heSpPihOcXgP-iCkBFvvP2x-8=oxYGUFJbUhF8mwcYfgoxA@mail.gmail.com>
Subject: Re: tsan: t5400: set_try_to_free_routine
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 August 2017 at 19:35, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 15, 2017 at 5:53 AM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> Using SANITIZE=3Dthread made t5400-send-pack.sh hit the potential race
>> below.
>>
>> This is set_try_to_free_routine in wrapper.c. The race relates to the
>> reading of the "old" value. The caller doesn't care about the "old"
>> value, so this should be harmless right now. But it seems that using
>> this mechanism from multiple threads and restoring the earlier value
>> will probably not work out every time. (Not necessarily because of the
>> race in set_try_to_free_routine, but, e.g., because callers might not
>> restore the function pointer in the reverse order of how they
>> originally set it.)
>>
>> Properly "fixing" this for thread-safety would probably require some
>> redesigning, which at the time might not be warranted. I'm just posting
>> this for completeness.
>
> Maybe related read (also error handling in threads):
> https://public-inbox.org/git/20170619220036.22656-1-avarab@gmail.com/

Thanks for the pointer. Threading is tricky business, indeed. I still
haven't entirely groked all the users of set_try_to_free_routine, i.e.,
what they want to avoid and what they want to achieve. I'm just happy
that the only user which cares about the old value is not threaded, to
the best of my understanding.
