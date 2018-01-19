Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7706C1FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755088AbeASAqr (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:46:47 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45050 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755030AbeASAqq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:46:46 -0500
Received: by mail-qt0-f196.google.com with SMTP id m59so136515qte.11
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XDMc6N/uxCj+OY56W6OoBF1Ic8d0HrgGRLCiG+Oa908=;
        b=plX8KIRXtnFJ+0Vg3rcnKwAhcHVnoPLo1dWv4P83YUiis1TQQMFTXCybjHGYC9x35h
         eqqOlNdIS1b0IvqJEhUTqQqCemvkrFEyn5qJA1HVwdZipvFgBxMvXkE4jRCIZ2bDIJ25
         pKvb4AW2pz9ftpq5Tjy93Vvv7VBr+C/djLBYIMNR7t06YCZRGKAFci7qNhkW3shXxHmb
         I9mSKPFQ6ZF/AgjYu0hygDGwa5gozsi2FkFdAouv+QJngk0IMfndt4dP1ZBzkxc9LWyQ
         d4QU3M/iumXRm5/otJKBidORu2rQ2HPIsZ9GeuE+avZDgqHyNIsVSTNYerwkwlD0Ardb
         +p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XDMc6N/uxCj+OY56W6OoBF1Ic8d0HrgGRLCiG+Oa908=;
        b=JTeadzOw+8eaBMR4SvGDw1UaFwNitOa+/TkpKBvC6UajgGVPcmOSU3j2cnfHmKMEnX
         Maj6DWfFuirD8SxDiRQvPg3tvSEva6T+rdr5kJOu2IDq96fDL5BO5L3xxDLZr+6SXK/T
         1ZO+laB9qHBdpLXzgS7Pqo2NjPAEBKwHj+eY0ylKV05DE/+smGMc0do8wilq5rLaleFh
         TAwuYYaLGKzCGDu05ppMBN+++bag5Z/GNanEvbY7xyR2FLb6Fp1huuNSCFg+z5Vv5pbs
         yilkMb3c3mFga/q01Q7dedwxOAjnzbnaI5SyXQ6ykr/mJ5NrRFTUPuBPbstpXLKHrrmt
         k8+A==
X-Gm-Message-State: AKwxytd4S+UqbcYLHhE6W3GT/0m1KSk3ZH2eZxLnabtA7sEg8hkRZ675
        U36ESucxn7dkgIyhGUaNqYehsok7Ik38uD0g4rI=
X-Google-Smtp-Source: ACJfBovUEvDe+DVOQeGY/Kb4GtDiNpXhF8FZ6xTAKGkyc3cy9a5takCh65emYE93Y9Z5QWlSJhxRFkJ4vgh4DcttBYI=
X-Received: by 10.55.116.71 with SMTP id p68mr63418905qkc.164.1516322805639;
 Thu, 18 Jan 2018 16:46:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.143 with HTTP; Thu, 18 Jan 2018 16:46:45 -0800 (PST)
In-Reply-To: <20180119000027.28898-7-avarab@gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com> <20180119000027.28898-1-avarab@gmail.com>
 <20180119000027.28898-7-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Jan 2018 19:46:45 -0500
X-Google-Sender-Auth: sSMzcHobuiL_p-PoK6mH4YIz5o4
Message-ID: <CAPig+cRVHQQR_V+GH1X-KVBtCRkGq=PewOQJu6WcnVa6N+sRNA@mail.gmail.com>
Subject: Re: [PATCH 06/11] git fetch doc: add a new section to explain the ins
 & outs of pruning
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 7:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Add a new section to canonically explain how remote reference pruning
> works, and how users should be careful about using it in conjunction
> with tag refspecs in particular.
>
> A subsequent commit will update the git-remote documentation to refer
> to this section, and details the motivation for writing this in the
> first place.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> @@ -99,6 +99,55 @@ The latter use of the `remote.<repository>.fetch` valu=
es can be
> +PRUNING
> +-------
> +
> +Git has a default disposition to keeping data unless it's explicitly

s/keeping/keep/ or s/to keeping/of keeping/

> +thrown away, this extends to keeping a hold of local references to

s/away,/away;/
s/to keeping a hold of/holding onto/

> +branches on remotes that have themselves deleted those branches.
> +
> +If left to accumulate these stale references might make performance

s/accumulate/&,/

> +worse on big and busy repos that have a lot of branch churn, and
> +e.g. make the output of commands like `git branch -a --contains
> +<commit>` needlessly verbose, as well as impacting anything else
> +that'll work with the complete set of known references.
> +
> +These remote tracking references can be deleted as a one-off with
> +either of:
> +
> +------------------------------------------------
> +# While fetching
> +$ git fetch --prune <name>
> +
> +# Only prune, don't fetch
> +$ git remote <name>
> +------------------------------------------------

Did you mean "git remote prune <name>"?

> +To prune references on a remote as part of your normal workflow

This reads as if it's possible to prune something on the remote
machine itself. Maybe just say:

    To prune references as part of your normal workflow...

> +without needing to remember to run that set `fetch.prune` globally, or
> +`remote.<name>.prune` per-remote in the config. See
> +linkgit:git-config[1].
