Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649FAC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiLLWj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiLLWj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:39:57 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F27C31
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:39:56 -0800 (PST)
Date:   Mon, 12 Dec 2022 22:39:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670884794; x=1671143994;
        bh=GjDD4+PF2BTMvvn72dYlynpn6EQs3p3Fign7aqnVE48=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=TNl7y1vX/ukJWSTR8+uR8VvQvcRcDUr3Jr5n4oPMOCER30NR+whphrHdy8J1NmqA8
         bwVrDlPb7d8H1GDsw9A14rECN4C7V1U0EtDGzuIoR8HrT0n9MHumm6m9MbHCVxD4L9
         m9EoBj5jo/UYEl6+xSDtZu66Hfj2ksOVFY19QbqJGwdDVUxlgX9WW5+TKj0wZW6NYl
         muKYFOhfzYiLeDXMjyEDigRrptAib/VZ+xN3++uUYb0Y9yDeLC2oPg3Y8R3jFuqwIJ
         +x4jVmwUcqI9lM/sM3DZId1SFUeMm+yqlO8K2PE07SuXPudRDeIA6Ri5wL093KnN7n
         Uhf/XFcIRm+1Q==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 2/3] worktree add: add --orphan flag
Message-ID: <20221212223939.oetchpx4u7uysd25@phi>
In-Reply-To: <221212.864ju05vyx.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221212014003.20290-3-jacobabel@nullpo.dev> <221212.86tu2158bz.gmgdl@evledraar.gmail.com> <20221212145515.pohzoyllo3bgz7eb@phi> <221212.864ju05vyx.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/12 07:14PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Mon, Dec 12 2022, Jacob Abel wrote:
>
> > On 22/12/12 09:11AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> > +=09struct strbuf symref =3D STRBUF_INIT;
> >> > +=09struct child_process cp =3D CHILD_PROCESS_INIT;
> >> > +=09cp.git_cmd =3D 1;
> >>
> >> (aside: We usually split up variables & decls, I think this is better
> >> right before the run_command() line).
> >
> > Sorry, I'm not quite clear what you mean.
>
> I mean that we usually put two newlines between the last deceleration
> and the start of any code.
>
> And additionally, that the usual pattern for CHILD_PROCESS_INIT is to do
> these "flag" assignments right before the run_command().
>
> See e.g. the code in "check_clean_worktree()"
>
> So following its example would resolve the decl style nit

Ah OK. I understand what you mean now. I've made the change.

