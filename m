Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8146F1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755135AbcIAIEB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:04:01 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35403 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755114AbcIAID4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:03:56 -0400
Received: by mail-wm0-f53.google.com with SMTP id w2so63341452wmd.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UXp5phL9CLy5Unj5Jf00q5JnkPehYg10PNMWMrtFlWs=;
        b=w0m1XdeDo+5o5/pD1l4H+WTYX+KsIB2bp8keDercfcqOTAIMSJuS10EwQQEoxdCGT8
         K8sDk0Z/HsrbB1aMZT1N68Z5aHhM0XRfi/VEpa/bNp1WM/a9h9S5iPJTvPIKyGjKPYVA
         Vw76xiJ6u/c5IdAlBxOip3QTPWFartHAFyDjuVnfzgxdQFI2e8mcKJ9mmP3ptqVZLu56
         F2ynlkwv/j3iUxK1hnnC89I3WcDdYD+BS+5rrZfzTHrtLR9CWtbwhCpfnESdc52Cvyth
         ofspbElNda9d8VP8Ws3MaC20p6Keldy5MOUDJXzt0tFRrfqaI13t4IF/vxnFMHqgpfFJ
         qSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UXp5phL9CLy5Unj5Jf00q5JnkPehYg10PNMWMrtFlWs=;
        b=UARuUAKcAJGgC980geAtXn02c4uXsd0sAp0QG9RafNkMU/ojxfSN1mEz/+JCww/Iq0
         6gLNIBxxL/pB/Trlso110H5xkum+mDRgzoJMAN2NHinpniuk+ufSTurcKhxi1os9ZGuF
         5pjNL5/SsHp0CYVY4xigk9zAJenjiJ7GL0Qzy1/Y+zF2rXzZWCDe9SGrTmxbYLF/3LAA
         GC/pX5DDqWQ+E9NYsv4CZkQkRodJc6hRc4tNXm/ULblxYII2jqvZuzUSOZVmtChs0OXZ
         t/Q+B0SMbD94gLj0UHzHyx5fy4vNao3FInbL7o+ElijcrLDuh3e25dKt2j5YY8QEOEjh
         Q7bg==
X-Gm-Message-State: AE9vXwPJYKYDr7wuYC/lGRRV5ML1O/Si4JoUae5vA4H5y7EN1NcO8FDhIVgedb35pxprTHq2xluql/I9MNXflQ==
X-Received: by 10.194.89.73 with SMTP id bm9mr14102584wjb.76.1472717029947;
 Thu, 01 Sep 2016 01:03:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Thu, 1 Sep 2016 01:03:49 -0700 (PDT)
In-Reply-To: <CAGZ79kYzOh-trnnc2JH9QX21DX=6nz=q0M99tbpU_Q68tmH0Qw@mail.gmail.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-3-chriscool@tuxfamily.org> <CAGZ79kYzOh-trnnc2JH9QX21DX=6nz=q0M99tbpU_Q68tmH0Qw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Sep 2016 10:03:49 +0200
Message-ID: <CAP8UFD3DS_AV_ATH8Z9v0f0y4zFjhjhD0h9LfHwnJ2R0Fm5EqQ@mail.gmail.com>
Subject: Re: [PATCH v13 02/14] apply: rename and move opt constants to apply.h
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 11:46 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>  extern int check_apply_state(struct apply_state *state, int force_apply);
>>
>
> With greater scope comes greater responsibility. Nit of the day:
> In case a reroll is necessary, consider putting a comment here.
> (What are these constants? what do they control? How/where do I use them?)
>
>> +#define APPLY_OPT_INACCURATE_EOF       (1<<0)
>> +#define APPLY_OPT_RECOUNT              (1<<1)

Ok I will reroll with some added comments.
