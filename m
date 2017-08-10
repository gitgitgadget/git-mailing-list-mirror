Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81151208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdHJR1p (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:27:45 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36970 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbdHJR1V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:27:21 -0400
Received: by mail-lf0-f46.google.com with SMTP id m86so6428781lfi.4
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lCR6eHEGopvNgnr9Y/ORRSTRoQ9sfTyDA2ja/OAdW/0=;
        b=AKSJP1+nWTEmba92NlREnQ0k/Ix+lzlUIqpYOsPBjOVyuS9Uqy4Vua0xqW1saJbKD/
         FYF64YzNPY03CbyHI8/RzYXeOp4QreNNudGgVeaQe6qhTFqkN0jAm1iKeUBH+SP2x1NT
         vHzvZk/MVn7kVf2wA9OCOH33+iQuk5BDX1hGBAjyTjpE2MlHvD0ZEFQI8tAXMq4VtjhP
         xlOMR1oKUe8Cf6vOcKxonEhal8WNosRqYt7krsIO2EcdyU4gtLrsQQf1yk/nCl5NAoGg
         X0N6suIYlIzxqWUmkyL8E6nbfyO55CyzvC1CMJcbwsou0pjAkHZFeLvm7HqaIXGofAJg
         lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lCR6eHEGopvNgnr9Y/ORRSTRoQ9sfTyDA2ja/OAdW/0=;
        b=UR13FcC62X/KgyOrV9DhZDjpMakdU1qdPyII4hMuWQ1jFZKorpe/xLNfodC4/iSb/q
         HN8O7BaEK5LlSMXhggBvOT7jf+5jfShuPbY+BpPd/Koa7Wz198J8906UMq/tlDqKcMb1
         JAmhLYpSyFiWwafbR6JZBfBOwk3ScYA64yMiHs32V/bK/1DloJ0kA3upgL8wrwUdUuZK
         w+30VJYDPR3rX+LlSPAnP1SP7EpUyhpVYTqIwvuY77xuO5WkOo2PAf1G4rvLPyvUnfNJ
         bVsxJE4HaoPjIY8IJo2BeUfgrAUmCdBxu+4eBEzBF3b/nTvGJATfv85Cwgt+w0yMPGXj
         mKOA==
X-Gm-Message-State: AHYfb5j0DD55o3leiSFak7NB/8s2yXF9A178faymd5deQaybbjJroovs
        cRgW845zyprvfokyhHKuqMdNuydtuSIL
X-Received: by 10.25.228.206 with SMTP id x75mr3844014lfi.94.1502386039972;
 Thu, 10 Aug 2017 10:27:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 10:27:19 -0700 (PDT)
In-Reply-To: <20170810073239.ny64rqmwb3yqbpb6@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net> <CAGZ79kYqq_EhRxckM4iV=99r59Y7_y94j+-65xXLUF4y2vNUUw@mail.gmail.com>
 <20170810073239.ny64rqmwb3yqbpb6@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 10:27:19 -0700
Message-ID: <CAGZ79kYHPhaZLSsBq2vM=D+_QMP9MY=xYjRwfG5q36neFyNH3w@mail.gmail.com>
Subject: Re: [PATCH 3/5] interpret-trailers: add an option to show only
 existing trailers
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 12:32 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 09, 2017 at 11:18:19AM -0700, Stefan Beller wrote:
>
>> On Wed, Aug 9, 2017 at 5:24 AM, Jeff King <peff@peff.net> wrote:
>> > It can be useful to invoke interpret-trailers for the
>> > primary purpose of parsing existing trailers. But in that
>> > case, we don't want to apply existing ifMissing or ifExists
>> > rules from the config. Let's add a special mode where we
>> > avoid applying those rules. Coupled with --only-trailers,
>> > this gives us a reasonable parsing tool.
>>
>> I have the impression that the name is slightly misleading
>> because 'only' just reduces the set. it does not enhance it.
>> (Do we have a configuration that says "remove this trailer
>> anytime"?)
>
> No, I think you can only add trailers via ifExists or ifMissing.
> I actually called this --no-config originally, because to me it meant
> "do not apply config". But the processing applies also to --trailer
> arguments no the command line, which is how I ended up with
> --only-existing.
>
>> So maybe this is rather worded as 'exact-trailers' ?
>
> I'm not fond of that, as it's vague about which exact trailers we're
> talking about. I also thought of something like --verbatim, but I'd
> worry that would seem to conflict with --normalize.
>
> I dunno. All of the names seem not quite descriptive enough to me.

I meant 'exact' as in 'exactly from the patch/commit, no external
influence such as config', so maybe '--from-patch' or '--from-commit'
(which says the same as --no-config just the other way round.
Having --no- in config options as the standard is a UX disaster
IMHO as then we have to forbid the --no-no-X or reintroduce X
and flip the default)

Maybe --genuine ?

>
> -Peff
