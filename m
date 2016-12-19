Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543BD1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934105AbcLSSlg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:41:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64729 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934108AbcLSSlf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:41:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0D00581F5;
        Mon, 19 Dec 2016 13:41:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J/ZSoOF8TKKko9Ss4VM3yqKS7ZE=; b=x3CjPd
        SMGmsRRg4toJwU3f4Gtr+6z5Qe/1hSDWhZEdSuoZLtY9EIMYLXofr4dexK7MVFrA
        vZVntA1aZgtpadb1p2JeoUo0blW45+BV56dIpm4vTGI+X7fmnuoAybLhCQhq1JO7
        xV4t86gwOKd3KL04rh4d59aKyu9DLS44xS36A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fPszkNDDNkFLI4uPMLIgJv53Fzc5n5ja
        lHz3wJIbTzReZ/UDdjSCa7yJSe11eWgAqva76CxPjqlzQRw7/1R2fcTIxVDqwUag
        7Rg4emK8JvR62Ql1GxHo0QOmTmZ39ijOlwBGnSaLNMtNkIaZu2MSnRfkZn4Y3iNf
        TzQHgcDbBgM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90C9E581F4;
        Mon, 19 Dec 2016 13:41:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEBE4581F2;
        Mon, 19 Dec 2016 13:41:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 0/3] push only submodules
References: <1482171933-180601-1-git-send-email-bmwill@google.com>
Date:   Mon, 19 Dec 2016 10:41:32 -0800
In-Reply-To: <1482171933-180601-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 19 Dec 2016 10:25:30 -0800")
Message-ID: <xmqqd1gnpxr7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3E3E6BC-C61A-11E6-A63B-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> This series teaches 'git push' to be able to only push submodules
> while leaving a superproject unpushed.
> ...
>  builtin/push.c                 |  2 ++

My knee-jerk reaction is "why is this even part of 'git push' if it
does not push?" 

I think "git submodule foreach git push" is probably a mouthful to
say, but I am not sure "git push --recurse-submodule=only" is a
short-hand that is way better than that.  

Maybe I'll find why the latter is better after reading the patches
through ;-)




