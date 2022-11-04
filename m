Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD31C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 04:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKDELZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 00:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKDELX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 00:11:23 -0400
X-Greylist: delayed 11284 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 21:11:22 PDT
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A21EC75
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 21:11:21 -0700 (PDT)
Date:   Fri, 04 Nov 2022 04:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667535080; x=1667794280;
        bh=jGGnZax5fc9dkpDfTE6mioFNE/WkfgKYkZFwcyYE1wg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sp+K3Z2mT5NF81SWWaW5UYGvdt1jf/EPU1gHlnz0tkbJZ/kAAjA9AJzqMRlSdmNHD
         I24XECv3H0rgbjmvw+WrleO0yi+BnCLSTlJD8smcc57oQIlBRz5ZADBuArYmSJTHyd
         rUGS3vmBkiL5/TQdVoqqhel9DquNJpS0wO9PwaVm31787X76c+I4xeJt8DKX6X7LKQ
         +Pupe8l8eitInSAN7D+Y+flukNy24IdPOS9r+yTWXJOUgX6l1xCOalDzkJ/rvrqnH1
         w+4aUeTn2ZvhOhCurz4cPvXOV9cF6qN15ReW4mEYDWECqDA1tR6KVoSL7XZwVGK5XE
         vsd0bb3c2tvoA==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] worktree add: add --orphan flag
Message-ID: <20221104041107.cva7yf5pdibcw3ic@phi>
In-Reply-To: <221104.86o7tnzehq.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-4-jacobabel@nullpo.dev> <221104.86o7tnzehq.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/04 02:33AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > ...
>
> Here.
>
> > ...
>
> And here we have a stray style change, in this case conforming to our
> CodingGuidelines (it's agnostic on the former), but IMO better to keep
> this out, or split it into a "various style stuff" commit, makes this
> harder to review...

I believe those changes were introduced when I ran `make style`. I can reve=
rt
these changes in v2.

> > ...
>
> ditto, we don't usually \n\n split up varibale decls.

Noted. Will fix in v2.

> > ...
>
> This is just a stray refactoring of existing code to not-our-usual-style
> (first arg is on the same line as the "(", rest aligned with "(").
>
> > ...
>
> Ditto, these look like they're too-long in the pre-image, but please
> resist re-flowing existing code while at it.
>
> > ...
>
> ditto.

Ditto the comment above regarding `make style`.

> > +=09if (!!opts.detach + !!new_branch + !!new_branch_force +
> > +=09=09    !!opts.orphan_branch >
> > +=09    1)
>
> The continued "if" is mis-indented, and that "1" is on a line of its
> own...

Ditto the comment above regarding `make style`. Also I'm not exactly sure
what the tool tried to do here but I was initially hesitant to override
the formatter.

