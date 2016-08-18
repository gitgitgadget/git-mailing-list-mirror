Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7121F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbcHSCkx (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:40:53 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36771 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbcHSCku (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 22:40:50 -0400
Received: by mail-io0-f175.google.com with SMTP id b62so36623734iod.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 19:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pXndsctUZoMJzMksZJiJNccKwmv+BcVd5loJ8Mq+jQA=;
        b=Hehy6zD5RX8ieFPlNt3/eZAANMAvTDANe9cQlUAYOf9a0vtJuy+AHZlrfj5abWdabW
         puFLmK25BZgICwhzObkpAN7pao1rmlzCq5AiqryzCDkZTjbSfDea26pUo5nDY60iseIX
         Cmd64n57R6KuHtrGoEndfWCdGhur9wLGejKqwec1EMAc+bfSEFgXq9ZidezhMevbmLs0
         aegDn9Xk90WxP0yIrl0CHf9qF0KePfNLOKDIZ3iyyStsPg9kxpIGDcxMsifV7PFPBcKk
         CsWASmLq5W+zJKz5D8bbrHw3pytZJlXww3htymIfekZLfuWxkNGmdfjWW5V+lf8q3vfB
         279g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pXndsctUZoMJzMksZJiJNccKwmv+BcVd5loJ8Mq+jQA=;
        b=E/AnaBlUkKrD8fD5dHanEURbQGYxkFGhHcG1miJyNaugl+mW7w5/bQCX1piEBKK8hA
         J5cjU1Czx1R4VP4Fk7LaARaohGOE8k10mKN74YCHuKcBqd6Rymypk375eaKQg2xcSYl5
         6cs+x+VSHgolXZluNulZ0sjkA9k89lVmm0a83vwz9AIjx+J0QlIJ3T/SODkVBE9yrslC
         c6M/mLvV5bD+oir26EFhOpJ3kli5XnPUCAIxSRPO1EkLXF5SQAtFzyALty66BNxS3Xnc
         FkrhkLd4L7MXWW09ynqDDADqzZ5IftRLmpvLghuaygqoRnrUMuxYn8FmAAXlOGNFubkn
         zllw==
X-Gm-Message-State: AEkoouuAXwZYg3mpfUBoTAcngb0SNhj6uuuNC9YK/bfLt81TTzwQvqTSUeZ1YymMw4bo6lHFqV45c7sd/w7+kV+P
X-Received: by 10.107.178.129 with SMTP id b123mr4589893iof.83.1471540688688;
 Thu, 18 Aug 2016 10:18:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 18 Aug 2016 10:18:08 -0700 (PDT)
In-Reply-To: <xmqqziob6ibv.fsf@gitster.mtv.corp.google.com>
References: <20160817224535.5551-1-sbeller@google.com> <xmqqziob6ibv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Aug 2016 10:18:08 -0700
Message-ID: <CAGZ79kbRNG-BCs2vZAq5CWBNc2EYyaL7Ft-eTt2=H6GmP+aNfQ@mail.gmail.com>
Subject: Re: [PATCHv8 8/8] clone: recursive and reference option triggers
 submodule alternates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2016 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  and now with error handling of invalid options.
>
> Thanks.

Well this was not the end of the story. I sent that version out,
before doing a final test run, because changing a few lines is trivial right? :(

I'll resend with:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a1da3ea..a366757 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -562,7 +562,7 @@ static void prepare_possible_alternates(const char *sm_name,

        if (!strcmp(sm_alternate, "superproject"))
                foreach_alt_odb(add_possible_reference_from_superproject, &sas);
-       else if (!strcmp(sm_alternate, "no")
+       else if (!strcmp(sm_alternate, "no"))
                ; /* do nothing */
        else
                die(_("Value '%s' for submodule.alternateLocation is
not recognized"), sm_alternate);
