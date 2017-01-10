Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70B0820A93
	for <e@80x24.org>; Tue, 10 Jan 2017 18:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdAJS3s (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 13:29:48 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:36833 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765950AbdAJS2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 13:28:44 -0500
Received: by mail-io0-f170.google.com with SMTP id j13so56843773iod.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 10:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9F8DvHIqf+ixiT7n4VSeqlOfKjgQ/cU3t+id3cFAze8=;
        b=uYUEr1G7jGmYEj7t1wQosiLXABAPSzp+Rrap3PGrcMmT0qwfw0nhXe+3nQ39pEFeqM
         gRUDtO0Ud0e/LkAIdL6PwvFS5epDGaPLB3oApVOWmRxBUAEnv5DPD/fdh/pa9hWmxVcf
         gM4F0o3vYLYApHSU8O2Ap5U/8Jy9EZfczgr5W/5Pk8F+o7Lkc0/74V6QgKGg3P2IgbHJ
         0fZ7onM4gyj8l05LzwF0ra2aN/2q+UaXmdwXTOEUyHch6J2VptHqeW8sbPPHkyX1nK7S
         KaLxcJmqXhzWHkc1cFGejyqkiJv3Ho+b9jOLqCspXsK9sBUGrtVFGOhgD4QR3mYWp0fT
         tfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9F8DvHIqf+ixiT7n4VSeqlOfKjgQ/cU3t+id3cFAze8=;
        b=M3jUXeR6Bmg2D3FC6aBSIzPlK1BaNJJUeuaUMrFi+u5M2KdOHHWpUMMgcEV7ZW8iS+
         k0wj4ViBQbmwvhko6iEEGKkoE9aZ+YOSS3BBIV36pczUIUfalROJA0PXxwFKwrkY0+i5
         6XOYEkZVDYGyzm8KR0VKktrrm4gWtTSb34kJ3u/Xm1Fi09+UaIPtkK9Eq0g4HMXuSWda
         ob8BjLwZwEAFsoDPRYGIusi+p/93HsJW4a+Wny8ZuELggYeoKCM933rYRr6M/8irAAoZ
         AQm/m6MKH6UfreAGipAGLjLtOPm0Cz98CVYWIVIZSvn3oWr/7jsSlCUk8is+BMbBFtnO
         wcww==
X-Gm-Message-State: AIkVDXL/dqdLp5TKRU0Yc7Q10Cu/ALW/1giAWSiAXbiRUz1UlZLtzu2qU8pRJnye/y7is2enXHSGvx2cl/+Jo277
X-Received: by 10.107.37.148 with SMTP id l142mr4111378iol.159.1484072923346;
 Tue, 10 Jan 2017 10:28:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 10 Jan 2017 10:28:42 -0800 (PST)
In-Reply-To: <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net> <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jan 2017 10:28:42 -0800
Message-ID: <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Localise error headers
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 1:04 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 09, 2017 at 01:43:15PM +0100, Michael J Gruber wrote:
>
>> > I can't say I'm excited about having matching "_" variants for each
>> > function. Are we sure that they are necessary? I.e., would it be
>> > acceptable to just translate them always?
>>
>> We would still need to mark the strings, e.g.
>>
>> die(N_("oopsie"));
>>
>> and would not be able to opt out of translating in the code (only in the
>> po file, by not providing a translation).
>
> I meant more along the lines of: would it be OK to just always translate
> the prefix, even if the message itself is not translated? I.e.,
>
> diff --git a/usage.c b/usage.c
> index 82ff13163..8e5400f57 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -32,7 +32,7 @@ static NORETURN void usage_builtin(const char *err, va_list params)
>
>  static NORETURN void die_builtin(const char *err, va_list params)
>  {
> -       vreportf("fatal: ", err, params);
> +       vreportf(_("fatal: "), err, params);
>         exit(128);
>  }
>
>> In any case, the question is whether we want to tell the user
>>
>> A: B
>>
>> where A is in English and B is localised, or rather localise both A and
>> B (for A in "error", "fatal", "warning"...).
>>
>> For localising A and B, we'd need this series or something similar. For
>> keeping the mix, we don't need to do anything ;)
>
> What I wrote above would keep the mix, but switch it in the other
> direction.
>
> And then presumably that mix would gradually move to 100% consistency as
> more messages are translated. But the implicit question is: are there
> die() messages that should never be translated? I'm not sure.

I would assume any plumbing command is not localizing?
Because in plumbing land, (easily scriptable) you may find
a grep on the output/stderr for a certain condition?

To find a good example, "git grep die" giving me some food of though:

die_errno(..) should always take a string marked up for translation,
because the errno string is translated?
(-> we'd have to fix up any occurrence of git grep "die_errno(\"")

    apply.c:                die(_("internal error"));

That is funny, too. I think we should substitute that with

    die("BUG: untranslated, but what went wrong instead")


>
> -Peff
