Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C4F1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756605AbeAHTik (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:38:40 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:40117 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756468AbeAHTij (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 14:38:39 -0500
Received: by mail-qt0-f173.google.com with SMTP id u42so15035296qte.7
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 11:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XQuG2IRjSb+fW/jxZ9uzyDypMi4tu4Lz93KQDH6mbTo=;
        b=KLpQpg9hACvxQjMeZJZeY5fEUuzoAr4BdSpIVlIsQCHHe15k5WZ1WwO2OYCsxA5je7
         ChxKBHxvJqit8R+lfSFxjNjWOSMPdMZN3YL1SqQDlRU1ld1hHDJdtO0LmOgl1DUye6i+
         OQULHIZZ4tUkZbnaZEyU0Yum8ENYIFO55DdzKwArXOC66C86mzfK2gmemxQEg6E966NI
         paF/OXmmelnpaSmYOUBLfk42jUXyXP8DFsuP+pTsvHh0sRMuqRxcyejSTT4zw4HQTUnE
         7qdvCJhqGuNWCxu5XU240iSeXCoyHBJmbzrbOjFEDPrMVuyIp5oXEQCGAJN8og/gZPmI
         69VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XQuG2IRjSb+fW/jxZ9uzyDypMi4tu4Lz93KQDH6mbTo=;
        b=jEfPNdMnGm2HV8I8jzerwzw4FWaU9abJJEyoVclN2MNFimS5xotAY0vICQE7kLuqcw
         mPXEMP0XRc2x3ydmH8gEvkFik0bohxo51vCh0mbzlrH1vBH7ARY5OHPAEyj7sAsp614U
         PJKwFCZTbkcVLX8eOKrobDMQxggyX37zKG8k90BoGg4Nn7zvwadBBl+Dicy6Bp76cdi5
         i0BliRnFql5aMzU3krcC+H7RzI6A5hE/lQTqb0AiMX1Uzz04kDvj/q68Ta+XgxNDJnIS
         sTne2gjo71uzmtRaDnc24gnROQV2K4uqmcrwxWdeMjmWWGO6MHdXDce+Z+b2dwQzTtNn
         NLWg==
X-Gm-Message-State: AKwxytcF/0sr6b9SvYYRxMbVCm6loES1xbt9MR4H6MzCzIeqHntWXNyH
        Uwu/U4pggQp4BXv/YIJF0X+nF/+ZCKat2HHuFUmycHHm
X-Google-Smtp-Source: ACJfBovl4XrwJFRe3LJpo8AL4dyo5QZuhYKOKFYNrcWosFWpYpTnhCOGJNrINHqaPt6Z2SE3CvPK9BzeLOMU+AdJwTs=
X-Received: by 10.237.53.50 with SMTP id a47mr18635017qte.29.1515440318503;
 Mon, 08 Jan 2018 11:38:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 11:38:37 -0800 (PST)
In-Reply-To: <CAPig+cQg3o2iicGhSmwPM8dDjtUFSGow5dwprbRNnq4-m5EmFA@mail.gmail.com>
References: <20171228210345.205300-1-sbeller@google.com> <20171228210345.205300-3-sbeller@google.com>
 <CAPig+cTkxmiJZwLqYhKhvApZubJLTLufv2Yo6D5nLMLmrUc2cg@mail.gmail.com>
 <CAGZ79ka22DPHX5_etFREvdVjfsQPzQG66iFgyfsjCdLnwUcAdA@mail.gmail.com> <CAPig+cQg3o2iicGhSmwPM8dDjtUFSGow5dwprbRNnq4-m5EmFA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 11:38:37 -0800
Message-ID: <CAGZ79kYxP7ZwpQvv_-2voN+-6C6trZmVwGXoRE1NiAMe7O_GxQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] builtin/blame: dim uninteresting metadata
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 12:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jan 4, 2018 at 5:10 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, Dec 28, 2017 at 2:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Thu, Dec 28, 2017 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
>>>> +static inline void colors_unset(const char **use_color, const char **reset_color)
>>>> +{
>>>> +       *use_color = "";
>>>> +       *reset_color = "";
>>>> +}
>>>> +
>>>> +static inline void colors_set(const char **use_color, const char **reset_color)
>>>> +{
>>>> +       *use_color = repeated_meta_color;
>>>> +       *reset_color = GIT_COLOR_RESET;
>>>> +}
>>>
>>> I'm not convinced that this colors_unset() / colors_set() /
>>> setup_line_color() abstraction is buying much. With this abstraction,
>>> I found the code more difficult to reason about than if the colors
>>> were just set/unset manually in the code which needs the colors. I
>>> *could* perhaps imagine setup_line_color() existing as a separate
>>> function since it is slightly more complex than the other two, but as
>>> it has only a single caller through all patches, even that may not be
>>> sufficient to warrant its existence.
>>
>> Have you viewed this patch in context of the following patch?
>> Originally I was convinced an abstraction was not needed, but
>> as the next patch shows, a helper per field seems handy.
>
> I did take the other patch into consideration when making the
> observation, and I still found the code more difficult to reason about
> than if these minor bits of code had merely been inlined into the
> callers. I neglected to mention previously that part of the problem
> may be that these function names do not do a good job of conveying
> what is being done, thus I repeatedly had to consult the function
> implementations while reading callers in order to understand what was
> going on.

I asked the question before rewriting and resending, and now I agree
that we do not want to have these small helpers.

Thanks,
Stefan
