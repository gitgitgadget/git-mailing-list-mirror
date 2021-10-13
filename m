Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE6DC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2876101E
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhJMU0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:26:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50052 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhJMU0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:26:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F692D8DD0;
        Wed, 13 Oct 2021 16:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hrK9J8Gi1PZHKi1XjOSJLFGSFbWbiBxtz3KmfT
        VRLL4=; b=e9T+MOB+l8TYaiHosYdDesJPFyFLJIuNEdz0pkOBYic+l9egzyjJRy
        1G9eybzxKfbBWFt3dLe/cOsiER9S24Ciyl1sKkApCDo2BR84nuFZR45lA5GY5JLq
        4IPc/Wuvgzhydmq6jwIUGwF0LcVAesAZ4O7JVlktP7jPqfckScYkg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78601D8DCF;
        Wed, 13 Oct 2021 16:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2E52D8DCD;
        Wed, 13 Oct 2021 16:24:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] remote: add struct repository parameter to
 external functions
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
        <20211013193127.76537-1-chooglen@google.com>
        <20211013193127.76537-4-chooglen@google.com>
Date:   Wed, 13 Oct 2021 13:24:00 -0700
In-Reply-To: <20211013193127.76537-4-chooglen@google.com> (Glen Choo's message
        of "Wed, 13 Oct 2021 12:31:27 -0700")
Message-ID: <xmqqczo8fzbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80E4FFAE-2C63-11EC-BCB1-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Finish plumbing remote_state by adding a struct repository
> parameter to repo_* functions. While this removes all references to
> the_repository->remote_state, certain functions still use the_repository
> to parse oids.

OK.
