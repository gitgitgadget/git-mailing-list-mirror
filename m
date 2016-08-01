Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C311F855
	for <e@80x24.org>; Mon,  1 Aug 2016 19:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbcHATCm (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 15:02:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33672 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbcHATCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 15:02:37 -0400
Received: by mail-io0-f196.google.com with SMTP id y195so14569182iod.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 12:01:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LJhGitTMId8taFnDfAlE0Zc8+H3o+5zkUaihZgaTWt4=;
        b=Fa1tFR3XPuJ6kUbMJDxXtHJHnHog3DUAjTSrWoVjzRmOororrUCqduyH194n6AcyqI
         b4ML+FJKNYN0erzOi9sWq9ojMV3Oby0WrTj4kk5UFBGWg/1GQ1yNdxteY4ENf+09a6wF
         VO1Q6jsP/iPLkopU9DGoqQBfD83ZdPLAHopXkplMCkYbNkn5lqI7sGUEKLC3kqEsy47E
         J10lNrfGW7eCb5c2tFu3aVlfY88Q6jccvWunUHCNUKTQ+MuGpIDowlnb4PeW7esz74Z6
         2cepz0tueUr8B4qK1QSAKY4wXaGYDPlaW2MfOd3UAZj1hTLpJbDr4O3rDNdZgtUzDHO/
         PxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LJhGitTMId8taFnDfAlE0Zc8+H3o+5zkUaihZgaTWt4=;
        b=QtE0VZLPzkca8IEbDEfzRNCCxnZZjzhS8ydLxS2ezKxLPCodDbt5XCKR4JnnR3gJ70
         fcNu4ohxtD4x6iL+WzFqi1RqtfInKh+RzL9/Jg69OMBcNHjjYF+s2LQmkoYUYk06KvuY
         716Up3Hq1zPQrjaBOBrgsmQPLG1tI6ymOJ9BSxuxoQiImfsIsF3WGxDuDnip+CpISpDl
         8rUmAogMbMRyywMLvjqICCyTvls7fo7Hf6esNXMSMcNHurlBk978x17YVpVDQUqVvZW9
         lDje6s1aTqCuiB2PyaDfuYpB7fqYs6PdaIMuoUrSTM+XFGAhiKvq++TdtlODAARjw2rQ
         hFBg==
X-Gm-Message-State: AEkooutIZfVTDbHz9YglIVdaiHc4+tV7u1yMP/to9IYWLp6OePyfHlnWgN5ruQMzBl9qR7uE3lFb+DojY6S4LQ==
X-Received: by 10.107.8.140 with SMTP id h12mr59653550ioi.95.1470074503932;
 Mon, 01 Aug 2016 11:01:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 1 Aug 2016 11:01:13 -0700 (PDT)
In-Reply-To: <20160801175216.payv2zrc3mkvkbmz@sigill.intra.peff.net>
References: <20160801010557.22191-1-e@80x24.org> <20160801010557.22191-2-e@80x24.org>
 <CACsJy8AEFFTnGw01mTBrZu8QnUWmQav7bhZUyw7o91ph7DUwaA@mail.gmail.com> <20160801175216.payv2zrc3mkvkbmz@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 1 Aug 2016 20:01:13 +0200
Message-ID: <CACsJy8CLNtbAvRxVtX_9qZ0cahce7cFfk=wh78Wm99Qf5B8HRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
To:	Jeff King <peff@peff.net>
Cc:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 7:52 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 01, 2016 at 07:46:34PM +0200, Duy Nguyen wrote:
>
>> On Mon, Aug 1, 2016 at 3:05 AM, Eric Wong <e@80x24.org> wrote:
>> > From: Junio C Hamano <gitster@pobox.com>
>> >
>> > Allowing PAGER_ENV to be set at build-time allows us to move
>> > pager-specific knowledge out of our build.  Currently, this
>> > allows us to set a better default for FreeBSD where more(1)
>> > is the same binary as less(1).
>>
>> Nice. I was just too lazy to do something like this and "export
>> PAGER=less LESS=FRX" then ignored it :-P
>>
>> Slightly off topic, but pagers like 'more' does not understand colors
>> either. But color.ui = auto does not know what and prints color code
>> anyway. It would be nice if we had some configuration to describe
>> "this pager can show colors, that pager does not" so I don't have to
>> maintain separate .gitconfig files on two platforms.
>
> If you are interested, I suggest you read the thread linked earlier:
>
>   https://public-inbox.org/git/52D87A79.6060600%40rawbw.com/T/#u
>
> which discusses this and other issues. But basically, I think you cannot
> really solve this without getting intimate with each pager (which people
> seemed not to want to do).

Cooking pager specifics in git does sound bad. But it does not have to
be that way. What if we delegate the decision whether to color or not
to a script (e.g. by setting color.ui= "script <path to the script>")?
The script has all the info (env variables, uname, user preference...)
and can make a better decision than 'is stdout a tty?'. It's not about
out of the box experience, more towards customization (without
fragmenting .gitconfig files too much).
-- 
Duy
