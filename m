Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BDDF1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 21:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbcHQVl7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 17:41:59 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37074 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbcHQVl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 17:41:58 -0400
Received: by mail-it0-f51.google.com with SMTP id f6so3396175ith.0
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 14:41:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bDaa5NN4xcUvZsn9UJI8mBms0iS2FXrdusgs3udeRw8=;
        b=Rcpf4ryxkE971tc4/ZKVsmUvhdy2tCmJTg6snl98X0x/OWtuPCLARugn5u1kIC+eV1
         XCPTMqfdvZcgpaIouElzzCYmuLNFKI3t1SILlr8YQ+eA8NPZpOcPFUt0LhapqYroZmAC
         cw0N0r26mGB+dC3M0tlilIvaTY9QBII4n+cJT958Ky/TL5LGLDnEdPQR9eAfQUcVwmej
         RD3YOSgoR5iXHZj3WJXKaABHwsOOaMjLrA2p/0cASpU566ItivSzqmbpY2SXBI3TVX0g
         27jdw4p763Rf9J/QuRrsGi+7w8OJF4/Q6cljuAxTID3hUr1Db3Ji4XXPMh1Fmch6E9Bw
         Lu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bDaa5NN4xcUvZsn9UJI8mBms0iS2FXrdusgs3udeRw8=;
        b=YNuvNvskOk1SaMqQVGLokpYEP00J56EWP0yjpqg8dG+NZiB+iTlqXkpxfwdVZeQgfn
         MdglblaEUWR6wvA8YhJifNPVPQgIBk8P2T2Oysv4pm+oBEm7JCiK/VL4nBwnVF2jBnnB
         jA/fPsNPoufftwJU7IJ0ibgnZoZcJldtm3WVGkmv2tTjq2TaXFmWCEOsKlsA85HG3Luo
         ULW3QbS/4gC8rryUt9Zc453hjkRfpWSNzYJswd3cdlVvupB3OCi1ozfIrzOy8QfpvyDL
         JQHsbsVRuaXUTlkUAfeAybAh4N9OUcQlja0yYugaMsBSOK0mynfZV6dm7UFNQm/l0QbF
         sQKw==
X-Gm-Message-State: AEkoousD2S40sqt9NsDp+CnexnNdg9ICbTyCOwfSXUpf5oRUL+R09IUGRgT7ZvSBWIrgM2r2A9o63b7TzE4ILPiA
X-Received: by 10.36.127.7 with SMTP id r7mr30385282itc.49.1471470117557; Wed,
 17 Aug 2016 14:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 17 Aug 2016 14:41:57 -0700 (PDT)
In-Reply-To: <xmqqd1l784lf.fsf@gitster.mtv.corp.google.com>
References: <20160811231405.17318-1-sbeller@google.com> <20160811231405.17318-9-sbeller@google.com>
 <xmqqr39n88pg.fsf@gitster.mtv.corp.google.com> <xmqqd1l784lf.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 17 Aug 2016 14:41:57 -0700
Message-ID: <CAGZ79kaqy16PLm8aZkAzp6PtTPFDuN80CiPPi-bbU9tec3X_oA@mail.gmail.com>
Subject: Re: [PATCHv4 8/8] clone: recursive and reference option triggers
 submodule alternates
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 2:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> +static void prepare_possible_alternates(const char *sm_name,
>>> +            struct string_list *reference)
>>> +{
>>> +    char *sm_alternate = NULL, *error_strategy = NULL;
>>> +    struct submodule_alternate_setup sas = SUBMODULE_ALTERNATE_SETUP_INIT;
>>> +
>>> +    git_config_get_string("submodule.alternateLocation", &sm_alternate);
>>> +    if (!sm_alternate)
>>> +            return;
>>> +
>>> +    git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
>>
>> I have to admit that I need to follow the codepath in config.c every
>> time to check, but I _think_ git_config_get_string() gives you your
>> own copy of the value.  As this function does not give ownership of
>> sm_alternate or error_strategy to something else, they are leaked
>> every time this function is called, I think.
>>
>>> +    sas.submodule_name = sm_name;
>>> +    sas.reference = reference;
>>> +    if (!strcmp(error_strategy, "die"))
>>> +            sas.error_mode = SUBMODULE_ALTERNATE_ERROR_DIE;
>
> Another thing I noticed but forgot to mention.  Can error_strategy
> be NULL here?  We are assuming sm_alternate can be, so I presume
> that it is sensible to protect against dereferencing a NULL here,
> too?

Oh!

Of course we need to fix that too. That slipped in because I assumed that those
two variables go in tandem (if sm_alternate is set, then
error_strategy is set as well),
but that is not the case of course.

Which leads to another thing: we need to have a default for error_strategy.
I think "die" is reasonable here. That also needs a documentation update.

>
>>> +    if (!strcmp(error_strategy, "info"))
>>> +            sas.error_mode = SUBMODULE_ALTERNATE_ERROR_INFO;
>>> +    if (!strcmp(sm_alternate, "superproject"))
>>> +            foreach_alt_odb(add_possible_reference_from_superproject, &sas);
>>> +}
