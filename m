Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEA9C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 17:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiBBR3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 12:29:39 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:53817 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbiBBR3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 12:29:38 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4JpphH41Glz5tlD;
        Wed,  2 Feb 2022 18:29:35 +0100 (CET)
Message-ID: <bc8fb1ae-4ad0-b435-758c-d5ecc12ffe25@kdbg.org>
Date:   Wed, 2 Feb 2022 18:29:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/4] i18n: factorize more 'incompatible options'
 messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
 <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
 <2eac2ef502b86d0c15513c8d0e69928ce2140b1f.1643666870.git.gitgitgadget@gmail.com>
 <xmqqv8xzh6iw.fsf@gitster.g> <29731fdd-ca0c-a3f6-84c7-7429ccef5673@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <29731fdd-ca0c-a3f6-84c7-7429ccef5673@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.22 um 17:05 schrieb Jean-Noël Avila:
> With "static", we ensure that either it is inlined or there is a static
> function (in which case, this bit of code will be duplicated across
> compilation units).

That is the plan. Since the function is declared static, the compiler
has much more freedom to inline it because it knows that the function is
inaccessible outside the current compilation unit.

Besides, if you grep for 'inline', you will only find 'static inline'
(except in some borrowed code). static inline it is, or you pick the
macro or out-of-line solution.

-- Hannes
