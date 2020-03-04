Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A67C3F2CE
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304FA2073B
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 17:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b5+QxwL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgCDR0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:26:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59284 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDR0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 12:26:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB72FA8274;
        Wed,  4 Mar 2020 12:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=adbUVbxCS6mcfaa4yp1LdN0BII4=; b=b5+Qxw
        L0saLp3n4scEySsfDpkKFU+MxwRZ+wd64S6zbpPB28dCt5IVF0/xEjYRkt1JGthc
        Yv9yE/uFsSxwQ0Egu/qu/D81lIrxI51tOXaxiF90GlsVoOFWEGepCjMHMxpcCCIH
        Dtg3D3oMHtOB5GRWHrfzmCE9Sl+QCB/GKZEkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hGFTIRzwILGIDmTuKs9ZHBuMMi/o+U+U
        v2EZB6NsUxldkpMEUk7VK6CMeme0j/+keaWepijJnOEdkKZnodSAW+zNR6NT7vsG
        GJyTEYUIaLX/RwouFQHJ7Be9ahbv0mlsCOPmRiKAvMrys7Eg0uaoK8oNmV05mMk5
        3BcqyplpLqg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B398AA8273;
        Wed,  4 Mar 2020 12:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB61DA8271;
        Wed,  4 Mar 2020 12:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Takuya N via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Takuya N <takninnovationresearch@gmail.com>
Subject: Re: [PATCH v2] doc: use 'rev' instead of 'commit' for merge-base arguments
References: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
        <pull.719.v2.git.git.1583325514607.gitgitgadget@gmail.com>
        <xmqqd09s5atg.fsf@gitster-ct.c.googlers.com>
Importance: high
Date:   Wed, 04 Mar 2020 09:26:00 -0800
In-Reply-To: <xmqqd09s5atg.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 04 Mar 2020 08:44:43 -0800")
Message-ID: <xmqqzhcw3uc7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38EA7364-5E3D-11EA-AF56-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ... another important
> point (i.e. when a command wants to take a commit but a user gives
> it a tag that points at a commit, the command almost always accepts
> the tag, finds the commit the tag points at, and uses that commit
> instead of the tag ...

A side note I forgot to add.  A few commands take both commit and
tag but want to do different things depending on the kind of object
they get, and for them, <commit> and <commit-ish> should be used
carefully in the documentation.

For example, "git cat-file commit v2.25.0" and "git cat-file tag v2.25.0"
do two different things.  They should be described as

	$ git cat-file commit <commit-ish>
	$ git cat-file tag <tag>

"git merge <commit>" and "git merge <tag>" do different
things, even though <tag> must be a <commit-ish>.

But most of the Git subcommands (including the "cat-file commit"
case) peel a tag as needed, so these special cases are minority.
