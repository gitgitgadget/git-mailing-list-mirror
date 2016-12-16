Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29A41FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756018AbcLPVmg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:42:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64934 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755661AbcLPVme (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:42:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E470579F2;
        Fri, 16 Dec 2016 16:42:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T1ElKsIgXqajC8PGzsKqW+LvAy0=; b=LiZt8w
        gxyHZWG6fsz+C5bQLy86srC2StSlpFGYOX4NyFd0wISPJFvTJDH6gShewgkQmeZm
        NZ93SP78hfAe9qRtv/+xNv749zPu2SXJ4iWoDPPOaaTAnsvMsr9/9sPXw9h8leiv
        jKFTBA0SaTCcpXWX76R+eXrHOju0z5iM+kYZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vTbS2XxYjYOu91cBfxTXITYFv8jhxHJq
        s4BKN74CK2RpBEw57swpjeY9tEg72MYOTwdXyAfBSPZcxOrb6zYJXwMQ3bKdNQMR
        LSc2y6E+Giiwu/I0j9nHsnbniPukWd6gP/lSXQq4dF6VR+fpr8r1X+MzOngHKwUu
        Eu0cBJ0wOME=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 046FF579F1;
        Fri, 16 Dec 2016 16:42:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F3BA579F0;
        Fri, 16 Dec 2016 16:42:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        jonathantanmy@google.com, jacob.keller@gmail.com, j6t@kdbg.org
Subject: Re: [PATCH v7 0/7] recursively grep across submodules
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
        <1481915002-162130-1-git-send-email-bmwill@google.com>
Date:   Fri, 16 Dec 2016 13:42:32 -0800
In-Reply-To: <1481915002-162130-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 16 Dec 2016 11:03:15 -0800")
Message-ID: <xmqqlgvfr1o7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D7ABBF8-C3D8-11E6-A3DD-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Changes in v7:
> * Rebased on 'origin/bw/realpath-wo-chdir' in order to fix the race condition
>   that occurs when verifying a submodule's gitdir.
> * Reverted is_submodule_populated() to use resolve_gitdir() now that there is
>   no race condition.
> * Added !MINGW to a test in t7814 so that it won't run on windows.  This is due
>   to testing if colons in filenames are still handled correctly, yet windows
>   doesn't allow colons in filenames.

Nice.  

Will queue again to see if those on other platforms have troubles
with it.  I read it through again and think the series is ready for
'next'.

Thanks.
