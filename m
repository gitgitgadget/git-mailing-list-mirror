Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7C22047F
	for <e@80x24.org>; Tue,  1 Aug 2017 17:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbdHARfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 13:35:39 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35506 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbdHARfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 13:35:31 -0400
Received: by mail-lf0-f51.google.com with SMTP id t128so10058727lff.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TCzuz12y455KiYunmN+c3XWX7OQicB8zslzn5bDGRxA=;
        b=rey7W35yT7t20I6QW7IBqtiD5UoK8VBurMTRbSIVug5n24l5BmDY9sHDLD4VUTYUjC
         l6zPS0dGx45CiNgjiEsRy+Spzh1/NL09EZzWYhJENB2ZTMWVpRvTB623plv5Lb0vy0sF
         o09r9VMko0dJ9m34m++/QcurpNaI/3L67NQVzJQ5Uegl/hQo92oDSvewd0w6ONokMfq3
         0T9vRnqiF3dT54pQ9FNGe1OdkkcbodguEonszhnfSs0eYfgz6CziZFBZXBEa2i7/cYZl
         fpHWUs1McPfkkJ40zOL1EbarOa/3Vj0ycmkgxHK3h4pO3v3xiVZ5/RFpLyT2xgOlJ8VM
         DqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TCzuz12y455KiYunmN+c3XWX7OQicB8zslzn5bDGRxA=;
        b=SFcA6KSijvE/ErocEabiAFIa33nX2fo84ukxw0I0rHk58LS/wQoyEO9rZgsl4CwpDS
         sMVW6XhHSt1ogW8gxvjXCG4e2SC1AFnpI0VNgkFoMgyMBo0uj9Ju08OzwYZcFSJapUpo
         Tka36hewTILwODdsqzvVUQzLpATYw1RdttnGp0E/3Jv2/8qxoP6O1W014TaBZjh5kbu7
         nuNtTEdeQyC2zJ78Dix8ZwhL054LLVOkf3D2F7Rb2VJDViYKz23WrHeKsIWIW+blDM9M
         5eII0OlDLIdVrmN56kc6F29HJkX3IsTzGx6O0rIKUCZJfC0Gw6QkeVXM/PjrGkf/VFK3
         c4OQ==
X-Gm-Message-State: AIVw113XIrikvMccLvChq1OGliQZPB/871MWyDCnmH+0MCDoGQYed7mq
        GelqthHkp2XdSEBFNfGG4ic14nlUwPBH
X-Received: by 10.25.232.41 with SMTP id f41mr6350474lfh.90.1501608929729;
 Tue, 01 Aug 2017 10:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 1 Aug 2017 10:35:29 -0700 (PDT)
In-Reply-To: <413e4f55-5f8b-a80f-775b-b456c4de8a46@jeffhostetler.com>
References: <20170718190527.78049-4-bmwill@google.com> <20170731231142.15053-1-sbeller@google.com>
 <413e4f55-5f8b-a80f-775b-b456c4de8a46@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Aug 2017 10:35:29 -0700
Message-ID: <CAGZ79kY-H7rWW_h-k4fHXkwqfMJvd8MtGBooNH8J7PaA2Gj1Yg@mail.gmail.com>
Subject: Re: [PATCH] convert any hard coded .gitmodules file string to the MACRO
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 6:14 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 7/31/2017 7:11 PM, Stefan Beller wrote:
>>
>> I used these commands:
>>    $ cat sem.cocci
>>    @@
>>    @@
>>    - ".gitmodules"
>>    + GITMODULES_FILE
>>
>>    $ spatch --in-place --sp-file sem.cocci builtin/*.c *.c *.h
>>
>> Feel free to regenerate or squash it in or have it as a separate commit.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>   submodule.c    | 18 +++++++++---------
>>   unpack-trees.c |  2 +-
>>   2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index 37f4a92872..b75d02ba7b 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>>   @@ -233,18 +233,18 @@ void gitmodules_config(void)
>>                 strbuf_addstr(&gitmodules_path, "/.gitmodules");
>
>
> Did you mean to also change "/.gitmodules" ??

Goog point. We should pick that up as well. However as we do not have
a macro for that, we'd have to have 2 calls to strbuf API

    strbuf_addch(&sb, '/');
    strbuf_addstr(&sb, GITMODULES);

>
>>                 if (read_cache() < 0)
>>                         die("index file corrupt");
>> -               pos = cache_name_pos(".gitmodules", 11);
>> +               pos = cache_name_pos(GITMODULES_FILE, 11);
>>                 if (pos < 0) { /* .gitmodules not found or isn't merged */
>>                         pos = -1 - pos;
>>                         if (active_nr > pos) {  /* there is a .gitmodules
>> */
>
>
> It might also be nice to change the literals in the comments to
> use the macro.

Yes, I wondered if sed would have been better for this job.

>
> Jeff
>
