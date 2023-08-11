Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA0C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 00:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjHKA7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 20:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjHKA7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 20:59:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D712D7B
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 17:59:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586a5ac5c29so18895597b3.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 17:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691715553; x=1692320353;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOYn4Mr2DocWdeMDYB9hrJ8/MH0ho9dR9/o98fPhhIk=;
        b=muh7XbXUEOEYSKKy879UYNjM1ldnj+ja0oQWZakn7qW5x0/3WFo129I6fMb3udgkAz
         Aj6BTTvWKOl5sDOM+4VW25g63uOP0RfyTJ6TSWpswBJIN8EwngG/5JdGHG/DZOevHmR6
         5HDUL1YxpWVWhdvS5k0MKegmZ5OW5yBOs+C2YG54w9yT7e3FeSPEi3WG1sb8WLeQipxI
         Ge5lRMARX7v0yO/M/8RJpLm+LrfpbtB/4Pm19rH35pIpTwbJw7WbKjvEi8YIHjeQiaKL
         frLC79oLwKazlFCnn7y1huUvxUd+uur2LLLyFxGWxuVWX9qACvjFfWn1nWDghKSZHvsJ
         tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715553; x=1692320353;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOYn4Mr2DocWdeMDYB9hrJ8/MH0ho9dR9/o98fPhhIk=;
        b=TNrc+b96L4VvbcihK2K3iy7KqzO98EmYC4eJjwhjmKN9/wmAuHCvHZqVGWt2sgOXXX
         rtWqhErAhXEHXjJI+hDUGx8uK13qbZVcvoj3HR1AYXrqRZ6GJ4N60yqgv0bxv7RUIYJO
         Q/AZsuu3ZywvG4T6HXLTJaYl41pU9FCuBLoHmrr7trP3bdjsaL5kk0DTMIVGVuUM3GIo
         J0R7CZ9tSe+fn3ZIG76x9W4TC8pGtRBCBJYSK5mff7wcyi+AJUf+nr8RDVFoQDb5hDfg
         FhscH1JihmSolpB+34vQti6ooc6GHf6vdzF1TxFuMUHnQDBB/maEygIHJtgfQqdR6pGs
         Uz9A==
X-Gm-Message-State: AOJu0Yy6mXdbJYTtTD55njwWW/5r5+ANTZN55R3kNbuqKcMFeLBNweht
        3L5AU/JNEPx6diXLmQI3nD3D5cvULwc=
X-Google-Smtp-Source: AGHT+IHxb1zW+nRJTB1buU5FrliPrv0/LGfN1gCrITSxz4CYc7FRvgIeIhzo03QpHxEM75mVS8xkVaMrCW0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:4509:0:b0:586:b4e9:753 with SMTP id
 s9-20020a814509000000b00586b4e90753mr9990ywa.4.1691715553818; Thu, 10 Aug
 2023 17:59:13 -0700 (PDT)
Date:   Thu, 10 Aug 2023 17:59:12 -0700
In-Reply-To: <kl6l1qgea2k0.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <c8bb013662187e9239d4a2499a63ed76daa78d14.1691211879.git.gitgitgadget@gmail.com>
 <kl6l1qgea2k0.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <owlypm3ufl7j.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/5] trailer: split process_command_line_args into
 separate functions
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
>> Previously, process_command_line_args did two things:
>>
>>     (1) parse trailers from the configuration, and
>>     (2) parse trailers defined on the command line.
>
> It parses trailers from two places, but it still only does "one thing",
> in that it only parses trailers.

More precisely, it parses trailers from the command line by first
parsing trailers from the configuration. In other words, parsing
trailers from the configuration (independent of the input string!) is a
required dependency for parsing trailers coming from the command line.

If we take a step back, we need to do 3 things:

   (1) parse trailers from the configuration
   (2) parse trailers from the command line
   (3) parse trailers from the input

I think these three should be separated into separate functions. I think
no one wants to combine all three into one function. And I can't think
of a good enough reason to combine (1) and (2) together either. Hence
this patch.

> I find this equally readable as the preimage, which IMO is adequately
> scoped and commented.

Aside: is "preimage" the status quo before applying the patch?

>> @@ -1070,8 +1075,11 @@ void process_trailers(const char *file,
>>  
>>  
>>  	if (!opts->only_input) {
>> +		LIST_HEAD(config_head);
>>  		LIST_HEAD(arg_head);
>> -		process_command_line_args(&arg_head, new_trailer_head);
>> +		parse_trailers_from_config(&config_head);
>> +		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
>> +		list_splice(&config_head, &arg_head);
>>  		process_trailers_lists(&head, &arg_head);
>>  	}
>
> But now, we have to remember to call two functions instead of just one.

But only inside interpret-trailers.c, right?
