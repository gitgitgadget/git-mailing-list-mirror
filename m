Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF34C001DE
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 00:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHKAlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 20:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHKAlj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 20:41:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9592D2D52
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 17:41:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5868992ddd4so19265187b3.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 17:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691714498; x=1692319298;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmqwBZVQ37BfxVU8d9uzKY9DOzVloZCcX057zQArxw4=;
        b=chtQzopNIJqJXCvU12okN5CLrNR6bcSuYufB/JP3ha2ilhrdJC6GNJmbuBZByrDk9Q
         CqIRufv/fHLB2GGTLBf//md6G+NmR7XT1MTCFBEco5XWTmZhd2nCxezs0ll+DnXmn5HB
         rfg28DoUZBVqp9pFVYoyj4Q9Cd1vtzJkfsGHjYMHhDsMl2H3JUsiL8pRDf6GQtXoyWrL
         UufKU+nJdvNf/BJciLtfBTPZLpN8OpLdccornFWh3dMnNh4CESzYrw/9kg7PBJA7MhV1
         xhPDlRACj1oMNVd7fsixWaKdXfx7dfpRij53/1V6UHD8ZZiGsLPk6sQgzVLJdDu87shq
         adAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691714498; x=1692319298;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmqwBZVQ37BfxVU8d9uzKY9DOzVloZCcX057zQArxw4=;
        b=XHrzevwwPFbM1uRhwmjMaOovu5rL8Y5hUbnLLnR/r69MCR2AiS7L19UJw4y50WZPsl
         an+Ltkv3wQSD8sgnfCV4+HxuVeXJ7L4SzSQrIKRjjC/9SJ6fi+YUEXv+nPIBDCdjCp59
         vQki60/eykwQCgo8T2d9xwPT9O69rYatHTy0jLOaEQ5gqtCEL4psEEPyMUDWytjT/zrm
         5UZTZjaT4TB28T1R+qC9/OuAZuRApL0NXuQfeJbwpqfIMYWj1zXig9XblAkpY7m9TqKX
         1BYhVYuxB4BT0JnOxuTt60whcpxJgszWDBT4nLrtpTPkWb5NgBPuUIWP+1XV2ekx7fsr
         a8Ug==
X-Gm-Message-State: AOJu0YwNTcSncDYAEuv2dhmvjy5YlSJEV1fT3Uojv2mK+gOag05g3BWX
        tuRM2V3GQ4AurdrvoM8FxkxCWQTaAFE=
X-Google-Smtp-Source: AGHT+IGSIMK1y2uiS9F9bShkbHG2Zi3XT5VIspUni+sws3DubRYSLa1SWRNS0M43XLkab9GlDz6uXoeAkEw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:4c7:b0:d62:60e3:2387 with SMTP id
 v7-20020a05690204c700b00d6260e32387mr6288ybs.1.1691714497925; Thu, 10 Aug
 2023 17:41:37 -0700 (PDT)
Date:   Thu, 10 Aug 2023 17:41:36 -0700
In-Reply-To: <kl6l5y5qa34v.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <d023c297dcac0bb96f681dc1fc0116a649c2efec.1691211879.git.gitgitgadget@gmail.com>
 <kl6l5y5qa34v.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <owlyttt6fm0v.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 2/5] trailer: split process_input_file into separate pieces
From:   Linus Arver <linusa@google.com>
To:     Glen Choo <chooglen@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Currently, process_input_file does three things:
>>
>>     (1) parse the input string for trailers,
>>     (2) print text before the trailers, and
>>     (3) calculate the position of the input where the trailers end.
>>
>> Rename this function to parse_trailers(), and make it only do
>> (1).
>
> [...]
>
> Is there some additional, unstated purpose behind this change besides
> "move things around for readability"? E.g. do you intend to move
> parse_trailers() to a future trailer parsing library? If so, that would
> be useful context to evaluate the goodness of this split.

I think it's still too early to say whether certain functions will make
it (unmodified) into the public, libified API. So currently "move things
around for readability" is the most concrete reason.

>> The caller of this function, process_trailers, becomes responsible
>> for (2) and (3). These items belong inside process_trailers because they
>> are both concerned with printing the surrounding text around
>> trailers (which is already one of the immediate concerns of
>> process_trailers).
>
> I agree that (2) doesn't belong in parse_trailers(). OTOH, (3) sounds
> like something that belongs in parse_trailers() - you have to parse
> trailers in order to tell where the trailers start and end, so it makes
> sense for the parsing function to give those values.

I don't think (3) should belong in parse_trailers, mainly because the
"info" struct we pass into it gets this information populated by
parse_trailers already. Which is why we can do (3) in the caller with

    parse_trailers(&info, sb.buf, &head, opts);
    trailer_end = info.trailer_end - sb.buf;

to get the same information. Also, the endpoint of the trailers is no
more inherently special than, for example, the following other possible
return values:

