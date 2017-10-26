Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851F0202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 17:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbdJZRp7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 13:45:59 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:53400 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdJZRp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 13:45:58 -0400
Received: by mail-qt0-f196.google.com with SMTP id n61so5330597qte.10
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=22Gb4RkdXgZLkOfOEAonmaRZTxEXL6tTbJmNcLYsb2w=;
        b=UvEshI8z2J4Gl3DJizpHgkzMdP5wTPC5XDL4fw8yeHncKWBjMZ4X2kUAbSuLBhFWFZ
         +/YLI5CMLFP58S51Baz/sqWdUInEqdXCFZA27UzmyxxGFpF0zrb6ZSGS9eSI8AvWWVfK
         J+rwhQlrGwimqQUk/PyWhJmGAjKg7dXUS9UnXXUYdnjagG8wTPnfyHsflYVv8AGUhZ3S
         IBY8arlz4ZVM3mb3Wx8oTF3oUs5SI6VLNwuD9dbRI2Ud3MCpMzFdMnhbRwFLYUP3AsFE
         5qZsP+mtBYXrR6lOHpbHyeyKsvF8VkV8AYVQPm2uuSo+8dZ6pdUaqTmcJTUmWm2ZcvV1
         CXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=22Gb4RkdXgZLkOfOEAonmaRZTxEXL6tTbJmNcLYsb2w=;
        b=Xd8DK3dZyJD5X4s0hp6mSp1WXnKzCBcmRib7m2Br6OKDKDN4PEwaPcfds0YdCDLGEU
         sgcvvbgDErELgvSGfw5PXdW/nFeMot0AofmHOqGv2RN97PvhVw30qs/vJQIVlSElXQnu
         f0cD3QHVEK/9/GPkdwgmpuNgtrSuVBgae3MgPj74oStQkb956RmrPapRN6tUDaupow+J
         KYhXdckNmhGhJNN22GDEyUJnzLl7dI5AnRMZ7swszvoyO1i00Q5l7pm0eHDIawMedWI6
         rOmtIR1gqqcK1yNji7HP4AS4lMyQgbwHMY6ykoWXOtY4F30Ejpwh0by5dUTur1aSPVSk
         +95g==
X-Gm-Message-State: AMCzsaXBY55uKYd9blh4NdN9KqFlTCLYYC5CkgMSY8yFUoRv4hPt5nJu
        wWCs/D8uiMvkF5DD2inPvD4LjCC434YlFqhOvKeBVw==
X-Google-Smtp-Source: ABhQp+RI21ZAoUr4gVzsiY+SJrUdQXPJgbRa5dhKj2jkCC5r7b9DjCjwiHQhYjh/FJO0VFCIfWYsqjVIN2w6nu9Btew=
X-Received: by 10.200.40.146 with SMTP id i18mr36864816qti.79.1509039957968;
 Thu, 26 Oct 2017 10:45:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 26 Oct 2017 10:45:57 -0700 (PDT)
In-Reply-To: <1509039696.11245.9.camel@perches.com>
References: <1509030170.10651.59.camel@perches.com> <CAGZ79ka41NdzNxGAvtVW802088KydKkp3yHx=Z5q3Mc9GGa_+g@mail.gmail.com>
 <1509039696.11245.9.camel@perches.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Oct 2017 10:45:57 -0700
Message-ID: <CAGZ79kYWPunzZ2u=MtCoCadxXu_4etEK5DYnhYXo+CgeHrXQwQ@mail.gmail.com>
Subject: Re: grep vs git grep performance?
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 10:41 AM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2017-10-26 at 09:58 -0700, Stefan Beller wrote:
>> + Avar who knows a thing about pcre (I assume the regex compilation
>> has impact on grep speed)
>>
>> On Thu, Oct 26, 2017 at 8:02 AM, Joe Perches <joe@perches.com> wrote:
>> > Comparing a cache warm git grep vs command line grep
>> > shows significant differences in cpu & wall clock.
>> >
>> > Any ideas how to improve this?
>> >
>> > $ time git grep "\bseq_.*%p\W" | wc -l
>> > 112
>> >
>> > real    0m4.271s
>> > user    0m15.520s
>> > sys     0m0.395s
>> >
>> > $ time grep -r --include=*.[ch] "\bseq_.*%p\W" * | wc -l
>> > 112
>> >
>> > real    0m1.164s
>> > user    0m0.847s
>> > sys     0m0.314s
>> >
>>
>> I wonder how much is algorithmic advantage vs coding/micro
>> optimization that we can do.
>
> As do I.  I presume this is libpcre related.
>
> For instance, git grep performance is better than grep for:
>
> $ time git grep -w "seq_printf" -- "*.[ch]" | wc -l
> 8609
>
> real    0m0.301s
> user    0m0.548s
> sys     0m0.372s
>
> $ time grep -w -r --include=*.[ch] "seq_printf" * | wc -l
> 8609
>
> real    0m0.706s
> user    0m0.396s
> sys     0m0.309s
>

One important piece of information is what version of Git you are running,


$ git tag --contains origin/ab/pcre-v2
v2.14.0
...

(and the version of pcre, see the numbers)
https://git.kernel.org/pub/scm/git/git.git/commit/?id=94da9193a6eb8f1085d611c04ff8bbb4f5ae1e0a
