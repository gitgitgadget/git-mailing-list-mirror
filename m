Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830F6211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 03:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLEDy4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 22:54:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50565 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEDy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 22:54:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 319CB2414B;
        Tue,  4 Dec 2018 22:54:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DrtYKiH/t0ofH/WcCdo85I/k/dI=; b=anF09G
        rEbeDXlI3ZsMTOx+AttPs/eiERkdu3s1OTPWxbUib67HY/6s+EybJ4QKwPFizEmP
        7bokG3cHF+xfew1f8+ghhSGkaE2kKHJMlWiCSxLpVOiO41pQ2zqYdrKWfXO/sGoI
        My7lSmuM06y5fKPsHFS9QFQqMtLLN9Alt1hlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XXJclrnSIC2cgnG764VXd7Jiu8InNGXb
        wpSUf7+KEDEjIVMLZMmEQFosblmtwgnBV9CSzAp8Mgig1ta8bJkw+3jPnZVhW+/X
        OYUqfzjGcJoVIF8T6b+eedwPMpXLmnkoiOneHgTacYawxLz9rK2rxtIccsFXfKCD
        OP+UUebKDpc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2ADE92414A;
        Tue,  4 Dec 2018 22:54:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 474D724149;
        Tue,  4 Dec 2018 22:54:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>, <j6t@kdbg.org>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section Behavioral Differences
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
        <20181204231709.13824-1-newren@gmail.com>
Date:   Wed, 05 Dec 2018 12:54:49 +0900
In-Reply-To: <20181204231709.13824-1-newren@gmail.com> (Elijah Newren's
        message of "Tue, 4 Dec 2018 15:17:09 -0800")
Message-ID: <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 846BD476-F841-11E8-8CF6-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Gah, when I was rebasing on your patch I adopted your sentence rewrite
> but forgot to remove the "sometimes".  Thanks for catching; correction:

>
> -- 8< --
> Subject: [PATCH v2] git-rebase.txt: update note about directory rename
>  detection and am
>
> In commit 6aba117d5cf7 ("am: avoid directory rename detection when
> calling recursive merge machinery", 2018-08-29), the git-rebase manpage
> probably should have also been updated to note the stronger
> incompatibility between git-am and directory rename detection.  Update
> it now.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-rebase.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 41631df6e4..ef76cccf3f 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -569,8 +569,12 @@ it to keep commits that started empty.
>  Directory rename detection
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -The merge and interactive backends work fine with
> -directory rename detection.  The am backend sometimes does not.
> +The merge and interactive backends work fine with directory rename

I am not sure "work fine" a fair and correct label, as rename is
always heuristic.  

    The "directory rename detection" heuristic in "merge" and the
    "interactive" backends can take what happened to paths in the
    same directory into account when deciding if a disappeared path
    was "renamed" and to which other path.  The heuristic produces
    incorrect result when the information given is only about
    changed paths, which is why it is disabled when using the "am"
    backend.

perhaps.
