Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157DC20756
	for <e@80x24.org>; Fri, 20 Jan 2017 13:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbdATNJQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 08:09:16 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:33100 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbdATNJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 08:09:14 -0500
Received: by mail-it0-f67.google.com with SMTP id e137so2848148itc.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 05:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hYmkKTGwoFfOyjyOFX2qiLl869oMdghe0tyHmOhouAM=;
        b=ibBA9/k9mRxybs6XGuUzNtD17IZnDETfujFDf+uEMBUmKQzOVDM/FGvhfhqBNKCSOy
         2C5JeJFOqxEm8+0jVg8zqaEWK8bik404zVbCS0J3Ic8sk1TKynS2sf7MPadh51IwpwOk
         ZRnSCd1mDKUw3sMqjAmdItZVkQkiQehD1p3GJC4DLasjjgxBa45QlNXKAqFoDiaN9iB7
         b66waEc5rWTCvODhLQf2ZEbdev1pYVoMNvwoOh0oMuhT8JSqdctbVeGyurxgpDdqh58C
         QLagV+mgfyvMvAbap2MWtZtLKu0MDniNLE1DNpcyudbE+HADhm+XkUT+i3qVgCuNDCCQ
         rRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hYmkKTGwoFfOyjyOFX2qiLl869oMdghe0tyHmOhouAM=;
        b=BiXiLjV68wSBORTOw1XAee77krKuOMDvRQnQ+ZMTsfvUpRlSwRL7hYzJIDJlhYYNzn
         eEAYZVJeOSfTNZ+0vhqeZJs3U/gQ23J31LgQGbOe5UUNSxyKzHBDJOvjZQI+acDz5CCf
         Uk9esgR/4YUNF1qSiu4jleFremI2CKstTK9MS8mNnjXIj4QGrdwKiGZkUJk3NfBZKpxZ
         GmK6TO2WutSZDxfl2gOxZvqP3fEYHgMR15W+Yfja8Akaa+XgM0bc/e5X9By0doE+9JNp
         0/upAiJnnHm8gxQW9b6u+trdc5npZCI6RNSf45X/y2FW9VbSb0wvY2BOmX1hq0OQ1oaZ
         9fDw==
X-Gm-Message-State: AIkVDXKP1AqBhPCjqmxtMaLxbjWxsb/QuMyD0ZCgMhKsPBh+RFWY2MzYOJfmzNTjWwR93yr1gqNg/9vf3Cf6gQ==
X-Received: by 10.36.122.208 with SMTP id a199mr3467794itc.74.1484917754141;
 Fri, 20 Jan 2017 05:09:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 20 Jan 2017 05:08:43 -0800 (PST)
In-Reply-To: <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net> <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net> <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net> <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jan 2017 20:08:43 +0700
Message-ID: <CACsJy8BRdd4f7f7+7XyN8jd69GS6tnkEGhw05F=7c96eViRVQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Localise error headers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Yes, I would think die_errno() is a no-brainer for translation, since
>> the strerror() will be translated.
>>
>>>     apply.c:                die(_("internal error"));
>>>
>>> That is funny, too. I think we should substitute that with
>>>
>>>     die("BUG: untranslated, but what went wrong instead")
>>
>> Yep. We did not consistently use "BUG:" in the early days. I would say
>> that "BUG" lines do not need to be translated. The point is that nobody
>> should ever see them, so it seems like there is little point in giving
>> extra work to translators.
>
> In addition, "BUG: " is relatively recent introduction to our
> codebase.  Perhaps having a separate BUG(<string>) function help the
> distinction further?

I was going to write the same thing. On top of that I wonder if have
enough "if (something) die("BUG:")" to justify stealing BUG_ON() from
kernel (better than assert since the condition will always be
evaluated).
-- 
Duy
