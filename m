Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5801F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbcHCUeG (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:34:06 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36447 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbcHCUeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:34:01 -0400
Received: by mail-yw0-f194.google.com with SMTP id u134so17587679ywg.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:34:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LQf0QaRp7c5s0PNwGp23yqQ9YhOoijN1GwQMsKvw+VQ=;
        b=gUJmqD50i+Io8++8yZlea+IE11goZxJ6mKee036yJ/yeqnhhlLcupIcTElp7e4gkjY
         KD5/1Wm/TjN+XdrOEsSYxu33NeeXzD8t4VeAb1UzTAZGvvYevXhAMajTQopFYBZepQ9G
         iV1uF8A9omA37MreZRk112xvlkyAEP9WIPJ6VkVPpFzay2eCRMhAlWF7lY1ZUd0YQ3aD
         odow61QQWXQfqB7/auPshFySAkVK0ln6Hboh1AryGZZtCqXW23uIl9OMMqIDvKP1gWPr
         ud/yzbODZeiEGzzZEq1njQk53oP6T67q3GjGYl1XV6p5vwfoIB9kdrTElDX4RIHMH1U4
         9KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LQf0QaRp7c5s0PNwGp23yqQ9YhOoijN1GwQMsKvw+VQ=;
        b=AnB4PMRYDIRoavp+Pw9yN3lg6d5/L87qygn/UVkC+b1s3Iu+nPv1tXicpWTDY67wBI
         TauuKvb7YrO0LLVrfTYFJqhf9VYCnHZnvnNdT797NoG7krBiQU2KXtJV5vYl0+a0tJc0
         fYmRLUMs36N1jntOBoh/yGsl/t02bTeqAfahpulr6KJ6rWP+XkiFqC36IDk22bjnunDx
         1zkGudIwJVzqiQ+EUxZfofV87FGx0hIqCBoUMSGRt9dH3Q3fNKINcEWtSjVbr/KMLZnn
         u949suD2tJ/+zOsHNXhseNkMEpCvJlWZ8VXyQb+rS3mxr6j4W5/kFq2U829JchIo2MzJ
         8YWw==
X-Gm-Message-State: AEkooutGdRwg580nb2ALNV0pJ4nkQ2/6tjtHwqpiJocvvwnbKgg7B6nkOjv19vCCQ9xeDo4zpyuaSuhMPHUcKw==
X-Received: by 10.13.193.135 with SMTP id c129mr53749131ywd.302.1470256439670;
 Wed, 03 Aug 2016 13:33:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:33:59 -0700 (PDT)
In-Reply-To: <xmqq1t27dlhr.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423d09-87c8e96f-f10f-47dc-b24e-e30ba1de4408-000000@eu-west-1.amazonses.com>
 <xmqq1t27dlhr.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 02:03:59 +0530
Message-ID: <CAFZEwPMK5-WXVNts1r=wxZdDVJTTCf6tauSHdWDjRbijqFJ6pg@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 12/13] bisect--helper: `get_terms` &
 `bisect_terms` shell function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Wed, Aug 3, 2016 at 12:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int bisect_terms(struct bisect_terms *terms, int term_defined)
>> +{
>> +     if (get_terms(terms)) {
>> +             fprintf(stderr, "no terms defined\n");
>> +             return -1;
>> +     }
>> +     if (!term_defined) {
>> +             printf("Your current terms are %s for the old state\nand "
>> +                    "%s for the new state.\n", terms->term_good.buf,
>> +                    terms->term_bad.buf);
>> +             return 0;
>> +     }
>
> In the original, all of the above messages go through gettext; this
> rewrite should do the same.

Sure!

Regards,
Pranit Bauva
