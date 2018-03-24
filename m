Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CC31F404
	for <e@80x24.org>; Sat, 24 Mar 2018 12:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeCXM6F (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 08:58:05 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:45946 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCXM6E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 08:58:04 -0400
Received: by mail-oi0-f42.google.com with SMTP id 71-v6so12525755oie.12
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gw0kF3LEYW2aXLVUPqFmTpJunPRk4oDVvKv+TbTfKWg=;
        b=U/rMZsCZcAicod9QBzfXXzPhAuEhebjel+MmI96wW43bbdiK3jxkxpPElDbnSJ28sM
         2ctrXPCxb3z4Mh/j9iEuxIlqyzszIwwxmx3u/jykGa8atL/ce7CHmprlhYJRR67bJ4K+
         NG9qdtWTzNNBHmFKh0YaBmAiw60rIDRJlEDkZ7gioVb1jtesUzRZF8qgiWP/8pByJhoq
         6LdJjZ4uWkqowqMrAIXUNWkP6NGy4mC+JfEZ9uFvgS10scvd2qLrcuDzxnfurCzv8woH
         ne3Vy0v4FvqPCVVY3teU09eI5a69pPI+LD9hhNImKmxO9ZqxYjJlobrMFNl/UVafm/yL
         hKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gw0kF3LEYW2aXLVUPqFmTpJunPRk4oDVvKv+TbTfKWg=;
        b=laFOX/G9zVRUrT2ydIhrRJYVpJLaUha2TgBiPhKUtdBZhkWr8KIujtFfoylcR0UTLR
         Ryng/VrIJ1Qgl9/i4YRBoTOo9XSxdR7eUy7WUaEn83W80fzqCtkjjVdha/aWVcvT3Eo2
         I9dG5vASef5vzTl9kJ1N1Rr2KBfxlci7BgBFqSwJgi6tu6DZhAd37MySYnqPZ20KR5S6
         TXYwROZ0XMwsXoWa1s5J4Ktdaef4XeZEqEPJKcMKLD9XBTbfX4ITCFdjohmsQpssUFaz
         +n2i5ke4uuflOikkogr4E4Zci5tOxRmnna+NXAVNklVHUQv/Fbgx2gwQ8eE8bVKyNJrX
         SBdQ==
X-Gm-Message-State: AElRT7GHVxuPzaCZ0hhlEuzhQifhAfRGBPAh0yeRBeN0xzDIKeHjsQKA
        RVFdwcfeOC8EoDpReUTTLzkZ886lim0lt1CYDn4=
X-Google-Smtp-Source: AG47ELt3PTZHE4RmiymdcBUI1dG5uHOrWlGpnoofNie5dehVTSfpdBYe6tYdNnmzdXFvD80Mtx/CSfx3qFY/1TQ/mzU=
X-Received: by 10.202.206.13 with SMTP id e13mr19491359oig.34.1521896284201;
 Sat, 24 Mar 2018 05:58:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sat, 24 Mar 2018 05:57:33 -0700 (PDT)
In-Reply-To: <87bmfdy6vg.fsf@evledraar.gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com>
 <87bmfdy6vg.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Mar 2018 13:57:33 +0100
Message-ID: <CACsJy8A=qRN6VCP_NwTdtuZWEgsnX6U+zQN8LK8F9FT2XvBaRA@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] Combine t/helper binaries into a single one
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 1:50 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Mar 24 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> v2 fixes a couple of typos in commit messages and use the cmd__ prefix
>> for test commands instead of test_, which avoids a naming conflict
>> with the existing function test_lazy_init_name_hash
>>
>> [the previous v2 send out was aborted because I messed it up with some
>> other patches]
>
> This whole thing looks good to me, and I've applied it to my own build
> and run several modes (normal, split index etc.) of the test suite with
> it. Didn't get any problems.
>
> Micronit: If you M-x sort-lines (and I assume similar in other editors
> that have a function to sort stuff in ASCII order) the test-tool.c list
> you get this diff on top:
>
>     diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
>     index cd5e28b045..c38939b93e 100644
>     --- a/t/helper/test-tool.c
>     +++ b/t/helper/test-tool.c
>     @@ -32,8 +32,8 @@ static struct test_cmd cmds[] =3D {
>             { "revision-walking", cmd__revision_walking },
>             { "run-command", cmd__run_command },
>             { "scrap-cache-tree", cmd__scrap_cache_tree },
>     -       { "sha1-array", cmd__sha1_array },
>             { "sha1", cmd__sha1 },
>     +       { "sha1-array", cmd__sha1_array },
>             { "sigchain", cmd__sigchain },
>             { "strcmp-offset", cmd__strcmp_offset },
>             { "string-list", cmd__string_list },
>
> I think it makes sense to keep such lists in ASCII order (" before -)
> for subsequent edits where one or more things are added to the list and
> then sorted before submission.

Yeah, my brain just failed to see that sha1-array should be behind
sha1. Bad brain!
--=20
Duy
