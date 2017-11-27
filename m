Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682B820C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbdK0Xhe (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:37:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57226 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752614AbdK0Xhd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:37:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3D2C969CC;
        Mon, 27 Nov 2017 18:37:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1rZouqCu6aZKuvPFnQIAxrtiBms=; b=ANKtM3
        tg9eWiOfBko6fwlg6fMpT6x72TUmscCCBn+BBHegOsfdMfSxYz9rJ1YxGVdYtK0u
        5roKIaOezwGZhg7gYdhAPfZw6R3YGa/11EcN51ikxHrLlQBYm66UoM3qyu2rNP5G
        7K4Tnrvnu1QLLfL7UFMDET5DsBzfohyxCqrmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lT2Qac0aytnvYsEOu5UHnde5WzvhDgvx
        cZpv456oeV2YejND3x9Fk6JPxubIQif2y6LMtio89vk2CdJmCxLPNkJ+kY2b9dvk
        4GHCHi0Xfax0RCvisOoSda1J4+rqSjcu2HuFmrsBlEGcRLMjXfPXm7LTxKR1i/an
        V42cLeyLPXQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA4E0969CB;
        Mon, 27 Nov 2017 18:37:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50ECB969C9;
        Mon, 27 Nov 2017 18:37:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
References: <20171116020039.17810-1-sbeller@google.com>
        <20171116020039.17810-8-sbeller@google.com>
        <xmqqwp2qx5w6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaGGUJSGG6OdfaTepDrvGBGFd17paBNNYuQt7t8XnDfHw@mail.gmail.com>
        <xmqq7euiu4r8.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZajrugviv60kQA6UepYrQGpJK447BK1fBFd3N5Wnn5rQ@mail.gmail.com>
        <xmqqtvxkm9eq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYbvdov_0cR1W9zOzkbHra6qk6gE0eAPGkzGWL_4WwcaA@mail.gmail.com>
Date:   Tue, 28 Nov 2017 08:37:31 +0900
In-Reply-To: <CAGZ79kYbvdov_0cR1W9zOzkbHra6qk6gE0eAPGkzGWL_4WwcaA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 27 Nov 2017 11:38:40 -0800")
Message-ID: <xmqqwp2b9ttw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F06B5700-D3CB-11E7-A830-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I was reacting to your "fixed".  So will we see a rerolled series or
>> not?
>
> I was not planning on rerolling it.

OK.  Then I do not have to worry about this one and drop it perhaps.
One less topic on 'pu' is always good, if it is not active.

Enjoy your vacation.

Thanks.
