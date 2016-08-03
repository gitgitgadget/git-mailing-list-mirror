Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D0A1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbcHCUVv (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:21:51 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34319 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795AbcHCUVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:21:50 -0400
Received: by mail-yw0-f181.google.com with SMTP id z8so238475049ywa.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:21:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5TYEe4+y67FAgzVit4IG82W3mYmUoPnLrjDdf8AyWvg=;
        b=TNeFfyY+087ERCcJw4HwT1uti991i9j1DXVK7tZA499wvhHdr1M71cDUuQtFf+gGvA
         fl6+M0NcP3XC0jgAwpxdHLI+5Spg/MwwoRfZIVQZTKSOMvZEWO9xxxOOhef0nKckJAGY
         e282aikQK2UgN5qlzBmkyaojwpzjsRvC5KgY5ZOwM5FsCfTXPKjNr07b//jQ1GbwMQoZ
         FwMKQ/9j0Yokf7h4a2gLZfWGdqpgpZw7b6QWgF3Ld9p3FH0eT17mIbHdj91/9IQszx1L
         Ii9LVa4E0wW1Ej5hNlUeS4YDOnlF4xAWywK9GQYszvnGadThRv9J2B4Ulb2jEhjiZay1
         jT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5TYEe4+y67FAgzVit4IG82W3mYmUoPnLrjDdf8AyWvg=;
        b=IRf2adqxq11fAdmxK/FNj5Hl/yR7tDVJF8MnOM4kJJeDVdTPc3H9ojLTzT2uAX+Qkw
         gyeO708tr8puJx9s6nEFvALYhGeggNTRy/Wz2MdCi55LA/OImZt1W6weS47rkcaEwV1h
         sc2sGYydkxiKSfBLkg39FOyQGQ1RHib4ubibh26vcBhp2DT4VoFawSo3RIaTY0xttBLr
         o8h12M92XFSsRfFbWKBP5/p3+xcRHhITPifeIgMri/cU0zNXXfUa7KAX8USuXs0d9Ep2
         PVUCVkn6wod4b9DOPUtFDFi1VA9G+KUNyUWNPnYicV40D9GBfrdWAGnJEi7aHLeEPA1w
         50hg==
X-Gm-Message-State: AEkoouskxAKjlNTt7alJfGIRlmEKuuNi7VrcBpQ0U+sDG1F7OCYJ96dvUEhAyB/vRRX2OGkdllXVUsI0hciEig==
X-Received: by 10.129.154.76 with SMTP id r73mr56621629ywg.164.1470255709279;
 Wed, 03 Aug 2016 13:21:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:21:48 -0700 (PDT)
In-Reply-To: <xmqq37mnf4vk.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423cd0-ae286008-08b7-4ca4-9b2b-f4226aa80a97-000000@eu-west-1.amazonses.com>
 <xmqq37mnf4vk.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 01:51:48 +0530
Message-ID: <CAFZEwPNFz60GrX9ZqaFAvCU4HoNg8rmuqa0t5+DXFjaEHTmDeg@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 03/13] bisect--helper: `write_terms` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Tue, Aug 2, 2016 at 11:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int write_terms(const char *bad, const char *good)
>> +{
>> +     FILE *fp;
>> +     int res;
>> +
>> +     if (!strcmp(bad, good))
>> +             return error(_("please use two different terms"));
>> +
>> +     if (check_term_format(bad, "bad") || check_term_format(good, "good"))
>> +             return -1;
>> +
>> +     fp = fopen(git_path_bisect_terms(), "w");
>> +     if (!fp)
>> +             return error_errno(_("could not open the file BISECT_TERMS"));
>> +
>> +     res = fprintf(fp, "%s\n%s\n", bad, good);
>> +     res |= fclose(fp);
>> +     return (res < 0) ? -1 : 0;
>> +}
>
> If fprintf(3) were a function that returns 0 on success and negative
> on error (like fclose(3) is), the pattern to cascade the error
> return with "res |= another_call()" is appropriate, but the made me
> hiccup a bit while reading it.  It is not wrong per-se and it would
> certainly be making it worse if we did something silly like
>
>         res = fprintf(...) < 0 ? -1 : 0;
>         res |= fclose(fp);
>
> so I guess what you have is the most succinct way to do this.

I agree with your point and your suggested code is better!

Regards,
Pranit Bauva
