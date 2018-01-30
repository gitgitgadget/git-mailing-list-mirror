Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7A81F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbeA3XVI (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:21:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53097 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeA3XVH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 18:21:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id g1so4496111wmg.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aWhhjUiajiLvoCQRZuKypxO4nyusitL5bdgE4EAqMRc=;
        b=dKjW68UMhlYEqkweeHPnNTKZyd25vc1Z/R4yw0s1Ay4Ewq+cHsI1nk3GRfyRvw48cO
         Pc5zT3l4lGaRmFODQ05T5EtDIy/Me7OUVjfCIGI2CvXRefgIA+1KmrMctx5HvmqLnezq
         xO2q4BDLPhGaCdHXi45Rc7xKl8QzjHMSCe1441sAsNXT4tXn8PKzmJlGU5xfndr5UqF+
         EM+NXgfYaLgs18E0pOX/MfX+A3mBy5Z1Esio2pcA2uXqCUlIrzbmIhrLFGzTUpNjatIz
         vwPHkjs2MuWhG2WXqMRZT2lUlyKRH2Lvve+4spPcnuzC57I3wAZSnVCylQbbAxZ18bRq
         Q3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aWhhjUiajiLvoCQRZuKypxO4nyusitL5bdgE4EAqMRc=;
        b=VCdKcIrBrR6wZwW5L9BxwQs7npGEDpbsIiLWbI2qNnEFf6wTk7MXl7vS4SraUh8Zz3
         a+pP/Badjq4y28Pio4j+3NQIVQ82zlIiyBa0kgJkGpiDaNseCC2F4tNq0043uNwtAVQ8
         VO0eZgvNrMJo/mhLBxnSrZxmApkQng5LWvZhEFy/NDCWVTSFeKL7FEmAgxqMcxbKXM+5
         KPhTvzmzxwZF4P86bdA4yTPX8ASJ9ZIYILK6YKnpHmOlX8TPvyoXUofxF+VFOsYmXShg
         lcZmK1/z7hPjFn0GGtKUZIK/5sNtmeO5Qc/4gd2SsaRt3/ZltTD3onGw/yZLED/8ISbX
         OVcQ==
X-Gm-Message-State: AKwxytembWsXcWuB1nhLqhDI6UKC1GTD02jZgHlgSd5HmCSaEiCmSaSi
        I99Bv+tILvuSeI58G34Ot3I=
X-Google-Smtp-Source: AH8x224NPdQgKEAQwh4d2hjSWNfHFCNOgDWcYnASnBh5C2x1bVz+5vGJ6us1tLyfg5Nl9wqqyNAXgg==
X-Received: by 10.28.148.150 with SMTP id w144mr21475973wmd.0.1517354466208;
        Tue, 30 Jan 2018 15:21:06 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d17sm12816156wrc.19.2018.01.30.15.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 15:21:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 37/37] replace: rename 'new' variables
References: <20180129223728.30569-1-bmwill@google.com>
        <20180129223728.30569-38-bmwill@google.com>
        <CAGZ79kYwOc3vMsj8DWyNtudM-OBzyw8iTEfKK3nnOJM23GF78A@mail.gmail.com>
Date:   Tue, 30 Jan 2018 15:21:04 -0800
In-Reply-To: <CAGZ79kYwOc3vMsj8DWyNtudM-OBzyw8iTEfKK3nnOJM23GF78A@mail.gmail.com>
        (Stefan Beller's message of "Tue, 30 Jan 2018 14:58:46 -0800")
Message-ID: <xmqq372nrl0f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jan 29, 2018 at 2:37 PM, Brandon Williams <bmwill@google.com> wrote:
>> Rename C++ keyword in order to bring the codebase closer to being able
>> to be compiled with a C++ compiler.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  builtin/replace.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index 42cf4f62a..e48835b54 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -284,7 +284,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
>>  {
>>         char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
>>         enum object_type type;
>> -       struct object_id old, new, prev;
>> +       struct object_id old, new_oid, prev;
>
> new is a keyword that often comes with a counterpart, here `old`.
> So while at it, also rename old to old_oid ?
> Do we care about the symmetry enough to warrant additional churn for this?

Absolutely.  That is one of the reasons why the "hacky" approach is
so attractive---it does not force those who are doing conversion to
think.  With this approach, "new" in this context gets replaced with
new_oid (because this is about oid; in another codepath, "new" and
"old" might have been referring to a file and the new names for them
would have been "new_file" vs "old_file") after some thought, and
the same thought process should realize "old" must become "old_oid".

Very good point.
