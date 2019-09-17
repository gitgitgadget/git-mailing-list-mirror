Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93C911F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfIQQsF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:48:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61327 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfIQQsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:48:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62A812F27D;
        Tue, 17 Sep 2019 12:48:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+y78HiQxXzinKlXwzqF/I/zWOlA=; b=Wz/9H1
        DZJ2rjY7C3hYXN7b6l4GtBTztdDGrsD1gZD9FW55A7BT0znnMJMpxnBJCzSpCRoc
        zdMancB8S1Z7H3G5ga+JhutRCkiytq/Z9h/7IYlJGJElv7MG7rFCia0ej+W1WIVN
        KghjJ0S0kE13umMy0UbmXqsk3qNjRdgextRNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OocCXG0GcLDvdEKaFipzl+fGmreTEveb
        hw4IrX+i90gduXF29zLp/hg3ON9ekEtWGHpvxxF9ES//iCLF88xdvHWhSMCZkr7p
        o44mJcOzmluWfex6USy1Nrv4uCevJLEL5cWEva/YnLbzxgwaEqw3HnqAHhPVpFHh
        FnbH2bOBfJQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AB442F27C;
        Tue, 17 Sep 2019 12:48:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F12A2F27B;
        Tue, 17 Sep 2019 12:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] gitk: rename zh_CN.po to zh_cn.po
References: <6feff2e73e1c4ca838efcabe90e0978a4d88cb7d.1568710294.git.liu.denton@gmail.com>
Date:   Tue, 17 Sep 2019 09:48:01 -0700
In-Reply-To: <6feff2e73e1c4ca838efcabe90e0978a4d88cb7d.1568710294.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 17 Sep 2019 01:52:06 -0700")
Message-ID: <xmqq36guamym.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9F975A4-D96A-11E9-B2BB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When running make from a clean environment, all of the *.po files should
> be converted into *.msg files. After that, when make is run without any
> changes, make should not do anything.
>
> After beffae768a (gitk: Add Chinese (zh_CN) translation, 2017-03-11),
> zh_CN.po was introduced. When make was run, a zh_cn.msg file was
> generated (notice the lowercase). However, since make is case-sensitive,
> it expects zh_CN.po to generate a zh_CN.msg file so make will keep
> reattempting to generate a zh_CN.msg so successive make invocations
> result in
>
>     Generating catalog po/zh_cn.msg
>     msgfmt --statistics --tcl po/zh_cn.po -l zh_cn -d po/
>     317 translated messages.
>
> happening continuously.
>
> Rename zh_CN.po to zh_cn.po so that when make generates the zh_cn.msg
> file, it will realize that it was successfully generated and only run
> once.

True, and it is not just that.  The install target would fail
because it cannot find zh_CN.msg, I think.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  po/{zh_CN.po => zh_cn.po} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename po/{zh_CN.po => zh_cn.po} (100%)
>
> diff --git a/po/zh_CN.po b/po/zh_cn.po
> similarity index 100%
> rename from po/zh_CN.po
> rename to po/zh_cn.po

This would make this in line with pt_{pt,br}.po, existing locales
with country code in them.

Reviewed-by: Junio C Hamano <gitster@pobox.com>
