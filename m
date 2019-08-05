Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F991F731
	for <e@80x24.org>; Mon,  5 Aug 2019 18:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfHESkk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 14:40:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55869 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfHESkk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 14:40:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BF6D174CF2;
        Mon,  5 Aug 2019 14:40:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lnUnqWbNlsrQUtIZVBCfObUK7V8=; b=MdlJrf
        AANDTGUUpbitacRIUkCf7GrgbUrdKLNrOHWkDgZoSsGulxtGZT2/K3XRjr2kPe32
        aHekhbTi4hlTIV2HQprqvn/dZ0mpNhrdrqKVTXSXoi9PvHzd1IMtjpTsTGrpAzhX
        dSYoaIDhLeAKwpp+W/Zus7QypD7njSNr9tgys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d8NuWt5tGPyl27WbhLPTI7olKpn/smgA
        zCzTA+q0/rzzCnMtinpZScpQqooqJwkQnofQ6V3XninonXq1wd3yVuerbtdVdX4v
        NXRV178X5M0YMgcLAGyX88n+7PxI1QKKYLrz5WOOmwRfDRN2eozAN5uVppaDNCXa
        S6rVewzIB0Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F929174CF1;
        Mon,  5 Aug 2019 14:40:38 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6050174CF0;
        Mon,  5 Aug 2019 14:40:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/visual-studio, was Re: What's cooking in git.git (Aug 2019, #01; Thu, 1)
References: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1908021405450.46@tvgsbejvaqbjf.bet>
        <xmqqk1bvlds0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1908032217420.46@tvgsbejvaqbjf.bet>
Date:   Mon, 05 Aug 2019 11:40:35 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908032217420.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 3 Aug 2019 22:22:24 +0200 (CEST)")
Message-ID: <xmqqzhknmp5o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83EDC7F0-B7B0-11E9-AE28-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Yup.  I think they are now in good shape to be among the first to
>> graduate post release.  Building the warning facility necessary to
>> start dropping the $GIT_DIR/branches/ support would be too late for
>> this cycle, but now this topic is independent from that, so it may
>> even be worth considering to have it in the upcoming release.
>
> I see that you made up your mind and graduated the branch to `master`
> already. Very happy about that, and of course I hope that this was
> intentional ;-)

Yup.  Thanks, as usual, for all the help.  I didn't see anything
remotely problematic in the latest round of the series (except for
possibly the "resurrect '#if 0'ed out block of code in git.c" piece
but that one is a simple enough change in a reasonably dormant
codepath that is easy to revert if/when unforeseen issues are found
by people with different/unanticipated use patterns).

