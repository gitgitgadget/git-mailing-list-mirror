Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05CA1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbcHARZQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:25:16 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34443 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbcHARZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:25:13 -0400
Received: by mail-io0-f175.google.com with SMTP id q83so189813715iod.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 10:24:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gZcK+H2HSYFmCiXDDY2zbFv90qaknCnmojNIDsOhU50=;
        b=DUTNkfzTg2GFgsIOKLDKHCMQRFsPHO+RpQWGLzijwbY88KzBv9/tNrWIu4E6G31l/O
         OIRynAYHof0dkjucDlehjuq+3x+gWe1KxSB1S83AgFCOSlKYoRW2rHLdXX9Yo6gwMOGI
         vhQFLnJjQWoaJCRixmh0Tp2bTowAmuVvL6DK/Zcz2KUJChSlCjk2ny2uCN1l7Ku3DjNG
         +N5ymeR5G9OBCCDsTxFZdu3Gsv0RMiqK12LnYXziapAEOYOxhVDYNH2NK16yZg9LukaX
         ILRvkUz3+4a/ZCU+vHRiY0q2vv5yC7F5lOU82+grJjI51oAzWciECz5Bxlwew6DAobiz
         x3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gZcK+H2HSYFmCiXDDY2zbFv90qaknCnmojNIDsOhU50=;
        b=Y/328vOZHHWtzcg6iscEzfEubXqbTZYa5YSqSsTbIQQze6JifscG+gTIZlToEFyE5w
         c6vukJL1Sy0TWUSE2BJUQ97y8sAK4qsUnWL3NmZmie/Tj4KxyKydw2/a3L1Ro7l+mita
         D5CQCG5H3QfdhVMwst6OPD3FooI+qhHA5IicaNhYN1eGYoIRaJ0t33W5YbNAsJd8D7sF
         pxRGmu/dinnWGZ6Fryz0Q+F7McFO21X/bJ5kmAbM94irrQZ9UjVGAhjqxVXsQX3/t69B
         AVxqlWyER7/Rxs/sTPbd8oFodoZ3SEbqjEaocGc1ByXughMq/22G7wiJwApUx9aJQ/JH
         eu7Q==
X-Gm-Message-State: AEkoouuVcvW4W5Bk0BnBsMHvtnWjvQtHm93JbAAnW3Qdkrx/qw9JIPiZ5+4pCGNZ+Y5okJ8PaHLwsbKyEmktFB9K
X-Received: by 10.107.131.38 with SMTP id f38mr59897889iod.173.1470072256559;
 Mon, 01 Aug 2016 10:24:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 1 Aug 2016 10:24:16 -0700 (PDT)
In-Reply-To: <20160730172509.22939-34-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org> <20160730172509.22939-34-chriscool@tuxfamily.org>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 1 Aug 2016 10:24:16 -0700
Message-ID: <CAGZ79kYzxCq6M49Zmf_4J7xTdXHMunvgPuFaLnV7fXtuTbEogQ@mail.gmail.com>
Subject: Re: [PATCH v9 33/41] environment: add set_index_file()
To:	Christian Couder <christian.couder@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 10:25 AM, Christian Couder
<christian.couder@gmail.com> wrote:

I have reviewed briefly all 41 patches and generally they look good to me.
There were some nits, which should not stop us from proceeding, though.
This one however is not one of the nits.

>
> And yeah this is a short cut and this new function should not be used
> by other code.

> + * Yeah, the libification of 'apply' took a short-circuit by adding this
> + * technical debt; please do not call this function in new codepaths.
> + */

How much effort would it take to not introduce this technical debt?
Do you consider getting rid of it anytime in the future?

Can you clarify in the commit message why you introduce this technical
debt and justify why the reviewers should be fine with it?
("It is better than before, because ..." instead of "Yeah I know it's bad".
Tell us why it is bad, and why it is not as bad as we thought?)

In cache.h we have a NO_THE_INDEX_COMPATIBILITY_MACROS,
and lots of
  #define foo_bar(..) frob_bar(&the_index, (..))

Could you operate on the raw functions that take pointers to &the_index
and point these to a temporary index?

I could imagine that this would lead to a lot of
passing around an index pointer in the am code and
in the lower level stuff, which would make the function signatures
ugly and heavy to use.

This specifically sets the index file, would the same be possible
for just resetting the &the_index pointer?
(Conceptually the same, but slightly more leightweight?)

>
> +/*
> + * Temporarily change the index file.
> + * Please save the current index file using get_index_file() before changing
> + * the index file. And when finished, reset it to the saved value.

Should this warning go inside cache.h?
Or should we make that implicit by providing a stack for the user

    extern void push_new_index_file(const char *index);
    extern int pop_index_file_redirection();

?

Thanks,
Stefan
