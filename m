Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554401F461
	for <e@80x24.org>; Tue, 25 Jun 2019 19:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfFYToP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 15:44:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58927 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfFYToP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 15:44:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B74C6DE3F;
        Tue, 25 Jun 2019 15:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gqVWq5HUZ4YMANB1d8qfysOe1bI=; b=VMjYym
        jK4QxLtLOvFyh6xc/5yMq/U21u3qcKP57fYaKuHWtP9kOw+dzDPhK2lLrsSylzaR
        ZPC1Hf5JWcYGQQWjlvGfuTTOG9HJUhCcgva5B0V6kyvFiaLAz3dTCOAkkboNgdGy
        lkxOIMGLyNlMykh/AA6Wlb3IMrwC8y/5Q2v7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LZW6APiuLGjLQgulNVmM13A8xHj5cBO3
        5+4UuGB83F5bSIUG7gtCuxPbYHxclLxAQ9ZqGswxH36t7a+mmA8vJSLOTd5eAM/6
        sfuxxvSKZ9bzX9lXgUV3h5d801xL1K4XSnQN/TkBSiw0uGAUrjiQlRDShyESumO3
        4DQRLljO8iY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 032F86DE3E;
        Tue, 25 Jun 2019 15:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 111646DE3D;
        Tue, 25 Jun 2019 15:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] progress: use term_clear_line()
References: <20190611130320.18499-1-szeder.dev@gmail.com>
        <20190624181318.17388-1-szeder.dev@gmail.com>
        <20190624181318.17388-6-szeder.dev@gmail.com>
        <nycvar.QRO.7.76.6.1906251110160.44@tvgsbejvaqbjf.bet>
Date:   Tue, 25 Jun 2019 12:44:07 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906251110160.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 25 Jun 2019 11:10:57 +0200 (CEST)")
Message-ID: <xmqq5zotfo1k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99F240D4-9781-11E9-B80D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> To make sure that the previously displayed progress line is completely
>> covered up when the new line is shorter, commit 545dc345eb (progress:
>> break too long progress bar lines, 2019-04-12) added a bunch of
>> calculations to figure out how many characters it needs to overwrite
>> with spaces.
>> ...
> Very nice change, indeed, I totally love how much simpler the post-image
> looks. Well done, for the entire patch series, and thank you so much!
> Dscho

Thanks, both.  Let's merge down sg/rebase-progress soonish.

