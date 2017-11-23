Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C1620A40
	for <e@80x24.org>; Thu, 23 Nov 2017 09:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbdKWJPu (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 04:15:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38055 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdKWJPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 04:15:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id 128so15026050wmo.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 01:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hM0sc9RqJcfs4lA71I/OfOsI6cDtQBF+DR+B9ZGvCPc=;
        b=iQA7/Fm30TKsHiZJ6y9MQEwQ3vdrp0TtZYmZbIppBuFc/zLuWJetLo0DlftvnVOVJr
         nOlHD8qu7X2YKXp+CNswnHBuAswDmtOCrZHRMwsffrciaMgfpv7gGMWUBNQ7fk/JyMAh
         zuK2aJI8jTr3sslKrtr+61uxCSNFazRnLaxX9rl8Kv5hL8YMT2f7ZWv3S7+MSe8G746b
         PKvRmGVPsNEVSpe8TW5Sm5egUPqOVT01PEMvGO/oKNlRWOLpXjhx7+YogBMQQeH+J2YB
         KJc4JRrwt8g3vZleYEKdohx+oVPby0AcwFc5BMtas7ZANBuDdVOGYbQ5DeUIluQzWL5t
         9bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hM0sc9RqJcfs4lA71I/OfOsI6cDtQBF+DR+B9ZGvCPc=;
        b=Nc70r5jk4TPbu4YPLWnLaBmyKUrRo3w9yKazBFuv+RYROR1dPpJgjz4qy244S7j+TV
         ol+IYbLmbC0BAQC+XIudg/aqLXusr1bjp92E+hhMf54BIwfAmmagxC+aOnxgpFRrKzcl
         cWyecQmbKF35t6Gn3+9VVN7r6dPldRl4b+/p3AAmjBbol31EqtMHQcRmjEDfRv6ZpZCT
         nCCb0foQe42LLJPYI0c8BjsW+qISzBZEvI0DBzGyR5DUVJcUdfCHNI4zzxvOfck0akdH
         iRO+V6KMbu0FwGTQOID/yrSuoaNkm4kLTKQwqbUfY1n2U+BHfAEk+ISULRgBx+jP6oRn
         /2mA==
X-Gm-Message-State: AJaThX50s7jYeWdn+x32O2n39OeVNTkrvwqMIwUCYkqCn/94C3UH6cXE
        zH25ZVJ/43OhEuxIIdPg06gizkb0
X-Google-Smtp-Source: AGs4zMa1t8CJgEL05EMY6XCtm/7rqsanVkKJgH7CY5lSIdI7gjd7t1y6Qph8JDfsJm/VE666Enqnew==
X-Received: by 10.80.141.141 with SMTP id r13mr33523532edh.122.1511428546419;
        Thu, 23 Nov 2017 01:15:46 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id x7sm12202404edi.6.2017.11.23.01.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Nov 2017 01:15:45 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eHnbk-0002FX-Lr; Thu, 23 Nov 2017 10:15:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] grep: fix segfault under -P + PCRE2 + (*NO_JIT)
References: <20171122133630.18931-1-avarab@gmail.com> <20171122133630.18931-2-avarab@gmail.com> <CAPig+cS_R5wcJQNavGSgNQXtbXNbDsTDhj8cbSZ5BBxRqU8yRQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAPig+cS_R5wcJQNavGSgNQXtbXNbDsTDhj8cbSZ5BBxRqU8yRQ@mail.gmail.com>
Date:   Thu, 23 Nov 2017 10:15:44 +0100
Message-ID: <87bmjtwe2n.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 22 2017, Eric Sunshine jotted:

> On Wed, Nov 22, 2017 at 8:36 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Fix a bug in the compilation of PCRE2 patterns under JIT (the most
>> common runtime configuration), any pattern with a (*NO_JIT) verb would
>> segfault. This bug dates back to my 94da9193a6 ("grep: add support for
>> PCRE v2", 2017-06-01):
>>
>>     $ git grep -P '(*NO_JIT)hi.*there'
>>     Segmentation fault
>>
>> As explained ad more length in the comment being added here it isn't
>
> s/ad/at/
> s/here/here,/

Thanks. I'll let this sit for a bit and submit a v2 soon. There's also
an upstream fix in pcre2 to prevent the segfault that'll be in future
versions & I'm going to note in the amended commit message.

>> sufficient to just check pcre2_config() to see whether the JIT should
>> be used, pcre2_pattern_info() also has to be asked.
>>
>> This is something I discovered myself when fiddling around with PCRE2
>> verbs in patterns passed to git. I don't expect that any user of git
>> has encountered this given the obscurity of passing PCRE2 verbs
>> through to the library, along with the relative obscurity of (*NO_JIT)
>> itself.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
