Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCB71FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 19:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbcLTT0L (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 14:26:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57792 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938599AbcLTTZy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 14:25:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 487B05780B;
        Tue, 20 Dec 2016 14:25:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zo5uKP5ctirqRSr76QV5Hv2TD9E=; b=kDKUh6
        CGfTfIZrtLG99rViayccIZ4ggtV+OxHnetIPrlcabz2/k9w3CnWZcTPqIAcSsdf9
        QFD6GYnqRofkMH3FASSJQosroqeS2pQxz+sHGYhxQ2dRHFmO7ce5bhNt8aZ+hxOg
        TuRFmVHxQGi0YC4UhNRpn12vw4tfUs21XJaj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TnZNn9wbabs/sXucTEThJV/aK39qoauX
        3DwR6o2s1LdG/se3Xonuw+v8unovdk2LJfGgc4P7XaB1kzoKryqNKGR81JB2iJgv
        Yk0jEuKcintMlz5kQ2fn+em92cVpJPmiX+w5hYmBZ7Mb2FuEazNFkXLU23AppBcN
        Fi0p/My1G3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40BD45780A;
        Tue, 20 Dec 2016 14:25:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B101057809;
        Tue, 20 Dec 2016 14:25:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 0/3] push only submodules
References: <1482171933-180601-1-git-send-email-bmwill@google.com>
Date:   Tue, 20 Dec 2016 11:25:51 -0800
In-Reply-To: <1482171933-180601-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 19 Dec 2016 10:25:30 -0800")
Message-ID: <xmqqr352jtc0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F150488-C6EA-11E6-98FC-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> This series teaches 'git push' to be able to only push submodules
> while leaving a superproject unpushed.

It somehow feels a bit strange to single out the top-level as
special like this one (iow, shouldn't it be equally as easy to push
out the superproject and two submodules leaving one submodule alone,
as to push out these three submodules leaving the superproject
alone?), but I will queue these for now with tweaks to address a few
minor points.

 * What is done with 1/3 I do not think is "refactor".

 * "perhaps a code review tool" -> "perhaps a tool like Gerrit code
   review" as suggested by Stefan.

 * Swap the order expected_pub and expected_submodule are generated
   to match the order they are used for final verification in the
   test.



