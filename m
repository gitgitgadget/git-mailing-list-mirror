Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653C11FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 00:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdJFApF (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 20:45:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60053 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751083AbdJFApE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 20:45:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B08DA6003;
        Thu,  5 Oct 2017 20:43:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=deCnWgqlfeEOisnRUgykUCKcCO8=; b=KoPsIL
        +ZSc7kZ2FRDA6JJAFdGWtdXZt0awnIew5OadWSeFUHKVZFMLh1OAougty3ZG27Zx
        cjCkrk7Wwb0F1TTT8AWWXtnCl28UJLJ1xhmukW38IJ453RB0L/p+HgfVDoy+qOu/
        nk+qlmtCDac7082LhAc7KOeL4IrUZMrZhLWB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vX0TtBwvR2njofrslBJNjpM9Kn9HvAJR
        2KINGDCgL0L5bR147n7jLEiRMAm0VCa4GM6oonf4fusthqcFDosCEZNm4J2XynsE
        y9sX/W5TVzxJaWWiS1QychoFf9e7DDFf1Z0QpF/ZvBu6ZCtrqsxPGirAARGwa6Ri
        /H8XTG1zj64=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73877A6002;
        Thu,  5 Oct 2017 20:43:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF097A6001;
        Thu,  5 Oct 2017 20:43:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Reporting index properties
References: <alpine.DEB.2.10.1710051625430.812@alexmv-linux>
Date:   Fri, 06 Oct 2017 09:43:14 +0900
In-Reply-To: <alpine.DEB.2.10.1710051625430.812@alexmv-linux> (Alex Vandiver's
        message of "Thu, 5 Oct 2017 16:39:20 -0700 (PDT)")
Message-ID: <xmqqzi955cnx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57159112-AA2F-11E7-8D48-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

> Do folks have feelings about surfacing this information, and where such
> logic should live?

Probably one of the t/helper/test-dump-*.c programs, if we already
do not have one.
