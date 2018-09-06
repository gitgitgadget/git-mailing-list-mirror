Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08A01F404
	for <e@80x24.org>; Thu,  6 Sep 2018 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeIFV5A (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 17:57:00 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38835 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeIFV5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 17:57:00 -0400
Received: by mail-wm0-f41.google.com with SMTP id t25-v6so12036851wmi.3
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2YS6apWE1dcWAdhMwKvn3BQd3J8cnRfkLzwgEke0tsc=;
        b=ms2V4Iu5fqgqWInaeX5DHdAEG1NSX3Cfr6YLhGyrN5+FXyUZKCR6n4XZ0Y43UdyqSM
         uwEvyztAuMFCsEzAReazj9jLhvlAaAcKKDjzCFMq0h66Cw3Q23gkTr48JZenKxFfRZHK
         u87Repz0ZkjKBj2BirDYZrIZUvV7ShdGMMOez0Mmtk/dBKmWoSlFyDhAqjtt0dvAqSmW
         tgWWmCHrmwK/ffW0ydV48aQNCfEYLAyh2aTrsYML3lLs+2GHkwkEx2R5BkBIQIHZadtU
         I+gAopQFA5Gx+ZSVpNaXpUIfRDo391USCH1EgosxfmspJgaY4dCAs9za9AiuA+lusMxW
         /mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2YS6apWE1dcWAdhMwKvn3BQd3J8cnRfkLzwgEke0tsc=;
        b=SBMX39x1/As0I3KxABWyCqfaeDpkhiUj3ke9qzAvMFboSZC5ngSM+bxI5As2AVKGE6
         tbyEo92sUHV5JNXYNa5m8B8SS9oKQPUtSzZK423U5HEHZwaStbQIZl/44Q9KAXKXROeI
         o9cM6/4Yf9fV7lPvHX/H8d1XBnVswwkwwtiYQ1r92rfbmhFNqrmj1ou88OS0firDiYoM
         TUIlaREO54XzcS7fR9m2TY02XkDFkTKicFuoZf0KVIf3xid+kKW1WLVXCOhU57K8MQ6F
         Vo/WFls9+WQFNsAP/gQ189MAQkIEWT+7tDJkwQ/mMNi+mY5wqZQQ+ersdKBbFVHyovQw
         /shQ==
X-Gm-Message-State: APzg51DlMbrvE5JLH9vP7/X8kGAHGbEs+1sOyiY4VfEycIKOxd33FBIu
        MjEtfGKyQmF52b6xgnHuBco=
X-Google-Smtp-Source: ANB0Vda6nUL+Hl8KYfKvY3+TGzUiwJj+yXfGtbFk0Ey2U+Z+JooYxvsDp5b15+Nasz24u6ZHlsJQWg==
X-Received: by 2002:a1c:f0a:: with SMTP id 10-v6mr2975635wmp.58.1536254431233;
        Thu, 06 Sep 2018 10:20:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t131-v6sm7894129wmg.10.2018.09.06.10.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 10:20:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/11] sha1-array: provide oid_array_filter
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-4-sbeller@google.com>
Date:   Thu, 06 Sep 2018 10:20:30 -0700
In-Reply-To: <20180904230149.180332-4-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Sep 2018 16:01:41 -0700")
Message-ID: <xmqqsh2m1r1d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +/* Call fn for each oid, and retain it if fn returns 0, remove it otherwise */
> +int oid_array_filter(struct oid_array *array,
> +		     for_each_oid_fn fn,
> +		     void *cbdata);

Comparing this with object_array_filter(), which I think this was
modeled after, I notice that this is much harder to remember how to
use it correctly.

    void object_array_filter(struct object_array *array,
                             object_array_each_func_t want, void *cb_data)

It is clear to a potential user of this function who needs to
implement the callback function what the function should return,
because it calls it "want" (as opposed to "fn").  The function must
answer "I want to keep this?  Yes/no?".

Also polarity of oid_array_filter()'s callback is different.  It
retains elements for which "fn" returns false.

So one step of improvement may be to rename "fn" to "reject", but as
we do not have any caller of this new function yet, perhaps match
the polarity and call it "want"?

I think "x_filter" is perhaps trying to match other language's
filter(), e.g. Python's

	>>> filter(lambda x: x % 2 == 0, range(0,10))
	[0, 2, 4, 6, 8]

so "say yes if you want to keep it" may be more familiar than "say
yes if you want to filter it out".

