Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1129C1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 02:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfKMCFs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 21:05:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63962 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfKMCFr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 21:05:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A852298B26;
        Tue, 12 Nov 2019 21:05:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JUYoQWyyGzUzCt0wq49WfK/2kX4=; b=KbMBgG
        hQ/k2JVODjiZ8ATHQ4gE3jzuWKsfp9ZE6i92MfhjlcW8cwGJZb/6jAbZwufO98EI
        Zp/nDIlDb+3mTIcpXNBK49tvwHTxC1z5OupsPrcOcoLn3ZEsDA/pAK7XdxzViR7e
        H3v6bE03FBeGF/9FZW9yDmGGxVwf7SToyD8sY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hc+d8o06SrB0lwYaEi4HjUXV7EGS903Z
        18j+KY3h/QRmQ8+styIHVGJ57mJvF0Ix2YnyWONFrS05seDF4J/qQ2x3hXZ1ozQ1
        vysO5/RgdsuOIo8T7ol+Ly/xaZdgynakJI7og+z9JCtmeo9tt4nIH3dTxtfKVBfD
        azC4BCwC7sc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A07EB98B25;
        Tue, 12 Nov 2019 21:05:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD0E698B24;
        Tue, 12 Nov 2019 21:05:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        James Coglan <jcoglan@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3] t4215: use helper function to check output
References: <8e950ddfba3fa0f6d0551a153228548da6af6117.1573520653.git.liu.denton@gmail.com>
        <86af5739a4e5f5f38b2597a86d03d5501ad5468b.1573584933.git.liu.denton@gmail.com>
Date:   Wed, 13 Nov 2019 11:05:41 +0900
In-Reply-To: <86af5739a4e5f5f38b2597a86d03d5501ad5468b.1573584933.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 12 Nov 2019 10:56:22 -0800")
Message-ID: <xmqqeeyccyyy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1987F1F8-05BA-11EA-AB27-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> .... Is there any way to
> force git to make the diff show up the other way in both this diff and
> in the blame or is this the best that we can do?

"git blame -M" is your friend, I think.

	$ git blame -b -M HEAD^ t/t4215-log-skewed-merges.sh

would show what this patch did rather nicely.
