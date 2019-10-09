Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29361F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 11:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfJILha (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 07:37:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51170 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJILha (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 07:37:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 328633C7DB;
        Wed,  9 Oct 2019 07:37:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8otSTzcP8W23dJf0JqVcUKPVqiE=; b=sc0y7+
        nL2lDmoZIG7pSN7vkOBptW35f9SLfTBZJ52t86SRpNDUUVPOd1pNp7jM2WARRyom
        ZMuWmke/ub4J+XAa4syqjmvgBThZFbGlCSpD2xLjS1qMsbjIXhAa81cu6Zg90PMw
        EmWJnPHtI10pidV4hsCbTj7AJZvDgGFowhUBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vox6G17ZYMH22VgU533dmumkmfQ+VhUF
        bEJlalEEzouIaQkoVkqRhCBoxLsmha28Q2Uh+GSa9yUCcAPFoKpQF8n+vzGQGw2P
        jIriK/5YATkrMlIS/cAp6FAWN+QMIqCp1qoLwfhGBtTJnB9ekeoptyNdhIpzTh3X
        j080wslsOPc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2824C3C7DA;
        Wed,  9 Oct 2019 07:37:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E5C23C7D9;
        Wed,  9 Oct 2019 07:37:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
References: <20191008074935.10972-1-toon@iotcl.com>
        <20191009014039.GA10802@szeder.dev>
        <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
        <20191009112021.h2ywofk2pivdyavd@camp.crustytoothpaste.net>
Date:   Wed, 09 Oct 2019 20:37:26 +0900
In-Reply-To: <20191009112021.h2ywofk2pivdyavd@camp.crustytoothpaste.net>
        (brian m. carlson's message of "Wed, 9 Oct 2019 11:20:21 +0000")
Message-ID: <xmqqimoykv49.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BB1F848-EA89-11E9-9E8F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ...  An option to git commit such as --trailer would
> allow folks to add whatever trailers they wish, including this one,
> without us needing to bless particular options.

Yes, that was what I was hoping to become the "core" of the idea,
with possibly syntax sugar to make it easier to use.

Thanks for filling in what I left unsaid ;-)

