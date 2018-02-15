Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E141F404
	for <e@80x24.org>; Thu, 15 Feb 2018 23:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165088AbeBOXeV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 18:34:21 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34481 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163785AbeBOXeU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 18:34:20 -0500
Received: by mail-qt0-f173.google.com with SMTP id d14so1863865qtg.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 15:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=llmn3ojIbrtZZlzKmSCFuiZ8ZBRuTxiznu4nzSd39FI=;
        b=MS+o3cAGsbLu3phEVKdAol/+I48X+SJtsDAh2DBDiD2pFDCk1q61viHGW3M2qqFrUh
         lmN/LNKYt/M3xMw1TRLMibHKi1UZs4zNrPpDNZBfY6F+rL7qMw5Yf9znjvhn3O+dlaXa
         F6kCrHGT7bKnqxwzPQi2wb6PlCRZcuxoPRfRUpx8zB2yGQqhgEDHieh0L6v7aqDvf1P1
         gnoVtdj+upPEKRhglsHj7r26FglrTjlmVmCudWfykgvj5+SWLLq8nqW8bJe8WpxzLVV/
         ojugZ0Em/BoPh63lt/27K51Oll0ZmbCWJJKsfBLvYWs5VhbiWIqoI/4aK7MlkYcw2aRO
         6ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=llmn3ojIbrtZZlzKmSCFuiZ8ZBRuTxiznu4nzSd39FI=;
        b=mkLqaLqbGiOswsOdfaehCaWpmYwkDQesgvkG6Gwa9VTpwbcY/azfqJSr3Db2sgT+jW
         eDnesDB9X7LQgGm5HelyJK4VNgk90KY2RpXaDzBnkwPuEoltG9X60SpN3Us4Dr6tkugI
         ewVcokIpHd12udoRnTK5bQmSapr6g6GPwgt77wB6KYQTf0I6DWfsPkxzZPTr42GEgrnC
         GBzXfz4yJrFSSNG2ve72rUreVoSrqKWJqfmj4NhkU9m5tzKU8GW3l3j1tpgKrlIbbX2c
         TmYgybzlOET6kgaguYFyHmo6ZKIhRCBulDfLCWFmhqdXMMELyP2RxHdy4hyoHGBXFxZ4
         g+jg==
X-Gm-Message-State: APf1xPBj8fzGmNXM+hlHQZT5PkkYHd51hTuM6HnzzsZEFH7vjqdQrzs7
        4ceYzYCT2rKz64F28z9UqvLQZ+QPL5+Tgia/q5c=
X-Google-Smtp-Source: AH8x224cUPBKhRNiZv4PDb3E3isuzi0Ehucg2nJVDAdpImG5WTIJVHOtDWZfd9jfgMD10cvvrvkHNyp6eVLKkURGiRw=
X-Received: by 10.237.37.161 with SMTP id x30mr6951754qtc.78.1518737659491;
 Thu, 15 Feb 2018 15:34:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Thu, 15 Feb 2018 15:34:19 -0800 (PST)
In-Reply-To: <xmqqy3jt7ty8.fsf_-_@gitster-ct.c.googlers.com>
References: <20180213080036.3bf3a908@canb.auug.org.au> <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
 <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
 <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com> <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
 <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com> <20180212222157.0a3bd472@vento.lan>
 <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com> <CA+55aFxkYTeY9h=VHFXi=gbXsnsHCRMAVZ9=1_EsFGSqr0sj9g@mail.gmail.com>
 <xmqqfu63o2xv.fsf@gitster-ct.c.googlers.com> <xmqqy3jt7ty8.fsf_-_@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Feb 2018 18:34:19 -0500
X-Google-Sender-Auth: vNBnwzqvHAj-KTgXVLQwsKQKwCM
Message-ID: <CAPig+cSJKDH=_-hGZLpZUjC4WEyjMRAd2VPgo-Vd+sHpa4jQ-Q@mail.gmail.com>
Subject: Re: [PATCH] merge: allow fast-forward when merging a tracked tag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [...]
> Update the default (again) for "git merge" that merges a tag object
> to (1) --no-ff (i.e. create a merge commit even when side branch
> fast forwards) if the tag being merged is not at its expected place
> in refs/tags/ hierarchy and (2) --ff (i.e. allow fast-forward update
> when able) otherwise.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/merge.c b/builtin/merge.c
> @@ -1125,6 +1126,42 @@ static struct commit_list *collect_parents(struct commit *head_commit,
> +static int merging_a_throwaway_tag(struct commit *commit)
> +{
> +       const char *tag_ref;
> +       struct object_id oid;
> +
> +       /* Are we merging a tag? */
> +       if (!merge_remote_util(commit) ||
> +           !merge_remote_util(commit)->obj ||
> +           merge_remote_util(commit)->obj->type != OBJ_TAG)
> +               return 0;
> +
> +       /*
> +        * Now we know we are merging a tag object.  Are we downstream
> +        * and following the tags from upstream?  If so, we must have
> +        * the tag object pointed at by "refs/tags/$T" where $T is the
> +        * tagname recorded in the tag object.  We want to allow such
> +        * a "just to catch up" merge to fast-forward.
> +        */
> +       tag_ref = xstrfmt("refs/tags/%s",
> +                         ((struct tag *)merge_remote_util(commit)->obj)->tag);

xstrfmt() allocates a new string...

> +       if (!read_ref(tag_ref, &oid) &&
> +           !oidcmp(&oid, &merge_remote_util(commit)->obj->oid))
> +               return 0;

...which is leaked here...

> +
> +       /*
> +        * Otherwise, we are playing an integrator's role, making a
> +        * merge with a throw-away tag from a contributor with
> +        * something like "git pull $contributor $signed_tag".
> +        * We want to forbid such a merge from fast-forwarding
> +        * by default; otherwise we would not keep the signature
> +        * anywhere.
> +        */
> +       return 1;

...and here.

> +}
