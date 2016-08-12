Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7291F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbcHLQZu (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:25:50 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36296 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbcHLQZt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:25:49 -0400
Received: by mail-yw0-f195.google.com with SMTP id u134so1311122ywg.3
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 09:25:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o6MV36GEY6GqmKcv8qvD5T2LWdzdcbVjipUp9UBLueY=;
        b=nK2WGPhfELmyJq1o0TzrhVdn7HCDR3n6+ScsDXUVbPWVbXyPAbTvr2mF+xV2ZrWpw+
         ZUQ3FsowgNamtgvVAGCGVKTl8g50m0SzIM/PA+9J4drNg6fDhjPNQXD/7WX8r+JsS87N
         1PZMFcPW1apD9LpGv7QNjILCpHTpfEIT7s7dfCpHTUxWVYSI59iJAC+qeXxiCEbZW/xG
         q+K0iq89b8OeXSwPIDw07VDS/fIzeAbrbuazGeloq2ICBM4vYCpZ18RhkRR7aNyITm1V
         sybvcAMc6bfvOwFLOIvChV2/xK5WJD8SHyuq1HkbP65hNHvhvMjKEMJCOarZBeE2J7X5
         8fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o6MV36GEY6GqmKcv8qvD5T2LWdzdcbVjipUp9UBLueY=;
        b=Ceff3g0FETf2U2frli4J2pCPukFf95qS9Sz/clgxPpRJpzBY01NfEWPKnBECqz+4nJ
         hdomzvcsxu0HQkmyWiV2SBEFhTmDdez0ZVoqOAEEe5yNfDVhmAgURJVhXpmJ1+84XHz6
         Dp9nuF3sYwUW5ggHbqHt6+O8hW+y+KjU3wA2rfZD1G3e9jAH/5KtaUlxvznfSpCjcQ7i
         +vQ2fWkGRaQbWjQaaV34OpI5T6cu+O3fDT/gDFh/BNnlk+0iiUqNutfumSGWqS78IYBu
         aQ/q/Z8NpAqSwltsYqu4PseSruCPatAUzJVGmWvNln8bJyuatMPJL4JwrZkYbcRRiCEi
         WxnQ==
X-Gm-Message-State: AEkoous+8g4R/KfF+836xRJVDGV91bpkNmrgOgbI3MUxqf4ayniwaxqprK/J2z4HClqN5dTJhjaM/MsWkzYi+g==
X-Received: by 10.13.209.71 with SMTP id t68mr11299322ywd.275.1471019148339;
 Fri, 12 Aug 2016 09:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Fri, 12 Aug 2016 09:25:28 -0700 (PDT)
In-Reply-To: <CAKRjdd4V3OfDnzisxBofBUmtds7q7ejUtuV_-s96eUVf7fqwHA@mail.gmail.com>
References: <CAKRjdd4WdVTgbT0gcR=a267+aEwD2Exztrc9gNau1nOXroC=ng@mail.gmail.com>
 <xmqqr39uxa33.fsf@gitster.mtv.corp.google.com> <A7A176B0-08CE-4D92-9756-51A59DF3B9D7@gmail.com>
 <CAKRjdd4V3OfDnzisxBofBUmtds7q7ejUtuV_-s96eUVf7fqwHA@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 12 Aug 2016 09:25:28 -0700
X-Google-Sender-Auth: Xlgoj3zMPCbl0JmpkkjHGM7IJw0
Message-ID: <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com>
Subject: Re: `git stash --help` tries to pull up nonexistent file gitstack.html
To:	Joseph Musser <me@jnm2.com>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 9:15 AM, Joseph Musser <me@jnm2.com> wrote:
> Oh, I'm embarrassed. The typo was mine, I must have typed `git stack
> --help`. I would have expected a syntax error message or "did you
> mean" suggestions; it didn't even enter my mind that it would look up
> whatever I typed before --help and assume it existed on disk.

I actually think you found an interesting (albeit minor) bug.
I think whenever "git" sees any word followed by "--help" and nothing else,
it blindly turns it into "git help" followed by that word. I think it
is reasonable
to expect that "git foo --help" responds with "foo: no such subcommand",
instead of "No manual entry for gitfoo".

It may not be too hard to arrange; this might be another low-hanging
fruit if somebody wants to try a patch ;-)

Thanks.
