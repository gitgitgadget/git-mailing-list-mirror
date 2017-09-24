Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA40B20281
	for <e@80x24.org>; Sun, 24 Sep 2017 03:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbdIXDvs (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 23:51:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56917 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751799AbdIXDvs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 23:51:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9358DB426C;
        Sat, 23 Sep 2017 23:51:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cvm488Z4m8TmMPpHynab/tIgx90=; b=pvYF/p
        wL62qrNE9CsQfqEPAjhAh6qEEoIYMuZnIERVXedbC3+FYjeCUaaybKS6SJDOqvdI
        Ui10knww35deEb1e/LwLyiGAgFhXw2iyw44nHxlRd+smhHWe8FwkOncVKVvk+7Xv
        h+6XqKUPmrPEeklHMvqqxmD6GzRNl4Wgi8De8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n24dbHLpzoaidakrUy3ouND0Jxsihe3M
        2SCcXfkIRKFMEAMzcJhd0Q7WghfFf57/m3mF1T0iQ31YysIlOkNYfx/U+09YWCE5
        370NEAZXiH7C9Re2BLWu5KZaLZigx5EL2n3lR+SXq1Hf26WoQO2OKsgMPb0pESah
        hP4JzlXHy3o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A95EB426B;
        Sat, 23 Sep 2017 23:51:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDE0CB426A;
        Sat, 23 Sep 2017 23:51:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        David Turner <David.Turner@twosigma.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v8 08/12] fsmonitor: add a test tool to dump the index extension
References: <20170922163548.11288-9-benpeart@microsoft.com>
        <20170922233707.25414-2-martin.agren@gmail.com>
        <MWHPR21MB0478265059A957CFB8785CEFF4640@MWHPR21MB0478.namprd21.prod.outlook.com>
Date:   Sun, 24 Sep 2017 12:51:45 +0900
In-Reply-To: <MWHPR21MB0478265059A957CFB8785CEFF4640@MWHPR21MB0478.namprd21.prod.outlook.com>
        (Ben Peart's message of "Sat, 23 Sep 2017 23:33:00 +0000")
Message-ID: <xmqqwp4ohhym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B00AF04E-A0DB-11E7-A73C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

>> You forget to add the new binary to .gitignore. (In patch 12/12, you introduce
>> test-drop-caches, which you _do_ add to .gitignore.)
>> 
>
> Oops.  Thanks!  Hopefully Junio can squash this in...

OK, will do.
