Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3191F42D
	for <e@80x24.org>; Tue, 17 Apr 2018 19:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeDQTEW (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:04:22 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:34324 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeDQTEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:04:21 -0400
Received: by mail-yb0-f172.google.com with SMTP id b14-v6so8998067ybk.1
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OUGfCQNm3Sjy5uX+7FfM2dnvJ6LY4u3af2tvM4GamRI=;
        b=AC4a1oPLqScNAMpyWHB9aPkIJxgHsaRK+9hCKhfHs2gBOvrgNGWDXNeNsol5iipEzr
         3xAVIwlAYFnVvWGdSX5Q7pDHQYkTzggmHKhVqcU2W9F0dPYqeHObsXFDU1IxMN0IOHJo
         otoDHss0Nfz/+VshlVYOC/4bHwGwPbxjBmCu7XvCuY5roUPXp0yZT9RVmOaW4FxkIclt
         x+WPk90sKIbiM7GwYb2CZnXY90vl5SRqsDQ6gh+4uehVv+pNI3s6T9NmI8iz4nV6yAaa
         8/DMLF6pBr6/D7LbNSm1f8RAmwN78gQdEQlMLRTjDcmEPIp+KB//7HhzfkIQw+dTNcD0
         t66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OUGfCQNm3Sjy5uX+7FfM2dnvJ6LY4u3af2tvM4GamRI=;
        b=QCIFWf2VDu1U5klLxLKcbmqQmJzkjCLwYhtWHL6qUYCV6eAd/Hzh4mb8r2yJC/Tk24
         zNtk2a4XQGs7S5UuULgLUt5BBix2TxvHNPO3LpKkNbPdQ/JU1rHg75SFflruNHHb6IyL
         Eu2tRfXH+5OqBDY+i1ct9hLeXXIxX42jbZUUMDYkaSYqfzNKBLy1/crFuzrdz6XwosO1
         CS/Fbk5LLSABaM692kjlumIuFRxKGslto9sFsMcFE1sSuQKSTyy+IskhePBhKxxFNZZS
         Q8jBqhJ4gdfgqtt2K+WNYDi2FUt5pt+Mkp1HVqW1L1PO0mrfE5r2ME+iZKzHYHFFPdye
         ODxg==
X-Gm-Message-State: ALQs6tAp0jP9vtgYnxTPv6zCYzRUN4rR0cPJwA0y49fCg/l2d3/lmjp7
        UTz/507klhrDRj8pojZLjptC+Q2u7F1mTITy21cmJg==
X-Google-Smtp-Source: AIpwx48hyO/B0/PMjsbmkCY+SMGXjwAajvDYT1Z5Ku9j/GfcRV8EwwFHZh/IMZYnt2VtXk6bMkglmV53PQ7+0UsOLbo=
X-Received: by 2002:a25:fc16:: with SMTP id v22-v6mr2482631ybd.247.1523991860636;
 Tue, 17 Apr 2018 12:04:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 12:04:20
 -0700 (PDT)
In-Reply-To: <xmqqk1t6v7w4.fsf@gitster-ct.c.googlers.com>
References: <20180416220955.46163-1-sbeller@google.com> <20180416220955.46163-2-sbeller@google.com>
 <xmqqk1t6v7w4.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Apr 2018 12:04:20 -0700
Message-ID: <CAGZ79kafDRFbeUXLdjM6TpA5xzPct95PJev1rm8CMaYp2d=W5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] builtin/blame: dim uninteresting metadata lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

>> -#define OUTPUT_SHOW_SCORE      0100
>> -#define OUTPUT_NO_AUTHOR       0200
>> +#define OUTPUT_SHOW_SCORE    0100
>> +#define OUTPUT_NO_AUTHOR     0200
>
> I wondered what these are about; they are about aligning with HT
> assuming 8-place tab stop like the other lines.

correct.

