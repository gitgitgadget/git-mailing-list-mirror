Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F15C1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 05:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbeBIF0a (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 00:26:30 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38494 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeBIF03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 00:26:29 -0500
Received: by mail-qk0-f195.google.com with SMTP id w128so8651777qkb.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 21:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WVIXhAZDRE1KLFyyMl0KhT/IHTPHZ9pVQnsrCXYU/6w=;
        b=ceb2T+um6kiTPIdBKK9JboyJ4Sv2FIku0NQOwzllY0aTB3wxEyxfydQktz01EpB+XO
         z6tBpWVDs7S+NIsR90Yn6YqSvOTyoPM+Xd3/jXTHU85+uaqGFC3emoq3kES3Bf+JbI7z
         j7/o91i3hmnfaAMPM0C0TOsjA3zpX+9lTlMx7yLiBekb/WcBFkQSsJ+Jhc45ddGOWr4Q
         +6NGG5Lv0WBhIJ7ZFRryn7PNVSVzdkfMyPgjyMfb6dDue7NQAWloixNnUtE2N2skJ2Qn
         aAObxHCN2wBZ/eJyvOCC1eyN8jkQgqoyVoTkS4sArofdfXUk+ruhRPFj9uQn75DDJxzf
         ubLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WVIXhAZDRE1KLFyyMl0KhT/IHTPHZ9pVQnsrCXYU/6w=;
        b=g4qvP0vin1ZBNCEiF2zqvtZ0X5GawNavmFIAYKt2b65aKZF7CCoM7mFD03i0C5NdNS
         nSNXmOYzQd9yLFX2J71hquThQ+LCMRIHjs4Ik3FZbo5Hn5/m/anKlclRJd+xu6sK1+k8
         HH/XpYMhliGhWitUbXoa2lAo/qi9/uLAGtk1wQyXiTteYVnBneiByl4rEV/w03n5i2cj
         RnSwMmw7x/rI6CRKdH4aAB41R+c+wS18P7+6UKN1hq5u0akECDivU9ROxDHZQ1WsNtth
         5IcHUFSMrwnLipUH72Bg51wS2Qin0EJLUKXVq84Pkt/7o41Dql7AYab6xyuno/RLb2MY
         AK/w==
X-Gm-Message-State: APf1xPAje30ZcMnJBplg3sXTrZx2Z0gI69IP99cGs2ogcPDZ3U/CBZa7
        U1Gvyi4V+eSFAYZ54PUco1P4T2fHZj7TZ/fAmPw=
X-Google-Smtp-Source: AH8x225tNBRAO0CUE/FOK4AK3dZ6bGZOcazLqbjncwHkTrWTpPiVe7oh941Aw9oDJv1tS1n63Ts5eGiLARuWLe6H0mY=
X-Received: by 10.55.221.76 with SMTP id n73mr2125358qki.53.1518153988420;
 Thu, 08 Feb 2018 21:26:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 21:26:27 -0800 (PST)
In-Reply-To: <20180208161936.8196-13-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-13-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Feb 2018 00:26:27 -0500
X-Google-Sender-Auth: DUa_9iJG_Dp2ScURKElkGV1Nsn4
Message-ID: <CAPig+cTa0UeUyLRL93ZPYvauiFpmn9Yur0=Ou+Abr=UUeqiPSA@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] git fetch doc: add a new section to explain the
 ins & outs of pruning
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 11:19 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Add a new section to canonically explain how remote reference pruning
> works, and how users should be careful about using it in conjunction
> with tag refspecs in particular.
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> @@ -99,6 +99,55 @@ The latter use of the `remote.<repository>.fetch` valu=
es can be
> +PRUNING
> +-------
> +[...]
> +If left to accumulate, these stale references might make performance
> +worse on big and busy repos that have a lot of branch churn, and
> +e.g. make the output of commands like `git branch -a --contains
> +<commit>` needlessly verbose, as well as impacting anything else
> +that'll work with the complete set of known references.
> +
> +These remote tracking references can be deleted as a one-off with

I think we call these "remote-tracking" (note the hyphen), which are
local but track something remote, rather than "remote tracking" (no
hyphen) which would themselves be remote.

> +either of:
> +
> +------------------------------------------------
> +# While fetching
> +$ git fetch --prune <name>
> +
> +# Only prune, don't fetch
> +$ git remote prune <name>
> +------------------------------------------------
> +
> +To prune references as part of your normal workflow without needing to
> +remember to run that set `fetch.prune` globally, or

s/that/&,/

> +`remote.<name>.prune` per-remote in the config. See
> +linkgit:git-config[1].
