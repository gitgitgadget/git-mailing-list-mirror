Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F6DC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjAIRM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjAIRMW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:12:22 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AB459D2A
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:11:26 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:11:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673284284; x=1673543484;
        bh=gTvu0zsk7RyEZ6B6ZA8nBL5YJEa/eWJxp5VUy8VSnKc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=N4rR9boJZcazki691rEXwVX2q346s3CzONWK4pYmIn2ZJS0bXOOBbHaMpCqNMnXr+
         OHGilWcCMrgzTA4HWQAY3YYlqIUj2heTcZEKbNV6uWErP+d56UtcLlzTgCjqS9Upgp
         xgMWeQKl/9pup0zzKaFEFljgGKUX5n3R0OOk1/PCOPa7lUD0qlhSFMU7xt+em4zMds
         kzAaugthICqE5iVzDlvHAEUEbXjsCHDAtjozkVnly7MHSDwpdpvOwkjJ7eUerYEV9r
         ChAoh9T02qRUuQnYMmr+qOmBLvC+ZXnIm6QoTLNtDDuP299QFyNmknQj6wzT0y4i2W
         v8wBA/aOuyP+A==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20230109171100.6jj65aktyohtykid@phi>
In-Reply-To: <230109.86r0w328nu.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <230109.86r0w328nu.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/09 01:26PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Sat, Jan 07 2023, Jacob Abel wrote:
>
> > [...]
>
> This round looks good to me, except for a small tiny (and new)
> portability issue that needs fixing:
>
> > [...]
>
> Good to get rid of this.
>
> > [...]
> >     ++=09=09grep -P "fatal:( options)? .* cannot be used together" actu=
al
>
> This is the new unportable code, the "-P" option is specific to GNU
> grep, and here you're relying on the "?" syntax along with other
> ERE-like syntax.
>
> It looks like the minimal fix here is to just change -P to -E, which we
> can use, you're not using any PCRE-syntax, but just syntax that's part
> of ERE.

Understood. I have made the change and prepared a new revision already if t=
his
is all that needs to be changed. I can submit it at any time however I was
unsure of whether it was considered bad etiquette to submit new revisions s=
o
close to each other.

