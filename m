Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF538C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6A420716
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="naIA4dsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbgHQQuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:50:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65254 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389035AbgHQQum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:50:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDAA5D9FF0;
        Mon, 17 Aug 2020 12:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lipViouNTPQN4VlfEaoKrrEtHsc=; b=naIA4d
        spdbtvs6PReZ15qVLMxv/a+dCKFp9Yr1lIkVmMwnyfqgvNdvdaHlls3ev8PzPRgk
        MwsPibg8jJnTLO811VxseoYJBIsQ/U4LWjsQRvYs2iERpPc32A2in+kINUt9zTiH
        2M0salMpVnzBIGb6HQrcn1yjqGjw0Ebto8tuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H3Pde0amdtC8bYDoI13GiV57cQdzPWv5
        fjg906wOOPbNuKcns7drfqTjpZU9LN3Ldi2P76ixDOi7E9grKKrPCTnuf3uH1kgI
        7wLJAnJQz3UjNerEW/b3TSqqkKqlhuKywFzSBf3yAf76iqdZkQfLoFudJchzkpQJ
        qJAvpL8mLL8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5B43D9FEF;
        Mon, 17 Aug 2020 12:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 297EAD9FEE;
        Mon, 17 Aug 2020 12:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danny Lin <danny0838@gmail.com>
Cc:     git develop <git@vger.kernel.org>
Subject: Re: [PATCH] Fix --squash for push in subtree doc.
References: <20200815023702.905-1-danny0838@gmail.com>
Date:   Mon, 17 Aug 2020 09:50:36 -0700
In-Reply-To: <20200815023702.905-1-danny0838@gmail.com> (Danny Lin's message
        of "Sat, 15 Aug 2020 10:37:03 +0800")
Message-ID: <xmqqzh6t2p43.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C70D4420-E0A9-11EA-AC47-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danny Lin <danny0838@gmail.com> writes:

> Subject: Re: [PATCH] Fix --squash for push in subtree doc.

Ditto.  Perhaps

	Subject: contrib/subtree: document 'push' does not take '--squash'

or something?

> git subtree push does not support --squash, as previously illustrated in
> revision 6ccc71a9d02726d59c1de818febf85a836f4e418.

Documentation/SubmittingPatches[[commit-reference]]

"..., as previously illustrated in 6ccc71a9 (contrib/subtree:
there's no push --squash, 2015-05-07)"

`>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---
>  contrib/subtree/git-subtree.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
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

