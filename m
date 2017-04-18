Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F0C1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 00:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755262AbdDRAjB (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 20:39:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50336 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755217AbdDRAjA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 20:39:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD8787404B;
        Mon, 17 Apr 2017 20:38:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dIQrrV2MXCdsD8Y4DiwKIQ7nzbE=; b=R17HbP
        2K+d26mQ7xZVZLnOkaxdyvSRVZxkVFhyzukxpAIPi6rjyNNb46q04H5C211UStEb
        RAod88LLeI2d/Fi/BN/cfGFom1VKszMYN0Gfwd2DBbXhI/1vU7WDRd8Crx5PDO06
        5LwTEYR3Q2Djer8VGPJHrQ5dOXmXXHXj076FE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sN04t8S38PFqTGIKr1NkmPCMymQKbQEA
        QLd6EYSOQZ0a3EP0VfDwbPg8BHj9Cli9/oxj39nFzxN1dWwzIEUxfKuHiLvk2yTA
        kVeBlNjRef7ZcjJAfrs/9c2W1Rhz9opbX/livRnzjfHfCB9n4mQTsCmhcoobIbYl
        S3jXNSyngko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D60787404A;
        Mon, 17 Apr 2017 20:38:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3400374049;
        Mon, 17 Apr 2017 20:38:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fred .Flintstone" <eldmannen@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: --format=json
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
        <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
        <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com>
        <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
        <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
        <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com>
Date:   Mon, 17 Apr 2017 17:38:57 -0700
In-Reply-To: <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com>
        (Fred's message of "Mon, 17 Apr 2017 15:09:20 +0200")
Message-ID: <xmqq60i2im72.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68D7CD02-23CF-11E7-87CE-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fred .Flintstone" <eldmannen@gmail.com> writes:

> So I would either have to do:
> git rev-list --all
> Then iterate over each line and do git-cat-file commit <commit-id>.
>
> Or do:
> git rev-list --all | git cat-file --batch
>
> If I do it in a batch, then it will be tricky to reliably parse since
> I don't know when the message body ends and when the next commit
> starts.
>
> JSON output would have been very handy.

I am somewhat puzzled.  I thought that you were trying to come up
with a way to produce JSON output and people are trying to help you
by pointing out tools that you can use for that.
