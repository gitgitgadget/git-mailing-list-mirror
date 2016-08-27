Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5406A1F859
	for <e@80x24.org>; Sat, 27 Aug 2016 09:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbcH0JtD (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 05:49:03 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35799 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbcH0JtC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 05:49:02 -0400
Received: by mail-yw0-f178.google.com with SMTP id j12so61955255ywb.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iRBjZBR63vLPwSv+Lu3Jhlkddy+GEcFkMU2KgYzCtds=;
        b=HlM1xSxdQ/WzEVpaESSuRvNTwKqYVp0oqSJYKg3UXOpU+U+Crpc7x1Nv3c6x22P4Ft
         y8KgQBLtgewVaWQfcjpJ9Ma1GuZL9mhxYbrymsJYN5f1U4hHWA5F28+JkL61QuQFFxqf
         do44g4GpdNSHoCTfwGlbzvWYqlpi/HfLaf3ftuWaIyDPKNC1l1TpYZpxM2X6gjh1jU7G
         UtQEdoOSi06KCpgUN/5wtFpbN0wtfHCGrJzu+v/g2YwoC9hi/i4YyvFsfyVntTUcerL+
         RB8abwicwoyaDiQ0680oT60rD3ADHJeFqiwb70cYHN0OCspKUYaDOORy8A2Bz3cqoC5M
         aF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iRBjZBR63vLPwSv+Lu3Jhlkddy+GEcFkMU2KgYzCtds=;
        b=ZMmtxq1+7Iele8h9SoNreuQ9tUNTdfgE+uK8dWb8MebO4Rj7yS1KrZnfTZ5eR83S1H
         a3YzZssTuwFmVHQYER8qMyYM944wR8Vl3QAsR7DsBAFUf8e1MtJ0CWesSWxE1XZu6zrW
         cx1jifkLm1hXK05nFvGIEf+MQEYIOyGUdnzJL9hIzh2bkyNZazrmiyRSuihyw/ykqJrU
         Zm8SCiyE9sVJvErGOI7jn+h9Z3+ZYrTlk0hBTeQWA8XjpLSweGfwpvuZVI52mIKs3Z3S
         RUm2vUd0bav64y0z2mm1gSCkSmWVG5FZ1A9Wk6NLcSWmI/aSEg1xJ+RYguC0hKgxMeLY
         Prmw==
X-Gm-Message-State: AE9vXwM31hBT8qHhjj6zLsTEFl3AjfT4G9wZXWj0jbeSmo+BdSf4oeGYpnXDJMAYgwzg9p8wmsKgcW6QqaX7eA==
X-Received: by 10.129.76.79 with SMTP id z76mr7023900ywa.33.1472291295289;
 Sat, 27 Aug 2016 02:48:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sat, 27 Aug 2016 02:48:14 -0700 (PDT)
In-Reply-To: <xmqqmvk0n2pl.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6b3-3ccd9de5-604d-4e7d-919d-a3adae869ebf-000000@eu-west-1.amazonses.com>
 <xmqqmvk0n2pl.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 27 Aug 2016 15:18:14 +0530
Message-ID: <CAFZEwPNTkgbFz-tcnLiaW9qvRSUoHgeNMzjnCjx7EwMHG71Niw@mail.gmail.com>
Subject: Re: [PATCH v14 12/27] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Thu, Aug 25, 2016 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>> +{
>> +     int i;
>> +
>> +     if (get_terms(terms)) {
>> +             fprintf(stderr, _("no terms defined\n"));
>> +             return -1;
>> +     }
>> +     if (argc == 0) {
>> +             printf(_("Your current terms are %s for the old state\nand "
>> +                    "%s for the new state.\n"), terms->term_good.buf,
>> +                    terms->term_bad.buf);
>> +             return 0;
>> +     }
>> +
>> +     for (i = 0; i < argc; i++) {
>> +             if (!strcmp(argv[i], "--term-good"))
>> +                     printf("%s\n", terms->term_good.buf);
>> +             else if (!strcmp(argv[i], "--term-bad"))
>> +                     printf("%s\n", terms->term_bad.buf);
>> +             else
>> +                     printf(_("invalid argument %s for 'git bisect "
>> +                               "terms'.\nSupported options are: "
>> +                               "--term-good|--term-old and "
>> +                               "--term-bad|--term-new."), argv[i]);
>> +     }
>
> The original took only one and gave one answer (and errored out when
> the user asked for more), but this one loops.  I can see either way
> is OK and do not think of a good reason to favor one over the other;
> unless there is a strong reason why you need this extended behaviour
> that allows users to ask multiple questions, I'd say we should keep
> the original behaviour.

True! I can just use return error() instead of printf. Also I noticed
that this is printing to stdout while the original printed it to
stderr. Thanks!

Regards,
Pranit Bauva
