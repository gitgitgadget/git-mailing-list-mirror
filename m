Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF5AC2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21849206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nykGZtLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfL3QwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 11:52:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64356 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfL3QwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 11:52:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C744F9D44C;
        Mon, 30 Dec 2019 11:52:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GhiUqqQKU3H3U11vBXmVLU0gS50=; b=nykGZt
        LOnL0TWCEUZMUOEgepr4hueOYWIYhskj5FMaRTS7Ug5ldWtDRBMD844DDskWD57s
        JZHkWtGz52+QboYCKHtHF67KUPoUiDj+U/t9eKuCD4RrAYyl2m9HZXlhCNGwaYPh
        hQLXtUa9ZID5ERYGuFzy/nFAjV9a67uto38Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tL06LfsJqU2XK8f+FR++BRpqa5Op1Qhq
        6kqMGHhlwJaGVcPaX0UqjYrtDmbPWFLxd7ubQviaWXHQ2A2/eEedmT3wgYRACZys
        xP/8TgnVcHxGR3pqZa52D8qh5iCp0mne/Cz/23xnAviiBz95oyGdylpl8U8TUJBP
        ifnmBPjynmY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEC019D44B;
        Mon, 30 Dec 2019 11:52:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8D029D448;
        Mon, 30 Dec 2019 11:52:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gal Paikin <paiking@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Updating the commit message for reverts
References: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
        <xmqq7e2l5ych.fsf@gitster-ct.c.googlers.com>
        <CAEsQYpMJGbw3L66vCd25Ht0bTBzvvt1yMRd2U3=u3U-BZukyzg@mail.gmail.com>
Date:   Mon, 30 Dec 2019 08:52:17 -0800
In-Reply-To: <CAEsQYpMJGbw3L66vCd25Ht0bTBzvvt1yMRd2U3=u3U-BZukyzg@mail.gmail.com>
        (Gal Paikin's message of "Fri, 27 Dec 2019 11:13:47 +0100")
Message-ID: <xmqqwoadhi2m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE4B9EB2-2B24-11EA-B385-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gal Paikin <paiking@google.com> writes:

> So the idea of changing from "Revert Revert" to "Reland", "reapply"
> has a big problem: sometimes Revert^2 actually means 'reverting
> "Revert"' since "Revert" introduced a bug that wasn't in the original
> change.

Sorry, I do not see a relevance of the above in this discussion, as
the situation does not improve if you phrase it as "Revert^2" or
"Second Revert".

Also as somebody else said in downthread, the phrasing "second
revert" would typically mean "a patch gets applied, proves to be
premature and gets reverted, the revert is reverted because the
situation in the rest of the system improved to make the orignal
patch viable, and then gets reverted again due to some other
issues", i.e. "Revert Revert Revert do something", so it is even
worse.

