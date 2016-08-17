Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567521FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 20:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbcHQUxC (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 16:53:02 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34509 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbcHQUxB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 16:53:01 -0400
Received: by mail-io0-f174.google.com with SMTP id q83so2731727iod.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 13:53:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sPfmzOhEjfvuUdGC4AbhNMbi2fWtLLlVU2WDnWj29b4=;
        b=f/JCuFbnWqpw3t3qvUQEC1A+4P5i/5g3cXru7R2ofsfzUiV7HpC37iTX2J5yXa6F32
         7UCSmP/CFCLMY8ALr9Rm1Skb/3z+ahp3ApXA1ftigZKVLhde+ccCxDNsAHlM6bNuRHiO
         HiHP0vqZXmwWYOifD1x4Ofut3l83xveh8OKiGBRw1iR1VxZeKBoc2X8E/Ik9EW1EflWT
         Ox7gSEt4W5ohD1UlQpmqDljSFee////mmcYqK2uHsLo2cPE3iigHSxDoM+f7EsM5o/fT
         4/n/FJZgPZRQkE1xqQ1zo3Yz7D8gV4JR3u+NfLiG2o9iYJ4ZVKA81cBdGKrjDnatw30r
         U29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sPfmzOhEjfvuUdGC4AbhNMbi2fWtLLlVU2WDnWj29b4=;
        b=mdRY++TGgk7bKO/F6F6jfqWKykuJgmmb/pIoz63S6xZK1OeGf63u40l/VGS8O/QD7P
         4XrNE2RwlSfAvJKIcAaLsuXO5FKLrHekz2ocSL418VaMYQBvuHlMJ8tnlJtpAxq9TAn9
         rwTBOchFYzdwJNhoVBSJVQBNi0lPaTZY5hmV2PajItWxfTK24+pZEgGC5s3bMm93iwel
         0S7BMr8Po8M+ZKSGUpTKSjXAu3D7Qp+Yf1krniz+m8r8Q0kQ7Q9+2l57moOEgqKzU0Bs
         j57pgzpUV/UrpfV/COcyqLC4H8DbgK5qE41Q2g3J+hWaHE5isztjd6x/duFfcPnB9mYs
         E3+w==
X-Gm-Message-State: AEkoouvvm5b8bxJ1TvzJDlqcCeJ4Be4iJIzJSnOC5Vk9X2oxbXdBnIAzWUU9BWPZV6eATmpxr7WN/UtoO9JpPxkJ
X-Received: by 10.107.144.10 with SMTP id s10mr47239734iod.165.1471467180703;
 Wed, 17 Aug 2016 13:53:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 17 Aug 2016 13:53:00 -0700 (PDT)
In-Reply-To: <xmqqr39n88pg.fsf@gitster.mtv.corp.google.com>
References: <20160811231405.17318-1-sbeller@google.com> <20160811231405.17318-9-sbeller@google.com>
 <xmqqr39n88pg.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 17 Aug 2016 13:53:00 -0700
Message-ID: <CAGZ79kZChE=y9=DiQw9rw70S1ToEJK3mqFo1JLHRueVvst4VoQ@mail.gmail.com>
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

On Wed, Aug 17, 2016 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static void prepare_possible_alternates(const char *sm_name,
>> +             struct string_list *reference)
>> +{
>> +     char *sm_alternate = NULL, *error_strategy = NULL;
>> +     struct submodule_alternate_setup sas = SUBMODULE_ALTERNATE_SETUP_INIT;
>> +
>> +     git_config_get_string("submodule.alternateLocation", &sm_alternate);
>> +     if (!sm_alternate)
>> +             return;
>> +
>> +     git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
>
> I have to admit that I need to follow the codepath in config.c every
> time to check, but I _think_ git_config_get_string() gives you your
> own copy of the value.  As this function does not give ownership of
> sm_alternate or error_strategy to something else, they are leaked
> every time this function is called, I think.

There are quite a few more occurrences of git_config_get_string
in the submodule helper, I'll also look at those.

Thanks,
Stefan
