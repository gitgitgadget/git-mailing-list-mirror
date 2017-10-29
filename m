Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0361F202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 17:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdJ2Red (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 13:34:33 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:51953 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdJ2Red (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 13:34:33 -0400
Received: by mail-qt0-f172.google.com with SMTP id h4so13794107qtk.8
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5VSSwAUtwKMvv/1AJzJp/utf7PsHvO3Gize1g2qPclw=;
        b=sxYZ2BJM7HF+xKeCKyIXPfGdLiHQBSsYJ76n+HOaMDyhN53Yeq+8HWV6TN+uZG+UZE
         4l1PFGd6NdSkXp+qOcdD1nuktmDh4+APGEPmlI6ug8pSt36ZAHLbb050XGpBSwG8WCMu
         7nNdj1swPXZ5LpYWk6f2nfduGYtC+sfVi8NPKMbJ+cw38utd3ZUtUYfyTqYC9dpMBF59
         4uKCQFHSfTmWjKUhgb72YoGfHktHOa9BtbkhN46AUDUPF4rOvfDBRDLbVALKTq9jlO6H
         9BWJiQJ9etzE7bJHFVrW9WU1MMNSA00Rya8tNZD+hauxmIrxTjhA+zA76/SSQp0lIsho
         BQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5VSSwAUtwKMvv/1AJzJp/utf7PsHvO3Gize1g2qPclw=;
        b=Id8+At2GFER2idFFFtF5HDl5rFlejms6i1+eYuysgE8uNOEQ1IrJIvIEl5UmMMO8kh
         xxQue4pkUvosOZWyy5ZO/+C0OWY/k4cxveN02Erx2Cfvb5R12Kmw1I8W3l53fkAFGXgy
         wElJco4LgxJ1krIs/AxTZIIsdw8IRfm+N/AEIbvd7TY8S5oM3SIlkti7ZEqbHU0ii2pV
         IW9GlUKDGY1NituVrwNlJav3BomkpqGZx5EiImXunVAVQEQ5e37eJp/jbWXeFjZjotBO
         Bl1mMfsV1vti7n5i+Tl4CkUcmrd5lBki2/iAeQywQoox0fT1rHhY+MbvDwoXOrwEiDj4
         zQlg==
X-Gm-Message-State: AMCzsaWzgmkBitQnzwqa7zyVKCU4YHFM4YSICrngWjLV/1tS2+60OTb4
        Uw+jGiLjgL0ElGE6PTNf7gfSNrcyGCtEUF0GDC0=
X-Google-Smtp-Source: ABhQp+TWtahNnuGZF5kR8idcF5h19waK+oC9l2YtibVSDHq9vfg4xw4sgTwdT4CLB/I50CKc5Bo+Jy9dyT27mfuKNI0=
X-Received: by 10.200.16.136 with SMTP id a8mr10428196qtj.177.1509298472136;
 Sun, 29 Oct 2017 10:34:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sun, 29 Oct 2017 10:34:31 -0700 (PDT)
In-Reply-To: <20171029160857.29460-4-anarcat@debian.org>
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-4-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Oct 2017 13:34:31 -0400
X-Google-Sender-Auth: ff9eaEBeFHhGaRig583HBB1y6AE
Message-ID: <CAPig+cSkwD35wK7Z_qZZusKWWBC5CU6AnbF9g_g907uqpeYQsw@mail.gmail.com>
Subject: Re: [PATCH 3/4] remote-mediawiki: show known namespace choices on failure
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org>=
 wrote:
> if we fail to find a requested namespace, we should tell the user

s/if/If/

> which ones we know about, since we already do. this allows users to

s/this/This/

Not sure what ", since we already do" means here.

> feetch all namespaces by specifying a dummy namespace, failing, then

s/feetch/fetch/

> copying the list of namespaces in the config.
>
> eventually, we should have a flag that allows fetching all namespaces
> automatically.
>
> Reviewed-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> ---
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-=
git/git-remote-mediawiki.perl
> @@ -1334,7 +1334,9 @@ sub get_mw_namespace_id {
>         my $id;
>
>         if (!defined $ns) {
> -               print {*STDERR} "No such namespace ${name} on MediaWiki.\=
n";
> +               my @namespaces =3D sort keys %namespace_id;
> +               for (@namespaces) { s/ /_/g; }
> +               print {*STDERR} "No such namespace ${name} on MediaWiki, =
known namespaces: @namespaces.\n";

Probably want to drop the terminating "." in the error message.

>                 $ns =3D {is_namespace =3D> 0};
>                 $namespace_id{$name} =3D $ns;
>         }
