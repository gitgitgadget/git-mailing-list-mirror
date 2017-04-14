Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61801FA14
	for <e@80x24.org>; Fri, 14 Apr 2017 10:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdDNKou (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 06:44:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63381 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751278AbdDNKot (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 06:44:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE94E6CA95;
        Fri, 14 Apr 2017 06:44:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jaGb2V1JKH77LMSkRMeoSD7r4nQ=; b=miL0P+
        +WqdICv/AzUUvhdvRtGpfEtA3PMYPErknFqtmYHCK/X0q/+GdV6CIo94ukaXC2sY
        TZYwncgxO3fv0dC9iXBPTAZJgH0HoQFyYkWWObtCiZQrW0WFURqahjFcaSqtnAZr
        tIH8+RjohpVJQPjDx5pg0T5p0YdhdNCpJnZSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F/e2W9g2saFp8cfzjLetr9HIJNYSjhAP
        LT6MXISElerK2oxZRjeSE3mv7U5+9vzofLljYUsgygop8z7o16VF4vEfr45vhA+T
        sIdZBb8akPL2dCiedBGt+gbIsUj7N76jzb0mwYttdCGv7CJk9mvdJEi1Kf94Lnin
        MaUgvCxN10A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E654A6CA94;
        Fri, 14 Apr 2017 06:44:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4832E6CA93;
        Fri, 14 Apr 2017 06:44:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v7 19/28] files-backend: replace submodule_allowed check in files_downcast()
References: <20170318020337.22767-1-pclouds@gmail.com>
        <20170326024241.31984-1-pclouds@gmail.com>
        <20170326024241.31984-20-pclouds@gmail.com>
        <4e4fd98d-055d-6e2b-845d-51d3f1c2856f@alum.mit.edu>
        <CACsJy8ByRdcXUS57pqSH4Gmr6FLSfK1yNnq7u5wVzh=7hj0vBA@mail.gmail.com>
Date:   Fri, 14 Apr 2017 03:44:46 -0700
In-Reply-To: <CACsJy8ByRdcXUS57pqSH4Gmr6FLSfK1yNnq7u5wVzh=7hj0vBA@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 7 Apr 2017 19:41:17 +0700")
Message-ID: <xmqq8tn3nu8x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60F8B574-20FF-11E7-951C-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I'll mark this mail and do a follow-up patch once this topic graduates
> to master. It's less review burden and mail traffic.

I actually do not mind a single replacement patch.
