Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B951FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 23:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbcHWXDY (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 19:03:24 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38655 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753615AbcHWXDX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 19:03:23 -0400
Received: by mail-it0-f48.google.com with SMTP id n128so4488727ith.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 16:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qSebuXqwTpOw5MXDSh7SzXtz8BLiwaEju3X3seBLiKc=;
        b=WNy9zsSX6Af0+JySRVYdLcWEOoz0KdU6IFZMWMuVVBHLJC6mD7qEMycRR2wL9laBgC
         bhk0oa8L0TJlHTQnkdEhejZ8Ux2Of9L8qn6MzNYvUd76fjbZNogG1qNmN1DzdB1y4HX0
         X2OA3eoBKb1B/HHZDk+qZMuVFeh5pfyvjv/eQcK77CahgxyuMUYr5pJ3jWUBIqM+SuIg
         Cgg3GdJ2iAdpIqffVHvNKYeOyImbGz74u2LiuGD71cQED9d4zFX+Hwwu4dTEbtqJ24Z0
         DNQBhNUAYl1wz+rrsoZtoHyiW1Pt2Fkdy4H7oqDT0m7bgcB0CUtEPbbKZ3QsI3j6lw9J
         MDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qSebuXqwTpOw5MXDSh7SzXtz8BLiwaEju3X3seBLiKc=;
        b=lp4tOPgIQs0GT5uvjGjGlMF1yKiwBD3vkZqLGEmIy7uoSgJ42peEy3XJ59cQ8YKPYx
         +UrK4hsWh3VW72zv8tJsncoacMLuGtP0YfQsUv73VgcqOTaRAOh1jLP1n1f7p9iHP9SF
         FBO6CU/6PwL88Ea3++YBLU3BootiwiZDUK2Xz/sMfyG7HVSNBbNPh2IF4QeeFJE8amsd
         Dcwq/PQMmPYiuZtNAtYRrGRW7mQljhim4H1KDkYO29Sotp/SjwP9f/suQ0ssN+ewndW1
         LI4uoAl4cOWGSpILA+0TXkN5WJG+APRb/MC84rub6wJB+LhFKIoHzy8tzF5opAHEzyvK
         Vslg==
X-Gm-Message-State: AEkoout6WYQu4j5n9vgB67At33ZNAD5Kic6YkEvCgv7KoPYAGigz4hyt43/Yb5ne6/Gv5hKCFRl63bs14Qsqzk1Y
X-Received: by 10.107.178.129 with SMTP id b123mr505907iof.83.1471993402363;
 Tue, 23 Aug 2016 16:03:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 23 Aug 2016 16:03:21 -0700 (PDT)
In-Reply-To: <CA+P7+xpDqkTFLUJBhSwWiVnXw-iy1fmGBWzVBLmybOcPOmevBw@mail.gmail.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-9-sbeller@google.com>
 <CA+P7+xpDqkTFLUJBhSwWiVnXw-iy1fmGBWzVBLmybOcPOmevBw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Aug 2016 16:03:21 -0700
Message-ID: <CAGZ79ka6nwYjBRcUKAxCqAodq=Hw6f86J0Mq6GWyKgMO_PNi4A@mail.gmail.com>
Subject: Re: [PATCHv5 8/8] clone: recursive and reference option triggers
 submodule alternates
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +
>> +       if (option_recursive) {
>> +               if (option_required_reference.nr &&
>> +                   option_optional_reference.nr)
>> +                       die(_("clone --recursive is not compatible with "
>> +                             "both --reference and --reference-if-able"));
>
> So if you have multiple references that don't all match we basically
> just refuse to allow recursive?
>
> Would it be better to simply assume that we want to die on missing
> references instead of failing the clone here?

The new config options are per repo (or even set globally), and not
per alternate. And as we communicate the [if-able] part via the config
options to the submodules it is not feasible to transport both
kinds of (reference-or-die and reference-but-ignore-misses).

That is why I introduced this check in the first place. If we'd go back
to the drawing board and come up with a solution that is on a
"per alternate" basis we could allow such things.

> That is, treat it so
> that multiple reference and reference-if-able will die, and only info
> if we got only reference-if-able?
>
> Probably what's here is fine, and mixing reference and
> reference-if-able doesn't make much sense.

I think the reference-if-able doesn't make sense for one project alone
as you can easily script around that, but is only useful if you have
submodules in a partially checked out superproject that you want
to reference to.

Thanks,
Stefan