- the number of trailers that were recognized and parsed
- whether we encountered any trailers or not
- the start position of when we first encountered a trailer in the input

which makes me want to avoid returning this "trailer_end" value from
parse_trailers.

One more thing: we already have a function named "find_trailer_end"
which is supposed to do this already. But it uses "ignore_non_trailer"
from commit.c (that function should probably use the trailer API later
on to figure this out...). I wanted to clean that part up in the future
as part of libifcation.

>> -static size_t process_input_file(FILE *outfile,
>> -				 const char *str,
>> -				 struct list_head *head,
>> -				 const struct process_trailer_options *opts)
>> +/*
>> + * Parse trailers in "str" and populate the "head" linked list structure.
>> + */
>> +static void parse_trailers(struct trailer_info *info,
>
> "info" is an out parameter, and IIRC we typically put out parameters
> towards the end. I didn't find a callout in CodingGuidelines, though, so
> idk if this is an ironclad rule or not.

I wanted to minimize churn as much as possible (hence my hesitation with
changing around the order of these parameters). But also,
trailer_info_get uses "info" as the first parameter, so I wanted to
align with that usage.

>> @@ -1003,9 +998,7 @@ static size_t process_input_file(FILE *outfile,
>>  		}
>>  	}
>>
>> -	trailer_info_release(&info);
>> -
>> -	return info.trailer_end - str;
>> +	trailer_info_release(info);
>>  }
>>
>
> Even though "info" is a pointer passed into this function, we are
> _release-ing it. This is not an umabiguously good change, IMO. Before,
> "info" was never used outside of this function, so we should obviously
> release it before returning. However, now that "info" is an out
> parameter, we should be more careful about releasing it.

Hmm, agreed.

> I don't think
> it's obvious that the caller will see the right values for
> info.trailer_end and info.trailer_start, but free()-d values for
> info.trailers, and a meaningless value for info.trailer_nr (since the
> items were free()-d).

Agreed. Will update to avoid calling trailer_info_release() inside
parse_trailers() because the caller might still need that information. I
think the fix is to move the trailer_info_get outside to the caller,
much like how format_trailers_from_commit() does it.

> I think it might be better to update the comment on parse_trailers()
> like so:
>
>   /*
>    * Parse trailers in "str", populating the trailer info and "head"
>    * linked list structure.
>    */
>
> and make it the caller's responsibility to call trailer_info_release().
> We could move this call to where we "free_all(head)".

SGTM. (I regret not reading this text before drafting my response above.)

>>  static void free_all(struct list_head *head)
>> @@ -1054,6 +1047,7 @@ void process_trailers(const char *file,
>>  {
>>  	LIST_HEAD(head);
>>  	struct strbuf sb = STRBUF_INIT;
>> +	struct trailer_info info;
>>  	size_t trailer_end;
>>  	FILE *outfile = stdout;
>>
>> @@ -1064,8 +1058,16 @@ void process_trailers(const char *file,
>>  	if (opts->in_place)
>>  		outfile = create_in_place_tempfile(file);
>
> Thinking out loud, should we move the creation of outfile next to where
> we first use it?

Not sure what you mean here. Can you clarify?

>> +	parse_trailers(&info, sb.buf, &head, opts);
>> +	trailer_end = info.trailer_end - sb.buf;
>> +
>>  	/* Print the lines before the trailers */
>> -	trailer_end = process_input_file(outfile, sb.buf, &head, opts);
>> +	if (!opts->only_trailers)
>> +		fwrite(sb.buf, 1, info.trailer_start - sb.buf, outfile);
>
> I'm not sure if it is an unambiguously good change for the caller to
> learn how to compute the start and end of the trailer sections by doing
> pointer arithmetic,

I think a future cleanup (in a follow-up series) involving
find_trailer_end should simplify this area and avoid the need for
pointer arithmetic in the caller.

> It feels a bit non-obvious that trailer_start and trailer_end are
> pointing inside the input string. I wonder if we should just return the
> _start and _end offsets directly instead of returning pointers. I.e.:
>
>    struct trailer_info {
>      int blank_line_before_trailer;
>  -  /*
>  -   * Pointers to the start and end of the trailer block found. If there
>  -   * is no trailer block found, these 2 pointers point to the end of the
>  -   * input string.
>  -   */
>  -   const char *trailer_start, *trailer_end;
>  +   /* Offsets to the trailer block start and end in the input string */
>  +   size_t *trailer_start, *trailer_end;
>
> Which makes their intended use fairly unambiguous. A quick grep suggests
> that in trailer.c, we're roughly as likely to use the pointer directly
> vs using it to do pointer arithmetic, so converging on one use might be
> a win for readability.

Agreed! I would prefer to use offsets everywhere, as I think that is
more direct (because we are concerned with locations in the input).
