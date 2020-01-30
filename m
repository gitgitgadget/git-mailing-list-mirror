Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D24C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE3120658
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p7K66K7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgA3S0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:26:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64274 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgA3S0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 13:26:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2B2452F63;
        Thu, 30 Jan 2020 13:26:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6TuSO+UCoqyvoyn8nEdmEgUA86c=; b=p7K66K
        7MfW9Dn7VlFg3qcjHCds2KMVrJijO8RnHwAmVw50hOs2VahzWcLbUOxIZjYW9jO9
        +GBVU4QqD1CeBGD3zQ2CtMODQZ8IahwIqIlnUzcDIaqokgmHZwIJ2FjOHlUtuqkV
        RpTJMeWpCCG73W4hvmwXB6GVpFMqfVmKWadSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GyOpUJjXWiUp3tttC7wTmVFmtIY8Nf+j
        WdhRIqjDZQ17G6nEikuGknwYNhO0OrTudS9oZYInjUOQYYdtZ5R+O5+QDmKMx34Z
        AyX7vX/+g/+CFuz6u3jfEJtD8eEW0FMzzOe1II1+LjyNfzJ4igxSRBQsvxAaX52C
        Z9g6lf7gIbc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C68E152F62;
        Thu, 30 Jan 2020 13:26:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34C6152F61;
        Thu, 30 Jan 2020 13:26:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v4] git: update documentation for --git-dir
References: <pull.537.v3.git.1580185440512.gitgitgadget@gmail.com>
        <pull.537.v4.git.1580346841614.gitgitgadget@gmail.com>
Date:   Thu, 30 Jan 2020 10:26:21 -0800
In-Reply-To: <pull.537.v4.git.1580346841614.gitgitgadget@gmail.com> (Heba Waly
        via GitGitGadget's message of "Thu, 30 Jan 2020 01:14:01 +0000")
Message-ID: <xmqqr1zgdcmq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04271CBE-438E-11EA-9B8C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Range-diff vs v3:
>
>  1:  2a1404f1b3 ! 1:  e27f150c4b git: update documentation for --git-dir
>      @@ -31,18 +31,18 @@
>       +	an absolute path or relative path to current working directory.
>       ++
>       +Specifying the location of the ".git" directory using this
>      -+option (or GIT_DIR environment variable) turns off the
>      ++option (or `GIT_DIR` environment variable) turns off the
>       +repository discovery that tries to find a directory with
>       +".git" subdirectory (which is how the repository and the
>       +top-level of the working tree are discovered), and tells Git
>       +that you are at the top level of the working tree.  If you
>       +are not at the top-level directory of the working tree, you
>       +should tell Git where the top-level of the working tree is,
>      -+with the --work-tree=<path> option (or GIT_WORK_TREE
>      ++with the `--work-tree=<path>` option (or `GIT_WORK_TREE`
>       +environment variable)
>       ++
>      -+If you just want to run git as if it was started in <path> then use
>      -+git -C.
>      ++If you just want to run git as if it was started in `<path>` then use
>      ++`git -C <path>`.

Will replace and queue.  Thanks.        
