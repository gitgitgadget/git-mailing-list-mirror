Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A56C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiHJQzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiHJQzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 12:55:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5922983B
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 09:55:40 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id ix21-20020a170902f81500b0016ee5379fe5so10091419plb.18
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=RvrYeuky0YLbkMfl9LNWdOn4ftRDlUAY4/Oa5NV+iTo=;
        b=j3RRruS/ZhkVfJFJaO0x/Xe1tvxl94/c15JKf9pHYXFgHTHyzB3noT0m1GzklsDq7x
         x/3cbDulcYD5IGEQYSwtxoeVoqsHaz4aGpntmGoNeM8hqdfM37aRnK91xDKDp9TJ/YOC
         xMGKtrc1DXPD+W+RsilORjG1pBZ5cx2n9JSRnYFyNu6UVc7mSjoRq+r1lZBvBxsYI9CO
         rmEWIeMfcB++qIvw3dXbJP9kLUfwPWpEcRGUlTl54+99NJvU4OJlla2htE4+Jj8zSnR5
         iJwhcJx8/p0VYnjXYcZYLNjY4Li/JJTpreQD9kDj15UoBMqV7kU0ob5UPdjL9dbdQ3u2
         jzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=RvrYeuky0YLbkMfl9LNWdOn4ftRDlUAY4/Oa5NV+iTo=;
        b=5/stwVhQ6gE9rhifY5qupaD3NPs4+IGhIyVpHflnic80SAvZ/76rztNFihPtOoHZ8u
         ujRc2qQDzqKtEcbJACCSHD/wGKmKACBfbUYonFOwai4ljLyW1ihscxxeXkbfA82FqAqk
         pJeT/QftjKdq63SNArCkuCfrbNnNWIEZL8RiXq1zzOhq48KH0jZjdos5VXP8dzIkhEnl
         gLU5eG4tFumO0O0iXh1XF5dRFBXazWEOq8YcMIzP+kX468dQfRXcuXh4Lw6LTts7/jgj
         MONUltrlGEgdX5l3Jq1XBUv5oawvbwILSAsmgSdrMxVuFwBGjPEBaHI2HoVWnQnnKisn
         sKWA==
X-Gm-Message-State: ACgBeo3x8HBXO8egGk0WlBheEVTE1Ue8uFuAWEIrmwem7PBlAHQbIK3L
        Tm+wljlD7Ftuv+6IwMNAkg2agCn7jTS5ww==
X-Google-Smtp-Source: AA6agR7BZbCPenQbO+9nNgSqBjRYvDsS4bECbHi/f1V7cfYA2EZ8PFcfGuCg+lvgT8p1gVN+7PUcnLQjUs0F9w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:d206:0:b0:41c:1903:1c74 with SMTP id
 a6-20020a63d206000000b0041c19031c74mr23518960pgg.391.1660150539717; Wed, 10
 Aug 2022 09:55:39 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:55:38 -0700
In-Reply-To: <CAMP44s2z1FC-3T0X39aT5WTq2aFGph_-iVz-yJtTN6VpG-qdzA@mail.gmail.com>
Message-Id: <kl6l5yj0qbqt.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1304.git.git.1659387885711.gitgitgadget@gmail.com> <CAMP44s2z1FC-3T0X39aT5WTq2aFGph_-iVz-yJtTN6VpG-qdzA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-reflog: remove unneeded \ from \{
From:   Glen Choo <chooglen@google.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Aug 1, 2022 at 4:04 PM Glen Choo via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Glen Choo <chooglen@google.com>
>>
>> There are some inconsistencies with how different asciidoc environments
>> handle different combinations of "\{<>}", e.g. these results were
>> observed with asciidoc on two different environments:
>>
>>   | Input     | Output (env A) | Output (env B)   | same/different |
>>   |-----------+----------------+------------------+----------------|
>>   | \{<foo>\} | {&lt;foo&gt;}  | \{&lt;foo&gt;}^M | different      |
>>   | {<foo>}   | {&lt;foo&gt;}  | {&lt;foo&gt;}    | same           |
>>   | \{<foo>}  | {&lt;foo&gt;}  | \{&lt;foo&gt;}^M | different      |
>>   | \{foo\}   | {foo}          | {foo}            | same           |
>>   | \{\}      | {}             | \{}^M            | different      |
>>   | \{}       | {}             | {}               | same           |
>>   | {\}       | {}             | {}               | same           |
>>
>> The only instance of this biting us is "@\{<specifier>\}" in
>> Documentation/git-reflog.txt; all other combinations of "\{<>}" (e.g. in
>> Documentation/revisions.txt) seem to render consistently.
>
> So, I did some investigation. {} are used for attributes, if you do
> {manversion} that will be replaced by the manversion attribute (which
> we are setting), but if you do {foobar} (an attribute that doesn't
> exist) different implementations will do different things, what you
> should do is \{foobar} as that's how the documentation says you should
> escape attributes [1].
>
> In 552cecc214 (Teach "git reflog" a subcommand to delete single
> entries, 2007-10-17) it was {specifier} which could have been an
> attribute and thus should be quoted, but in 49cbad0edd (doc: express
> grammar placeholders between angle brackets, 2021-11-06) it was
> changed to {<specifier>} and that apparently cannot be an attribute,
> so it should not be quoted.

Aha! Thanks! I'm glad that there's a satisfying explanation for all of
this :)

>
> We shouldn't be using verses for this kind of stuff though, since we
> want the whole thing displayed as-is, it's better to use literal
> blocks [2], but that's a bigger change.
>
> For now it should be:
>
>   @{<specifier>}
>
> So the patch is correct. ACK.
>
> Cheers.
>
> [1] https://docs.asciidoctor.org/asciidoc/latest/attributes/reference-attributes/
> [2] https://docs.asciidoctor.org/asciidoc/latest/verbatim/literal-blocks/
>
> -- 
> Felipe Contreras
