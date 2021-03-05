Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF5BC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C6765005
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCEAZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:25:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53498 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCEAZD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:25:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84BF198DE1;
        Thu,  4 Mar 2021 19:25:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EXky+jhoKdqW0e9YLxxNFK+K5eQ=; b=odtIxa
        eIq0DRgN9eAxm2WUu1lnljFAFYy4j/Qv4y4c0FPKHRQbCQNCneVj3BP7crjhdAh6
        E6vtgLvSACJ+2DtfSrl7XMAWdC3FiGJMV0rteaHRHoZFS1T4oBgMcZ36bOZWd0F6
        EryoqWFHtBnm5MXuCczkjsNtqUDkb6VcQ2Mc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cFkfJBU7Qysx8EyZ9WzGd5hZi97VVPAZ
        Tg9yBJAVtCczQATTaBzjgQ8C64Wr/wRa26FvZZduUthtPFt4IglemgbkPwMlG2Ek
        O8a2zz73yTA6xmTvaBYrykTHpPzDQqNhAzDVW3H7feFXnBJY1u49AyX3LO3SzzYr
        nKS2OssUYts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D90B98DDF;
        Thu,  4 Mar 2021 19:25:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EFC098DDC;
        Thu,  4 Mar 2021 19:25:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/8] Simple IPC Cleanups
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 16:24:59 -0800
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com> (Jeff Hostetler
        via GitGitGadget's message of "Thu, 04 Mar 2021 20:17:19 +0000")
Message-ID: <xmqqlfb2bg6c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3949B744-7D49-11EB-8759-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sparse failed seen, so I tentatively added this on top of your
series.

Thanks.

 t/helper/test-simple-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 4da63fd30c..42040ef81b 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -227,7 +227,7 @@ struct cl_args
 	char bytevalue;
 };
 
-struct cl_args cl_args = {
+static struct cl_args cl_args = {
 	.subcommand = NULL,
 	.path = "ipc-test",
 	.token = NULL,
