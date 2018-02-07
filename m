Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5E91F576
	for <e@80x24.org>; Wed,  7 Feb 2018 10:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeBGKg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 05:36:58 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45016 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeBGKg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 05:36:57 -0500
Received: by mail-ot0-f196.google.com with SMTP id l5so342698otj.11
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 02:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vY/2dD6oGSmjgkwoy4tL7KNK5wb3Ol4jFmEaPkcAq3Y=;
        b=dxRFxTwhjE3i2OjcvEHQv6deFt0p+ZsbtxY5AEZQsSIlhRejY5unCoEIdSQkwR674t
         BzzN3rdM2qtAvZ3OHEn5pjBKvqD/GAInfGBGiGHdRG67p9yY7Xy4pyp6+5w/qGTgzo1k
         oMGrkeqTYAxoDmnZHmD/Tmb0S8CRo7xDG/zAmLldEDKS5+heZaJLeTOtDuTkfxhI2W1K
         3O8PwGobG1/Qbx65J3QTgCw11fE4eLvnR/btm9XjSn4wibG9AoVU/+C9VIWROUG9mE2O
         Z3YlxncMA0oGZTucMfcp28cTy0RlUozRSWVNLWNYDfTZRmsHnodinuemI3sVxpro4DyW
         NN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vY/2dD6oGSmjgkwoy4tL7KNK5wb3Ol4jFmEaPkcAq3Y=;
        b=YmaJM/mluEQEvGF6VFz9LOWclkcvNClgroVWKDhSy/SMxtSqNoKdX1hUhOAJfymoBK
         FklXzKm/foM+30RzK6/bj9G5nfBTHmUEilpCffhyjSa0bjwqCQ3SkeDDw6KeK0rNn/CG
         pl794yB/cRzPzEi3dTAHNtcvvSBYNqCr7+SKlX8z9SQU2aKia040Rp5hAVj4SASfHWjW
         bocgBIPsREpnYNh3tudNjJYSPe1GB85/V7Fxdu/1NH5lATOUziH3PE/WVLzEvEujWaNu
         h9hfHyFjozxiDkAPJpTpR5vwUF3TaVQoYpt6mEGjW4Y05AtPyq5Na2qyGaH2kwz5y4DL
         3reg==
X-Gm-Message-State: APf1xPB594vgmme5DMYVpIwiS/Z8Gn1vcCgsbD0m+zGgwTIAbeX1/OrC
        I+wC/zm96xYKZ7z1A1DUPLwYTcwwjKaSn8h24kc=
X-Google-Smtp-Source: AH8x224CzG/biIBjh7PQB0Z8cU0nLpvfyZ7c3YLpZ2EXCRmM0PSTiVvqtoJmfRmyOTOKQYNEXvNUi7CfdX+rgD0nFuE=
X-Received: by 10.157.31.47 with SMTP id x44mr4255149otd.165.1517999817278;
 Wed, 07 Feb 2018 02:36:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 7 Feb 2018 02:36:26 -0800 (PST)
In-Reply-To: <CAPig+cR9RycfLz0C6tXA4iPXdqoyczfij8CBaU4MmRGRmuRhSQ@mail.gmail.com>
References: <20180201130221.15563-1-pclouds@gmail.com> <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com>
 <xmqq8tc7b6yt.fsf@gitster-ct.c.googlers.com> <CACsJy8CQLnzX6vijE+WHE3_nwqVfFiNWFb_rcA-Lw_fvGf=aFw@mail.gmail.com>
 <CAPig+cR9RycfLz0C6tXA4iPXdqoyczfij8CBaU4MmRGRmuRhSQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Feb 2018 17:36:26 +0700
Message-ID: <CACsJy8AiBq__c0UET5ywMbTTz_MJNo-bZ-qAaoGZXdMNnECcaQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 4:52 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Feb 6, 2018 at 5:20 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Feb 6, 2018 at 1:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>> I actually think compact-summary was a good way to phrase it.
>>>
>>> Personally, I think it was a UI mistake that --summary can be given
>>> independently with or without --stat (instead, there shouldn't have
>>> been the --summary option, and instead when it was added, --stat
>>> just should have gained an extra kind of output).  A single option
>>> that can give both kinds of info may be a good way forward, so
>>> another possibility may be --summary-in-stat (meaning: the info
>>> given by summary is included in stat output).  I dunno.
>>
>> +Eric maybe he has some idea (sorry I forgot to include people from
>> the last round).
>
> What about the earlier suggestion[1] (and minor follow-ups[2,3]) of
> making this another option to --stat= (for instance, --stat=compact)?
> Did that idea get shot down or am I misunderstanding the question
> here.

I thought that was something like
--stat[=<width>[,<name-width>[,<count>,[compact]]]] and turning on
"compact" alone would get awkward because you need to specify all
those widths and counts too. --stat=compact as a separate form, with
no combination with any other stat params, does not feel justified. We
could just do --stat-compact then. Perhaps we can allow compact to
appear anywhere in --stat=, and not just the end? The --stat= syntax
would be

--stat=[<option>[,<option>[,<option>...]]]

where option could be keyword ones like compact or anything else in
future, or <keyword>=<value> form. <option> could also be a number,
but in that case the three consecutive number options will present
width, name-width and count in this order.

Or we could simply add new --stat= syntax _without_ "<option> as
numbers". widths and counts must be specified keywords as well, e.g.
--stat=width=40,name-width=20,count=10,compact and leave the old
syntax "--stat=<width>,<name-width>,<count>" alone.

Then we still need to decide the new keyword for this feature, I feel
compact is a bit too vague (I read --stat=compact as "it's compact
stat", not "stat with compact summary"), so perhaps
--stat=compact-summary, or just --stat=summary?

> [1]: https://public-inbox.org/git/CAPig+cQLgs59JYxcmK30qY307ArwqJx6pNOo95Z39_jJ9+D6+g@mail.gmail.com/
> [2]: https://public-inbox.org/git/CACsJy8B5qrN8T1aai3y3nfEc5baqn2Xkk6vZozMp5Lh-mPZ0VQ@mail.gmail.com/
> [3]: https://public-inbox.org/git/CACsJy8CPHk+aXHr-mkHZi27s=c3+ny8D9CSuzOSO8PweviBcqQ@mail.gmail.com/
-- 
Duy
