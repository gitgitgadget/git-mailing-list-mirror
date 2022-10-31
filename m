Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A067DFA3744
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 12:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJaMW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 08:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiJaMWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 08:22:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18AF5B3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 05:22:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j12so10582806plj.5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E//bRD+a8rlWMyqUB4wrrkCK6JOdKB2WjbcolELzmJk=;
        b=RtG1G5vavCrhdXAI/YQ4K9zTy1PKO65skWEtj0prle6hRy5QdWgwhcd/H6i1jl3Vlb
         De8XZSY5jjq7pLemMFHnNoSNVst7W4l4N7HXvg9IJ8vgocW5jfUcovjt7BaPr+iMRkNC
         NJb7cb/hCSXG1VzM2r3Y9e0aI8vgnMNKSMdL5tt7LdW5gAKPH9pAopJpOOIQnp9eK+yM
         OQzAOD6GkUlsMDC0a21d6Y5wHkpa0WqKTojAYYxoqAO72Ntn9PBK4sQhMCJ1LbMM9wiB
         iIraquVxrl0A6wwncxMj+X3f/2ni1NDaKCzCc1mX9mxCEFk/WXRsi78H5ef0TtR4NfXp
         iUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E//bRD+a8rlWMyqUB4wrrkCK6JOdKB2WjbcolELzmJk=;
        b=HfzqEQHYG09ICrO0ygftY0mK3UAUEN/ILkr03aBPpAXXlovEU1BHiTpA7BETHYYwbJ
         5atC1RW1WsN6gJL6XwTW5vRX/0o8/b5VlAuMRSh4SJ/qN1BR7EVNRfXaxzonUL1lWpuq
         K+FgLs1zj00e7u87IzW0DepPai34zTefrOBZV5xtsxB+an11ecVRBWM6NdHWDHGeDz15
         GJEVFwoCVj+L0TghKD624ebrzREEql4YOrbVkPrArWV9Bp8g9gcUAw6Ef8r///lL+wWT
         gahjAltqv78Y29Nsm2nW6/gl06f1Y4Q8gT+pcnGu2iIYd/WTAl/PNrHZGfv3bCrYzgW2
         GG9Q==
X-Gm-Message-State: ACrzQf3DNLCFLpeMnM4IMvYRbRwI65TM7RHRotNshscZYiiobvOHALMF
        muKBMC/8oFZ0m+UYSAiH3z0=
X-Google-Smtp-Source: AMsMyM4RmbN5sDI9Z1Q59a3ChvNxYIdMZ+hIf0d2KJjAw3bY3RBwlt84NCDDcEMdsAWgL7L7AfoInA==
X-Received: by 2002:a17:902:70c4:b0:17c:f9fe:3200 with SMTP id l4-20020a17090270c400b0017cf9fe3200mr14203343plt.1.1667218960488;
        Mon, 31 Oct 2022 05:22:40 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.40])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b0017f49b41c12sm4357916plh.173.2022.10.31.05.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 05:22:39 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Taylor Blau <me@ttaylorr.com> writes:                                                                                                                                                                                                                                        
Date:   Mon, 31 Oct 2022 20:22:34 +0800
Message-Id: <20221031122234.22473-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <Y17FeGeWqEE7CWQS@nand.local>
References: <Y17FeGeWqEE7CWQS@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Maybe that is the best approach forward. Teng Long: does that sound OK   =
                                                                           =
                                                                           =
                                            > to you?=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
Sorry, there are some problems on my Mac (I can't run coverage but it's ok =
now),                                                                      =
                                                                           =
                                            I will read the context and rep=
ly again a little bit later.                                               =
                                                                           =
                                                                           =
             Thanks for Taylor Blau, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 and Jeff King to supply the                                               =
                                                                           =
                                                                        dis=
cussions on this topic.=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
