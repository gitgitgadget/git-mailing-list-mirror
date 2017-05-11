Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD221FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbdEKHtc (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:49:32 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36688 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754347AbdEKHtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:49:31 -0400
Received: by mail-it0-f44.google.com with SMTP id o5so39156038ith.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m5gRnPBwGx6Qe5hgijeh3dCDc1jE75z6pMdRYNMKphc=;
        b=jIEHQlzGKgWiA6IB7GyyQD/Vikr+pi1GoLTDcmjwc8BKhAgazX4h5x43zmUZeDVPMs
         wUocjFnz2/n85wMuUdnfDvB3DCifXIUIXw3se1JhLIWBSwib8JJ8Vt/fPrb6SCcJnG4v
         f5ud8kz1zmBiC4BHz9nUzRgJE5u4ErNNj9l8K2hfn3BpMJW5mM7ZUPDJmQJY6lv71Dho
         s4DQmFFUjtLwa9JPNKl/rmgme6uyskpnSfIy45fMJk+4wMvCVo3xw9DXLFAIPlpNXS7q
         3eL2YTIC1y0KFYwDx2SHINpS2YSc3/kies19NrJGNDqYajPpAAWEedRmNXRCiEf2NkoR
         yqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m5gRnPBwGx6Qe5hgijeh3dCDc1jE75z6pMdRYNMKphc=;
        b=q61SoN1PGGoqqslV8KdemMRaF1lHFktRtG7KFc/ioma1RcZWR5wsTdo9bUxO4WHE3v
         NKeANGUrDHLO48Tm1ygb0IFs0nhSMKjiGwC2WhWDWSVqnS16WPsY5O7OOfPdLb4HNysm
         otapd5K/mpaYfwMBn9mRKoAHax7gYLpE9/j6yW0YIo7FbZvVFJIOr1Rqs/CuQmMiOEar
         CeWMBlbeBmd/t7GFuhIFc7UuTKNb58A2axFGY+46/TGKwf1HU6HZ+HPRBOauU2HF21mO
         gXQepkoewAOj3YRdtfzYUrfqOWE1k2ZziH2wcwTXfzJeXMNrlahAMa7ggz2iDc8+pxdg
         5EoA==
X-Gm-Message-State: AODbwcDDQsOKVq8KPGS3JQuJAu1roJ6USEVaFn8M5JKnDVtdf67uq6Ga
        Q92rigOmJgg3Igj4zSrLpuNfIsnnWg==
X-Received: by 10.36.166.4 with SMTP id q4mr9234531ite.66.1494488970608; Thu,
 11 May 2017 00:49:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 00:49:09 -0700 (PDT)
In-Reply-To: <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com> <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
 <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net> <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
 <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com> <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 09:49:09 +0200
Message-ID: <CACBZZX6hpL0=Zw0kvB-Ww95uGvuJ8129MTwkmv7DOEE1i66a_Q@mail.gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 9:42 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 11, 2017 at 09:19:50AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> 1. It says "The included file is expanded immediately, as if its
>> contents had been found at the location of the include directive.". At
>> first I thought this referred to glob expansion, not
>> s/expanded/interpolated/, the example section uses "expand" in the
>> context of pathnames, which caused the confusion.
>
> Perhaps it should say "The contents of the included file are expanded
> immediately, as if they had been found at..."?
>
>> Maybe this would make that less confusing by saying the same thing
>> without using the same phrasing to mean completely different things:
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 475e874d51..49855353c7 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -167,8 +167,8 @@ Example
>>
>>         [include]
>>                 path =3D /path/to/foo.inc ; include by absolute path
>> -               path =3D foo ; expand "foo" relative to the current file
>> -               path =3D ~/foo ; expand "foo" in your `$HOME` directory
>> +               path =3D foo ; find & include "foo" relative to the curr=
ent file
>> +               path =3D ~/foo ; find & include "foo" in your `$HOME` di=
rectory
>
> Yeah, probably makes sense to use a different word than "expand" here.
>
>> 2. There is no example of such expansion for IncludeIf, prose should
>> always be backed up by examples for the lazy reader when possible:
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 475e874d51..fc4b87cd7e 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -173,6 +173,8 @@ Example
>>         ; include if $GIT_DIR is /path/to/foo/.git
>>         [includeIf "gitdir:/path/to/foo/.git"]
>>                 path =3D /path/to/foo.inc
>> +               path =3D foo ; find & include "foo" relative to the curr=
ent file
>> +               path =3D ~/foo ; find & include "foo" in your `$HOME` di=
rectory
>>
>>         ; include for all repositories inside /path/to/group
>>         [includeIf "gitdir:/path/to/group/"]
>
> Yeah, makes sense.
>
>> 3. When I read reference docs I almost never start at the beginning &
>> read it all the way through, in this case I thought I could help
>> someone out by maybe answering a question on the ML quickly, so I went
>> to the examples section, found no example (fixed above), then searched
>> for "relative" or "path" in my pager and the only results were for the
>> "Includes" section that has a paragraph that's only talking about
>> "include.path".
>
> I do, too. And I'm all in favor of structuring things to accommodate
> that flow. But at some point we have to assume the user actually reads
> the documentation. :)
>
>> Of course we say "same rules apply" below, but I managed not to spot
>> that. Maybe this:
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 475e874d51..b35d9a7b80 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -95,8 +95,11 @@ Conditional includes
>>
>>  You can include a config file from another conditionally by setting a
>>  `includeIf.<condition>.path` variable to the name of the file to be
>> -included. The variable's value is treated the same way as
>> -`include.path`. `includeIf.<condition>.path` can be given multiple time=
s.
>> +included.
>> +
>> +If variable's value is a relative path it's treated the same way as
>> +`include.path`. `includeIf.<condition>.path` can also be given
>> +multiple times.
>
> I don't like this because it copies the rules for _one_ property to the
> conditional section. What happens when you're looking for some other
> property of include.path?

Yeah, as I said once I wrote it up I found it wasn't really any
better, but just wanted to send an explanation for why I didn't find
it while I remembered, as a sort of case study.

> I think in your case you found the "relative" section in the earlier
> paragraph, but there was no link there to the includeIf behavior. So
> should that earlier paragraph just get the "includeIf.path behaves the
> same way" mention?
>
> I suspect that whole paragraph under Includes could be reworded to make
> it clear that anything it is saying applies equally to include.$key and
> includeIf.*.$key, and then that would future-proof us for other
> modifications.
