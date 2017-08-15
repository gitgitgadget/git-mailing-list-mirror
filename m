Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C244208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdHOT3o (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:29:44 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33103 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdHOT3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:29:44 -0400
Received: by mail-qt0-f196.google.com with SMTP id u19so1632376qtc.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WDreeWaAPXN6ZxiIHWCEGUevyzW6TPuenE3Kx9Wdjzg=;
        b=VUP27p3REHyKgSy/8shKcG6oWJJDiLrVZ4MJEryKLGv1EsAkSxiV+ZOtfTTcYYPqLe
         6VoQTwefNpaX5Zs1SpRyhjUHCHwJkFdw2BvGGRtZGhyIFmj04f07cWFWydAJIr+beRKm
         zcNSShltSHjMC4+eQH3SSnpfl+bWHlCU/djaG8uhB638HUkCuBFwGsU/JFqvxnz1H3cC
         QMv75wdpraKnE8eMLYPhtCgKOdzs4RcSREizRqamQwKhrTox7Hub/YFuQzFVYPzMNq+M
         xkPvMKzuaFpYV1LHe8+mVSlz5lwyCXAd/2B1grtXKdqPK33Fa5+9cYO56md9tyTbo8x3
         2JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WDreeWaAPXN6ZxiIHWCEGUevyzW6TPuenE3Kx9Wdjzg=;
        b=QJ3zALP17qaH330ywzlpWesiewLiFl1iaVt/UB1SMI8Q7UMxiMrj+Q4YkljSfruN0w
         pnF1DPaN5+ssZo4xXC8y8HaPwAPMpUxQYJ0VA3U79F+9ID7C/BepuIK80PwNqPL5qgM3
         EZ34yNYc73qSeagQpoMlMOQ3n9Bsbkm1SUX+8hIA9iRn07gcdFFSd9iq8aSlRALsFIZ1
         XnkAmR4JhBznzyQZ3EDHNRVhkVHnrk9OcB1QXxBSeDQAgbmW3pz8NDMpnq+PCLaR8IO/
         P/NLmBBpIqcZUJUeFeL9j+5EzodEwlUHr9fbRdYrE0JBvt6JPAvmC9HmPAYDo62wBzFb
         8nJw==
X-Gm-Message-State: AHYfb5iC2+AxEjEup585b/GAQCw1gzv/IDwaslcjuK6TkT0z3LOBA98J
        9zp9lu/6NPXLROHm0PeQX/LfIas1Cg==
X-Received: by 10.200.37.193 with SMTP id f1mr40216149qtf.264.1502825383435;
 Tue, 15 Aug 2017 12:29:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.77.16 with HTTP; Tue, 15 Aug 2017 12:29:42 -0700 (PDT)
In-Reply-To: <836F754B-C78C-4D19-8365-875D96B3F115@gmail.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org> <836F754B-C78C-4D19-8365-875D96B3F115@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Aug 2017 21:29:42 +0200
Message-ID: <CAP8UFD2KBEVwZE8obaDxf+0AyU4zH0+5bWJzzHazFywgWT9QjQ@mail.gmail.com>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 9:00 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 15 Aug 2017, at 19:36, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> In handshake_capabilities() we use warning() when a capability
>> is not supported, so the exit code of the function is 0 and no
>> further error is shown. This is a problem because the warning
>> message doesn't tell us which subprocess cmd failed.
>>
>> On the contrary if we cannot write a packet from this function,
>> we use error() and then subprocess_start() outputs:
>>
>>    initialization for subprocess '<cmd>' failed
>>
>> so we can know which subprocess cmd failed.
>>
>> Let's improve the warning() message, so that we can know which
>> subprocess cmd failed.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> sub-process.c | 13 ++++++++-----
>> 1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/sub-process.c b/sub-process.c
>> index 6edb97c1c6..6b133f8dce 100644
>> --- a/sub-process.c
>> +++ b/sub-process.c
>> @@ -158,7 +158,8 @@ static int handshake_version(struct child_process *process,
>>
>> static int handshake_capabilities(struct child_process *process,
>>                                 struct subprocess_capability *capabilities,
>> -                               unsigned int *supported_capabilities)
>> +                               unsigned int *supported_capabilities,
>> +                               const char *cmd)
>> {
>>       int i;
>>       char *line;
>> @@ -184,8 +185,8 @@ static int handshake_capabilities(struct child_process *process,
>>                       if (supported_capabilities)
>>                               *supported_capabilities |= capabilities[i].flag;
>>               } else {
>> -                     warning("external filter requested unsupported filter capability '%s'",
>> -                             p);
>> +                     warning("subprocess '%s' requested unsupported capability '%s'",
>> +                             cmd, p);
>
> Wouldn't it be possible to use "process->argv[0]"?
> Shouldn't that be the same as "cmd"?

Well in sub-process.h there is:

/* Members should not be accessed directly. */
struct subprocess_entry {
    struct hashmap_entry ent; /* must be the first member! */
    const char *cmd;
    struct child_process process;
};

so if cmd is always the same as process->argv[0], maybe there is no
need for the cmd member in the first place?
