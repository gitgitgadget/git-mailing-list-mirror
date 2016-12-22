Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646581FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 21:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966777AbcLVVTC (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:19:02 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34749 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbcLVVTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:19:00 -0500
Received: by mail-ua0-f175.google.com with SMTP id 34so57135169uac.1
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=qTtWMopjK7DWlr+faTQxFCTd936djJtbBeXCcd7goRo=;
        b=ZTVjbScm6ITuXdU/6Jyklig0kCNtc6kBZnpdmg/6gYPh0dE2UeBXsywZ0IRgUXqSE6
         dYQnxG3n0I3m4nzigNwrepxYQOv5wyDDv77XowCMjZx7pzu+V2CtuxMs9JlnQ70ixD4S
         5uqvrx7srqSXvNfOpCaMq8WgbnXlG1aSgtKld0al2fzMmXdEcRYvgBCJd6hndhp192ag
         kvrrD0PSElHG1Qp/NkUFdC/THbJ5PsbPSl3VXKK4nUMb0IvwrEdpndxNaAnRgRQcUgx9
         IUTQSvz1mWjQI6Lz7BZEkVbWMT4c8x0JrJj6r7WuvS9n8clwthi6i6SKOsqqmTjx6iwS
         lLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=qTtWMopjK7DWlr+faTQxFCTd936djJtbBeXCcd7goRo=;
        b=DT72x0Wwj/CLhYjmV+AKgtwIvmMTjRMGV3IlDxp/JVXNzWY8I+ByNfhtzNymVvvRyK
         h3d8QE4t1neCvx5KSeJLeQ1XZRNsC9S73kWx2Qz2e0065eBXYBn9YjLXqH1VM8vDI0WK
         T3gKB2NLja6zeJyYD/pN9sojVg2zNehXl+MSO4L7INC4IQrjzleEw3eJZj/0P5asME84
         SDocJF/LsfL5G07wdKgSTjVrFjoBIdA2P5oMG3dx4nAjAMOeBLn/em52H/u8xNpkzUNi
         ejw9VRyOQpVTOhCV1Gmyc3zryy6Ym04Yz23LMCaxJFwACGES6fCTnp2rBKzz9B2SIMVc
         SBSA==
X-Gm-Message-State: AIkVDXL/8v6Ko/NX8X18SwyjiGsO6C6cNG/Sc5/8fOqtchkGA9PIK275cvNgPyfq2ZjFdbirVNFeiFGEgfx04w==
X-Received: by 10.176.71.21 with SMTP id h21mr9123994uac.167.1482441538709;
 Thu, 22 Dec 2016 13:18:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.45.11 with HTTP; Thu, 22 Dec 2016 13:18:38 -0800 (PST)
In-Reply-To: <CAJtFkWtjowyGaFfsCVd-HAZM2-3e0=CkkyYfxne8KRdYq5kJ9g@mail.gmail.com>
References: <CAJtFkWtjowyGaFfsCVd-HAZM2-3e0=CkkyYfxne8KRdYq5kJ9g@mail.gmail.com>
From:   Stefan Monov <logixoul@gmail.com>
Date:   Thu, 22 Dec 2016 23:18:38 +0200
Message-ID: <CAJtFkWuypdH+ikdXL=-DXOx-8F+34nV3phqO2jTGoqtnM7=DZA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Making_it_possible_to_do_=E2=80=9Cgit_push_origin=E2=80=9D_i?=
        =?UTF-8?Q?nstead_of_=E2=80=9Cgit_push_origin_=3Cbranch=3E=E2=80=9D=2C_without_having_to_?=
        =?UTF-8?Q?one=2Dtime_prepare_each_branch_for_it?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, if I do the "setup" step (`push -u`) for a branch that doesn't
exist yet (neither on my PC nor on the server), does that remove the
need to do `git checkout -b <branch>` first?

On Thu, Dec 22, 2016 at 11:14 PM, Stefan Monov <logixoul@gmail.com> wrote:
> Hi.
>
> I'd like to use just:
>
>     git push
>
> or at most:
>
>     git push origin
>
> rather than having to first check which is the active branch with `git
> branch --list`, then type:
>
>     git push origin <branch>
>
> At [1] and [2] I've seen that if I do this once:
>
>     git push -u origin <branch>
>
> then from then on I can use just `git push` _for that branch_.
> However, I don't want to do this "setup" step for each branch, because
> it's extra work that I also may forget to do.
>
> Why is this "setup" step necessary and can I avoid it?
>
> Thanks,
> Stefan
>
> [1] http://stackoverflow.com/q/19312622
> [2] http://stackoverflow.com/q/6529136
