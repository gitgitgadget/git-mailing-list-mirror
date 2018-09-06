Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C141F404
	for <e@80x24.org>; Thu,  6 Sep 2018 15:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeIFTqG (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:46:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39088 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbeIFTqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:46:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so11684285wmq.4
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oMvJO5qQFAvZXJq3mOxijdF7xUy5617Ij4P32mRJpvk=;
        b=erKfeUz8fw/QcDQ8Ny68FS3cmulceLnKYK7Jx8KkSpcghe7kxzrFSIpKGhVeYKTa7j
         hoZ4Sge5RorIzevdg1W+psPjaHaxPdlDcX3eJKKHIkpph4nSQNgsRxcMDQDJUug0z6Uw
         g6InEf8piinx95NmcarIy5Qd+ZdR7wuIR7JUM/2wZCIpeJ1jcDObUX+pjbxEYaxzr6Ua
         U+DBR13Wod7+g8BQ5cNQ37C8PP917PoAPyLCu+CmANOfbPcn9uoIU3NeEzhY8xeRpLkv
         4P3SZ0SuEcTK9iuzt1tu/lsSB3d92BX7OkKuHVJG6x24F4/EuCzkmWB5mmfo6bqxLTxu
         ipJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oMvJO5qQFAvZXJq3mOxijdF7xUy5617Ij4P32mRJpvk=;
        b=VWZnRxuNqQ2KmqZYTXJpJpOcrRFxlrQzsrjVQgWkd7oQaGAKxiLdxFOh/up3nJFLew
         vPgBfOF7WEdfpIHsaYoNl4avPxAkp/0IlHLL9Ng75/pn6EYNo7L+G+X+07/+xu98u7yh
         AWfuoxmLL9yyr8PGSZSemHslAHYJDUr4BLnAKTDk7PMzXvOGgfq8mzfVyqN9yAeKCcGK
         kSSQ0Tq20cyggMYNC6SK3nPx+Kdp8NDsVXPdZD8dsO2WRK0T6BBYONA5xfJlQxkczyr4
         p5rUdmgl45paABbPIieoxn60L4CFsb0c2qH3W3g/F/KJCv7/QhhPjs45OtePraNQFCEx
         +u3w==
X-Gm-Message-State: APzg51A01m+9XFvzn+eZMTn9IKUZebIkxdHZ0ivePw1NYBNkq5c60cc4
        UOM76PYtbrhmPofpECmVbpw=
X-Google-Smtp-Source: ANB0VdZ3Cwq527lfoin5a9mrztG75svxUCD4mxnajqSdHfvejsvn8Ku5moUyOhEbiBwLEk8a4W+Qeg==
X-Received: by 2002:a1c:8291:: with SMTP id e139-v6mr2619775wmd.39.1536246606139;
        Thu, 06 Sep 2018 08:10:06 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id n15-v6sm3124332wrm.27.2018.09.06.08.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 08:10:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Tim Schumacher <timschumi@gmx.de>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v3] Allow aliases that include other aliases
References: <20180905085427.4099-1-timschumi@gmx.de> <20180906101658.1865-1-timschumi@gmx.de> <87pnxqrags.fsf@evledraar.gmail.com> <20180906145708.GA1209@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180906145708.GA1209@sigill.intra.peff.net>
Date:   Thu, 06 Sep 2018 17:10:04 +0200
Message-ID: <87musur7ar.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, Jeff King wrote:

