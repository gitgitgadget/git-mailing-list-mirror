Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87A34208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbeHFTtu (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:49:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41002 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732388AbeHFTtu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:49:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id s24-v6so5548472edr.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jIrYR6hotfH5sszaU3PZQn/fG5ZAc6aTdBpvZtePEG4=;
        b=VCmz+QIchw6+UflxJ/t9akHNWEc+PyXEsuU9ZkYgMz1mo4zT+7FsyUiyQUkV4Cfji9
         AUwhgjS944WdSbwJTEa7az+rIwXbeEDQYWyyz7kZ82lFW/2Li94pBX6SUyH74DrdL1n7
         vYU/R1M8ZfnElCJrOBZqKCQCMYMxoJrPXwKs8qJOAXhfsLiVlDg+U5j35rlGHZ1dbdoF
         ciNu/euwxrGdJgR2Jd3O0g2FpKGVnCmH+coIEY0xnPt6Q6xUUk9UzpQWq+AHCoFGxnz+
         KgGa5V5w4yRZCMGXDr080Ax8pvMhZ9koW/w9rQfR/EiWtMdoeA3jyBVzFMMEwYg9eFy6
         xTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jIrYR6hotfH5sszaU3PZQn/fG5ZAc6aTdBpvZtePEG4=;
        b=M33oZIvWL9+HolFMcETkS+gjb3xAy9bsDYCfKNTT/OxZe3NJTilR6JO0jweSSE7ura
         oTNxqWvQQdQFZh7VTaQl22TmsEgYxDXZWMBsaT2aut4nipBpkQXrSEDpnS6OIU6I+T1n
         fsBrFWuTu9RZ+8kOB3d+0UieqdDfhlbFbrtz+CGwR+xn/FMAw9MBiLIuaCM+i+lTxNS3
         lOYgI+3ahW2tN88bGuPew54l5G7tawz7GB3oJJtKvMQaMcUAm6uBo0JMKTXCELmc+pZQ
         a6YGyUbxE2j6pn9EgH53+wbm5z3BpWLRP/j1N5miczFXXVgR8sO//j9E8v3Y1W0Rbuf8
         KDFA==
X-Gm-Message-State: AOUpUlF/jE9973TMyUpYX+77WZNZ4yEfnXrCe996FCtB8k1h9kAkB4Cn
        o08uVXhT4lNq7Z7tnMUN54g=
X-Google-Smtp-Source: AAOMgpeeFF/aop3C50r8YwZI+L+Uj+XysEUP+nlDQD03SBF5TJwFGxqh2b7pWO5ToW9FKOTCOsB79Q==
X-Received: by 2002:a50:be49:: with SMTP id b9-v6mr18953274edi.46.1533577181347;
        Mon, 06 Aug 2018 10:39:41 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id t44-v6sm7183817edb.79.2018.08.06.10.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 10:39:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
References: <20180804020009.224582-1-sbeller@google.com> <20180804020255.225573-1-sbeller@google.com> <20180804060928.GB55869@aiede.svl.corp.google.com> <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com> <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com> <87zhxzsb2p.fsf@evledraar.gmail.com> <20180806170211.GD19053@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180806170211.GD19053@sigill.intra.peff.net>
 a--text follows this line--
Date:   Mon, 06 Aug 2018 19:39:35 +0200
Message-ID: <87y3djs8bs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06 2018, Jeff King wrote:

> On Mon, Aug 06, 2018 at 06:40:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> Responding to the thread in general, perhaps people would like this more
>> if we turned DEVELOPER=1 DEVOPTS=no-error on by default?
>>
>> That's basically why I added it in 99f763baf5 ("Makefile: add a DEVOPTS
>> to suppress -Werror under DEVELOPER", 2018-04-14), because I wanted the
>> abilty to have verbose informative output without the build dying on
>> some older systems / compilers.
>>
>> It's fine and understandable if you're someone who's just building a
>> package on some older system if you get a bunch of compiler warnings,
>> but more annoying if you have to dig into how to disable a default
>> -Werror.
>
> I had the impression that DEVELOPER=1 was allowed to set flags that old
> versions might not even know about. Hence they might actually barf, even
> without -Werror. Maybe that's better since the introduction of the
> detect-compiler script, though.

I misrecalled that -Wimadethis-up wouldn't error on e.g. GCC today in
the interest of forward-compatibility, but it does. So that changes
things.

Although we could today pick some set of flags greater than what we use
today if there's interest, and enough compiler compatibility.

> I do think we may have a skewed view of the population on this list.
> We're developers ourselves, and we interact with new developers that we
> want to help.  But there are masses of people[1] building Git who are
> _not_ developers, and want the default to be as robust as possible.
> They're probably not going to show up in this thread.

Indeed.