>> -#define OUTPUT_LINE_PORCELAIN 01000
>> +#define OUTPUT_LINE_PORCELAIN        01000
>
> But then this line has SP plus HT here; it should have been just a
> single HT (i.e. replace a single SP with HT), to be consistent.

fixed

>> @@ -384,6 +388,19 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>>               char ch;
>>               int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
>>
>> +             if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
>> +                     if (opt & OUTPUT_COLOR_LINE) {
>> +                             if (cnt > 0) {
>> +                                     color = repeated_meta_color;
>> +                                     reset = GIT_COLOR_RESET;
>> +                             } else  {
>> +                                     color ="";
>
> You need a SP after '=' that assigns an empty string to 'color'.
>
>> +                                     reset = "";
>> +                             }
>> +                     }
>> +                     fputs(color, stdout);
>> +             }
>
> This fputs() should be hidden to the case where color is *NOT* an
> empty string, no?  In any case, it should be inside "if color-line
> is in effect" block, I would think.
>
> Users of "git annotate" would not pass the --color option, so I do
> not think the outer if () block is worth the loss of readability due
> to increased indent level.
>
> I would say that it is a job of the caller of git_config() to make
> sure color.blame.lines would not take effect when the command is
> annotate, if what you are worried about is the configuration in this
> code.

ok, so we'll have to correct these mis aligned configs before hand and
here we just go by the bits set in the flags.

>> @@ -949,8 +979,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>>
>>       blame_coalesce(&sb);
>>
>> -     if (!(output_option & OUTPUT_PORCELAIN))
>> +     if (!(output_option & OUTPUT_PORCELAIN)) {
>>               find_alignment(&sb, &output_option);
>> +             if (!*repeated_meta_color &&
>> +                 (output_option & OUTPUT_COLOR_LINE))
>> +                     strcpy(repeated_meta_color, GIT_COLOR_DARK);
>> +     }
>
> This code does not check OUTPUT_ANNOTATE_COMPAT because it assumes
> that OUTPUT_COLOR_LINE won't be in output_option when we are working
> in annotate compatibility mode.  The deeper codepaths we saw above
> should do the same.  It should be enough to drop color-line when
> anno-compat is set, or something like that, immediately after
> reading the config and overriding them from the command line.

Makes sense.

>
>> diff --git a/color.h b/color.h
>> index cd0bcedd08..196be16058 100644
>> --- a/color.h
>> +++ b/color.h
>> @@ -30,6 +30,7 @@ struct strbuf;
>>  #define GIT_COLOR_BLUE               "\033[34m"
>>  #define GIT_COLOR_MAGENTA    "\033[35m"
>>  #define GIT_COLOR_CYAN               "\033[36m"
>> +#define GIT_COLOR_DARK               "\033[1;30m"
>>  #define GIT_COLOR_BOLD_RED   "\033[1;31m"
>>  #define GIT_COLOR_BOLD_GREEN "\033[1;32m"
>>  #define GIT_COLOR_BOLD_YELLOW        "\033[1;33m"
>
> I wonder if it is worth adding a new color only to give this a
> different default.
>
> Traditionally, we use CYAN for lines that are less interesting than
> others (e.g. hunk header), so reusing it might make the life easier
> to the users, especially because I envision that we may want to
> introduce another "logical" level to give another redirection
> between the configuration keys like color.diff.frag and
> color.blame.repeatedlines and the actual ANSI sequence like
> "\033[36m".  I.e. we update the system so that these two
> configuration keys take "uninteresting" (which is one of the
> "logical" colors) by default, and then map "uninteresting" to
> "\033[36m" at the physical level by default.  The users could then
> change the mapping from "uninteresting" to "\033[1;30m" and
> consistently modify both diff.frag and blame.repeated if they wanted
> to.  Of course, if they want them to be different, they can come up
> with a different "logical" color and split the two.  And from that
> point of view, adding new colors to the default set we have above
> will make life harder for the end users.

That is a good longer term vision. I'll switch to cyan for now.
Thanks,
Stefan
