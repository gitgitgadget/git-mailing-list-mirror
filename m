Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2371F576
	for <e@80x24.org>; Fri,  9 Feb 2018 06:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeBIG66 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 01:58:58 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39216 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeBIG65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 01:58:57 -0500
Received: by mail-qt0-f194.google.com with SMTP id f4so9378860qtj.6
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 22:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CafI/Cf2FLlumOfKAJBDiqz8J18mA45E3ufLIreeVQo=;
        b=Uu3hlXLts4rb0nTsKTaDaFe7XAbosmeffCxUBfaXImve8l4dgcwVpwyNqhxwZrIYLm
         9jL9DOEJLcSdg6hrc/qMptoJhWOgkaA6m/sK3pcbHEEknNVbnKxi0jZT8FMeMaO5Nu4A
         HrylQe5l50nn7f/gUs1sJ8i4lKEVHj7dou8/RgsZDMBEHyU5hX+bnK4WKHZjrUie3RE/
         eC30YAb9I57x5eDhGpnW8f1NhMrgZv1JvHy5pKhpu0S9L5UzdXGDbTY5Pnk8e236Afst
         fiZPUQxkCsVrZLy9fLbblaxvEBxPeOvMMqs6ifqGKzDseEMA/YYF72x0FzOCiidFReYm
         XsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CafI/Cf2FLlumOfKAJBDiqz8J18mA45E3ufLIreeVQo=;
        b=WKtJSCTN2vGm4i5zuAdhhfXrN1Jel6ou09mv1WkQqFLhbznk4qcfYqAnIvveseSLvj
         a4oTo6ageryS0W7QdO8lP6IxVUwYwSO/DDoF2HAoqzayWcOj/d9OlBo+yltU4++mkWCV
         9Sh3PGeFn4vcwxcoDdi+bm6L8GYZDbn9yDFtUHFZ/gZuZJh3zppwuXa48s5tWfAm+9xw
         I4qIB9g3BXI2WbaHsaX2mYvw7X/RSGg4KDXxOLXRH4e5xjBpRypDUfGAgXEiVqKvt8gV
         d+0yhhkDMl5lU0EBL6a7e/j+2qhfymBSyI6Et8YJYorwI5UWu/TnILw/GSa0I1acXJ71
         ubQA==
X-Gm-Message-State: APf1xPA0FS09ASjTvLRDrpjI7ZSMlfExuIOApsiCtlUdGxwcVT8GU8as
        wsj/NptgWImg3fFG4V3acIL9tJE1UvmBg0kX8YI=
X-Google-Smtp-Source: AH8x225BYwhgEcbJ85YkmaqNLQ3jzKmMB68+EhXeyjRm7qrYT+FvWGcTsRpiXIhyT+QhBUjtkh5BJJViAHrfyWiRfBw=
X-Received: by 10.237.37.168 with SMTP id x37mr2882917qtc.78.1518159536629;
 Thu, 08 Feb 2018 22:58:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 22:58:55 -0800 (PST)
In-Reply-To: <20180208161936.8196-17-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-17-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Feb 2018 01:58:55 -0500
X-Google-Sender-Auth: AUe62ZOgJFQTQRRkM3Ysux1VxeU
Message-ID: <CAPig+cS3OCi9CDykF-5EAx=J3ouXPo+7HE_CB8DfmWccBxyxgA@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] fetch: add a --fetch-prune option and
 fetch.pruneTags config
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
> Add a --fetch-prune option to git-fetch, along with fetch.pruneTags
> config option. [...]
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -592,6 +592,15 @@ test_configured_prune_type () {
> +               if test "$fetch_prune_tags" =3D 'true' ||
> +                  test "$remote_origin_prune_tags" =3D 'true'
> +               then
> +                       if ! printf '%s' "$cmdline" | grep -q refs/remote=
s/origin/

Is $cmdline guaranteed to end with a newline? Historically, not all
'grep's would be able to match the last line if it was not properly
terminated. Perhaps you want '%s\n' instead?

> +                       then
> +                               new_cmdline=3D"$new_cmdline refs/tags/*:r=
efs/tags/*"
> +                       fi
> +               fi
> +
> @@ -705,6 +714,66 @@ test_configured_prune true  true  unset unset kept  =
 pruned \
> +# When --prune-tags is supplied it's ignored if an explict refspec is

s/explict/explicit/

> +# given, same for the configuration options.
> +
> +# Pruning that also takes place if s!origin!<file:// url of remote>!,
> +# or otherwise uses the file://-specific codepath. However, because
> +# there's no implicit +refs/heads/*:refs/remotes/origin/* refspec and
> +# supplying it on the command-line negate --prune-tags the branches

s/negate/&s/
s/--prune-tags/&,/

> +# will not be pruned.
