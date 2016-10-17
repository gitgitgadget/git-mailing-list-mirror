Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E781F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 20:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758392AbcJQUHK (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 16:07:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64489 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754426AbcJQUHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 16:07:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D785048809;
        Mon, 17 Oct 2016 16:07:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ECXU1Iayv3YEAQ/sPGLhJiKmRSc=; b=o+CicK
        gc+RmCHGo7F271X90iztYhAhgSki9gCyKmTDQLmP2PMlxQu7fk+6MD6hlEcmo41w
        AqvfMEmD18piU0Ohi4gvCUXTeCek3yeGKE5qe8jeSRWdNNKcc1qxCKp+tRFOGLBx
        wuFoDdMRaBsRaFxcU55zMEr5tqbGtF7/IzJ0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OjtqpvtNvwRUFEqHHA+3gvzIMlN1ofOD
        QE14x39lG0mlRaV9f5yy3Zw1JzRCP0p5TQLXjuFDKVwUPSOwpYqpEcAk7bH1INpG
        drCRyilUGI0T9eYY5K1Y6Z5ltltdYrscsnVhhagy8zx7YnqAmTnTJ2WuPKsw94D+
        mC3KPEUmO5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE98F48808;
        Mon, 17 Oct 2016 16:07:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3518C48807;
        Mon, 17 Oct 2016 16:07:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
References: <20161010175611.1058-1-sbeller@google.com>
        <alpine.DEB.2.20.1610121501390.3492@virtualbox>
        <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
        <alpine.DEB.2.20.1610131255001.197091@virtualbox>
        <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
        <2aa41392-a7ed-cd48-2737-bd852757ab35@kdbg.org>
Date:   Mon, 17 Oct 2016 13:07:04 -0700
In-Reply-To: <2aa41392-a7ed-cd48-2737-bd852757ab35@kdbg.org> (Johannes Sixt's
        message of "Mon, 17 Oct 2016 21:32:52 +0200")
Message-ID: <xmqqr37eu4d3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46FE576E-94A5-11E6-BB54-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>     "../." taken relative to "$(pwd)/." must be "$(pwd)/."
>>     "../." taken relative to "$PWD/." must be "$(pwd)/."
>>
>> test, because of the limitation of your bash, cannot have the latter
>> half of the pair, so you'd need to comment it out with in-code
>> explanation, perhaps?
>
> No, we do not have to test both cases. Git, the program, never sees
> Unixy input. It cannot distinguish the two cases.

Thanks.
