Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40BB1F51C
	for <e@80x24.org>; Tue, 22 May 2018 13:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeEVNCd (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 09:02:33 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35481 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbeEVNCd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 09:02:33 -0400
Received: by mail-oi0-f66.google.com with SMTP id a6-v6so16093622oia.2
        for <git@vger.kernel.org>; Tue, 22 May 2018 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L8KyomEWrxFp/YpZs5DhO34SR/7HCiVxDnVV9AFSlA8=;
        b=b/wenyGjnKV89eo1ZOBvthZL84xMiPXCBkDk6pQ4LxNDhnJhuuGYjycthFTpzLUvF0
         rleri+HxmHj1+VrwMqtmaCIBj5WoFKOBbTaKiT1P9sM23D6LF5nPhx5YmxuyMV8phYPY
         e19HD6vSnmk2filyokHCLS4/4Y5cw2t7UrE0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L8KyomEWrxFp/YpZs5DhO34SR/7HCiVxDnVV9AFSlA8=;
        b=OUlMiu9vvLvFQygLR7qLq0/hU23XvPVoTOko3QMDIqPwEd0H4pLnIg1JHakzB9HEiF
         D1xYpcrHSMAVxBF51bUycftoi782JnQ6paCYa1+c3IN01pWeyynp61v8tvvRAmCYD5Ln
         5/Gvp2BnRdwgpsF4idzxhPIMQKH/1eNV6rlU5N1lfB1DQKK70pM+X1Re+ZJLJIXcX+Fy
         5/nLKf6+qoRseJjpYVAj3IJH3okGvfSE+pz1ALEigsMa/e8HXTDkcSneEVokB0i5FBti
         u3YRDWqhZRbAeedJCt36srth1ND2FQ8cgX3UYVnLd3PFR723lj0jeFBG6tk3ps2/fp6q
         PajQ==
X-Gm-Message-State: ALKqPwfVFPghOwrkqJkRnm37GWF1FMg4oiYMTREXV1WtyLVNn44Zl+Wg
        lWQguezLUsn4nsXHnk9mWm/Tns88CdAZiYx3HWfZ5g==
X-Google-Smtp-Source: AB8JxZrX2XgVhpSX861wQ+0KsCGlgXYbJXiq5Q3OHlWVkzXJ5gnChk+czLDfBO2vnndpu2tDpGtXdJZPni+dZp9UzHo=
X-Received: by 2002:a54:4406:: with SMTP id k6-v6mr12951075oiw.162.1526994152547;
 Tue, 22 May 2018 06:02:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Tue, 22 May 2018 06:02:31
 -0700 (PDT)
In-Reply-To: <CAM0VKjkdGByfTtj5cunUzqeneu4Bi8Qw4vj428zV1h3ezHXyQg@mail.gmail.com>
References: <20180522084109.29787-1-luke@diamand.org> <20180522084109.29787-2-luke@diamand.org>
 <CAM0VKjkdGByfTtj5cunUzqeneu4Bi8Qw4vj428zV1h3ezHXyQg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 22 May 2018 14:02:31 +0100
Message-ID: <CAE5ih79_Ai8F48zFpJ09e8saGrySoiyVdsgkk8ZpRrQAd15a4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: unshelve: use action==add instead of rev==none
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 May 2018 at 11:15, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
> On Tue, May 22, 2018 at 10:41 AM, Luke Diamand <luke@diamand.org> wrote:
>> SZEDER G=C3=A1bor found that the unshelve tests fail with newer
>> versions of Perforce (2016 vs 2015).
>>
>> The problem arises because when a file is added in a P4
>> shelved changelist, the depot revision is shown as "none"
>> if using the older p4d (which makes sense - the file doesn't
>> yet exist, so can't have a revision), but as "1" in the newer
>> versions of p4d.
>>
>> For example, adding a file called "new" with 2015.1 and then
>> shelving that change gives this from "p4 describe" :
>>
>>     ... //depot/new#none add
>>
>> Using the 2018.1 server gives this:
>>
>>     ... //depot/new#1 add
>>
>> We can detect that a file has been added simply by using the
>> file status ("add") instead, rather than the depot revision,
>> which is what this change does.
>>
>> This also fixes a few verbose prints used for debugging this
>> to be more friendly.
>>
>> Signed-off-by: Luke Diamand <luke@diamand.org>
>
> For what it's worth, I can confirm that 't9832-unshelve.sh' passes
> with these changes, here and in all Linux and OSX build jobs on Travis
> CI.

Thanks!

>
> However, instead of a separate patch, wouldn't it be better to squash
> it into the previous one?  So 'make test' would succeed on every
> commit even with a newer p4 version.

Junio?

I can squash together the original commit and the two fixes if that
would be better?

Thanks!
Luke
