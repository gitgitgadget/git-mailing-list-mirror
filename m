Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6D61F406
	for <e@80x24.org>; Tue, 12 Dec 2017 20:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdLLUoT (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 15:44:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751813AbdLLUoS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 15:44:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2E40C8D4F;
        Tue, 12 Dec 2017 15:44:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/2lvxXepk7tu3gEFDMG7yrBz8UM=; b=LydzhV
        bkK9xl8dQFQLXHj/aYWgdaqP01gIsCQ4WyWivJy7y8iQZ2twvfOWmcnCvza8cKMR
        l1br83kkNxQFQsT91nYbaxf+N1hHM+sLqM4qr4600crgUFBcwRckMDIM8/wqivge
        tqV81ooazpfnzkVOdSab040Qwz+ICRDMQlJpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GTbUvkcLxYD3Sg7UuI7JMRdrTVX9B0Gn
        bN6UQJWK46MyWiWUOKhDE9QdbEbLZtlRTDg60W2Io+vh94cHxkB1xUcwfClZ7TIG
        y6BnMzkz9SNNtGVVHxB+F1QLqGbF4YUQB/2jceniAaRVHP30v0yP5UNnLm3lSncm
        B6zxnABgNaE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9787C8D4E;
        Tue, 12 Dec 2017 15:44:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B346C8D4D;
        Tue, 12 Dec 2017 15:44:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] convert submodule.c to not use the index compat macros
References: <20171212195352.146675-1-bmwill@google.com>
        <CAGZ79kZsTduEsrC-BWOuT6Y+QGn_SLngO4Fs78q2N8Rp+xnhCg@mail.gmail.com>
Date:   Tue, 12 Dec 2017 12:44:16 -0800
In-Reply-To: <CAGZ79kZsTduEsrC-BWOuT6Y+QGn_SLngO4Fs78q2N8Rp+xnhCg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 12 Dec 2017 12:08:59 -0800")
Message-ID: <xmqq374f1xsv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 389F2A4E-DF7D-11E7-9542-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> ... would call out patch 2 to be a bugfix that could
> go independently, but the whole series is fine as-is with me.

Good eyes.  

I agree that it makes sense to treat 2/3 as a follow-up fix for an
already graduated topic, and make the other two depend on a result
of applying that first.  In practice it should not matter all that
much in this case, because the breakage is only in 'master' and is
not going to be merged down to 'maint', but it nevertheless was a
good point to raise.

Thanks for carefully reading the patches through.

