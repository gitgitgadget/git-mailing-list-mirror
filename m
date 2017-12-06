Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C2820C11
	for <e@80x24.org>; Wed,  6 Dec 2017 15:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbdLFPk5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 10:40:57 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:35204 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdLFPk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 10:40:56 -0500
Received: by mail-io0-f175.google.com with SMTP id q15so3092857ioh.2
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 07:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sourcegraph.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=bQp+DEj5UIhbpacfzwr8E3ramTad08L2Pj19lUTcX5Q=;
        b=B3Yr6xhQ+ybGS1GjnubjygQHVg1WKlJ5/+kI+u3vscu5tjZiMBM9GUjnG02awPDUPg
         RbrYPJgrqDjQT3jI8TtJ+BuNlXtmD4DqeCmYoG2RmSMbtmP8NAqraIWsElk2oCH6RkzS
         6DGomY8q4QB5GQDITgqSX9Wimd6B8xgqV8b+XNC1C30VAQuadiZX5jA7WAeqoZXj+AyH
         tEx8dtCSgu7RVfBwBvSBt4MhCZTP+CzpEUEu/Qk7Ws3Wf9dgDwaK32NLcH/ikCGXkolG
         Cb5XuSySO6LAloF6hSWDli0pk1tTGEwgh/uCoURXeXIlZIzQNyjKQ2ZKbXYlxZm4N6VS
         Hy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=bQp+DEj5UIhbpacfzwr8E3ramTad08L2Pj19lUTcX5Q=;
        b=YPdsY5bbBPYvjoVKVwH+7Mv0uqbxOQdsfw4nd8NuVqueXjpHfsBppCiF0VSo+MXWkO
         PHASM3yjAmSD3RMx3pMLOSVFVTWMqmuM2ZcyVbvZq8Hvc2vd6E5oxS5h3+F+908R4zha
         2cP7h9tGpkxLlw9BEA8fAjGxM0kqNC0Kfsh9TOHSMFC8doA/Lxf0BTReLCtK4wGVIsRg
         0rVAs21g4qdh9qc7+DykG35pvrhyeTHU54m1FvyMoU6aiNHHg4PVCasVuUHSnYS8e+/S
         g9jxdWdvhxHeIiaDtiabto9g7byIUSNICPzeuFXfC8H/JZwBD8W1m9jxTdidD2o9lh7g
         fo/A==
X-Gm-Message-State: AJaThX640cDt5XmnIIvy/jkD4GgM2hjds3LGGVdI4lLkh3RKbFv5Yj2n
        Lio2Ir3zSRu6LxTUAcRIou0cxCPED7j7hQKS//Wk/tCG
X-Google-Smtp-Source: AGs4zMbsuDRQz7gzxRe0LkgRtSombL7dTN/1kTdJa9GRDEgdiJLKIpPZDceSKMel/dT8etctVLS66maVR/d3Gy5JUL4=
X-Received: by 10.107.88.7 with SMTP id m7mr34121189iob.65.1512574855942; Wed,
 06 Dec 2017 07:40:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.7 with HTTP; Wed, 6 Dec 2017 07:40:35 -0800 (PST)
In-Reply-To: <CA+SQVf1W6BhNyB6bGxh7WfCwb6+E3pNjHLeS4xDYPJ6BLT8cng@mail.gmail.com>
References: <CA+SQVf1W6BhNyB6bGxh7WfCwb6+E3pNjHLeS4xDYPJ6BLT8cng@mail.gmail.com>
From:   Nick Snyder <nick@sourcegraph.com>
Date:   Wed, 6 Dec 2017 07:40:35 -0800
Message-ID: <CA+SQVf24rcQ1iKAQBW0Ky7Qm8zuF3Esw8qMKvG+KCbCA-mCcfA@mail.gmail.com>
Subject: Re: git blame --reverse doesn't find line in HEAD
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This can be reproduced on Linux and Mac. This behavior seems to be a bug.

On Wed, Nov 29, 2017 at 12:06 AM, Nick Snyder <nick@sourcegraph.com> wrote:
> I have a repo that reproduces a behavior with `git blame --reverse`
> that surprises me. https://github.com/nicksnyder/git-blame-bug
>
> The readme explains the observed behavior and what I expected to
> happen. I will inline the readme at the bottom of this message for
> convenience.
>
> Am I misunderstanding --reverse or is this a bug?
>
> Thanks!
> Nick
>
> $ git --version
> git version 2.15.0
>
> Blame of L465 in Tree.tsx at HEAD (ca0fb5) points to L463 at 199ee7
>
> $ git blame -p -L465,465 Tree.tsx
> 199ee75d1240ae72cd965f62aceeb301ab64e1bd 463 465 1
> filename Tree.tsx
>             public shouldComponentUpdate(nextProps: TileProps): boolean {
>
> EXPECTED: Reverse blame of L463 at 199ee7 points to L465 at the
> lastest commit in the repo (at least ca0fb5).
> ACTUAL: Reverse blame of L463 at 199ee7 points to L463 at 199ee7.
>
> $ git blame -p -L463,463 --reverse 199ee7.. Tree.tsx
> 199ee75d1240ae72cd965f62aceeb301ab64e1bd 463 463 1
> boundary
> previous ca0fb5a2d61cb16909bcb06f49dd5448a26f32b1 Tree.tsx
> filename Tree.tsx
>             public shouldComponentUpdate(nextProps: TileProps): boolean {
>
> The line in question is in the diff (git diff 199ee7..ca0fb5), but
> that particular line is neither added nor deleted, so I don't know why
> blame would think it is deleted.
>
> Relevant hunk in diff:
>
> @@ -452,28 +462,17 @@ export class LayerTile extends
> React.Component<TileProps, {}> {
>          }
>      }
>
> -    public validTokenRange(props: TileProps): boolean {
> -        if (props.selectedPath === '') {
> -            return true
> -        }
> -        const token = props.selectedPath.split('/').pop()!
> -        return token >= this.first && token <= this.last
> -    }
> -
>      public shouldComponentUpdate(nextProps: TileProps): boolean {
> -        const lastValid = this.validTokenRange(this.props)
> -        const nextValid = this.validTokenRange(nextProps)
> -        if (!lastValid && !nextValid) {
> -            // short circuit
> -            return false
> +        if (isEqualOrAncestor(this.props.selectedDir,
> this.props.currSubpath)) {
> +            return true
>          }
> -        if (isEqualOrAncestor(this.props.selectedDir,
> this.props.currSubpath) && lastValid) {
> +        if (nextProps.selectedDir === nextProps.currSubpath) {
>              return true
>          }
> -        if (nextProps.selectedDir === nextProps.currSubpath &&
> this.validTokenRange(nextProps)) {
> +        if (getParentDir(nextProps.selectedDir) === nextProps.currSubpath) {
>              return true
>          }
> -        if (getParentDir(nextProps.selectedDir) ===
> nextProps.currSubpath && this.validTokenRange(nextProps)) {
> +        if (!isEqual(nextProps.pathSplits, this.props.pathSplits)) {
>              return true
>          }
>          return false
