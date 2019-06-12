Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD961F462
	for <e@80x24.org>; Wed, 12 Jun 2019 17:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFLRs4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 13:48:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54847 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfFLRs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 13:48:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E48A793F8;
        Wed, 12 Jun 2019 13:48:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ls2F+Ij238OkqDeLCnb/pdX5ryE=; b=v1ARjQ
        zZYhYevEo7+O7B4G2HEAt1yXcrRdrPqrH8OxaOEqz3BJUvQ0KgM99pyBTbfWmix/
        XUjtFaef/uLmWE4YyytLAFT/9cSuSA87bSwl1+njl05rE8Nw5tCdofGnEh6t+uOe
        U5d8VDo5qxaaKjSAzfhbzVjGc0H+s380uirNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RaCyrG3eWol6skxrWSrHbnH/ty1tYz2F
        s9OvCWko5CLgOHpG3qV0vIqyp0FpCpHtK12jrkoY7O4XcHmec7Xb0FiC7+jkeUdf
        IWf0bxP1XCSs0cHu/rcL3QUw9OoP3y40PoeeyKFDW7ofbUez1KmgI89zbrT1UDpl
        EjRzKoS/ijM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46E7F793F7;
        Wed, 12 Jun 2019 13:48:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 733A2793F6;
        Wed, 12 Jun 2019 13:48:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #02; Thu, 6)
References: <xmqqimtiqyey.fsf@gitster-ct.c.googlers.com>
        <a958e78b-523a-5578-24dc-77597a77c724@gmail.com>
Date:   Wed, 12 Jun 2019 10:48:49 -0700
In-Reply-To: <a958e78b-523a-5578-24dc-77597a77c724@gmail.com> (Derrick
        Stolee's message of "Wed, 12 Jun 2019 09:19:34 -0400")
Message-ID: <xmqq5zpak83i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56C4F1FE-8D3A-11E9-8438-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>  (this branch uses ds/commit-graph-write-refactor; is tangled with ds/close-object-store.)
>
> Sorry for the tangle here. I'll place the proper use of
> close_commit_graph(struct raw_object_store *) into my changes
> in the next version.

FWIW, "tangled" is no bad thing.  Two topics that build on the
mainline could be in one of these three kinds of relationship:

 - independent, sharing no commits, or
 - one builds on top of the entirety of the other, or
 - share some commits but neither is a subset of the other.

and "is tangled" was, even though I didn't really like it, the best
phrase I found to describe the third kind when I wrote the script
that manages the "What's cooking" report.

Thanks.
