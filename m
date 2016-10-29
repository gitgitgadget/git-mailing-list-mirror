Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794C72022A
	for <e@80x24.org>; Sat, 29 Oct 2016 22:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbcJ2WY5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 18:24:57 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35195 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbcJ2WY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 18:24:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id p100so518587lfg.2
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wXyln5L0tr14vACvKNs8+S4VxfHEIo5Q9Y65ld6P+28=;
        b=OedcGWtTSM1RkX0VAu6Eg+qjgeuThcqO4IACy5ouP+82Bkh5XiFMcjWYnJY+hKQ4b2
         RFMxbC+Kb5dDIJareV7o0EKEb6ZpRS65sD+k1hmLIbRbvDsaUy9Al0sMCGigtTnQwnnA
         UeGPicwAlwgYg9ds0R12LYIz7ou6PIeVFzuiB0v3nxVwMKNB3NknOq17fnrfZWu/cyCx
         8rWu3zj0TkMrf+aQWBcG0zvpVM5GlNnZGZkhtCrTA4oM0V1aEszvKUpgFVtyXB5u+lIT
         0hsnhKRR/jAJRn36tLpV1LsOV6XW6UUyPowEzKNzVpN4qmq679tdvMd1YpZmNC+7V3qM
         G6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wXyln5L0tr14vACvKNs8+S4VxfHEIo5Q9Y65ld6P+28=;
        b=ZULJ+r0/ISpLKHiE3p0YwFVWXDibE6QwA1hDvkg4Yu8ZfUP+t2xElxcR6p7H4CxCPN
         LqkyvHbc9z9vv1uuC7CNyTlC20Y5XuVrPOow134bgUr/1a5iNfFlUoZGThfymo5zaNNw
         zBFTWfLw+Q3yLhAP/dzW6+8UItddtq63zN8U9qbd76GHrwLqHOC4kEFyXU5lJcZA50me
         oHrSGK/Ft9zzATe/oD8wkWU9xvs2oT3hI2fb53vqDkueaTHtpNQW1HKXqe1kcRJNY9et
         CU6hfdgLCEhvve26brmzfVjIL0qoe4MK7VArk18TFg/NrBmOCxf6UxCSp2aQhdKFPuKz
         r5wQ==
X-Gm-Message-State: ABUngvcRydFG7tJpmlfclVSixcUxGBNhuNiLRDqzbV+lrtNz/2Ld867PsYDBLHlRfvTo1TcmSmhxhgWOoup20g==
X-Received: by 10.25.74.5 with SMTP id x5mr4085282lfa.154.1477779894688; Sat,
 29 Oct 2016 15:24:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 29 Oct 2016 15:24:54 -0700 (PDT)
In-Reply-To: <CACsJy8A0djR6=s0AY0tzVehYY5b1-o11uRsFdGtOUCeu4Z6Xjw@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-10-chriscool@tuxfamily.org> <CACsJy8A0djR6=s0AY0tzVehYY5b1-o11uRsFdGtOUCeu4Z6Xjw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Oct 2016 00:24:54 +0200
Message-ID: <CAP8UFD3kPVRdubHEsbKbUuxhMDjWNz6y_ANLBB+4Au76PJ3U6w@mail.gmail.com>
Subject: Re: [PATCH v1 09/19] config: add git_config_get_max_percent_split_change()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 12:06 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> This new function will be used in a following commit to get the
>> +int git_config_get_max_percent_split_change(void)
>> +{
>> +       int val = -1;
>> +
>> +       if (!git_config_get_int("splitindex.maxpercentchange", &val)) {
>> +               if (0 <= val && val <= 100)
>> +                       return val;
>> +
>> +               error("splitindex.maxpercentchange value '%d' "
>
> We should keep camelCase form for easy reading. And wrap this string with _().

Ok, it will be in the next version.

Thanks,
Christian.
