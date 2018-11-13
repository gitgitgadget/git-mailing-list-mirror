Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8C61F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 01:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeKMLGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:06:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63356 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:05:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6B081E8CD;
        Mon, 12 Nov 2018 20:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hDFD6DqEQs5+QM22gZ8ALrePSzE=; b=wbapMh
        pwi/rtaMffEUXCg1icB8wbc2TKcDS8yjMZlbh5sOp3rcumra//gAxOJs1PuiqENo
        WqUBHKCDy2rGP13+GjOzKU7QYeHmeg9aqu5JUBS5T9KyAor+dBAkzSzyEpbjObJw
        EiJ97B313rVdWF5AT/pSI+g4Y19m3lHYTX/ac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NGZCeNaJx3KgNhrR1cTC0HLk0rLUXR6S
        TM3NIEapb1m0CJfTOYWtcrNU7MsDD0jkWJSvnSKzVPijAxAS59Cze6IiQ311HNG/
        ZLvQNx735dHQGMEXiZg/eNwDEt4XoqtHRzTugroeMWNiUDbLveryOrNmvUaQKJae
        eIs/Zh7OOZo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFB751E8CC;
        Mon, 12 Nov 2018 20:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D065F1E8CA;
        Mon, 12 Nov 2018 20:10:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 3/3] index: do not warn about unrecognized extensions
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113004019.GD170017@google.com>
Date:   Tue, 13 Nov 2018 10:10:13 +0900
In-Reply-To: <20181113004019.GD170017@google.com> (Jonathan Nieder's message
        of "Mon, 12 Nov 2018 16:40:19 -0800")
Message-ID: <xmqqlg5xzssq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E11DE582-E6E0-11E8-B21B-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> We almost obey that convention, but there is a problem: when
> encountering an unrecognized optional extension, we write
>
> 	ignoring FNCY extension
>
> to stderr, which alarms users.

Then the same comment as 2/3 applies to this step.
