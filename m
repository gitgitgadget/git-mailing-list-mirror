Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F0E1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfHZO0r (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:26:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62175 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfHZO0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:26:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48A416B9D4;
        Mon, 26 Aug 2019 10:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fWz4zjQx9zwb2ekybTUzXP8fZ4A=; b=FXbQ7w
        nh+zDVk6IAJLOGi/mPSi4Y83yA1WHy5Ot2sVfo8kBfLdHAdjgnn30fzA04dQHRvC
        O3rGt9sJhW/ZrGdIuhnXU6j3C1FDio9PXDw6ZZIH3RZ0EljtrPfdHk3QJcTjiQuo
        zJh6W8NdhL8N3MJe2JKUBJZUyq4CZoRjHbLtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kr/3Y6odBFsS06D3FIOjRSzy9BCFfzJm
        5Nhl5uFvc7qjkkSnZUK+bTXdvmTjdV6wJkajYTiAFIb3sSH/ZmvUAf41YlYB9/mV
        n1oJ4qs5X2tQEuA8SuAwaCm6mtsIoebPEh80ltqcp3gEvLWp7lyt3uFvTmIo8yTV
        pVHX1KVl4+g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 411F06B9D3;
        Mon, 26 Aug 2019 10:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52A106B9D0;
        Mon, 26 Aug 2019 10:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
References: <cover.1566258525.git.liu.denton@gmail.com>
        <cover.1566285151.git.liu.denton@gmail.com>
        <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
        <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
        <20190823181545.GA14048@archbookpro.localdomain>
        <d8a02cfd-2250-44ce-b559-dbec742b7cdf@iee.email>
        <xmqq1rxbmy8r.fsf@gitster-ct.c.googlers.com>
        <20190824080328.GA9726@archbookpro.localdomain>
Date:   Mon, 26 Aug 2019 07:26:36 -0700
In-Reply-To: <20190824080328.GA9726@archbookpro.localdomain> (Denton Liu's
        message of "Sat, 24 Aug 2019 04:03:28 -0400")
Message-ID: <xmqqef18knoj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 846FCFBC-C80D-11E9-8FD1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Perhaps something like
> --cover-subject-from-description={true,auto,false}?

Is it still only about "subject"?  I thought one of the improved
behaviour was to populate the subject header with the title
(i.e. the first, often single-line, paragraph) and use the remainder
in the body?  --use-description-in-cover={both,auto,body} meaning
"both subject and body gets filled" (among the three this name is I
am least happy with), "automatically decide---if the first paragraph
is overly big, it is unwise to use it on the subject", "use it only
in body" (implying "use the *** SUBJECT HERE *** placeholder on the
subject header), perhaps?
