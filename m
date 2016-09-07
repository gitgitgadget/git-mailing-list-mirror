Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393751F859
	for <e@80x24.org>; Wed,  7 Sep 2016 16:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758119AbcIGQpC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 12:45:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56899 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756334AbcIGQpB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 12:45:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D1F33AFA6;
        Wed,  7 Sep 2016 12:44:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hW5yP3UjY9QXc7fMdKw/3k1C250=; b=Qp317Q
        tec4W+JYcbfpcDVgjQIU7PdQFXKFWlBj5QnZLGV4dolzKkxXeH5RomxRp3FSdPRQ
        KjT/DFLH8Xh6mzMA23OvafUxCMFpoIziue/nSSCDEi/lVEvA4bqEk8ROsL3Bf+R4
        v6956/Ef7jgKvDpjgwLC7sT9+KGd3r3VEquA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=buqr3Z/2ConghAwpmM8TEtYyN+l6X6TC
        sPNTRFBnRDuNYJUqZvPIgrRN29xGkyG5A5yXETan7g1JyFJfmF8h4D84Bzrw+5bx
        0lu4A3qYdANtBs3+YrVYV/62siQ04OfAm11F+OrD+nvPSzO/8s8il5VxStMUN8ie
        Vsqo9uBEwDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24C803AFA5;
        Wed,  7 Sep 2016 12:44:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BCD83AFA3;
        Wed,  7 Sep 2016 12:44:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        git@vger.kernel.org,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 1/4] add: document the chmod option
References: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
        <20160904113954.21697-1-t.gummerer@gmail.com>
        <20160904113954.21697-2-t.gummerer@gmail.com>
        <alpine.DEB.2.20.1609050944070.129229@virtualbox>
        <20160905192202.GB8254@hank>
Date:   Wed, 07 Sep 2016 09:44:52 -0700
In-Reply-To: <20160905192202.GB8254@hank> (Thomas Gummerer's message of "Mon,
        5 Sep 2016 20:22:02 +0100")
Message-ID: <xmqq1t0vpsl7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67722BB0-751A-11E6-A4BC-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Ugh, thanks for catching.  I'll wait a few days for more comments and
> address it in a re-roll.

Thanks for starting this.  I agree with you and Peff that running
"chmod" on the resulting index after other "add" operations took
place is the right approach, as we want to flip the executable bit
for paths that hasn't otherwise changed.

