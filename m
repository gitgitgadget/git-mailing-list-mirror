Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6141F453
	for <e@80x24.org>; Fri, 26 Oct 2018 00:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeJZJ1U (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 05:27:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeJZJ1U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 05:27:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id q6-v6so11091612wrw.11
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 17:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b1HgjqONe5SNVlm8jDrpDP48JsEh4tPh9IdqdD+afSY=;
        b=TnkL7choO1/42Jp92rR8Dpp1b6zZUwu0bIWbJuIFFO0sZZxkv2reeHclSyiGFNgQGK
         bEnpJDmtzTOtUtvLUYovv5T6FwJAZPBSc7O0BdJyv9BuOiOZBinyLdZMMMGdVt/ZxZcQ
         QbvqbK/1UT7XBd+oJh4dg/+/MTWYfS73SYhcqh4RhGaWt32KYw4e61rosVJn4leg6/My
         SCsTLvi+tYhHv2IYkoBtDv6SgVBfUozDEY50it9Y5QOkVoiz2nIuprzCs9JbaVIIc0nf
         wQK4LzrJSVh9mKEMAO6OYO7X2JZF+G5NmANyoyjOkfCT3Luoj8FCzX1c7T6RS4a9OBEs
         knxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b1HgjqONe5SNVlm8jDrpDP48JsEh4tPh9IdqdD+afSY=;
        b=kQRhb3D+bfrOCFOo8WUz5D8r5LrAgQpp0qidTxS8RSDX+8Wv1G2U52n2kS23dkvRP8
         HmNEGML4pOwZHRg6KW6RIfyfX11QVB6KJsysqut1+pt6I6FCuXqgIseFICQIoxqAUc08
         dVVaRTgPWq6/+ekdLRNHGndCxjvgjW4URdAJpelHeOI5xBC7Oa9C53vW8Mjqg7qewfNn
         eBdG6PpdNMylbljypbBE8dydSz5py6fe4W1TkpTU1LgI6AmGisfqSyLhHMzHKljNzUeK
         O+07B/XBAi//Y6cKoOVz0pWrWyV7SqH0PRjjz9O89e7x2MmfWTO2uoSgLY7y3ZXVbytC
         cwEw==
X-Gm-Message-State: AGRZ1gLU954MAoKAS/dMNOjRmNrw5tQXAMS4RZzXOSiRzFk5r+NWCJwO
        AFXTujfiPKGKNo/1wVcGhnU=
X-Google-Smtp-Source: AJdET5drtdto3/q8aiamMXbaxGLDpsgdo4N+oYKPY46Jp+yi/9aMSaG8TRhN5juPyy+jZiIiRNKhuQ==
X-Received: by 2002:adf:e2c1:: with SMTP id d1-v6mr3897481wrj.26.1540515146665;
        Thu, 25 Oct 2018 17:52:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r73-v6sm1270682wmb.37.2018.10.25.17.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 17:52:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v5] branch: introduce --show-current display option
References: <20181025190421.15022-1-daniels@umanovskis.se>
        <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>
Date:   Fri, 26 Oct 2018 09:52:24 +0900
In-Reply-To: <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 25 Oct 2018 15:30:23 -0400")
Message-ID: <xmqqefcdfs1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       test_when_finished "git tag -d branch-and-tag-name" &&
>> +       git tag branch-and-tag-name &&
>
> If git-tag crashes before actually creating the new tag, then "git tag
> -d", passed to test_when_finished(), will error out too, which is
> probably undesirable since "cleanup code" isn't expected to error out.

Ah, I somehow thought that clean-up actions set up via when_finished
are allowed to fail without affecting the outcome, but apparently I
was mistaken.

This however can be argued both ways---if you create a tag first and
try to set up the clean-up action, during which you may get in
trouble and end up leaving the tag behind.  So rather than swapping
the two lines, explicitly preparing for the case the clean-up action
fails, i.e. the first alternative below, would be a good fix.

Also it is a good question if the tag need to be even cleaned up.

> You could fix it this way:
>
>     test_when_finished "git tag -d branch-and-tag-name || :" &&
>     git tag branch-and-tag-name &&
>
> or, even better, just swap the two lines:
>
>     git tag branch-and-tag-name &&
>     test_when_finished "git tag -d branch-and-tag-name" &&

> However, do you even need to clean up the tag? Are there tests
> following this one which expect a certain set of tags and fail if this
> new one is present? If not, a simpler approach might be just to leave
> the tag alone (and the branch too if that doesn't need to be cleaned
> up).
>
>> +       git branch --show-current >actual &&
>> +       test_cmp expect actual
>> +'

A bigger question we may want to ask ourselves is if we want to
detect failures from these clean-up actions in the first place.
There are many hits from "git grep 'when_finished .*|| :' t/", which
may be a sign that the when_finished mechanism was misdesigned and
we should simply ignore the exit status from the clean-up actions
instead.

I haven't gone through the list of when_finished clean-up actions
that do not end with "|| :"; I suspect some of them are simply being
sloppy and would want to have "|| :", but what I want to find out
out of such an audit is if there is a legitimate case where it helps
to catch failures in the clean-up actions.  If there is none, then
...
