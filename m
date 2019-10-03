Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391B41F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 00:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfJCA51 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 20:57:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51603 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJCA51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 20:57:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD0FC1B547;
        Wed,  2 Oct 2019 20:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7m2y1WIkQqQJzskE7rMFcfLAD80=; b=ucYKeA
        OjTOcDUiB47wIsoJpGtYSXIWChmrq6oS4BILG3rqxGK14qNNtGDE9FziF8k/gVYu
        CeTGQxwdEM/SlTQC+/I1dYDCg9OQ0QMQhyT/uFbrqpYoW7tn0dzCu8FFBuQQ0i1g
        4J0Nnl/BDRPhUXXlxzc3IoK/njX/3yf491GCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IKs3M1e4cIOO198iC1QTNHWYox1Jd3MB
        AiNSFQUqb3LCWB5lDgDtGjR2OGrstj6CEehew3B+u0CFFnM3UK08iSLSa4VBwlRz
        NFYVID6TVlBsmAz2CWvCdTfku0lzmX9Bmnh2lVgJ9fA4qhcBKFMkzGZroMo4jOrA
        0LaLksXoJU0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3FF21B546;
        Wed,  2 Oct 2019 20:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A1381B545;
        Wed,  2 Oct 2019 20:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 3/3] format-patch: use a command to generate the output directory name
References: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
        <431f8a4e372feccf240b9c66c91248a6f53eab47.1570051490.git.bert.wesarg@googlemail.com>
Date:   Thu, 03 Oct 2019 09:57:23 +0900
In-Reply-To: <431f8a4e372feccf240b9c66c91248a6f53eab47.1570051490.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Wed, 2 Oct 2019 23:26:13 +0200")
Message-ID: <xmqqeezud4ss.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C313B8EA-E578-11E9-B49D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Having 'format.outputDirectory' is convenient, but being able to process
> all produced patches via a wildcard command is even more so. I.e.,
> using an argument like '<dir>/*'. Neither '-o' nor
> 'format.outputDirectory' can be parameterized to produce a new unique
> directory. Thus provide the new 'format.outputDirectoryCmd' configuration
> to specify a command which does the job and puts the name to standard
> output.
>

The above does not interest me (a reader) enough, without the log
message explaining why

	git format-patch -o "$(outdircmd)"

is not sufficient.

Thanks.
