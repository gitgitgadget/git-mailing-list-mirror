Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023041FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 02:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbdDACVh (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 22:21:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52560 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750769AbdDACVg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 22:21:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC57F824CA;
        Fri, 31 Mar 2017 22:21:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Asy6wpo0+ss0CoxLc5B9kwEYKy8=; b=LXoknM
        Vxr7q/9yjZM439W9EDnOGdUQherG5w/JlEwbF/qr/HtOprD4ebpWQx4AGtQjGhNX
        jAHCThpwwU+1g4hmpUz+HWXry1lRj2sy7gH/eoNPq/P6nUJUhs5/AUp58vZ0Dlk7
        J2ap17TxqRpDHi0y+rApKaP6Fio6YIho9aXqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pZ3nlGAGT/Ozsr2RpS4oui/GsCvJATWc
        LlbQLOUT8N3DNBC2ugAZziMU7qXVPgBIxc+hvDWLUlu1c/N1fSGtJtkzKWeoL2fH
        Uu+5/zYCRqUE6SksYlfzJsZZpt3E6hywxBtrvLfvvOBDTOUZI46CpNs3Emhl0yyC
        JNvlTUofZiA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5955824C9;
        Fri, 31 Mar 2017 22:21:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26555824C8;
        Fri, 31 Mar 2017 22:21:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mostyn Bramley-Moore <mostyn@antipode.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: improve git ls-files -s manpage entry
References: <20170331194708.22437-1-mostyn@antipode.se>
Date:   Fri, 31 Mar 2017 19:21:32 -0700
In-Reply-To: <20170331194708.22437-1-mostyn@antipode.se> (Mostyn
        Bramley-Moore's message of "Fri, 31 Mar 2017 21:47:08 +0200")
Message-ID: <xmqqpogwx3yr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED0C2B0A-1681-11E7-AB7D-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mostyn Bramley-Moore <mostyn@antipode.se> writes:

> List the fields in order of appearance in the command output.
>
> Signed-off-by: Mostyn Bramley-Moore <mostyn@antipode.se>
> ---
>  Documentation/git-ls-files.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 1cab703..a9149fc 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -57,7 +57,8 @@ OPTIONS
>  
>  -s::
>  --stage::
> -	Show staged contents' object name, mode bits and stage number in the output.
> +	Show staged contents' mode bits, hash, stage number as well as the
> +	object name in the output.

This is not an improvement, as the word "hash" is merely a
colloquial way to say what is officially known as "object name".

If the patch were only to swap "mode bits" and "object name" without
doing anything else, it may have been an improvement, though.  It is
implied that the path the output line talks about is shown, and that
is why we do not say "mode bits, object name, stage number and the
pathname".

>  
>  --directory::
>  	If a whole directory is classified as "other", show just its
