Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4671F404
	for <e@80x24.org>; Wed,  7 Feb 2018 00:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeBGAAe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 19:00:34 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34620 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbeBGAAd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 19:00:33 -0500
Received: by mail-ua0-f178.google.com with SMTP id g5so2404355uac.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 16:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oErAcNXqaiEDLD1IMXw17BBJxhorZ+HCuyDf+GHM/iM=;
        b=Bf2Dpi40vOemBr26XlsAYojT5YEkokHff878PGsO7/J93b3wQ5hgPNVg11X9eXJ9hb
         MzYr8boKnSSSrymmxg6OsOiuayUouT6SeUP2e5ZzszT1Joi0Dy6OYkjDRQnpP8+5MNgl
         l/h2DDWgBQecTwlXInoDk73kfFpnMKhMb46Zm2h8SDBXlqkEyXhZm8QRR8450KdiLY81
         xyS7fctE5FMEyCKFar/Tf9o4lsIxvxaIqmbqR/1qfs7zHWvZ6DcFS0Xle45QafqxamhO
         aX0nmoW//wJIMAtzFRCqLVo8F8OPoKgtIqYnJ+QBcGjZmTw1Uf/AhHIjMaOx8QXomCaN
         U+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oErAcNXqaiEDLD1IMXw17BBJxhorZ+HCuyDf+GHM/iM=;
        b=edVYkfHlmGvozqnWcZoi7vzZvg9FBD4kyT9tIlQ04ohlTUxlC0LeiOEkNNfJLjeqXk
         rlBp3TfyxgBUdyHCjjB5gfdvB1UcyGCwyFjsFkFHocNANGPbP6iqHY4FTeGm0JCqTSfH
         gbbxqIjBeBjSGD3BsoUhOgqdtC3G/EmtuibilxrNzznbzN+6l/pYcdz75+UjqW8/s29U
         gzJpCHg4WRzubmwxRXBbngkIG1fOdcTxJnUPHllisbTdDuZpjMrb2UoZgqQaW46OlpOQ
         +VGwuWUs0A1EmyxS6WJZEQbRFldvgRp+Sd/qh9zeSXgwnd3CJmjVVCxgljbXV/qPmE3q
         NWPw==
X-Gm-Message-State: APf1xPAmMt1wCXTdpWR+PN9XFF7RThLUK9SpOS1sGJXWt3U5r1VMVHZY
        7Bbdpcmeooufrmg5lu9PuJILJDLgXl1naGjq1Rc=
X-Google-Smtp-Source: AH8x225XMZRudC3dAjycBHy66hkjwI2A5A0/JlK5OwlwFfNZYLEeynk3ZHPUTWczLMUagdbqdzMsIGh83N83aCcFcx4=
X-Received: by 10.176.19.18 with SMTP id g18mr1650076uae.87.1517961632552;
 Tue, 06 Feb 2018 16:00:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Tue, 6 Feb 2018 16:00:32 -0800 (PST)
In-Reply-To: <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
 <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 6 Feb 2018 16:00:32 -0800
Message-ID: <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 3:20 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Feb 6, 2018 at 3:04 PM, Elijah Newren <newren@gmail.com> wrote:
>
>>
>> Does anyone have an idea what may have happened here or how to avoid it?
>
> According to Peff this got fixed
> https://public-inbox.org/git/20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net/
> and but you've had a corrupted repo from back when you were using an older
> version of Git.
>
> Did that repo exist before d0c39a49cc was rolled out? Then we can keep that
> hypothesis of "left-over corruption" as Peff put it.

I'm somewhat confused by this explanation.  That precise commit is the
one I bisected to that _caused_ the fetch to fail.  Also, there might
be one important difference here -- in the link you provide, it
suggests that you had a corrupted working directory that made use of a
now gc'ed commit.  In the case I was able to dig into, we did not.
(There was a left-over .git/worktree/<something> that had a now gc'ed
commit, but no working directory that used it.)

I suspect you mean that there was another previous bug that induced
corruption, that this commit fixed that other bug, while also
introducing this new bug that makes folks' clones unusable because the
error doesn't provide enough information for users to know how to fix.
It took me hours to figure it out, after users ran out of ideas and
came and asked me for help.  (Maybe if I was familiar with worktree,
and knew they had been using it, then I might have guessed that "HEAD"
meant "not your actual HEAD but the HEAD of the vestige of some other
worktree").

Does anyone have pointers about what might be doable in terms of
providing a more useful error message to allow users to recover?
And/or ideas of what steps could cause corruption so I can send out a
PSA to help users avoid it?

If not, I'll try to dig more, but I thought I'd ask others familiar
with this area.
