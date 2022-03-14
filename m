Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD15C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 20:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245180AbiCNU65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiCNU64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 16:58:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378561BE
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 13:57:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B048108129;
        Mon, 14 Mar 2022 16:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q3uCUNgiunE0afLPVecibxQS5F4X1H95thNRXQ
        5jRSo=; b=UMHnBFbZE0hET5AhvidpEhgSww+RCVSbjb6TbndCTeFFtCN+GwybzE
        QXBDqZNBjZEWVSBFbOicAcMcG7nVffgjepjieWm3zK1tGJxTdOMEa8LViQw7IhrW
        1jzfUdNyjBq0bkGxpeU2ATok6pPD8tN6ZPlynEHrRg9I28xovGoJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 827E0108128;
        Mon, 14 Mar 2022 16:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCFC5108127;
        Mon, 14 Mar 2022 16:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 7/9] git-sparse-checkout.txt: flesh out non-cone mode
 pattern discussion a bit
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <78028ecaa58f2c0b395b417cfa2543e73ab51fae.1647054681.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 20:57:42 +0000
In-Reply-To: <78028ecaa58f2c0b395b417cfa2543e73ab51fae.1647054681.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 12 Mar 2022
        03:11:19 +0000")
Message-ID: <xmqqo828p7zt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64FE7156-A3D9-11EC-AE29-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  INTERNALS -- FULL PATTERN SET
>  -----------------------------
>  
> -By default, the sparse-checkout file uses the same syntax as `.gitignore`
> -files.
> -
> -While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
> -files are included, you can also specify what files are _not_ included,
> -using negative patterns. For example, to remove the file `unwanted`:
> +As noted above, the sparse-checkout file uses the same syntax as
> +`.gitignore` files; see linkgit:gitignore[5] for details.  Here,

Here, following the suggestion to fix the early part of "Cone mode
patterns" section, move the "it is more flexible but requires more
cycles to process" you had there to replace the "As noted above".
