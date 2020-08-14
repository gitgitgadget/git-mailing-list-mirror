Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21266C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBA3206B2
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zt4D9oUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgHNRu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:50:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58931 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgHNRu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 13:50:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C177DE5C2A;
        Fri, 14 Aug 2020 13:50:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ERk86khjqj3BsyjvDACCuGyJjLE=; b=Zt4D9o
        UucrG1kZR2c7IOQkY3cuNsru9Em1nzJLw302bbCr75Kom+ctFDx7y49NX6XbPhL3
        7oZX7RS2U44aDbjc9eHy8fHrGLpu91C3ytvnbSZZg//gYZhXdpN+KsaPawbCWPbG
        hze79JgCbONEhr9h33NBYRLHCmT1tfFeZ46Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FRqmgkef6pir5yjmnprNPRK+NaiSJS6y
        aH6GvWoQLcVrMGDMWGsri0c9M6csidodgs2QSYLySE5ktYJ56J4Cu6frTEQTo//L
        xeHrifQ4SUnWAR2HdFfn5YSymj41VoHH09b+zDFLI5K698du8uIu4jc+YLuMIGJk
        tS+MHeESyug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA315E5C29;
        Fri, 14 Aug 2020 13:50:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0AEC0E5C27;
        Fri, 14 Aug 2020 13:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danny Lin <danny0838@gmail.com>
Cc:     git develop <git@vger.kernel.org>
Subject: Re: [PATCH] Remove "unsure" for --message in subtree doc.
References: <20200814145344.2413-1-danny0838@gmail.com>
Date:   Fri, 14 Aug 2020 10:50:22 -0700
In-Reply-To: <20200814145344.2413-1-danny0838@gmail.com> (Danny Lin's message
        of "Fri, 14 Aug 2020 22:53:45 +0800")
Message-ID: <xmqqbljdxgkh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1C13E4C-DE56-11EA-9FB4-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danny Lin <danny0838@gmail.com> writes:

> It is definitely clear that --message is valid for add, merge and pull.

If it is also definitely clear that it is _only_ valid for those
three, then the change is good.  I do not know if that is true
offhand, though.

>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---
>  contrib/subtree/git-subtree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index 352deda69d..47e2c611fe 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -139,7 +139,7 @@ OPTIONS
>  
>  -m <message>::
>  --message=<message>::
> -	This option is only valid for add, merge and pull (unsure).
> +	This option is only valid for add, merge and pull.
>  	Specify <message> as the commit message for the merge commit.
