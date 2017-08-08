Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD9320899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbdHHTnW (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:43:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60716 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752152AbdHHTnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:43:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBB399D696;
        Tue,  8 Aug 2017 15:43:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zfSokOoHn6568KGS/wDQu1YWr3M=; b=KCo+ak
        Ez6DaE1fn+V9WUxyH48kRXB34F1Kmq63xRXs3sBmdAufiuJE1Ba3aSpAewSu/vOi
        I3epUSDHCEGxctmLkCf1FAXAVdP6bDN1XSL/6yk2kTUrgKtBfweCFYWQtlyQi05A
        Wn+oJ0yWlMPFQCAGuq98Qv7Aet1Jw9hMm5CDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZcJXM2lt7mpFwLP8nr0q3Zy2igCVKQ0v
        dW/UsOq+igDAopMK5VP9yiNStLRRU9lxzEs2IY/c8T/SHP5FgP6olI2M0hhNQW8q
        KqFHG9c4OzO+EiEYA1/8FJNbzYYuQiQ8XwKReCtNxTeX6+vVBZ7Kj5pjpZwW+gbF
        99zpjSex450=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3E0E9D695;
        Tue,  8 Aug 2017 15:43:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 221279D692;
        Tue,  8 Aug 2017 15:43:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2 / RFC] branch: quote branch/ref names to improve readability
References: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
        <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
        <20170808171136.31168-2-kaarticsivaraam91196@gmail.com>
        <CAGZ79ka779gwmLKuSumRdFj3PqXkUe8SfG2ri+qmf_9Z3gsckg@mail.gmail.com>
Date:   Tue, 08 Aug 2017 12:43:11 -0700
In-Reply-To: <CAGZ79ka779gwmLKuSumRdFj3PqXkUe8SfG2ri+qmf_9Z3gsckg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 8 Aug 2017 11:55:43 -0700")
Message-ID: <xmqqh8xhc0c0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0A246CE-7C71-11E7-BEA0-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> (Though wondering for non-submodule users, if they perceive it as
> inconsistency as other parts of the code may not follow the rigorous quoting)

Do you mean that we may instead want to remove the excessive quoting
of branch names and stuff from submodule.c code, because they are
newer ones that broke the consistency existed before them (i.e. not
quoting)?

That certainly is tempting, but I personally find it easier to read
a message that marks parts that holds "external data" differently
from the message's text, so I think this patch 2/2 goes in the right
direction.
