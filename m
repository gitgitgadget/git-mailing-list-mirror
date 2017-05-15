Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2966D201A7
	for <e@80x24.org>; Mon, 15 May 2017 17:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760561AbdEORmE (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 13:42:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33748 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdEORmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 13:42:02 -0400
Received: by mail-it0-f66.google.com with SMTP id l145so11816136ita.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tzFgvh8dcc4TNWb8d9DbLSNuCYKRJjK/sbsywK7mk/k=;
        b=k5UGebAceyBoN1B9YpnLkLhaQOP0/d7l7sLLficcP935+bkliu1R2h08ZiG/k3XAo7
         F0fgry2+0ZnyDgREBByjVXjIbOadYhukRPVgIsxMMyhWlpjWzZuYgg9bMJjz7RFT9amW
         ktgKyXW+A1Prwwn1awleLV2OIqnFUFf3I8OZ4lEQ5n05aAi2J6jS4E92eHBc0fOFYwdr
         QuQuZohiI+G+ktFXBDOh/cLdj+lKW4sSC4OjJ9xblm01qVZVWWrVfDtnVomM9JOMaB0g
         smsWvpCWk/WJJBU/HKkjRMqiA9ffSBrQdnXIneku5c/WgAit34dpU4DQb902cz3KYjfF
         l5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tzFgvh8dcc4TNWb8d9DbLSNuCYKRJjK/sbsywK7mk/k=;
        b=KqWp+ndu1apJCNT9/avUmfRrHebbjLrof5lcvW0vTp+HpXOWzypa7ZwykoXpbTQkuV
         vEgdCTi5dGTC7XeoL5q/qXd6wmegBQSfU8GpBQUMQSoOEhsHgpLqabvhD6KRVc3L9sKD
         mYdXro+57Cq7dTdtfsAKGsBkx8TQpb9BXF8nj7Ep8Pd27Pf+FvoWMXfEv5gFXJAQPVdU
         NU+J2Hl7lsPYYe+2qUmXVBMUy3vkaGV4J+9yUjmGzn/jZ0fPCuYaSzAbuB7OApxmZ+hh
         UFZ3DXVLY1A858gnQAkBxNeZIDZ2TgsxhScNsi6jY/4J1M/KGbk+OTzCnXoKqngQUCEl
         kIlA==
X-Gm-Message-State: AODbwcD7XJZikNmkCM9KgVBsIyLX22kC6aLqDvu3BJoxXs9ZGjoAk+Oc
        R/R9biV/1WuZSz3XQZ1AnzWMQgtehw==
X-Received: by 10.36.37.78 with SMTP id g75mr6424601itg.94.1494870122091; Mon,
 15 May 2017 10:42:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 10:41:41 -0700 (PDT)
In-Reply-To: <xmqqshk6ve8k.fsf@gitster.mtv.corp.google.com>
References: <20170513231509.7834-1-avarab@gmail.com> <20170513231509.7834-21-avarab@gmail.com>
 <xmqqshk6ve8k.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 19:41:41 +0200
Message-ID: <CACBZZX5jRVtJd8wj93TGS4mcE=9qaxwQjmJQqNkcxuRkJ9fXaQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/29] grep: remove redundant `regflags &=
 ~REG_EXTENDED` assignments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 8:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Remove redundant assignments to the "regflags" variable. There are no
>> code paths that have previously set the regflags to anything, and
>> certainly not to `|=3D REG_EXTENDED`.
>>
>> This code gave the impression that it had to reset its environment,
>> but it doesn't. This dates back to the initial introduction of
>> git-grep in commit 5010cb5fcc ("built-in "git grep"", 2006-04-30).
>
> Back in 5010cb5fcc, we did do "opt.regflags &=3D ~REG_EXTENDED" upon
> seeing "-G" on the command line and flipped the bit on upon seeing
> "-E", but I think that was perfectly sensible and it would have been
> a bug if we didn't.  They were part of the command line parsing that
> could have seen "-E" on the command line earlier.
>
> If we want to find a commit to assign blame to, I think it is more
> correct to say that this came from the same one as 19/29 fixes.
>
> When cca2c172 ("git-grep: do not die upon -F/-P when
> grep.extendedRegexp is set.", 2011-05-09) switched the command line
> parsing to "read into a 'tentatively this is what we saw the last'
> variable and then finally commit just once", we didn't touch
> opt.regflags for PCRE and FIXED, but we still had to flip regflags
> between BRE and ERE, because parsing of grep.extendedregexp
> configuration variable directly touched opt.regflags back then,
> which was done by b22520a3 ("grep: allow -E and -n to be turned on
> by default via configuration", 2011-03-30).  When 84befcd0 ("grep:
> add a grep.patternType configuration setting", 2012-08-03)
> introduced extended_regexp_option field, we stopped flipping
> regflags while reading the configuration, and that was when we
> should have noticed and stopped dropping REG_EXTENDED bit in the
> "now we can commit what type to use" helper function.

Thanks for the history. I'll amend the commit message to note this.

> In any case, I think this change is safe to do in the current
> codebase.  I wonder if this and 19/29 should be a single patch,
> though, as the unnecessary bit-flipping all are blamed to the same
> origin.

Squashing these two makes sense. I'll do that.

>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  grep.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index 59ae7809f2..bf6c2494fd 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -179,7 +179,6 @@ static void grep_set_pattern_type_option(enum grep_p=
attern_type pattern_type, st
>>       case GREP_PATTERN_TYPE_BRE:
>>               opt->fixed =3D 0;
>>               opt->pcre =3D 0;
>> -             opt->regflags &=3D ~REG_EXTENDED;
>>               break;
>>
>>       case GREP_PATTERN_TYPE_ERE:
>> @@ -191,7 +190,6 @@ static void grep_set_pattern_type_option(enum grep_p=
attern_type pattern_type, st
>>       case GREP_PATTERN_TYPE_FIXED:
>>               opt->fixed =3D 1;
>>               opt->pcre =3D 0;
>> -             opt->regflags &=3D ~REG_EXTENDED;
>>               break;
>>
>>       case GREP_PATTERN_TYPE_PCRE:
>> @@ -414,10 +412,9 @@ static void compile_fixed_regexp(struct grep_pat *p=
, struct grep_opt *opt)
>>  {
>>       struct strbuf sb =3D STRBUF_INIT;
>>       int err;
>> -     int regflags;
>> +     int regflags =3D opt->regflags;
>>
>>       basic_regex_quote_buf(&sb, p->pattern);
>> -     regflags =3D opt->regflags & ~REG_EXTENDED;
>>       if (opt->ignore_case)
>>               regflags |=3D REG_ICASE;
>>       err =3D regcomp(&p->regexp, sb.buf, regflags);
