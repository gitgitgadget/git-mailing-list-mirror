Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95381C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBAA6143D
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhEMUJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:09:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50049 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhEMUJq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:09:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D459B5CD6;
        Thu, 13 May 2021 16:08:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kn2ReKDXCRbS0Rdf6nmrJNWaJEtOP/wns0vFGR
        BRi6E=; b=CwEBIectC0oXJGSV8hgM+MwPvcCt1A/I59wijLxwck8pj46q17jSwL
        Y5Z3jle5DBLsDh5V2p7UF8wci6b8sP+Ly3z0jMNCv9DYhkygU/fuyyBSyTsQbnVd
        ivmI1XfXoBTM7TErq+a8GcpRLL9VcM63twUwqAiSWr5MiDy441eIU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84BF9B5CD5;
        Thu, 13 May 2021 16:08:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 016A5B5CD4;
        Thu, 13 May 2021 16:08:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Alexandre Remy <alexandre.remy.contact@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git pathspecs difference in behavior between linux (wsl) and
 windows
References: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
        <81d06db6-fd91-7ec5-6aa5-84f69a227204@kdbg.org>
        <CAKToE5DgtW1Kuw4AE5+Am_=9gATN-S=xk1kYXMZUWvtdtNy_PQ@mail.gmail.com>
        <CAKToE5DEL1ZFwUbvcC-M3y-3mSVsVgMXDig4G=jcKbc-nJ_GnQ@mail.gmail.com>
        <68a4ebd3-3c80-8983-9a26-f205debc4b5b@kdbg.org>
Date:   Fri, 14 May 2021 05:08:34 +0900
In-Reply-To: <68a4ebd3-3c80-8983-9a26-f205debc4b5b@kdbg.org> (Johannes Sixt's
        message of "Thu, 13 May 2021 15:02:32 +0200")
Message-ID: <xmqqeeeabdml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF520496-B426-11EB-A14A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 13.05.21 um 11:31 schrieb Alexandre Remy:
>> I have an additional question, does double-quotes be safely used in
>> both windows (that's ok) and linux shell  for pathspecs (git status --
>> "src/test.js") in case of spaces in the path?
>
> They can be used in both POSIX shell and Windows CMD and, I would
> assume, also in the PowerShell. Note though, that there are subtle
> differences when other special characters occur between double-quotes,
> notably the backslash. Please use your favorite search engine to learn more.

And a dollar sign, in addition to the backslash?
