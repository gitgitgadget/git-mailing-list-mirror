Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C64E1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfGBRZT (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 13:25:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60268 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 13:25:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09412153179;
        Tue,  2 Jul 2019 13:25:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F45djRxsAYvL3A1DYYKquxkmsC8=; b=LkI6Zp
        /QnyVdr81qcGiuIBUeYPiz+GeqxpYslkXLrF2BtA/IOBELJdgHsKcazcHe6kOjAo
        67DWr40n8stpe3Xvxs3A6mc6dZN5UWSNfcQ8qJpgqVUS4cUCs6uf2HDE7naJ1Ja5
        CDsmgT7KT6td5VsgrcsINhBLV73hCYbIdtOoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MPjY3c1udF7GbwT0SjFRT+rOdGOXpgn3
        X71RqX2S/XD8Rd4WjNRVDruXFcbyw79PKnHf/z2SXSOA+2fMkO5sA89zhF+VUIRt
        UliM6Bisat7A8lpQjEIw5zF2EE2UNkvGc9DU7RDhSbr0hQwktUkBt4bfkJo6cFTf
        dy9d+dqCUJ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1936153177;
        Tue,  2 Jul 2019 13:25:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44C55153176;
        Tue,  2 Jul 2019 13:25:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] t5319: use 'test-tool path-utils' instead of 'ls -l'
References: <pull.280.git.gitgitgadget@gmail.com>
        <fec75453eb3e4c286f84c538c142c3da02f75826.1561986978.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1907021202000.48@tvgsbejvaqbjf.bet>
Date:   Tue, 02 Jul 2019 10:25:15 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907021202000.48@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 2 Jul 2019 14:06:21 +0200 (CEST)")
Message-ID: <xmqqimsk4adg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B83681A-9CEE-11E9-AD73-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Stolee,
>
> On Mon, 1 Jul 2019, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Using 'ls -l' and parsing the columns to find file sizes is
>> problematic when the platform could report the owner as a name
>> with spaces. Instead, use the 'test-tool path-utils file-size'
>> command to list only the sizes.
>
> Thank you!

Yup.  Sounds good.
