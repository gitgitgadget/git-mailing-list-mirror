Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D551F404
	for <e@80x24.org>; Thu, 22 Feb 2018 01:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeBVBwi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 20:52:38 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35890 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeBVBwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 20:52:37 -0500
Received: by mail-qk0-f196.google.com with SMTP id d206so4623846qkb.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 17:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yMJoAgbpXaamGqHdMUh1V5PUs5frgVaa94dLqwLiRwQ=;
        b=gpOOAW4u/nS0wdy8jd8CX9YH0cX7rAx+WY0544/Qvb7p68mrECgJWv0jK/ZaBAbyPb
         646LdZ8h2UD85eAd830xS7QZy4qON00aHegZavbcrmcuCwztf/5YITxHaSi0CFkAsWD8
         wUqg4EkE3uQbht3mI4arxk+xezWXv/Uo39Jcx4pqzrrtfrYyErrS12JuNqFVf1Sw4PSH
         rs8/ps3pA66mc/Lek9J5d4gihUADf06kLXK+ea9Rhl3JMI4OjI2WUge36mQm5z8dPq+W
         7ROT449WWulvziwXW0kWl+/P48BXRYXrsui+dlIQFZtZRNacquBsRse67YTJhpznLFeJ
         hcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yMJoAgbpXaamGqHdMUh1V5PUs5frgVaa94dLqwLiRwQ=;
        b=KxThOGQUwD0TiDeEkT8t7+zfgRgFgrxlPEuwEYPV/8elWF+QE71IXM71P6RFXy2mdH
         HCbpLcHvU7cCedeDaadbgVTwHV+9sVTxKQVwZB6DJIO0nBV3/0O+3bIlONktBG+jvIXw
         5P8nZjZ02GSyjHvLynVeJDcK5OzvyOVshRPKdpvWfXQ+JlYRh7sBoQKk6ujeCyxJQCvt
         VdnEFN5TEDGkWh6+GfnlZgFIa1PuNRNKkp9nW74rnI6F7wU59MObmOXGjZTEfLZMTw93
         HCsBGcZC00+vvnHGlYCwSJWoS5lct20DsT9lj9YlV4j1QLY9XU8Gw09WJSyNupzedHxH
         rTpQ==
X-Gm-Message-State: APf1xPCdj15Gq21x5AxPfoSX2Wf9A3xk5McreshpWKZhmfXmYpqZLXx7
        VXFW9HqrL/W4srGnZPAPFm4=
X-Google-Smtp-Source: AH8x225lfwHi3/BGBgsXIlkUkMK1SPGHlRcJz7GgqbB6rIXsO/GTiKYWdfU3/GoG1D5RT42XLcwV0w==
X-Received: by 10.55.41.12 with SMTP id p12mr8553271qkh.136.1519264356721;
        Wed, 21 Feb 2018 17:52:36 -0800 (PST)
Received: from [172.22.150.178] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id t200sm17397124qke.72.2018.02.21.17.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2018 17:52:33 -0800 (PST)
Subject: Re: [PATCH] commit: drop uses of get_cached_commit_buffer()
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20180221185204.GA8476@sigill.intra.peff.net>
 <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
 <20180221231338.GC7944@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <562f72bd-1917-6c29-97fc-6098bd109d52@gmail.com>
Date:   Wed, 21 Feb 2018 20:52:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180221231338.GC7944@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2018 6:13 PM, Jeff King wrote:
> On Wed, Feb 21, 2018 at 02:17:11PM -0500, Derrick Stolee wrote:
>
>> The get_cached_commit_buffer() method provides access to the buffer
>> loaded for a struct commit, if it was ever loadead and was not freed.
>>
>> Two places use this to inform how to output information about commits.
>>
>> log-tree.c uses this method to short-circuit the output of commit
>> information when the buffer is not cached. However, this leads to
>> incorrect output in 'git log --oneline' where the short-OID is written
>> but then the rest of the commit information is dropped and the next
>> commit is written on the same line.
>>
>> rev-list uses this method for two reasons:
>>
>> - First, if the revision walk visits a commit twice, the buffer was
>>    freed by rev-list in the first write. The output then does not
>>    match the format expectations, since the OID is written without the
>>    rest of the content.
> I'm not sure after my earlier digging if there is even a way to trigger
> this (and if so, it is probably accidental, since those lines were added
> explicitly for --show-all).
>
> And actually after re-reading the commit message for 3131b7130 again, I
> think the current behavior is definitely not something that was
> carefully planned. So I'd propose a commit message like below.

I only submitted my patch to avoid making you do the work of writing the 
commit message. My messages still don't have quite the right amount of 
detail (or the correct details, in this case).

Junio: please add

Reported-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,

-Stolee


>
> -- >8 --
> Subject: [PATCH] commit: drop uses of get_cached_commit_buffer()
>
> The "--show-all" revision option shows UNINTERESTING
> commits. Some of these commits may be unparsed when we try
> to show them (since we may or may not need to walk their
> parents to fulfill the request).
>
> Commit 3131b71301 (Add "--show-all" revision walker flag for
> debugging, 2008-02-09) resolved this by just skipping
> pretty-printing for commits without their object contents
> cached, saying:
>
>    Because we now end up listing commits we may not even have been parsed
>    at all "show_log" and "show_commit" need to protect against commits
>    that don't have a commit buffer entry.
>
> That was the easy fix to avoid the pretty-printer segfaulting,
> but:
>
>    1. It doesn't work for all formats. E.g., --oneline
>       prints the oid for each such commit but not a trailing
>       newline, leading to jumbled output.
>
>    2. It only affects some commits, depending on whether we
>       happened to parse them or not (so if they were at the
>       tip of an UNINTERESTING starting point, or if we
>       happened to traverse over them, you'd see more data).
>
>    3. It unncessarily ties the decision to show the verbose
>       header to whether the commit buffer was cached. That
>       makes it harder to change the logic around caching
>       (e.g., if we could traverse without actually loading
>       the full commit objects).
>
> These days it's safe to feed such a commit to the
> pretty-print code. Since be5c9fb904 (logmsg_reencode: lazily
> load missing commit buffers, 2013-01-26), we'll load it on
> demand in such a case. So let's just always show the verbose
> headers.
>
> This does change the behavior of plumbing, but:
>
>    a. The --show-all option was explicitly introduced as a
>       debugging aid, and was never documented (and has rarely
>       even been mentioned on the list by git devs).
>
>    b. Avoiding the commits was already not deterministic due
>       to (2) above. So the caller might have seen full
>       headers for these commits anyway, and would need to be
>       prepared for it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   builtin/rev-list.c | 2 +-
>   log-tree.c         | 3 ---
>   2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 48300d9e11..d320b6f1e3 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -134,7 +134,7 @@ static void show_commit(struct commit *commit, void *data)
>   	else
>   		putchar('\n');
>   
> -	if (revs->verbose_header && get_cached_commit_buffer(commit, NULL)) {
> +	if (revs->verbose_header) {
>   		struct strbuf buf = STRBUF_INIT;
>   		struct pretty_print_context ctx = {0};
>   		ctx.abbrev = revs->abbrev;
> diff --git a/log-tree.c b/log-tree.c
> index fc0cc0d6d1..22b2fb6c58 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -659,9 +659,6 @@ void show_log(struct rev_info *opt)
>   		show_mergetag(opt, commit);
>   	}
>   
> -	if (!get_cached_commit_buffer(commit, NULL))
> -		return;
> -
>   	if (opt->show_notes) {
>   		int raw;
>   		struct strbuf notebuf = STRBUF_INIT;
