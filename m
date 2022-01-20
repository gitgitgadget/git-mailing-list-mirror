Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B046C4332F
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 08:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359505AbiATI7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 03:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358903AbiATI7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 03:59:18 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80870C06173F
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 00:59:18 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 23so15673142ybf.7
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 00:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herrmann.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4Ov7yWF798CB6/E+zfeIBAQRJer7ULgM+zff9L6834=;
        b=CtNIUW7U1jl+Cswkd4a2IbDHJkx/Tk6WSV6WLjvjlbi7RP4kwM5zNb8XLzinu5DRia
         gu3LRuOxXtDZf9fYDFxBIK5BMzYKbMuRb9WWjzOv2xn7SXgsqVe4SblDMI6upeHlZBFd
         /m9emfay+PT6I/R0g7pZ5/a+HakliC9Pv4/G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4Ov7yWF798CB6/E+zfeIBAQRJer7ULgM+zff9L6834=;
        b=nFB6iHAxPxFgai8JRoT99+FnRN+9VwPntuogEclQT2jK8/zLydnqdmWlOg+vKn9a/j
         nJLAQuFYCwO+D8d04Cf+7/Wa1NjhFcqTXQ+ODwAjuNBRfNBg9nX3AFMWRZmT5d3bkuWG
         +Qp2AG2pzp6KmC6alEwRxGfFCz4lhvG1CkgOYhswLrbvtopSD3jzEL3DVC2t8iA8fk9s
         GeiXteMhnCxezjMvEpsIZzaHd0DkeB+T3ZAxvi5KjqVjx2WVgnBtuKwRErombnRT700M
         zFFqAKHVwtS/PKN7fXM+FFtMdoCe+Abm4hUvgK8pCqtbaxKdawmG8Az3jU/+362R7FAX
         w4tg==
X-Gm-Message-State: AOAM533eqAbIkEyZ90+wpFNSvnjRyZoorjy/UCNxuPHIGkPYAPVJK8VZ
        +0T8iy24lYylBrhPa8JaPIcAAFYu9D2uU477QrhloQ==
X-Google-Smtp-Source: ABdhPJzimcYdl6HlKx9lc0B0qU8ApiPdMKsKtidF65gN80oPLt4/B/VYnyllWrvRcF32MpKRFY2Aa8QZgCunx7JTmHI=
X-Received: by 2002:a25:55c2:: with SMTP id j185mr45634790ybb.763.1642669157784;
 Thu, 20 Jan 2022 00:59:17 -0800 (PST)
MIME-Version: 1.0
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
 <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net> <xmqqilufl5cv.fsf@gitster.g>
In-Reply-To: <xmqqilufl5cv.fsf@gitster.g>
From:   Michael Herrmann <michael@herrmann.io>
Date:   Thu, 20 Jan 2022 05:59:02 -0300
Message-ID: <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
Subject: Re: A puzzle: reset --hard and hard links
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your replies. Is there a way to tell Git not to sever
hard links as highlighted by my example?
