Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55DE51F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeKMIvV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:51:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38679 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeKMIvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 03:51:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id a2-v6so8780235edi.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ay3YBIgXL30JcElrI5tER+2p+rX44Yxdf88sJQDDcSA=;
        b=HvRaYYgiwty18pxQFs44BqZiFyqbTUVjtVVpx96bjV63ZrB3tO0oyl56+U2FZnsG1i
         v/dv3U/CZdLJQAN6YsvLebeRBn/uHuodmx7FgjD5m1H2NSaNm9hysQtMhOaZaNpgo9FN
         g2azVsiPdlygkKqlq6iTXQx7J7fB7LpmyjcyzNrg7WCBRxMZZIRLsStfqVQ+zhYw6hBo
         n8sgasMTWY/CEEV83mR2qMWWAD+z3c0rA7jFPyZNXx8wDnFIdfuOwTqMaEjAk6bYfJbl
         a0oXPBniNUEFByR8YEsweMancqm7dxzIKvA2e7uuukMv4ZafR9UPhbwVubPytZVobNX7
         MAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ay3YBIgXL30JcElrI5tER+2p+rX44Yxdf88sJQDDcSA=;
        b=bQLQ33jAYDEb9UvRP/pK00CN3Mu919vk1lR03RP8pQebXLGRk/EFUa9AOmI4fg76n7
         eLALuDui6JSf6R168zKxuUP3F8O0DazIhmBgaDkohypm7fxw7TzAOdYVth3yq8/RZLy5
         eVCVhY09E9R3hjPaysS7E9D5d/7WdgEjpjiRraczal55CxvM+fozo3s59JOWv1yXMEV1
         oh09fMcqtEOTM67zQXaZG1xgWZbBRPTXrEd3W0UbkpIUqKfByaROE/lRQhq1jYQITqfQ
         aHRGS1MHiupjRNDnmAS67/FEKv+bMT7VvwggcrUjMGodvKURaScTi7NBsNeUfgXsoBWE
         lycQ==
X-Gm-Message-State: AGRZ1gLsFcnRHjo94p2R1LkaFqjMtriF4P7FcAms9vnJcCpzGADYZmji
        3Htn9/kd1ZRP4o6DU9Y2h28RBjfVbc5Z8wC2oTd1Qp10NS8=
X-Google-Smtp-Source: AJdET5cLeGjyTyBqvO6oVi5VpXQiLHFF8XegT2va3AZ8K6svWbps8I5eMfL851LujMzLLoZMdb0Iv4jWVwvhiAazKbY=
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr10524683ejq.19.1542063364273;
 Mon, 12 Nov 2018 14:56:04 -0800 (PST)
MIME-Version: 1.0
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
In-Reply-To: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Nov 2018 14:55:53 -0800
Message-ID: <CAGZ79kbsELU=+91WzeUu6w8OUpQiP4FQO4LBvzCXJvBEe_qCdw@mail.gmail.com>
Subject: Re: [PATCH] remote-curl: die on server-side errors
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 2:45 PM <steadmon@google.com> wrote:
>
> When a smart HTTP server sends an error message via pkt-line,
> remote-curl will fail to detect the error (which usually results in
> incorrectly falling back to dumb-HTTP mode).
>
> This patch adds a check in discover_refs() for server-side error
> messages, as well as a test case for this issue.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
