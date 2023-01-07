Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A5FC54EBD
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 04:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjAGEpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 23:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGEpf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 23:45:35 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85795848F6
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 20:45:32 -0800 (PST)
Date:   Sat, 07 Jan 2023 04:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673066729; x=1673325929;
        bh=Q2KF8kZxPoElGpJEennh+l7+1TKhd1E2nZhfqYVtrvw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VV9RWZnyYwToz0iUfaUJ+l/qm36CqIWUSUN4CCumP70SZQ4dp75oLVDSLhYhHUDJT
         GL7PCfscCAKN0hBg7EfwsHjdtz0CfRct7OKcUpcLHsWdBMZYY0ldfr7kJFUWZ2gw8s
         7OVw2p/u/mUG7vc0ZoujlrH45gxq9os051QnuNF5w4JYK4v3/KSuv2yVuyiLsFkBJ+
         yMjSfTsigoPDklVnd+Royvpe+Y7BAnaF/V+6KWSZmKl8nU1SLwZqN1bjG2DOSo3LHZ
         G7hp8I550umjqmjAoTTUExMxZw6vMiG+OzLDXidoulTmWyJ1d0bPf6JuZXg06H83MK
         GfMGL2+TQBxww==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/4] worktree add: refactor opt exclusion tests
Message-ID: <20230107044504.lbxphqaoaa5g6z5x@phi>
In-Reply-To: <xmqqo7rbsuyh.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20221228061539.13740-3-jacobabel@nullpo.dev> <xmqq5ydvpu1o.fsf@gitster.g> <20221229065142.fmfviwisjmxsey7b@phi> <xmqqa636mskf.fsf@gitster.g> <20230106063130.v4npgjzp6dwq2p3r@phi> <xmqqo7rbsuyh.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/06 09:34PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > On 22/12/29 03:49PM, Jacob Abel wrote:
> >>
> >> [...]
> >>
> >> So from my understanding of the situation, the only two options that p=
ass all
> >> the existing tests are either:
> >>
> >> A: Use the diff in [1] without the two quote example tests included.
> >>
> >> B: Revert the changes to how this was done in v5 [3].
> > ...
> > Sorry to poke this but I wanted to confirm which path I should proceed =
with.
> > Both options are functionally complete and it'd just be a matter of cho=
osing
> > which version to push out for the revision.
>
> I think B. with "$@" -> "$*" (because you only want a flattened
> stringified version of the arguments in $opt to insert into the
> test name string) would be the more sensible avenue.  Let's not
> over-engineer the tests---it is not the point of these new tests to
> ensure that "git worktree add" can take arguments that require to be
> quoted on the command line.
>
> Thanks.

Perfect, Thank you. The revision should be out shortly.

