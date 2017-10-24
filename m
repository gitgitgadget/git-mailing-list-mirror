Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B156A1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 16:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdJXQT2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 12:19:28 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:54338 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbdJXQT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 12:19:27 -0400
Received: by mail-qk0-f177.google.com with SMTP id n5so26927131qke.11
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=M014qh8Jjke7s/DUvvm2/cVJlM/qPUMvzhyHaF2V9tQ=;
        b=uQcpV1oREquNWEUUDDVqepQ/myho7YGrQWO2we5wYyjD7zuId3IDzjWiiLDObP+JvD
         FGFEmIZl3+uTCmFUTnjjGEidpNJu2zVvWfXXfPLTkeYOIzv2TTUO0ikI2Q2dhdT9WAn8
         ELDuKwuhm8VSlKYOuZ3v+Dp4kCzduxDAz0n+1vjkkPO587S+vnJeoykhXlM11fiobpvw
         A5TlENuz9OGvJALGe/ZqimXIAFaMObxQFcAmn+FvAkUBg8iLdmOAEbV10/Hla7mma/eF
         z0Ssk7+Of+sphPkSdHVISw5LDz+ioz943N73zv2qPWUPam89vRvz1i/fRWIRu/ftiyVn
         iGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=M014qh8Jjke7s/DUvvm2/cVJlM/qPUMvzhyHaF2V9tQ=;
        b=TAjTPoNJk7uelHs/yngmCeE24M+Tn6Vwua7fxkVLfbkNlXyLDmW46hMEJpAs9Mn97X
         o9/z8X66B+ZNEYYxiAasH+w9k/cNyXeR/8242BCLemaMDyKtjn/GVMN1wxIAzfmbOf/I
         S0LRuG3Yz0mRfzl/qgep8iWqo9lnCHJXwCn4vehCOHif5HW1nxFqSERZKJBaak21wU9q
         7TR0svRaNDBcwWC1Odot5kVPyNcpbOn+prR2JQjWd7Rl5VG3xTzEHyAs51JjPm8WDBP8
         dUglpc5nZRejynafr1eO3POKZpbAze99w0nG1R4S9qUgxHZfq1/rrAzP9DjeVrL6WwAg
         0f/w==
X-Gm-Message-State: AMCzsaVAjV1IJTtfoP4LR6UV6ZYmpttwF2yAUlkpu9uFT0ZHbjm3jFIN
        iXbRMwwZxWEJBf9543LsydOUuIW9+SZSlOS7g1E=
X-Google-Smtp-Source: ABhQp+TNhIRWHTAp2qO1xUpjlAq4zM1iZIJQYgrUrtmzRzm8FO4YllOl9+v0f19hOvzzWnyR4LSho50XCyLPwt04at8=
X-Received: by 10.55.109.5 with SMTP id i5mr9925991qkc.73.1508861966930; Tue,
 24 Oct 2017 09:19:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Tue, 24 Oct 2017 09:19:26 -0700 (PDT)
In-Reply-To: <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
References: <cover.1508856679.git.mhagger@alum.mit.edu> <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Oct 2017 12:19:26 -0400
X-Google-Sender-Auth: d46fIVPQUHyOC2r3VCAf2E2iJGg
Message-ID: <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 11:16 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> @@ -34,6 +34,86 @@ test_update_rejected () {
> +# Test adding and deleting D/F-conflicting references in a single
> +# transaction.
> +df_test() {
> +       local prefix="$1"
> +       shift
> +       local pack=:

Isn't "local" a Bash-ism we want to keep out of the test scripts?

> +       local symadd=false
> +       local symdel=false
> +       local add_del=false
> +       local addref
> +       local delref
> +       while test $# -gt 0
> +       do
