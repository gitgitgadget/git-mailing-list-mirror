Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D451F404
	for <e@80x24.org>; Wed, 11 Apr 2018 23:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeDKXeB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 19:34:01 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45230 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbeDKXeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 19:34:00 -0400
Received: by mail-yw0-f196.google.com with SMTP id g9so26233ywb.12
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+HDTENgWzJSW7Mw5xLXGOlsQqzqahOmfX9BaELYEZr8=;
        b=X5vI2ts1brf+A+0mvKNzsCyUQjy9xSNY6jUkjZvO62RjW+0lE9Edeca3iWi28JrjhL
         oVnIOledOlfLfxPF865TxDnvXGRoHmb0oNhN1dKmxVw2+ab3bHe/Q0lKcQjh13eHww8Z
         m7O2a0k4+e+UHcuyQ950QRiM83NB1Kwx/KjR2NNNR8WKdtFmhYCKmxlnMhxm+oijVCVT
         TRSRxYpt/rKFk9NcyVHqkKA5upiXclr5VxTSFrFEToSdj7XFySm1LW1tlSdtM8b9yePT
         fwUMU8oFniCOwLPwRPphtvcu1IQFvc69AO5tV7zbYav5KC9XyM80gpUQJQ2wGx+/ttuQ
         epCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+HDTENgWzJSW7Mw5xLXGOlsQqzqahOmfX9BaELYEZr8=;
        b=mP3UVERCAk8nvhCzxjHj+CfcBrRzaj2MkbSoBZQjNEHg3loZTW+vuVk+oHrarxMooC
         Jf72cv5+kNFD/GcxzqrRoeJb8ppj7XoWcDnQwWwKBRI3C6oxD+wpyLIvQPD0F38NP1TH
         NOAfMePc9DFQWekMDjw4vEOcL8z2eZb5xQVa/fxoBf94kew7jm3bNzNaFks9PJz7GNC0
         oLNncbt+0D/pOoZjiZL2pymb3UdaU5didPmgA5hZSqVY7+ic4CGgAezOR6k2B56KGbDt
         4hWSFISIHuZKcxivWas7wEDTlAEN9ssANhw62OynBqn6jQwtpDPWs9etWqSWdosqTx6Z
         wQIw==
X-Gm-Message-State: ALQs6tB60oMiqij4GpGZUaNyMZREObU/3C769mQwM7LHmFymo6dLX3TA
        fULXBhwRHyOFarGZ+2TT3IxeSav/CsRxTyhIfPkW1g==
X-Google-Smtp-Source: AIpwx4+Z9hYOah6x+U3eHkfMds5+zCCixKbQIfuRE9N4cKp1igrQ1CEHxh6Xry3av3+s+uh/je8N15Xocl++bG/5Z2o=
X-Received: by 10.129.136.7 with SMTP id y7mr2967729ywf.238.1523489639274;
 Wed, 11 Apr 2018 16:33:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 11 Apr 2018 16:33:58
 -0700 (PDT)
In-Reply-To: <20180411225534.48658-1-haraldnordgren@gmail.com>
References: <20180411225534.48658-1-haraldnordgren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Apr 2018 16:33:58 -0700
Message-ID: <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 3:55 PM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> When ran with '--merges-only', git bisect will only look at merge commits=
 -- commits with 2 or more parents or the initial commit.

There has been quite some talk on the mailing list, e.g.
https://public-inbox.org/git/20160427204551.GB4613@virgo.localdomain/
which suggests a --first-parent mode instead. For certain histories
these are the same,
but merges-only is more restrictive for back-and-forth-cross merges.



>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>
> Notes:
>     Proof of concept of a feature that I have wanted in Git for a while. =
In my daily work my company uses GitHub, which creates lots of merge commit=
s. In general, tests are only ran on the tip of a branch before merging, so=
 the different commits within a merge commit are allowed not to be buildabl=
e. Therefore 'git bisect' often doesn't work since it will give lots of fal=
se positives for anything that is not a merge commit. If we could have a fe=
ature to only bisect merge commits then it would be easier to pinpoint whic=
h merge causes any particular issue. After that, a bisect could be done wit=
hin the merge to pinpoint futher. As a follow-up to this patch -- we could =
potentially create a feature that automatically continues into regular bise=
ct within the bad merge commit after completed '--merges-only' bisection.

The github workflow you mention sounds as if --first-parent would do, too?
