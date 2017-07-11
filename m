Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A48202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbdGKNsb (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 09:48:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34247 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdGKNsa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 09:48:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so19259pge.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P2kiaAUlfzq2R8v65VDs0hBHSxc8JSMFC1u3yA9nHHU=;
        b=JWDWb+lX+ywTl7XqyyEQE8IRG5KVobyErpoG4DEnw5Z9L3tBAQD8N/i0ENCDbpRurg
         6BmE8hlMQuNyZWcCuNr0Gpy2oREPtqk9HCpg5ZBKcjHffpD1x+1ZSoypb/lqbRPK5B11
         hqcTwFhjgYf12cJaGdUdskmESLpR28nqTFG5v7nwfcQuf07lqwBFQ3MMKmELMnSAvPt/
         +LH2LvAt+vEkVOrwYRrlqbJHJlFzL3jCztgGlU6k9CDTGiRXEJwV3EcmHHsf12YBawZt
         xd5Woi5kAJzWCNEQxb+v6jiUGiQ2w/mYtoHrqBUg3Pcyzsqk7IHbAustDM7B9CCUgJ8B
         sm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P2kiaAUlfzq2R8v65VDs0hBHSxc8JSMFC1u3yA9nHHU=;
        b=YXGz3K7F2IT99U+rrCq121l1UHugkIZx0PmQEn43WlFD9Bc2Id17RZWVPqxf2AC0iN
         aVKWmSU3SbgmJ33+9BfYM7SPY729HoxTeVgpQc5IzZ5c2m4chjJEHwsAUCY3aXuRNRdr
         wlkkZ7hFBY4FDATzuYnFNOM4IFqoOHwgJgfjwZJnPPj9JV5swuNcpQDkeI3VITIgX+9p
         td60YDgFbD8agFbp27MRpB0xlaJ3vFc9cHjte0z2/orEN7UK/O7Sjlgtelt1KJPWa+Q0
         Hbcy+uuzKRvXOl0qIx16kU5Rv+/lIAORjedtPAosTZe0u3dT3j+YhoNYJ5TCy85Zz3Sy
         3Gsw==
X-Gm-Message-State: AIVw110oHqg8PZGdbQ1tXd9KgfRG3F2bvFdlJm7BawAuR0szyjBs3iHK
        CSiEJzvoysyHL285WyPx/r1u0LhcUg==
X-Received: by 10.99.97.76 with SMTP id v73mr7371pgb.188.1499780910035; Tue,
 11 Jul 2017 06:48:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Tue, 11 Jul 2017 06:48:29 -0700 (PDT)
In-Reply-To: <20170711104108.vfkdo5vfoigcajdo@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com> <27ca13ea5b520d492f96ea319ae47d6f4b431e94.1499723297.git.martin.agren@gmail.com>
 <20170711104108.vfkdo5vfoigcajdo@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 Jul 2017 15:48:29 +0200
Message-ID: <CAN0heSqbxf+BNb6PUds364j3h1oJJpMFxXG-raPfFu9XLD5WXQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] tag: make git tag -l consider new config `pager.tag.list`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 July 2017 at 12:41, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 10, 2017 at 11:55:19PM +0200, Martin =C3=85gren wrote:
>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index e0f129872..e96ef7d70 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -446,6 +446,8 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>>
>>       argc =3D parse_options(argc, argv, prefix, options, git_tag_usage,=
 0);
>>
>> +     if (cmdmode =3D=3D 'l')
>> +             setup_auto_pager("tag.list", 0);
>>       setup_auto_pager("tag", 0);
>
> Ideally this would kick in whenever we are in list mode, even if the
> user didn't say "-l". So:
>
>   $ git tag
>
> should probably respect the list config. Likewise, certain options like
> "--contains" trigger list mode. I think the pager setup could just be
> bumped a few lines down, past the "if (!cmdmode)" block that sets up
> those defaults.

Oops, that's embarassing. Thanks. That means the paging starts
slightly later, but what happens in those few lines looks fairly
trivial, so there shouldn't be any real difference in behavior. I'll
add one or two tests.

Martin
