Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB9220986
	for <e@80x24.org>; Wed, 19 Oct 2016 18:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942325AbcJSSAu (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 14:00:50 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33848 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941011AbcJSSAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 14:00:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id r16so19891992pfg.1
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3OdIkK5EUF/8FBY3WDCc6Pp+6bf60ws8j4siSOvS7+M=;
        b=AvrH8TZYYwpAL6o9ak1sre5EP/seJ6ZXRHYumNvNbBcoUQppJqwek85sxaajJzKwLQ
         xGe2e8c0IZU/ScZjum9plh7o5VrRaNhb7BTCBHHvE73ojZT8BM30UfxM6+2NBgjxtCwP
         sQe6xSUvxH3+CQUoX5bl8KZoSgwb0igWXeu3SFuyMSCa/BLvuH3w1sR8lJnLa1PJAsvu
         r9io6A1G/TcYbX7azx3y1OoLcmFTyUy7BzLzNwjDwyv2GWOWl+zdZgqrqdvp3ceC6yDs
         MTXxn7rQA04Oj4wTbNrh4zVmeSw6Nyk0x0O8vd/tB7iXk12xwhHdaJc1ZKqki+S4GDBi
         qBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3OdIkK5EUF/8FBY3WDCc6Pp+6bf60ws8j4siSOvS7+M=;
        b=L0SHOpIUYVM3p8Qk/nCJVsWetZRi9+1bdq0l5yrOPidJA7hxRANRsweFQjgLhMLq47
         8fS/K2VxsVNPa9IavqYs7M2gUZod//Lk3/F/tX0I7GGxl4fWAqoxqPNccY93u853qR1J
         Cj2XPviQa8TEZTxIZ6v68pUu6czdaUAxa+lcbWpwEoqBH+Ho/2ypO/LBOknW0+JmW/Ls
         W/c4uCTUwm77/57q3S0tUrsLqWgeG07H7V+cWs99iK8Ge2DnEBiOrMlpPphxUCvMlBJm
         XbTD16gh1o/yMWg5Bo4/cbIjS/opHFrGiLkechCnrW4OXGqDPUYCsyRL3zc+SmkzQ2a4
         JN7Q==
X-Gm-Message-State: AA6/9RnzzWsVmjWdnO+DYCPKq2v6TnP4BHgyRP3TBDaJKrnXy8pIkCvx5yTSFECdEG+4UfyH
X-Received: by 10.99.61.10 with SMTP id k10mr11202190pga.142.1476900047716;
        Wed, 19 Oct 2016 11:00:47 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:9054:6595:5899:1841])
        by smtp.gmail.com with ESMTPSA id z11sm51364037pfd.49.2016.10.19.11.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2016 11:00:46 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] trailer: allow non-trailers in trailer block
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476466609.git.jonathantanmy@google.com>
 <1b3fe84e4b6126884a801e721d0a93c41fcb4184.1476466609.git.jonathantanmy@google.com>
 <CAGZ79kYLq1qA4_Qg2x5Fiu5AmGBZdozm4zk6K7LkU+uJ1LNUTw@mail.gmail.com>
 <xmqq7f96sa9i.fsf@gitster.mtv.corp.google.com>
 <cb622421-1857-d136-2618-ec62d438790d@google.com>
 <xmqqbmyhr4vt.fsf@gitster.mtv.corp.google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <31cae41d-701c-c657-f04e-3b617c0b1d39@google.com>
Date:   Wed, 19 Oct 2016 11:00:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmyhr4vt.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2016 09:36 AM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>>     * rs/c-auto-resets-attributes:
>>>       pretty: avoid adding reset for %C(auto) if output is empty
>>>
>>> And neither of the two colon containing line remotely resembles how
>>> a typical RFC-822 header is formatted.  So that may serve as a hint
>>> to how we can tighten it without introducing false negative.
>>
>> The only "offending" character is the space (according to RFC 822),
>> but that sounds like a good rule to have.
>
> I suspect that we should be willing to deviate from the letter of
> RFC to reject misidentification.  I saw things like
>
> 	Thanks to: Jonathan Tan <jt@host.xz>
> 	Signed-off-by: A U Thor <au@th.or>
>
> in the wild (notice the SP between Thanks and to), for example.
> Rejecting leading whitespace as a line that does *not* start the
> header (hence its colon does not count) may be a good compromise.

Good point.

>> I think that "Signed-off-by:" is not guaranteed to be
>> present.
>
> But do we really care about that case where there is no S-o-b:?  I
> personally do not think so.

I think we should - the use case I had in mind when I started this is 
the Android Git repository, which does not use Signed-off-by. For 
example, I quoted this commit in an earlier e-mail [1]:

https://android.googlesource.com/platform/frameworks/base/+/4c5281862f750cbc9d7355a07ef1a5545b9b3523

which has the footer:

   Bug: http://b/30562229
   Test: readelf --dyn-sym app_process32 and check that bsd_signal is 
exported
         readelf --dyn-sym app_process64 and check that bsd_signal is 
not exported
   Change-Id: Iec584070b42bc7fa43b114c0f884aff2db5a6858

>> Defining a trailer line as "a line starting with a token,
>> then optional whitespace, then separator", maybe the following rule:
>> - at least one trailer line generated by Git ("(cherry picked by" or
>> "Signed-off-by") or configured in the "trailer" section in gitconfig
>> OR
>> - at least 3/4 logical trailer lines (I'm wondering if this should be
>> 100% trailer lines)
>
> I'd strongly suggest turning that OR to AND.  We will not safely be
> able to write a commit log message that describes how S-o-b lines
> are handled in its last paragraph otherwise.
>
> I do not care too deeply about 3/4, but I meant to allow 75% cruft
> but no more than that, and the fact that the threashold is set at
> way more than 50% is important.  IOW, if you have
>
> 	Ordinary log message here...
>
> 	S-o-b: A U Thor <au@th.or>
> 	[a short description that is typically a single liner
>         in the real world use pattern we saw in the world, but
> 	could overflow to become multi line cruft]
> 	S-o-b: R E Layer <re@lay.er>
>
> "last paragraph" is 5 lines long, among which 60% are cruft that is
> below the 75% threshold, and "am -s" can still add the S-o-b of the
> committer at the end of that existing last paragraph.  Making it too
> strict would raise the false negative ratio.

Ah, sorry, I misread your original suggestion.

Would this work then:
- at least one trailer line generated by Git ("(cherry picked by" or
   "Signed-off-by: ") or configured in the "trailer" section in
   git config AND at least 25% logical trailer lines
OR
- 100% logical trailer lines

The first part is your original suggestion except that I think that it 
is more consistent to allow other trailer lines as well (but I do not 
feel too strongly about this). The second part would satisfy the Android 
Git use case above, and also retain existing behavior when 
"Signed-off-by" (for example) is added to an existing footer that does 
not contain "Signed-off-by" yet.

What do you think?

[1] Message ID <29cb0f55-f729-80af-cdca-64e927fa97c0@google.com>
