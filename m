Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD75C433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 19:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbiAWTv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 14:51:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50403 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiAWTvz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 14:51:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18FD4FE44D;
        Sun, 23 Jan 2022 14:51:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sRvxDivl38kxiHLtB3Jd1RWN/c0Q2I7S4utsQ5
        poO2o=; b=OKZQxKcrFRXqDf668ZDNZVXdyZjU9x1VetFYamdlwZP2pZf/zBiQCM
        xb+iEiCgxGZHytqYNVrLU1b+vglTwrKy3MJEVBxfyNYiTcH+rGCAkAS778dzg1fQ
        ufh9sJNXumkQOiTwGFYKc6CwaOJMgVh7eo55bXmqJ58Jx+3EmK15M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10823FE44C;
        Sun, 23 Jan 2022 14:51:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C1CFFE44B;
        Sun, 23 Jan 2022 14:51:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Hongyi Zhao <hongyi.zhao@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Git List <git@vger.kernel.org>
Subject: Re: Some sub-commands can't be completed by TAB key.
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
        <5373af01-eeae-fb66-e9f7-41f2a022b275@kdbg.org>
        <CAGP6PO+GMi6jqRZ5HWxES5GDYkEDHoXOOZ+VvDkm0sC4nxkT4Q@mail.gmail.com>
        <5a30ac1f-d414-0976-cd08-7b059117af41@gmail.com>
Date:   Sun, 23 Jan 2022 11:51:53 -0800
In-Reply-To: <5a30ac1f-d414-0976-cd08-7b059117af41@gmail.com> (Philippe
        Blain's message of "Sun, 23 Jan 2022 12:31:18 -0500")
Message-ID: <xmqqpmoi9qna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA4FC43E-7C85-11EC-8A61-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> I see the following:
>> 
>> $ git l<TAB>
>> latexdiff   log
>
> This would mean you have a 'git-latexdiff' command somewhere in your PATH.

True.  On Debian-based systems, the texlive-extra-utils package has
/usr/bin/git-latexdiff and that is likely where it came from.

It is also worth noting that completion will also include whatever
alias.  I get "lg" in the mix because I have

        [alias]
                lg = "log --oneline"

in my $HOME/.gitconfig, for example.
