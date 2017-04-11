Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F08D1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbdDKKqT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:46:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33172 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbdDKKqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:46:17 -0400
Received: by mail-io0-f193.google.com with SMTP id k87so1152612ioi.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+O6pQAnvZOD0RYdOqAay8lr75ViXPsJC5M+uZrMuPG0=;
        b=qBFg38kh7pkrVnJ2M3/S7F+zCH/sNMi8fbuFp/wsYbNexzHbtuwkOhevJY2rYGGfXW
         RCpHjDcsKAm1reJu+BKj2gFe2vkWDtBda/AUi25NknLwrC3phMsMwqVA6B1+l0kmqgjS
         FZjIyR/X3c236FWg0iDkOGFFi2X6ALj7va0BJEzEuHayZ79zhHFvXdPc2gkiLrbdxFPL
         W3OmWzw/+0c7nJ9nhKYxekITNI9EmD8R4Knb1KQXVnP8l+wRdpy1AgaVulwLAIWNwA1D
         9ES271pd5A00qMGLAnNECEMkgFob6whZ5JDIlsA35WU65rJOCfsbi5nPuzaqEqkHRxJ2
         oCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+O6pQAnvZOD0RYdOqAay8lr75ViXPsJC5M+uZrMuPG0=;
        b=e+2LGienG3Ssz/WbHdjqw4r5PDjS2DrBhBC2OP+I5q9Cll60uxxSkMFvqTCqnXA5uc
         BO3rUQ6wZXf292SdcF02fzWUOs/xsXc0w6FbyNpRftJEQdpJqxEJgcbYKbMQIIjVqj/B
         7DZSiqrfH7ND6VXMtbhPOt0Ugqe/l2xr9t4JCPhHCDjeXgPcsV80Dg2pNF0S0iEgnUKp
         5XmbqVNFWs+pJOZbLnlXl7DbvYz75Qhrz7BOB+GtPTsw+hjcJtL6TrUWJUDjEyMKo9eY
         j5t9yP62kCIgh034ykiqzVP5D7k3mvpkdJ4KpNEQPHveziMj1iwSxbJq0WhJNRSBuxtK
         11wg==
X-Gm-Message-State: AN3rC/530Zczr4xmA3I4Z53seVrDqdGIe6ngWcVr4SRzM+e7a6s80DT99S0x+ipRZbvc63are9OqwFxcNIkRTg==
X-Received: by 10.36.43.77 with SMTP id h74mr16473826ita.60.1491907576204;
 Tue, 11 Apr 2017 03:46:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 03:45:55 -0700 (PDT)
In-Reply-To: <20170411103746.bth3rof753gbjtjf@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-12-avarab@gmail.com>
 <20170411103746.bth3rof753gbjtjf@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 12:45:55 +0200
Message-ID: <CACBZZX5V96Vv5NAYpkQSBWpn-4rgHOatAnL51o4-4DADAF+pEg@mail.gmail.com>
Subject: Re: [PATCH 11/12] grep: change the internal PCRE code & header names
 to be PCRE1
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:37 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 08, 2017 at 01:25:05PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 9478ab5dff..dffb9743b8 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -490,7 +490,7 @@ static void compile_submodule_options(const struct g=
rep_opt *opt,
>>       case GREP_PATTERN_TYPE_FIXED:
>>               argv_array_push(&submodule_options, "-F");
>>               break;
>> -     case GREP_PATTERN_TYPE_PCRE:
>> +     case GREP_PATTERN_TYPE_PCRE1:
>>               argv_array_push(&submodule_options, "-P");
>>               break;
>
> Hmm. This isn't a problem yet, but wouldn't this need to pass some
> pcre1-specific option instead of just "-P"?

Yes, this is a bug. I'll need to add a git_options along with
submodule_options and pass -c grep.patternType=3D....
