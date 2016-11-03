Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555C92021E
	for <e@80x24.org>; Thu,  3 Nov 2016 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758529AbcKCQL5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 12:11:57 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34722 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758599AbcKCQJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 12:09:58 -0400
Received: by mail-lf0-f45.google.com with SMTP id b81so43099233lfe.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OeNg7YCo4hA1pbd0wR3+KutXQrKAgb0D3qp0vwxybKw=;
        b=YxZpIpNJLjxsjDHK0DRhRaoTyUU8FnYkWRkTiF08HOzZsFnlr/xqtl4Xqo0T3GCjtk
         zQTkrFv/Gtov8LqsAzDeq04BdsfdbBKvKt0ulb5fxXmNF9k/RuQAVJC54ufPRu7SfUMx
         Vh6K0r20eZBYGiXXPnnNZrwd9hkDtmqnOJ2s2CClTr2d5tt4/gLuCHSQcsIfSBdJK+Aj
         JMk7uUlKqsDkD57M4aUW152gprobQPmH8QKvNqt1SrhUcLwAaEiOJrMhZjLgQjRNBcXu
         b/Fn93R7UF6+514lNx2dKcWfTO6nzi4zTjhYM6L+nMvCduRZO2tl2Wiu0w8yLp45Ox8B
         wiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OeNg7YCo4hA1pbd0wR3+KutXQrKAgb0D3qp0vwxybKw=;
        b=PewDlvvhO7OtnlIZ3v5gfgGKQT81ERA+65pQkncH3SC67rvSelPWfuSI0wDbjK6uaY
         cqGk2gi6YNpFzUxFZ5xhthLZr4E134nwkqX6iOT3vMtqEMDxH14YpNQ/AxKRZmFoummG
         Pytn3mccwPdb+apE5VsGqw47Tt6G881VIVfYJXOoK7rdEcG13gt40quiD0NR6kmYGIda
         kXkSVRSa/2gNrUfSRIDalS/MzUx2ZFAryRkGkNv16IpjqdLluGTq9UXfcbnI7wbVKa41
         5ycSNAG0MoSleIRKdc54GvPX2PG/k7u8+j0oHhdI8+sSBzEZmDX5KBlwUyW/cTOUrd3l
         PrPA==
X-Gm-Message-State: ABUngveQY437E/40ttYDG65TkwSNItvSiXib4SE+06LoDmeyJbzIh2SrVmEV7d4ANW7Xbm6rfzVIAqiOKxgUXA==
X-Received: by 10.25.38.131 with SMTP id m125mr6199527lfm.100.1478189396877;
 Thu, 03 Nov 2016 09:09:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.215.102 with HTTP; Thu, 3 Nov 2016 09:09:56 -0700 (PDT)
In-Reply-To: <20161103160716.6ygtf5iosudo2w3g@sigill.intra.peff.net>
References: <CAJUoZVYF=ZCBUX6jztwhJX3BZdq4JEfrSRbi4cFPwn+7yA=VjA@mail.gmail.com>
 <20161103151422.nhrgzivapy5tisr4@sigill.intra.peff.net> <CAJUoZVbnWzpjzWe_qGZTnX_6N2+OJVG39WYaBgY7OfQBNCg+rg@mail.gmail.com>
 <20161103155400.jqzopj5i2rrlj6km@sigill.intra.peff.net> <CAJUoZVY0-OA7Tu=cHDPH+NwmQ8MUuWc37_5aqeGQbwKpNWVzqg@mail.gmail.com>
 <20161103160716.6ygtf5iosudo2w3g@sigill.intra.peff.net>
From:   Chris Purcell <chris.purcell.39@gmail.com>
Date:   Thu, 3 Nov 2016 16:09:56 +0000
Message-ID: <CAJUoZVbejQ2JE8GOKoyVqEEcLcH=5Jn8vAK83MAQosgPP7NsBQ@mail.gmail.com>
Subject: Re: Bug in git rev-parse @{push}?
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will do, thanks! Meanwhile, I'll work around locally by changing off
'simple' in my config=E2=80=94if I can figure out how not to break everythi=
ng
in the process...

On 3 November 2016 at 16:07, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 03, 2016 at 03:59:13PM +0000, Chris Purcell wrote:
>
>> >> Thanks, Jeff! If I remove the explicit configuration of remote.pushde=
fault
>> >> =3D "origin", I get the same error message as you, so I suspect that'=
s _not_
>> >> the default.
>> >
>> > That's really bizarre, because I get the same behavior with or without
>> > it set. Not only that, but it shouldn't even come into play, as
>> > branch.foo.remote should take precedence anyway.
>> >
>> > So now I'm really puzzled.
>>
>> That's because I lied. Sorry! Too many branches configured. I've actuall=
y got
>>
>> [branch "foo"]
>>     remote =3D .
>>
>> If I change that to 'origin' like I claimed it was, it starts erroring.
>
> OK, now I can reproduce. And changing remote.pushdefault _does_ matter
> because builtin/push.c:is_workflow_triangular() uses it as a key to "we
> are in a triangular workflow".
>
> That was added by ed2b18292 (push: change `simple` to accommodate
> triangular workflows, 2013-06-19).  TBH, I think the right solution is
> "stop using 'simple' in a triangular setup". But since that workflow
> exists for git-push, we probably need to support it via @{push}, too.
>
> I think the solution would be something like:
>
>   - move is_workflow_triangular() into remote.c so it is accessible in
>     both places
>
>   - when branch_get_push_1 sees that is_workflow_triangular() is true,
>     treat "simple" as "current"
>
>   - new tests should go into t/t1514-rev-parse-push.sh to cover this
>     case
>
> Want to take a stab at it?
>
> -Peff
