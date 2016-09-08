Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523B71F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbcIHVbz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:31:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60482 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932294AbcIHVby (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:31:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F1683D334;
        Thu,  8 Sep 2016 17:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zy4IXEoeI2sT
        B0B4LdTowL++eoU=; b=RsvC4YM6n5H6rpTb6FeMT4MdeTKlydzw13ma9rhkcAB7
        XaIku/+7eB6pRAGSSG2qLrQk6KNHLoctzh243/uZDLcDH6dtnK1J8I3sZp/ePNk7
        cPNJuR3xxX/mWToVJ9RvNO+q35upW4Zp6H4Sto1qyuWSfAtWqQDoxK9228TQqH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Owh6XO
        Ck/9s/+0ZXnYtPctmpz5DUzkpzJz2yyyvRAHD0FNMm39Yyu/vntp9Cv1icqr6J6v
        YuLNa3utTSwn6Mqx3Thr5EQg+zmG4o3tOnxEJPTDoZl/6dWnJEUTRbbAV7LmqxG/
        lH3zazLBWDc9SxAtgNaI5/ddJzwL86+e3E5TE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 678CD3D333;
        Thu,  8 Sep 2016 17:31:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E54F03D31C;
        Thu,  8 Sep 2016 17:31:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Cc:     Jeff King <peff@peff.net>, Leho Kraav <leho@conversionready.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] versioncmp: pass full tagnames to swap_prereleases()
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
        <20160907151251.30978-1-szeder@ira.uka.de>
        <20160907151251.30978-5-szeder@ira.uka.de>
        <xmqq7fami8nj.fsf@gitster.mtv.corp.google.com>
        <20160908223727.Horde.jVOOJ278ssZ3qkyjkmyqZD-@webmail.informatik.kit.edu>
Date:   Thu, 08 Sep 2016 14:31:51 -0700
In-Reply-To: <20160908223727.Horde.jVOOJ278ssZ3qkyjkmyqZD-@webmail.informatik.kit.edu>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 08 Sep 2016 22:37:27
 +0200")
Message-ID: <xmqq4m5qf588.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8CDFC28-760B-11E6-AD5E-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> I'm not sure about the relevancy of this pararaph, or the relevancy of
> the original version for that matter.  I mean, there is a different
> character for sure, so it's really rather obvious that it can't
> possibly be the same suffix in both, isn't it?  So I don't think it
> adds much value, and don't mind deleting it in the reroll.

Concurred.  Let's lose this confusing statement.

Thanks.
