Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1C720357
	for <e@80x24.org>; Mon, 17 Jul 2017 21:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbdGQVPp (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 17:15:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32990 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdGQVNL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 17:13:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1so182443pgs.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dn8Je6bPTuOvnR834pTSktBP+Y8BHKUsONJpi8/NcK8=;
        b=GxpKnKjz8NpLOz8IxLD0pfljVKz66CCCiSFJe6LAEax+3aTYVvU/G861Oijsz09vFf
         7G52DzL9qpJ80mEfJ4kaEsNyUTM36tAfEVTix0oYkAw2TBJ5kBHh6hzG+sesE6/SOp/z
         6KLD1+xqGg4/aoQMwxu6QI6vZMv36z0SoqWy7UqXNvixSslgL4zLoWiqiNpsEpSHq4ui
         WiG8pzrIYQZ5YQU1VUQuN4lfAwUj8uK3tiEuFl/27rvoPYVQ3vxQYfS1nfDKgaLmfuLk
         b7KKCmsWTUn98cjoq4gbpABmrrDfEsDj25d+Ygwhye6EwfyLshaCuTzGANVoliXEkEw2
         AawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dn8Je6bPTuOvnR834pTSktBP+Y8BHKUsONJpi8/NcK8=;
        b=lbuOBYB83uIEMso+uydksRhE5bbghVD+t2dJQQgdu8JLBGi8/Cuf6701UJjNIhgrOC
         RNZ7wlYlls7AYjjiMwo831BCzcGszSKctlD5y1O5RBUs+m/ALU5thB72ioDqP5hFbmip
         8MxC1IhZk1AznPHRR9u17hk/WlMq88VoxnsjGHuPi71AhzEP6RvqolUxzv+ad+6Y8uPo
         /cumPwSNqpE8WT+UmgKylANYojFwOrLdJjWjW5HmmFPId8QiKwXdZZRdJfiQOegAVIdv
         XWcuO1W6DUPnGmN7etPMvmhTd63eCZfn65OU/8jAvizq6do6fRIg6QSpkHoLZmUIdzIu
         NY+Q==
X-Gm-Message-State: AIVw110t+t+blmBFj3ARzPAKLnGA3Sz8JSd80G3NNCW6Anv22GFBAH2M
        PvRGjl/GcYXHeg==
X-Received: by 10.84.228.214 with SMTP id y22mr6808608pli.245.1500325991006;
        Mon, 17 Jul 2017 14:13:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id u17sm258540pfk.131.2017.07.17.14.13.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 14:13:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Paolo Bonzini <bonzini@gnu.org>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/3] trailers: export action enums and corresponding lookup functions
References: <20170712222116.7095-1-bonzini@gnu.org>
        <20170712222116.7095-3-bonzini@gnu.org>
        <CAP8UFD0LEHDutF83=V9zrDnFKy27dJSrq5DHV-8YV1=y=cPXqg@mail.gmail.com>
Date:   Mon, 17 Jul 2017 14:13:07 -0700
In-Reply-To: <CAP8UFD0LEHDutF83=V9zrDnFKy27dJSrq5DHV-8YV1=y=cPXqg@mail.gmail.com>
        (Christian Couder's message of "Thu, 13 Jul 2017 08:00:22 +0200")
Message-ID: <xmqq379uhin0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Jul 13, 2017 at 12:21 AM, Paolo Bonzini <bonzini@gnu.org> wrote:
>
>> diff --git a/trailer.h b/trailer.h
>> index e90ba1270..f306bf059 100644
>> --- a/trailer.h
>> +++ b/trailer.h
>> @@ -1,11 +1,33 @@
>>  #ifndef TRAILER_H
>>  #define TRAILER_H
>>
>> +enum action_where {
>> +       WHERE_END,
>> +       WHERE_AFTER,
>> +       WHERE_BEFORE,
>> +       WHERE_START
>> +};
>> +enum action_if_exists {
>> +       EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
>> +       EXISTS_ADD_IF_DIFFERENT,
>> +       EXISTS_ADD,
>> +       EXISTS_REPLACE,
>> +       EXISTS_DO_NOTHING
>> +};
>> +enum action_if_missing {
>> +       MISSING_ADD,
>> +       MISSING_DO_NOTHING
>> +};
>
> As these enums are now in trailer.h, maybe more specific names like
> "trailer_action_where" instead of "action_where" would be better.
>
>>  struct trailer_opts {
>>         int in_place;
>>         int trim_empty;
>>  };
>>
>> +int set_where(enum action_where *item, const char *value);
>> +int set_if_exists(enum action_if_exists *item, const char *value);
>> +int set_if_missing(enum action_if_missing *item, const char *value);
>
> "trailer_" should perhaps be added at the beginning of the names of
> the above functions too.

All sensible suggestions.  Thanks.