> On Thu, Sep 06, 2018 at 04:01:39PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> If we don't have some test for these sort of aliasing loops that fails
>> now, we really should add that in a 1/2 and fix it in this patch in 2/2.
>
> Yes, I'd agree that this is worth adding a test (especially if the
> output routines get more complex).
>
>> That makes sense from an implementaion perspective, i.e. we lookup "bar"
>> twice. But let's do better. If I have aliase like:
>>
>>     a = b
>>     b = c
>>     c = d
>>     d = e
>>     e = c
>>
>> It should be telling me that my "e" expansion looped back to the "c = d"
>> expansion. Here's a patch to implement that, feel free to either squash
>> it in with my Signed-Off-By, or tacked onto a v4 version of this,
>> whichever you think makes sense:
>
> I don't have a strong opinion on whether this is worth it, but I think
> your implementation could be a little simpler:
>
>> diff --git a/git.c b/git.c
>> index 64f5fbd572..38f1033e52 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -692,8 +692,64 @@ static int run_argv(int *argcp, const char ***argv)
>>  		/* .. then try the external ones */
>>  		execv_dashed_external(*argv);
>>
>> -		if (string_list_has_string(&cmd_list, *argv[0]))
>> -			die(_("loop alias: %s is called twice"), *argv[0]);
>> +		if (string_list_has_string(&cmd_list, *argv[0])) {
>> +			struct strbuf sb = STRBUF_INIT;
>> +			int i, seen_at_idx = -1;
>> +
>> +			/*
>> +			 * Find the re-entry point for the alias
>> +			 * loop. TODO: There really should be a
>> +			 * "return the index of the first matching"
>> +			 * helper in string-list.c.
>> +			 */
>> +			for (i = 0; i < cmd_list.nr; i++) {
>> +				if (!strcmp(*argv[0], cmd_list.items[i].string))
>> +					seen_at_idx = i;
>> +			}
>> +			assert(seen_at_idx != -1);
>
> The string-list code doesn't generally deal in indices. You can use
> string_list_find_insert_index(), but its return value is a little funky
> for the existing case. You can also just do:
>
>   struct string_list_item *seen;
>   ...
>   seen = string_list_lookup(&cmd_list, *argv[0]);
>   if (seen) {
> 	/* we have a loop */
> 	int idx = seen - cmd_list.items;
>
> That's a little intimate with the string-list implementation as an array
> of string_list, but it's already pretty standard to walk over and
> dereference that list (including in your patch). But also see below.
>
> Side note: there's actually a bigger problem with the original patch:
> the string list is unsorted (because it uses string_list_append(), and
> which is why your linear walk works here). But string_list_has_string()
> assumes it is sorted.  So I think we'd actually want to use
> unsorted_string_list_has_string() or unsorted_string_list_lookup().
>
>> +			for (i = 1; i < cmd_list.nr; i++) {
>> +				if (i - 1 == seen_at_idx)
>> +					/*
>> +					 * TRANSLATORS: This is a the
>> +					 * re-enttry point in the list
>> +					 * printed out by the "alias
>> +					 * loop" message below.
>> +					 */
>> +					strbuf_addf(&sb, _("    %d. %s = %s <== The re-entry point in the loop\n"),
>> +						    i,
>> +						    cmd_list.items[i - 1].string,
>> +						    cmd_list.items[i].string);
>
> This is always going to show the right-hand of the equals as the
> left-hand on the next line. Would it be simpler to just show the list?
> Likewise, the last item in the list is always going to be "where the
> loop started". Do we need to say that?

Yeah maybe that's overzealous. I figured in the spirit of clang & GCC
compiler messages these days there's no such thing as too dumbed down :)

> E.g., something like:
>
>   seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
>   if (seen) {
>           for (i = 0; i < cmd_list.nr; i++) {
> 		struct string_list *item = cmd_list.items[i];
>
> 		strbuf_addf(&sb, "  %s", item->string);
> 		if (item == seen)
> 			strbuf_add(&sb, " <==");
> 		strbuf_addch(&sb, '\n');
> 	  }
> 	  /* We never added this to the list, but we were about to */
> 	  strbuf_addch("  %s\n", seen->string);
> 	  die(...);
>   }
>
> I guess it's not that far off of yours. Not using words to describe the
> loop entry and exit points avoids translation, which avoids notes to
> translators, which is most of what makes your patch long. ;)

This still needs translation for RTL languages. I.e. they'd want to
print out the equivalent of "%s " followed by "==> %s ". We happen to
(unfortunately) not carry such a language yet, but it's worth
future-proofing output as we add it in case we get one.
