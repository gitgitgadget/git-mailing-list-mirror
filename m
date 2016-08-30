Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F97A1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbcH3STr (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:19:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55046 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752300AbcH3STq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:19:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8D9C3986D;
        Tue, 30 Aug 2016 14:19:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G9Y+s2oL3BwnGq8ca1DM6UWG+vM=; b=R+XVZw
        a7CnAzZ8SA5PE/zPf20T77Y7DbMDqU/zDPxlVDaioC0MQA7qnXuU8ICN/28WcPmG
        btzNJmnm0lNSkAY88CrSCB6ABBq2rJKZPWzsNosKg+apazzbcx5UfvaakMHPxKB3
        y2jltTb+5NSNZID7uxNK8mSiilHH+TLsS4bDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BSRINj7uKbMSq0whyuP7rzBCgF0szUYj
        okQbkCG7AECMjgXp1Kz+mrzkmHucM9Vw9A+QxoHIrwYXPMFCowwXRw28Ft4QwtJz
        JP+qaK56DdSgLpainqMkGOH0WaAk3w6IL0mRDzTzp0grWJYSGX1j8CP33XhOe541
        uMRTd+XqaJg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC2A63986B;
        Tue, 30 Aug 2016 14:19:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6754D3986A;
        Tue, 30 Aug 2016 14:19:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     ryenus <ryenus@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Notation for current branch?
References: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
        <20160828105159.GA5477@ikke.info>
        <4114ccbc-6b23-b7fe-ce4a-fcd0c9e4038a@gmail.com>
        <CA+P7+xrGh687cYHJmYyXiWfjg_8i2-31FZOvk4bEMsO1FU22WA@mail.gmail.com>
        <xmqqy43f9wzh.fsf@gitster.mtv.corp.google.com>
        <CAKkAvaxyEMjASzfGTqt73AtW7ag-YfqN1yVLEhFreiU-UVdnkA@mail.gmail.com>
Date:   Tue, 30 Aug 2016 11:19:42 -0700
In-Reply-To: <CAKkAvaxyEMjASzfGTqt73AtW7ag-YfqN1yVLEhFreiU-UVdnkA@mail.gmail.com>
        (ryenus@gmail.com's message of "Wed, 31 Aug 2016 02:09:58 +0800")
Message-ID: <xmqqoa4a3yrl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 538458AE-6EDE-11E6-BACE-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ryenus <ryenus@gmail.com> writes:

> For now the best use case I can think of is with git-reflog, e.g.,
> the meaning of `git reflog HEAD` and `git reflog feature-branch`
> are quite different, even if I'm currently on the feature-branch,
> especially when I want to track the rebase histories (if any).

"git reflog" gives you the reflog of HEAD in numbered format
(HEAD@{1}, HEAD@{2}, etc.), and "git reflog HEAD@{now}" is an
interesting way to tell it "I want that same HEAD reflog but not in
numbered but in timed format).

"git reflog @{0}" and "git reflog @{now}" give you the reflog of the
current branch in these formats.

