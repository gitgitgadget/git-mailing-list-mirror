Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1604CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbiDRP51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346031AbiDRP5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 11:57:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583C26F2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 08:48:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C28711EEDD;
        Mon, 18 Apr 2022 11:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KAf4HLa5VVZor/EJ2foVVB+OzTFxire/4iEnOA
        sqBFE=; b=Lt0EDaVDZ1PjVF/PKDkJtOL8TWHc83SoOui5V00PS+cfY0csdOkRVn
        QeBaAkZ+Obo/sHiAMnHwwiYl67I0dGKr8c4k2D4DMrEVAeZ00C/3x0nNYAQZ12Aa
        +fQUMSBqi4FfH+l7OqDgAX3YI4GY23Wy8b7f0I/SFpe0TMOgfk4AU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01F6C11EEDC;
        Mon, 18 Apr 2022 11:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46FD811EEDB;
        Mon, 18 Apr 2022 11:48:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
        <f87a549f-540e-d0f3-470c-178c2fa141a5@iee.email>
Date:   Mon, 18 Apr 2022 08:48:06 -0700
In-Reply-To: <f87a549f-540e-d0f3-470c-178c2fa141a5@iee.email> (Philip Oakley's
        message of "Mon, 18 Apr 2022 15:26:57 +0100")
Message-ID: <xmqqczhe1jgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F228158A-BF2E-11EC-8169-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> The rerere man page is still magic for me. The UX here could be
> improved. (also, could the rerere-train be focussed on each merge?)

I am curious to see a clarification on the question in parentheses.

>> These kinds of discussions frequently seem to feature git experts
>> saying "I have a script for my version of this problem" (Elijah,
>> Junio, Johannes Schindelin, ...), or even "I have a VCS for this
>> problem" :), but I seem to be too stupid or impatient to dig
>> through/understand whether or when these things will work for a
>> regular joe and how to use them.

You shouldn't take that to mean "there already is a script to
satisfy _my_ needs and no improvement is needed"; read it as "we
have real need that cannot wait for improvements in this area, so
(unfortunately) we have built our workflow around some scripts".
We can use these scripts to learn the workflows that are not yet
directly supported with existing tools like rebase, but other than
that, their presence is not a sign that discourage you to improve
the standard tools---it is quite an opposite.
