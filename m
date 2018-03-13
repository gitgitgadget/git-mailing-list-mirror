Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1E21F404
	for <e@80x24.org>; Tue, 13 Mar 2018 20:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeCMUra (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 16:47:30 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:38162 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbeCMUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 16:47:29 -0400
Received: by mail-pg0-f41.google.com with SMTP id a15so399186pgn.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NeJsfLM7IhoP+p1IAROHwChI1qo3oFODBbMqymHYsqU=;
        b=B8yURoA6YobEd1Wa+/zZkE4v780qnAWUpShSqzEakKmo2o+rmRildBn0czIbLN8K2u
         oC7oIuTO6ZOagNrBXlG66xbcExWtPtsaZJ2Oqeuyq5p9WnDtS/39rzJ5Nd1HR0tHdq5V
         oHfKMavXSFrv91uNkEbFMktuNjUlwezwU68Lv225p40Enmt/8nnVmdivXxhMJi/84Sib
         5NgA4N2BFayIRh0SrhrO0KIf8GFQmZeRdtOmIhT3N8hYfyYNl6hdEnYe6jqmKK/kRjR9
         a9p7cDbuFJ3PrluiHkmfCngMw3cG9IcRGUmAkCzu9hoacZo9ZlN1KY0rAR429JyRi2G6
         H93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NeJsfLM7IhoP+p1IAROHwChI1qo3oFODBbMqymHYsqU=;
        b=uXJzWjF44057JkYxJCxy36fgx86Wz9wb+VmCE+QqbZBcN9DEEbMWmSEhuj0/eHsS7l
         bHB5nMxB6nyfHzFuad7sWlz85G6J+Jgz3+UPLJ88tOihuw3AKu34ifNniXunLeHSwfup
         OK54CED9uh1uVYseLMirS+fJWxR2N4TmhsLuJHivCai9a4bk391bVhmA7XJGIhZso9Ri
         5Jzg/ZLmq8QBit8zKbzvecv/C1ZQ/pSFiN5uAQqZbuUTwqalWPRPP9Bg+csoJhUIkoex
         Yp2RF6NYZ9NbsrlYLxj9y+DfJhD570sQMu5Nui3jFAanJ1Wb4sUP3SVfaDh6ZWdOSO8t
         IX0w==
X-Gm-Message-State: AElRT7H1C4VKfAfnBUkYMyqdkQg7XcCsTCOCDBxdmOnu22D1FKQsuYBt
        ahxqnu8ARnMbrw8ShDgtzlRfbizx46Lq2QAedF4=
X-Google-Smtp-Source: AG47ELs0Y3RIEgU4vvptHwAlCejL1t/Tg/sOrDAMnQFBPkQpNRpN3dSx4d3WB1HxuZ0oaxD5tIZ4HUCDNIewoG1EaiE=
X-Received: by 10.101.88.130 with SMTP id d2mr945362pgu.383.1520974049135;
 Tue, 13 Mar 2018 13:47:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 13 Mar 2018 13:47:28 -0700 (PDT)
In-Reply-To: <20180313195640.GA147135@aiede.svl.corp.google.com>
References: <cover.1520680894.git.martin.agren@gmail.com> <78669e644b64fc10c34adb59717d2039f81cb092.1520680894.git.martin.agren@gmail.com>
 <20180313195640.GA147135@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Mar 2018 21:47:28 +0100
Message-ID: <CAN0heSoP1oVWH0YAFNcL5LG_K7TsmKMAHUA_TiDacVdPtWjTZw@mail.gmail.com>
Subject: Re: [PATCH 3/3] shortlog: do not accept revisions when run outside repo
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 March 2018 at 20:56, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Martin =C3=85gren wrote:
>
>>                                                       (So yes, after
>> this patch, we will still silently ignore stdin for confused usage such
>> as `git log v2.15.0.. | git shortlog v2.16.0..`. But at least that does
>> not crash.)
>
> I don't follow here.  Are you saying this command should notice that
> there is input in stdin?  How would it notice?

I have no idea how it would notice (portably!) and the gain seems
minimal. I added this to keep the reader from wondering "but wait a
minute, doesn't that mean that we fail to catch this bad usage if we're
in a repo?". So my answer would be "yep, but it's not a huge problem".
Of course, my attempt to pre-emptively answer a question only provoked
another one. :-) I could phrase this better.

>> --- a/builtin/shortlog.c
>> +++ b/builtin/shortlog.c
>> @@ -293,6 +293,12 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
>>  parse_done:
>>       argc =3D parse_options_end(&ctx);
>>
>> +     if (nongit && argc !=3D 1) {
>
> Just curious: would argc ever be 0 here?  'argc <=3D 1' might be clearer.

Hmm, good point. It "shouldn't" be 0, but I guess it's better to be safe
than sorry. (We seem to have both constructs, in various places.)

>> +             error(_("no revisions can be given when running "
>> +                     "from outside a repository"));
>> +             usage_with_options(shortlog_usage, options);
>> +     }
>> +
>
> The error message is
>
>         error: no revisions can be given when running from outside a repo=
sitory
>         usage: ...
>
> Do we need to dump usage here?  I wonder if a simple die() call would
> be easier for the user to act on.

I can see an argument for "dumping the usage makes the error harder than
necessary to find". I mainly went for consistency. This ties into your
other observations below: what little consistency do we have and in
which direction do we want to push it...

> Not about this patch: I was a little surprised to see 'error:' instead
> of 'usage:' or 'fatal:'.  It turns out git is pretty inconsistent
> about that: e.g. there is
>
>         error(_("no remote specified"));
>         usage_with_options(builtin_remote_setbranches_usage, options);
>
> Some other callers just use usage_with_options without describing the
> error.

The other two approaches ("die" and "error and usage") can be argued
for, but this one ("give usage") just seems wrong to me. I haven't
looked for such a place in the code, and maybe they're "obvious", but it
seems odd to just give the usage without any sort of hint about what was
wrong.

>  check-attr has a private error_with_usage() helper to implement
> the error() followed by usage_with_options() idiom.  Most callers just
> use die(), like
>
>         die(_("'%s' cannot be used with %s"), "--merge", "--patch");
>
> Documentation/technical/api-error-handling.txt says
>
>  - `usage` is for errors in command line usage.  After printing its
>    message, it exits with status 129.  (See also `usage_with_options`
>    in the link:api-parse-options.html[parse-options API].)
>
> which is not prescriptive enough to help.

I think it would be a larger project to make these consistent. The one
I'm adding here is at least consistent with the other one in this file.

> Separate from that, I wonder if the error message can be made a little
> shorter and clearer.  E.g.
>
>         fatal: shortlog <revs> can only be used inside a git repository

Some grepping suggests we do not usually name the command ("shortlog
..."), perhaps to play well with aliasing, nor do we use "such <syntax>"
very often, but it does happen. Quoting and allowing for options might
make this more correct, but perhaps less readable: "'shortlog [...]
<revs>' can only ...". Slightly better than what I had, "revisions can
only be given inside a git repository" would avoid some negating.

> Thanks and hope that helps,

It does indeed. I'll give this another 24h and see what I come up with.
I believe it will end up in a change to "<=3D 1", an improved error
message and a clearer last few words in the commit message.

Martin
