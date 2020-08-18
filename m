Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA8C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847602076E
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B6jv+EF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHRTNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:13:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61576 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRTNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 15:13:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12D72E999B;
        Tue, 18 Aug 2020 15:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CBCbYig+a17zxMdl6ooy+Il1jZQ=; b=B6jv+E
        F/3swDb56zRDtTZROvv+BjEDyWPMhUoqOhTgYD5wlBargXFTW4hTZmE9RIbtDuE4
        wsusZi/DRZIDa61K1w7TG8lB1MgRc8FiroeEyEU+I59lofNuqhWGEtZSrarB8YDZ
        uXTJuQlT7jRNewt/X/tO7bLc88D6vvbwOkbtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yPVDTR6NosS+8xwpDHC6lK0TzFASIikp
        7PTiooyUSHW2McUlaPYCVwUrtem08EGUH0m3lBDv938x7lkHHZcabY1nCEgip68g
        w9TNcF54WGj3mNq+k7pZN7mW21niu7nFkb0ifHLWtiCXbab5ZowdHCnciJ63IcM+
        /yA6vqqgnkY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B27EE999A;
        Tue, 18 Aug 2020 15:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C7191E9999;
        Tue, 18 Aug 2020 15:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danny Lin <danny0838@gmail.com>
Cc:     git develop <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/subtree: document 'push' does not take '--squash'
References: <xmqqzh6t2p43.fsf@gitster.c.googlers.com>
        <20200818052248.1880-1-danny0838@gmail.com>
Date:   Tue, 18 Aug 2020 12:13:03 -0700
In-Reply-To: <20200818052248.1880-1-danny0838@gmail.com> (Danny Lin's message
        of "Tue, 18 Aug 2020 13:22:49 +0800")
Message-ID: <xmqqwo1vydhc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7A95822-E186-11EA-B28B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danny Lin <danny0838@gmail.com> writes:

> git subtree push does not support --squash, as previously illustrated in
> 6ccc71a9 (contrib/subtree: there's no push --squash, 2015-05-07)
>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---
>  contrib/subtree/git-subtree.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.  Will queue both patches.


> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index 9ccd431c7f..0db02fe3c0 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -143,8 +143,8 @@ OPTIONS
>  	Specify <message> as the commit message for the merge commit.
>  
>  
> -OPTIONS FOR add, merge, push, pull
> -----------------------------------
> +OPTIONS FOR add, merge, and pull
> +--------------------------------
>  --squash::
>  	This option is only valid for add, merge, and pull
>  	commands.
