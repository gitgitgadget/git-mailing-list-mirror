Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D6B20229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbcJUWlt (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:41:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64314 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754820AbcJUWlt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:41:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BAC448EC8;
        Fri, 21 Oct 2016 18:41:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MYWKmbLpsHYj3Q8+vcQxjZRgS/U=; b=UPpmPw
        G9B/DvByg3MiT8BK6JPXfDsBfOd0yu3jhUtett0t38s4K47315ZfPsqd2vJ2dDkn
        RwNkQSpK0Mt5bBGSuPtXAK6QoRRY6qD2Ub5L5adSdPOW/EUULlbWMgabKGT7ByWr
        KhAQuOXyz+sIDrhfcgJAtxFEbNfYggD6yfB7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DTrUAoolqaCfYaOwR1JiDnJawS9sHm79
        PkOwIMYIsl7kT0NoZJfB03nBmTEP86k+GYxNGMBaZYmintblijE3wpJT592AFWl1
        cfpAzSRlMwWJRi6OK+W4y1P+Bp458Gtx0pOXI6RufDEaRdjLDRr04MW1RrL+Ji9O
        jCpf41jeYwM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13CFD48EC7;
        Fri, 21 Oct 2016 18:41:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BB1048EC5;
        Fri, 21 Oct 2016 18:41:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: generating combined diff without an existing merge commit
References: <CA+P7+xrN-_zP40uAUGtqZW+OO4D4Z65SiPRykdKvauO1zgNNcQ@mail.gmail.com>
        <CA+P7+xoTO6MqdBjekbSpSs=w_dJ-1h_ypMDAo50mm95iTOo9Pw@mail.gmail.com>
Date:   Fri, 21 Oct 2016 15:41:45 -0700
In-Reply-To: <CA+P7+xoTO6MqdBjekbSpSs=w_dJ-1h_ypMDAo50mm95iTOo9Pw@mail.gmail.com>
        (Jacob Keller's message of "Fri, 21 Oct 2016 15:01:25 -0700")
Message-ID: <xmqq60olb9zq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CB9F032-97DF-11E6-9B66-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Turns out that somehow I must have messed up my command because "git
> diff <treeish> <treeish> <treeish>" does indeed do exactly what I
> want.

Thanks.  I was wondering why it didn't work for you, as the feature
was done exactly to support that use case ;-)
