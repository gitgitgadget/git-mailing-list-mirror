Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD94D1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 20:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeAaULA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 15:11:00 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43025 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeAaUK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 15:10:59 -0500
Received: by mail-qt0-f196.google.com with SMTP id s3so23468342qtb.10
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 12:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xcLrwK+CqIUxGmgQMRrxAnxVvFpH1CWvxP4K9ukowe4=;
        b=dicnGdzaOZAQVQHARZJkKNs31r5d2LoI/9lpS1J3ZjrS/A8ZTNznRUwQcU9oNbGjml
         7b82iVNJqpw04c1RC0cGSS8eQdYET21uon0YBbTBCG1n6y8pphENoPGxQ6cyuSCs837u
         6krh/xuPW2ti8ApmCo/qiNwLVxwibsq1uNEm8ddAhDPJsIkLRJyCDxscSluZcOZv/h7i
         M+cfNGCoLqdC6Z6pgxNVXrOWx8HENd3C2uetNBIuFIExWdrVqR8STyUOtcUz40CLgzdP
         Sy94X+lloDfiVUL8Z3q6WwsH+0F2BADaYkSIdqPy7k+CvIwnrDHIeASZBhx82f6teT/n
         W/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xcLrwK+CqIUxGmgQMRrxAnxVvFpH1CWvxP4K9ukowe4=;
        b=d5wxSPEd2poza/U2xaIscpgsse0YphgGzPBtWR4uI2qvROrlVExwSZVGSLmrGiSAfY
         l33Av8/re/d4Jw5u0NCL4HWj8PFraNvmz6j2/pKR5z9n5EabGtv46UU6L+oHIWYTdC6I
         Fm5OFUBC5C+libzFvR7MrbXIGlVIHw/NpwplJ4ZF4xW309wC7ILG501BUDXG9QzQTf5C
         m/V4fQiPAh/RVtyGrvSLPXUZHPH0Sr5o8gUC60xPWAepza0JDJjDiTg+qiUKHGcPXtNT
         +L9AlfmgVgCbDUv23b2js3HbaEZAs4ONFGE1p5BfUIK7e9JPzRwFe4oKWqtngx566Ay0
         +fGQ==
X-Gm-Message-State: AKwxyte3AjUJDsDuh43ttA2lPd1c1VlGIwaMc2DSRigJ9b+SPQNGJ4Cz
        NKwecuSTK9yS2Wn9e1hIANHBmjqNlN6pL8S+ydI=
X-Google-Smtp-Source: AH8x224Hlbgh+prPlVINjnNmQ/fLVGO6gSCpX5Qz+T23SLdFTuqaayZenLY9C1XPl91uQphUE9meJ0Rs6+khe7cbWXU=
X-Received: by 10.237.37.112 with SMTP id w45mr50715105qtc.242.1517429458436;
 Wed, 31 Jan 2018 12:10:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 31 Jan 2018 12:10:57 -0800 (PST)
In-Reply-To: <2007efc8-ec31-0267-9b83-392a9d2eaf4a@gmail.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-15-bmwill@google.com> <2007efc8-ec31-0267-9b83-392a9d2eaf4a@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 31 Jan 2018 15:10:57 -0500
X-Google-Sender-Auth: awmKSC3QO3J1oc5lBjZ_reB7g-U
Message-ID: <CAPig+cQvPdMtAWijJaez17m4_fdG6ho_EJW9t=KmnTpocquwgg@mail.gmail.com>
Subject: Re: [PATCH v2 14/27] connect: request remote refs using v2
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 10:22 AM, Derrick Stolee <stolee@gmail.com> wrote:
> On 1/25/2018 6:58 PM, Brandon Williams wrote:
>>  +static int process_ref_v2(const char *line, struct ref ***list)
>> +{
>> +       int ret = 1;
>> +       int i = 0;
>
> nit: you set 'i' here, but first use it in a for loop with blank
> initializer. Perhaps keep the first assignment closer to the first use?

Hmm, I see 'i' being incremented a couple times before the loop...

>> +       if (string_list_split(&line_sections, line, ' ', -1) < 2) {
>> +               ret = 0;
>> +               goto out;
>> +       }
>> +
>> +       if (get_oid_hex(line_sections.items[i++].string, &old_oid)) {

here...

>> +               ret = 0;
>> +               goto out;
>> +       }
>> +
>> +       ref = alloc_ref(line_sections.items[i++].string);

and here...

>> +
>> +       oidcpy(&ref->old_oid, &old_oid);
>> +       **list = ref;
>> +       *list = &ref->next;
>> +
>> +       for (; i < line_sections.nr; i++) {

then it is used in the loop.

>> +               const char *arg = line_sections.items[i].string;
>> +               if (skip_prefix(arg, "symref-target:", &arg))
>> +                       ref->symref = xstrdup(arg);
