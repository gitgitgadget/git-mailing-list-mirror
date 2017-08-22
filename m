Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01AFE208CD
	for <e@80x24.org>; Tue, 22 Aug 2017 00:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbdHVAUf (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 20:20:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60758 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754328AbdHVAUe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 20:20:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09BA8A0AE4;
        Mon, 21 Aug 2017 20:20:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QjjlRrlpXKDJ+2ZGK9KaF9xiwB8=; b=h/DvSr
        OzR7FojfsLIZ4gprMPLEew23PtKTIBrPiCm7yOyxu8bZyY8Ma4puJhuCzW6b4lOA
        6z5IrNW1GBmHcfAh6Zao1kpWrFkSPkRyqVrk4P+yd7nhRJg5Ap9wpQBCyEIdaRek
        TIUwoIMPosBvdINK2212lcvaTMDbIuTAKqteo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AQhazbzzzJPkx3Zs+WW+EQwYCN9LHcMN
        p5chCTqkkDZOod8CEKaNgaJT65RoHEtLBt/YEKLUKN+KCG/7IX7sxoPSsQxABFdt
        Iw1YABMy+iHLjFzoozYyNwKtQu/buTQdRV8kwFhCNnAJJrp+lrVJcYhRD+A4nnQU
        4BHxgvOej3A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 001FBA0AE3;
        Mon, 21 Aug 2017 20:20:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6825FA0AE1;
        Mon, 21 Aug 2017 20:20:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, hIpPy <hippy2981@gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation/git-merge: explain --continue
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
        <cover.1503319519.git.git@grubix.eu>
        <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
Date:   Mon, 21 Aug 2017 17:20:32 -0700
In-Reply-To: <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
        (Michael J. Gruber's message of "Mon, 21 Aug 2017 14:53:14 +0200")
Message-ID: <xmqqo9r84fn3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B662FA8E-86CF-11E7-856E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Currently, 'git merge --continue' is mentioned but not explained.
>
> Explain it.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  Documentation/git-merge.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 6b308ab6d0..615e6bacde 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -288,7 +288,10 @@ After seeing a conflict, you can do two things:
>  
>   * Resolve the conflicts.  Git will mark the conflicts in
>     the working tree.  Edit the files into shape and
> -   'git add' them to the index.  Use 'git commit' to seal the deal.
> +   'git add' them to the index.  Use 'git commit' or
> +   'git merge --continue' to seal the deal. The latter command
> +   checks whether there is a (interrupted) merge in progress
> +   before calling 'git commit'.
>  
>  You can work through the conflict with a number of tools:

Thanks, looks good.  Will queue.
