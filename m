Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5BC61F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 20:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbfJNU2g (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:28:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36786 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbfJNU2g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:28:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so27279325qtf.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bHopzwp+yq5dpd6AlMytaABooKtuAm/6U0IhnOniLdg=;
        b=fSKY90yQjIcTQ/pfrqu5CPFnxH5YpUUtDcDbzrwcUFIq1qv3GAChJrb6M2D7gNuy1+
         mV3NRa/c/En7cl0PZSpr//m+s3EcoGtlUu1Xfc1IKRhgO5A+2QCn/Tn07RnpT5YjxJcy
         U1BcManY2Z85Ojyish13n0+xusb6hNuYLVeH5jJTvqi3Kef5gu93HxGm7+hecnlpEE39
         vWGgLKDhOT0r10VVw/OCMylYOm1MSDOhyv1QRVhXj13rQvfgLNXmu7jXhLxoJzwbe+kd
         IwhlVWFB/XkGm0AfjpY3gUDYZ4Y+9DUeV9DdB4+xHYBAKdTV1hFxyboOXrXOhdeel3PG
         ylyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHopzwp+yq5dpd6AlMytaABooKtuAm/6U0IhnOniLdg=;
        b=cFEV6PIfPe0zi9GFRqm8Zyn+7hPuBvUu9DC+9bPge99PX7H7trphgA2Vh+rZDsZ0MA
         7A/7JRKKlJEcF6mVAoYpF0y1Cm1gjHXUZEp4nkG/7dFrU61mOXRxPR03Pq/cQTeux9L9
         Z32vkJG6eIdCoFMLhSkUh2FOGZySy7hjpxqrp9ydDqw1W0UONGjIayaY7aRfhI/yT3yx
         w1D2u9m1+vTg+5RcOCaBhcPS951r3A/ZGdP9I8IATyGMjijYNcY2lXpFr/vRuXP6EXtC
         BhtRdqr2fUoqeOBErEccOwfj9qsTW7+T0pI3NAv9+CLU24mGxszN5p89fiSzJw6G9uJF
         aI2Q==
X-Gm-Message-State: APjAAAX1waBiO6KZKrYxTwCe0U1ZbvYtpCkozSTBR3vb3FP7fUwM5Ps5
        IzJ9pZWrvvy4l8KyWxQo1zvhMUUXzFY=
X-Google-Smtp-Source: APXvYqyzUfSl2dP+pPw+Z5eBFBfxHZAKmtix4sAxSOwDn7m+lFQ7SLOYBXdX3aL8r/a6aX2KGvF6CA==
X-Received: by 2002:a0c:ef85:: with SMTP id w5mr33233384qvr.159.1571084914814;
        Mon, 14 Oct 2019 13:28:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4807:bd77:fc97:8ac8? ([2001:4898:a800:1012:f93a:bd77:fc97:8ac8])
        by smtp.gmail.com with ESMTPSA id a72sm8538162qkg.77.2019.10.14.13.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 13:28:34 -0700 (PDT)
Subject: Re: [PATCH v3 05/17] sparse-checkout: add '--stdin' option to set
 subcommand
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
 <pull.316.v3.git.gitgitgadget@gmail.com>
 <0b1ed06bc8c27650086b10b587df943d3053b773.1570478905.git.gitgitgadget@gmail.com>
 <CABPp-BHc+iUq9NtTL4Mn1U-DhMmV2nX-_OTJr-Ltc7c3xDV-Ow@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d961532-0d9a-2e7f-a2b9-a05d09ef7c83@gmail.com>
Date:   Mon, 14 Oct 2019 16:28:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHc+iUq9NtTL4Mn1U-DhMmV2nX-_OTJr-Ltc7c3xDV-Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2019 6:27 PM, Elijah Newren wrote:
> On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The 'git sparse-checkout set' subcommand takes a list of patterns
>> and places them in the sparse-checkout file. Then, it updates the
>> working directory to match those patterns. For a large list of
>> patterns, the command-line call can get very cumbersome.
>>
>> Add a '--stdin' option to instead read patterns over standard in.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  builtin/sparse-checkout.c          | 40 ++++++++++++++++++++++++++++--
>>  t/t1091-sparse-checkout-builtin.sh | 27 ++++++++++++++++++++
>>  2 files changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 52d4f832f3..68f3d8433e 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -145,6 +145,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
>>         char *sparse_filename;
>>         FILE *fp;
>>
>> +       if (!core_apply_sparse_checkout) {
>> +               warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
>> +               warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
>> +       }
>> +
>>         sparse_filename = get_sparse_checkout_filename();
>>         fp = fopen(sparse_filename, "w");
>>         write_patterns_to_file(fp, pl);
>> @@ -154,16 +159,47 @@ static int write_patterns_and_update(struct pattern_list *pl)
>>         return update_working_directory();
>>  }
>>
>> +static char const * const builtin_sparse_checkout_set_usage[] = {
>> +       N_("git sparse-checkout set [--stdin|<patterns>]"),
>> +       NULL
>> +};
>> +
>> +static struct sparse_checkout_set_opts {
>> +       int use_stdin;
>> +} set_opts;
>> +
>>  static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>>  {
>>         static const char *empty_base = "";
>>         int i;
>>         struct pattern_list pl;
>>         int result;
>> +
>> +       static struct option builtin_sparse_checkout_set_options[] = {
>> +               OPT_BOOL(0, "stdin", &set_opts.use_stdin,
>> +                        N_("read patterns from standard in")),
>> +               OPT_END(),
>> +       };
>> +
>>         memset(&pl, 0, sizeof(pl));
>>
>> -       for (i = 1; i < argc; i++)
>> -               add_pattern(argv[i], empty_base, 0, &pl, 0);
>> +       argc = parse_options(argc, argv, prefix,
>> +                            builtin_sparse_checkout_set_options,
>> +                            builtin_sparse_checkout_set_usage,
>> +                            PARSE_OPT_KEEP_UNKNOWN);
> 
> Does this mean users can also spell it 'git sparse-checkout --stdin
> set', instead of the expected 'git sparse-checkout set --stdin'?

No, because the parse_options() inside cmd_sparse_checkout() parses until
it doesn't recognize an option. ('stdin' in your example). After we "consume"
the subcommand "set", we call this method and the parse_options() can then
read the '--stdin'.

Here is the output from my local command of 'git sparse-checkout --stdin set'
at this commit:

	$ ./git sparse-checkout --stdin set
	error: unknown option `stdin'
	usage: git sparse-checkout [init|list|set] <options>

Thanks,
-Stolee
