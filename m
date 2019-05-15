Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C47D1F461
	for <e@80x24.org>; Wed, 15 May 2019 02:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEOCNh (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 22:13:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58557 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEOCNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 22:13:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6078C60636;
        Tue, 14 May 2019 22:13:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mWixdLIvjwTb0xhyiVGKv+4hdB8=; b=qwIm16
        1vZIqAxtepHcECsQGpAyZ3uJYejaEBXEHS4ZGRKAIz4o52jLNSLD9O0YVeuKv8ww
        FrZNndgQfLpjHHFSZ3wrSPPPEWUtLro7QW/IZU2yDUS6FDwlGG6VuNT+40uwdF5f
        aY5Dj/EXdonFi1qU8BbgcnnADYqOrAQ6Dm1yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AHeB6TdgjB+L3vJkl61VX37BJfEN9HxX
        ltaqXkfmjRWJ3Pcj+LpqEOLWo9GtVTR1oGxTLV9UKv0uWo8vgNMU8synoF7Fql7u
        1L3Zc+edxQM2j8/r7L/ptvtpn4eEKCRgCoLFEEa/O3WajsYj0DLEqIGe6z2Qgz9C
        Tmm3bsD6DFk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5889660635;
        Tue, 14 May 2019 22:13:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C39D60633;
        Tue, 14 May 2019 22:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
References: <20190514020520.GI3654@pobox.com>
        <20190514023245.GB34155@google.com>
        <87o945wj7w.fsf@evledraar.gmail.com> <20190515011851.GP3654@pobox.com>
Date:   Wed, 15 May 2019 11:13:30 +0900
In-Reply-To: <20190515011851.GP3654@pobox.com> (Todd Zullinger's message of
        "Tue, 14 May 2019 21:18:51 -0400")
Message-ID: <xmqqtvdw79dh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09BB839E-76B7-11E9-A522-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

>>     This guards against cases where jgit is present on the system, but
>>     will fail to run, e.g. because of some JRE issue, or missing Java
>>     dependencies. Seeing if it gets far enough to process the
>>     "--version" argument isn't perfect, but seems to be good enough in
>>     practice. It's also consistent with how we detect some other
>>     dependencies, see e.g. the CURL and UNZIP prerequisites.
>
> Well said.  I indeed avoided putting the detail into the
> commit message because it was such a Fedora-specific bug.
> I'll update the commit message to add more details though,
> borrowing liberally from^W^W^Wperhaps stealing your
> suggested wording.
>
> Thanks!

Thanks, all.
