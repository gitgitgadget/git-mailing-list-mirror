Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F0C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC10610E6
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhDQILx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 04:11:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62053 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhDQILw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 04:11:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0E6711ABDD;
        Sat, 17 Apr 2021 04:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pqkoM3RJIWtfY1WbJMFw6v0cqfg=; b=BRhglN
        D6TET7SCH3fA/pOmmXvEJN7p+I2m454LNFrSVAIkA+hhcMoZwnQx0cEeNbo37YNp
        xeTcDbVCogXWbSDeC0L+GnjGyclCatz00wO18PtZ28HQGDJYGlvkVRWn5CFLlUDo
        Y21XAbYWoAprWNEHqonjLRmAFCoiqNGxzlHBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iw3ll96KwUoranEWxzzfWrzHB8xxrUgU
        wES99PWFGTKPQTiM89P6+051JhZd4i/l/W1IIChNwbAWO7mfjDnbJBVhuAjwSl5P
        4jbwjTSd2/uvNYsWaqNUMNLLHtOnMcUyWP608KEeREOpj0QKWYbuQI0U/T46UXv1
        xcmu789Y5fY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6D5511ABDC;
        Sat, 17 Apr 2021 04:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0378811ABDA;
        Sat, 17 Apr 2021 04:11:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
        <xmqqy2dikpc1.fsf@gitster.g> <xmqqr1jakp57.fsf@gitster.g>
        <xmqqpmytiplw.fsf@gitster.g> <xmqqlf9hinuw.fsf@gitster.g>
        <CAOLTT8S-CLSk6Obu-8L+QKb9YjBufVTMcTnSrfaUOQmyej59TQ@mail.gmail.com>
Date:   Sat, 17 Apr 2021 01:11:22 -0700
In-Reply-To: <CAOLTT8S-CLSk6Obu-8L+QKb9YjBufVTMcTnSrfaUOQmyej59TQ@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 17 Apr 2021 15:41:17 +0800")
Message-ID: <xmqqk0p1baad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 801B7950-9F54-11EB-B1C4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> But when I am reproducing your solution, I may be in trouble:
> If we let shell-script `exit(1)`, `capture_command()` will output
> "running trailer command '%s' failed" which is its origin strategy
> in order to catch the user's command error.

Yes, if we were to take that route, the trailer.c code needs to be
taught to conditionally not to pass $1, and capture_command() needs
to be taught to conditionally be silent on non-zero exit, as it now
is a perfectly sane for the program to exit with non-zero status in
some cases (like this one).
