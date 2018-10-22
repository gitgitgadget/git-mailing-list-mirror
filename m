Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EFB11F453
	for <e@80x24.org>; Mon, 22 Oct 2018 05:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJVNVk (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 09:21:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40115 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeJVNVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 09:21:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so8871239wmc.5
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 22:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gRKPtSr3R+MQEzGqFt7IMgxM+tkNHkxs+u3ie7Hx4Tc=;
        b=M9YYn8F5SMkibS5JIBchMaRIoB4GnJBOo1ubblcLZ9OF4om4EOhwOknfiPO1rDMHIP
         X52DIAJIAggkmKqRSWM7H/npjDazbumw5mewepgY94kZcuFWEDeJNqv+Q41Gd6D/res2
         Yniw/lu15n7SgOArNDiP1eMu5GYmz20ocQF+URYkYheedkOtvUU+PEG6YPlgVfsvP79U
         wOJaP5mGJNaUlOrsDc+Ajxdb/xejo1x328JyKhebUaCQtbgcQ6UoJ8ncIq8/Nyj2mQqo
         3NUgjQDCU5ecE4U/p1cjrLhzLT+faDnzgNFXbCzQKMfYlDsGXZM91ciuJKmMl+zhHKAz
         r+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gRKPtSr3R+MQEzGqFt7IMgxM+tkNHkxs+u3ie7Hx4Tc=;
        b=WDS9wiAJMRsCZ4S2LUI3NvL71qQMTUOehvxG0LTJyOkinHdeKWastFLW0mL9Msgv8g
         Z9Nx+UItgGPHCe+eXIC5AyMmRHME8pICWoL/aQJl+i5ecfycgnJRjT0Kmh7EM6U6MdVt
         r/aSP5jd6ZAb1XKgyyBVP/lHgPbRqXZz709OWxSbz837KOV8TSVyv9MIKlznDts9Z29I
         TSSxWui+20AuYF9zFcGdBmnB8lNOm1Di9tSXMPzydyLDy+x1oR0cM2iOm9XcInT53he8
         9qov85pZkJyEb0hbeGw86nwY4RXQ7lRszb8amUMNuvm14z1GZWzSzKspMZ9bYWGAabrX
         NvQw==
X-Gm-Message-State: ABuFfogfGjsD71XQpdxuWZsAQl5VBXKe6/rmeOsj2rEwQ/kB7LVpFnI/
        s6t4yBpYAH0UHsMTFvnho8jfi2V/frk=
X-Google-Smtp-Source: ACcGV611HbqxaDb9pCzH2dTsn1bWK6zJhsaFaEr4YEer7sp9/B8WJHRaA54PIXJ7p3GyGIauQnuC1w==
X-Received: by 2002:a1c:9895:: with SMTP id a143-v6mr14058609wme.43.1540184684050;
        Sun, 21 Oct 2018 22:04:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 143-v6sm22917370wmv.6.2018.10.21.22.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 22:04:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v2 2/3] reset: add new reset.quiet config setting
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181019161228.17196-1-peartben@gmail.com>
        <20181019161228.17196-3-peartben@gmail.com>
        <CAPig+cSL9=mmvdq9J9VXF67=010E1eZBjrYYaYQDN1z1OEf0CA@mail.gmail.com>
        <20181019164631.GB24740@sigill.intra.peff.net>
        <CAPig+cR7=OpNsuZu+ppdyDvt5HAHMdDj4cBVg2U34B_j2zZ03g@mail.gmail.com>
        <20181019171130.GA20834@sigill.intra.peff.net>
        <38b9f813-0463-3d15-ad9d-86f64c140043@gmail.com>
Date:   Mon, 22 Oct 2018 14:04:42 +0900
In-Reply-To: <38b9f813-0463-3d15-ad9d-86f64c140043@gmail.com> (Ben Peart's
        message of "Fri, 19 Oct 2018 13:23:06 -0400")
Message-ID: <xmqqa7n6wp05.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 10/19/2018 1:11 PM, Jeff King wrote:
>> On Fri, Oct 19, 2018 at 01:10:34PM -0400, Eric Sunshine wrote:
>>
>>> On Fri, Oct 19, 2018 at 12:46 PM Jeff King <peff@peff.net> wrote:
>>>> On Fri, Oct 19, 2018 at 12:36:44PM -0400, Eric Sunshine wrote:
>>>>> How does the user reverse this for a particular git-reset invocation?
>>>>> There is no --no-quiet or --verbose option.
>>>>>
>>>>> Perhaps you want to use OPT__VERBOSITY() instead of OPT__QUIET() in
>>>>> builtin/reset.c and document that --verbose overrides --quiet and
>>>>> reset.quiet (or something like that).
>>>>
>>>> I think OPT__QUIET() provides --no-quiet, since it's really an
>>>> OPT_COUNTUP() under the hood. Saying "--no-quiet" should reset it back
>>>> to 0.
>>>
>>> Okay. In any case, --no-quiet probably ought to be mentioned alongside
>>> the "reset.quiet" option (and perhaps in git-reset.txt to as a way to
>>> reverse "reset.quiet").
>>
>> Yes, I'd agree with that.
>>
>> -Peff
>>
>
> Makes sense.  I'll update the docs to say:
>
> -q::
> --quiet::
> --no-quiet::
> 	Be quiet, only report errors.
> +
> With --no-quiet report errors and unstaged changes after reset.

Sounds good.  Thanks all.
