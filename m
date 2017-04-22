Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486F01FE90
	for <e@80x24.org>; Sat, 22 Apr 2017 17:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1043993AbdDVRco (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 13:32:44 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34715 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043972AbdDVRcn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 13:32:43 -0400
Received: by mail-vk0-f67.google.com with SMTP id e15so758427vkd.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2017 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pPwAbW+xS1Aw5Z5T0/IquqMxe8jLgGgRJRO7+010SwI=;
        b=MQf3G3DHw7mQMFFgQPos7NDrC1rj5XvOeSNBSZOuAtCK7uKHZ+1sw8gASIrEkWii00
         5LGURlHv4v7uJQTwqvg8TWeVigbp/Xm/ZjdMe18/JMwKBTdXa5JL+8CppSM/AdfwKdOy
         t7koR3WHQ3RsxSvC2woJMIOPB9BbbfjV7WX4Mh3SIddeGC9eI958KvOeIOmpCif2unle
         gp4YkxC7bXGUTnayq48f/WQ54J5VOG0icOF8m8iECNm5DIwIaeHeaXQAXuggW8aTkRJo
         6rTOLAApbYwGLS8RLWhmq90/K3UyYkF5L2U17B9Qn/z11/tJgtgVcFH9tvmdr/rgdhs0
         XdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pPwAbW+xS1Aw5Z5T0/IquqMxe8jLgGgRJRO7+010SwI=;
        b=pG8UloGsqf15fNmyLemwWL7tL5F/Ac6Yrn+Wfn8ORjevVAiK3rTlsF6KpMrBGzw5E1
         DtrpNRxQhxR5klTilWDLGw4LqwRxlDFOnWjrhCiLgpFjy0uXbaqmXzp25Ts3U6OyxmPW
         5hOdTPLz9WulBwDrZK0S0mycFlXDGjUSDfH/pD/3LICiv7L+FoG2fwBaROdwh1H2zzU4
         R8kZ7Gy8GfWKRxrm6I2qtcbLXJ96r7ZRvPUvFnkHdV2ArfiVctefVRig3M9/dcz/spMl
         TEA9I5nkX9lv0HWxvovcGFtYoA8TN/z4moeQNXRxbAklcGS688NmAkBWUyO4DaUeBk8N
         zqCg==
X-Gm-Message-State: AN3rC/6EKYYg1YGtEhGjvoct/rVG3Y8dEgDlpdQnQfWsZyEJ8b2B11Jr
        gG2ynwTPo+Q77EZvyJoCLf4WjYiSDg==
X-Received: by 10.31.181.141 with SMTP id e135mr891884vkf.23.1492882362068;
 Sat, 22 Apr 2017 10:32:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Sat, 22 Apr 2017 10:32:41 -0700 (PDT)
In-Reply-To: <20170421201957.ztwnyw6mut4b5u53@sigill.intra.peff.net>
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
 <xmqqzifa4amr.fsf@gitster.mtv.corp.google.com> <CAM0VKjm=JMuYzsS-OTx+p-vFF8PmWJGbFnndag9dWw6xCe3g6Q@mail.gmail.com>
 <20170421201957.ztwnyw6mut4b5u53@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 22 Apr 2017 19:32:41 +0200
Message-ID: <CAM0VKj=j52hDD1TKqbube3Of1qo8zZ7e4q4yAmxbNORRRDZyFQ@mail.gmail.com>
Subject: Re: [PATCH] completion: optionally disable checkout DWIM
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 10:19 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 21, 2017 at 10:14:48PM +0200, SZEDER G=C3=A1bor wrote:
>
>> >> This is flexible enough for me, but it's possible somebody would want
>> >> this on a per-repo basis. I don't know that we want to read from `git
>> >> config`, though, because it's relatively expensive to do so. People w=
ho
>> >> want per-repo settings are probably better off with a hook that trigg=
ers
>> >> when they "cd" around, and sets up their preferences.
>>
>> We could discern between more than just empty vs. non-empty state of
>> the environment variable, e.g.:
>>
>>   - if empty/unset, then include "DWIM" suggestions.
>>   - if set to 'config', then query the 'completion.checkoutNoGuess'
>>     configuration variable, and omit "DWIM" suggestions if its true.
>>   - if set to something else, then omit "DWIM" suggestions.
>>
>> Then users can themselves decide, whether the per-repo configurability
>> is worth the overhead of running 'git config'.
>
> Yep, that would work. I wasn't going to bother with that complexity
> unless somebody really wanted it. The important thing is not to paint
> ourselves into a corner. By the rules you gave above, it would probably
> be fine to extend my patch later to match. But we could also be more
> specific (e.g., look for some positive value like "1").

That's fine with me.

We should have done this when we introduced env variables controlling
the prompt script, we could spare a 'git config' execution in a
subshell or two.

>> >> @@ -1248,7 +1256,8 @@ _git_checkout ()
>> >>               # check if --track, --no-track, or --no-guess was speci=
fied
>> >>               # if so, disable DWIM mode
>> >>               local flags=3D"--track --no-track --no-guess" track_opt=
=3D"--track"
>> >> -             if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
>> >> +             if [ -n "$GIT_COMPLETION_CHECKOUT_NO_GUESS" -o \
>> >> +                  -n "$(__git_find_on_cmdline "$flags")" ]; then
>>
>> || would be better than '-o', because the former short-circuits when
>> the first condition is true, but the latter doesn't.
>
> Ah, I didn't know that. Usually I use "||", but I thought "-o" was
> generally preferred in bash-specific scripts. We definitely want to
> short circuit here.

No, we use || and && fairly consistently in conditions in Bash
scripts.  There is no '-o' in the completion or prompt scripts, and
there is only a single '-a' in the former, but it only checks two
one-letter variables, so it doesn't matter.  (Besides, it's from my
second ever commit, so it has great sentimental value ;)

There are some inconsistencies using 'if [ ... ]' and 'if [[ ... ]]',
but oh well.


Anyway, v2 looks good to me.
