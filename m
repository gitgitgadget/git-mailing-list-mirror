Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08AF61F406
	for <e@80x24.org>; Fri, 11 May 2018 03:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeEKDJO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 23:09:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53984 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEKDJN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 23:09:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id a67-v6so492428wmf.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=foA7hgiIAnxvrFQQ+Hsqu2Tswxlhq4ukt1bFPAptI6c=;
        b=PTQgwnskMwXqT1Y6JNvt8NSZLh1VKU3/v1ykggjO5qfUT/24BAyP+zrke8VZjOREkm
         aQBq5+mt3T1m0CU9TqrlPs6KYQeLIKqtx8PG9pFvabbO3AqbPBpWXQfk/a2uAhz+fwNG
         VHYtAGejt4osKsIlFsHwwDt+AfQCAsNwkFePRuYtzyqSt7dpi9PXsBcegdXCA+C0o049
         WdH0gARk14EAubg7f17e6v4iTczSmPlvB2lMxhoqgRW129DdaryOsb6zd/lUqmTQ4MVv
         8ohZGKqi3s3BrdLr8b/d0/Mp6+n7foSFvOKC8lwCIXnYwLTrpR4nH5yJ2xnhvb93IerJ
         Pwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=foA7hgiIAnxvrFQQ+Hsqu2Tswxlhq4ukt1bFPAptI6c=;
        b=CzHY9BEAiBwVJt3wmLte/idtJhPnpIE3leATDq8/9hrppKFXq0TkQ5wHI1590euGGo
         ynstV5MZYPIqQN3j2oR+2USA1YASZuEiDzd3EhmiFlUGDoZuWd5Gskx4twsY/kHvz3NJ
         pPQ2WWMg+TuQ5B78qeijhNAsVMRMDubWz0P6YXgAca9rFm9yKN/0jBFNDG3cc0BfZ3KJ
         R8V787bAJ+kgFjV+cBnXYlGV6U/9V1ZW3BPR5Wdcc7ZAo4cxGPYFL8V6xemcRuxxhZaI
         vGdrv9cqmeGDfPH+IfoIEPGZuH2dBu+z6XmuiebhQGmcczOcaCCiTnmfeCbTX3CQwypv
         ivqg==
X-Gm-Message-State: ALKqPwdn0KrhSLenHIzuwLrAK77I1ejVvxRwOla0Sp3obP5WtCsQImjM
        yCKyydDR5tULD+iGybp+pWg=
X-Google-Smtp-Source: AB8JxZoiO+4Tn/FOesJIu9CekW2j1RzM7HmA2H6hFlbddtHHtyk4te6R1gOEOdd0iBlsYfBqkPzaWA==
X-Received: by 2002:a1c:7c05:: with SMTP id x5-v6mr656368wmc.7.1526008152680;
        Thu, 10 May 2018 20:09:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 69-v6sm792150wmi.29.2018.05.10.20.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 20:09:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 2/6] sha1-array.h: align function arguments
References: <20180501184016.15061-10-avarab@gmail.com>
        <20180510124303.6020-3-avarab@gmail.com>
        <20180510150615.GA6462@sigill.intra.peff.net>
        <xmqqvabuhouc.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 11 May 2018 12:09:11 +0900
In-Reply-To: <xmqqvabuhouc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 11 May 2018 12:07:39 +0900")
Message-ID: <xmqqr2mihors.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, May 10, 2018 at 12:42:59PM +0000, Ævar Arnfjörð Bjarmason wrote:
>>
>>> The arguments weren't lined up with the opening parenthesis. Fixes up
>>> code added in aae0caf19e ("sha1-array.h: align function arguments",
>>> 2018-04-30).
> ...
> But then "fixes up code added in" is not quite right, either.  It is
> what the commit should have touched but didn't ;-)

FWIW, I ended up with this description.

    The arguments weren't lined up with the opening parenthesis, after
    910650d2 ("Rename sha1_array to oid_array", 2017-03-31) renamed the
    function.
    
