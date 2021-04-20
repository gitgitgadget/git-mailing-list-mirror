Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11567C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADBA613C0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhDTUX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:23:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64577 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhDTUXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 16:23:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DD6EB900C;
        Tue, 20 Apr 2021 16:23:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uS5itk7eoL2a120n692oVtc3Fd4=; b=YNhmta
        vDQ0MYd5AdKWGrK0MZ7VHIII7kWr/SxsYkx0Vt1vbHtTHi7tuBMOIw7UI2OsILe4
        yUObWYWOevUFhyomLrlHVXBmJ25v7ebop0IAqlgPX8IZRVz/6P/4RDlHAw0BIl/W
        smRJSOsMagQuw236p+CpPae7wNwzf2GPDdXug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pr1fuLenTweCDRq8yvd7BhnssYuCv5Es
        YCiADs/R1eoBndJfhniW14eBcf4VEipZL71bXp7gO/21Ckct1gdoWsbNv56iiasJ
        FuRi/7jb/Xx50gVhCRxhJXVMZWX0zR2hwHhm3ebC1vIA8pXzG1JyewGsdRoVKnsc
        EWnCsSzl4Jk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84B16B900B;
        Tue, 20 Apr 2021 16:23:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00897B900A;
        Tue, 20 Apr 2021 16:23:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: Random GitHub Actions added to git/git???
References: <xmqqmttt7q8f.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2104201748400.54@tvgsbejvaqbjf.bet>
Date:   Tue, 20 Apr 2021 13:23:22 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2104201748400.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 20 Apr 2021 17:51:11 +0200 (CEST)")
Message-ID: <xmqqzgxs4sed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 411B46F8-A216-11EB-9DD9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you click on one of them (such as above-mentioned "Codacy Security
> Scan"), you will see that "This workflow run has been marked as
> disruptive" (see for yourself at
> https://github.com/git/git/actions/workflows/codacy-analysis.yml).

Yes, I was the one who "manually disabled" some of them.  I did not
find how to mark them "as disruptive", though.

How well are our refs protected from these random "Actions"?  Can
somebody spam us with a pull request with a new "workflow" that
advances one of our integration branches ;-)?


