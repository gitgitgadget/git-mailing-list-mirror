Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8D52089D
	for <e@80x24.org>; Sat, 29 Jul 2017 03:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbdG2DxJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 23:53:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50231 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753112AbdG2DxI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 23:53:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C210E9A031;
        Fri, 28 Jul 2017 23:53:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BMABSNC1Ri9LE6FuUz9/xbAghfg=; b=h/nxgA
        WxWlXUwC3WYxjF4HARh4jJjK2rVsIVjiTFSr+StFoKhUWBDqf7CKXRN9arxINywK
        9HjYEfbmD9601GLcWhRMR8tXibDJHbT6hkNcPn0sgWAg88Gc0ZHd6KLHAhMAWcTc
        x6LoGjGwWFxyJn6/rmX3VpGv4dmCnZJA+5gYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rD7D5xgcQKMN9b1oe6XtOT/ZlQ1DJkQb
        F40B5AWgnoZy7zMghvb3Ezi5AgCFRMM/D9EKXXAeZrZ+pQZNJWwkVdTGtoo5MQRO
        cHgNk1NLDG4JGYN16XTjwKqsp2OhsDxZIsMz1hKGH5zNSpvP6iIhDQwak79bdO0b
        RGEbS9XPap4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB3509A030;
        Fri, 28 Jul 2017 23:53:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35C379A02F;
        Fri, 28 Jul 2017 23:53:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
        <20170725212110.GG13924@aiede.mtv.corp.google.com>
        <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
        <1501296270.2112.2.camel@gmail.com>
Date:   Fri, 28 Jul 2017 20:53:05 -0700
In-Reply-To: <1501296270.2112.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 29 Jul 2017 08:14:30 +0530")
Message-ID: <xmqqefszlx0e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DBB0572-7411-11E7-977B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Though the message seems to be most fitting one, I'm a little reluctant
> to use it as it "might" create a wrong picture on the minds of the user
> making them think this would be the case in other cases too, which we
> know is not true. For example,
>
>
>     git log -p --full-diff master --stat
>
>     git commit -v Makefile --amend

These are accepted not by design but by accident.  

I do not think we even document that you are allowed to do these in
"log" and "commit" manual pages, and we should discourage them (I do
not even mind eventually removing these with the usual deprecation
dance, but I do not think it is worth the noise).

