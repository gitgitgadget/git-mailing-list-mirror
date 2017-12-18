Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519A31F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759551AbdLRSsi (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:48:38 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:45904 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758691AbdLRSsh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:48:37 -0500
Received: by mail-qk0-f180.google.com with SMTP id o126so7104312qke.12
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=q5iJyVPDM0Mqdri8TOIAw3IsRsL17hr0y3vZF/dhdz4=;
        b=fu6PCRIB9D4+c6ziytoYs7ZnOKyOfIiBIHuTblzK2zAx2rVSoMauSPZLsCxwEs+MJV
         v9bD6j1+wfJiLGhZvE3HnX5iPyhaRv+SESyYkJWqtI74wGWaw+gQ6YMCv0aOrdzZ5cRF
         q2fWzeFVCUJkbfh4o6GxFApFmiViEyGje2qlv+1S408R56FYv+LQfqdMHjB3Jq6DU8bU
         AFgi1450RkJbMfp+0YacOCTs+Qe6Zkrk6O4h8C9+XultdWVSoFH1NLJSqoqfee+uqr7l
         TYJ6+g7Ob0KpUwR0lyOLW3/2tSBDvM5AC+AO1HEaCrr4gubn+eEEUKAiQI+H/gGMFkwR
         Q6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=q5iJyVPDM0Mqdri8TOIAw3IsRsL17hr0y3vZF/dhdz4=;
        b=oRPQXmGzCPNGrLcmuK0j3bC/o/pLGkRJC8LNQaszfpxhj1EoZkmxv6+uvGE53RBOyi
         GsqOQQhgklpYCwUj0TUMiu4RD/rJzc8p2HijWc+c4GSVTsw1BPervOJRsnSKFdKIXdJ0
         DkQfth+3i5/BLjETqQbv4Fc3Gsjcl7nJCN+RQkYbFJknn7ZrrQD/ULLlAP4OJ7rEemC9
         iUFeuFo1j8O/0owoKg/W+kLOGd8O98/rrGhQL3Lxlm9zU3Lda3QeswNuEkCEOfwZQyH0
         kSzCOEl/7puCaVOwALvmtO2E4LcF9FrGB1ea0G10+ILWTpZzWN4mt51vgIpa5Mr0zrTe
         zc7g==
X-Gm-Message-State: AKGB3mKXVlGrGq/uZfYNXSZdFRPHCZQU26nvPQOjC4R/3nU6xQ9ze9SS
        cVj20vL9xchs8HIVZv/iLN7aNuey4n0avUA3VTI=
X-Google-Smtp-Source: ACJfBovj7ly5WbZFy/UTcsV2qfQ0rhpKiubMIXeU4gJFwv/eHwe56oQXDdIgiVE7bNMWxxYf4LAO9geqn1J2FrdtCpA=
X-Received: by 10.55.200.90 with SMTP id c87mr993684qkj.132.1513622917146;
 Mon, 18 Dec 2017 10:48:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.148.12 with HTTP; Mon, 18 Dec 2017 10:48:35 -0800 (PST)
In-Reply-To: <20171218182546.9962-1-kaartic.sivaraam@gmail.com>
References: <CAPig+cSEYHfupRt+-0sZK6H3_WcT_=wdNB2FfdYuB6geGQYZ3A@mail.gmail.com>
 <20171218182546.9962-1-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Dec 2017 13:48:35 -0500
X-Google-Sender-Auth: VY3W2gNlo9dy8xmZ6vll7ofPbC4
Message-ID: <CAPig+cSOn8PV52aL0Ky5uUwFfNMWye93UQGioRiXjj0ze9HX+g@mail.gmail.com>
Subject: Re: [PATCH v2] imap-send: URI encode server folder
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Doron Behar <doron.behar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 1:25 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> From: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> [...]
> resulted in the following error,

s/resulted/results/

>     curl_easy_perform() failed: URL using bad/illegal format or missing URL
>
> That was a consequence of the not URI encoding the folder portion of

s/That was/This is/
s/the not/not/
s/URI encoding/URI-encoding/

> the URL which contained characters such as '[' which are not

s/contained/contains/

> allowed in a URI. According to RFC3986, these characters should be
> "URI encoded".
>
> So, URI encode the folder portion of the URL to ensure it doesn't
> contain characters that aren't allowed in a URI.
>
> Reported-by: Doron Behar <doron.behar@gmail.com>
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> ---
>
> I came across the same issue that lead to this patch recently and found
> that this patch didn't make it in. So, I thought I could help out and
> hence this v2.

Thanks for taking up the slack.
