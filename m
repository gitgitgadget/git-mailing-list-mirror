Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB732047F
	for <e@80x24.org>; Wed, 26 Jul 2017 20:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbdGZUKL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 16:10:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65371 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751202AbdGZUKD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 16:10:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B60D090F5B;
        Wed, 26 Jul 2017 16:09:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gXIl20pwjsbOe7XzTjmcWjCY4eI=; b=MYhydd
        mpOccPxkNgvoqKVUHdYF9/RzQQZiyafh3wKqJroAPyrs2+iIKpTP9Dm60Qzgt5/T
        g3Ceu+qZFlNv2jGq7rURCNd9/4HiRaBiMnPP93q2pMVw8jVECmBmUZ7t5tXtdZlL
        FEVVgaskI68ZU1kE26y9ggId3DLgRtVYQRt10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rknty3UrpWiTGTP9KrvOhZJ09T00OLLn
        4dd7Db7ihUZ8TXOpHUNNXwbIOM1E4hnycEQA4RNXot3ZOVlxyc37CURoPIO2il8/
        R8q0nh9P4tlkiA3z/9TCjvDL4b52Fv7nLTAtSCV7S5nvQ4ZvfBfok0TUkL2eWYEz
        ICie+dz2ZjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEFA990F5A;
        Wed, 26 Jul 2017 16:09:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1893E90F58;
        Wed, 26 Jul 2017 16:09:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
        <20170725212110.GG13924@aiede.mtv.corp.google.com>
Date:   Wed, 26 Jul 2017 13:09:55 -0700
In-Reply-To: <20170725212110.GG13924@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 25 Jul 2017 14:21:10 -0700")
Message-ID: <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 654D1F9E-723E-11E7-91A8-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> For an initial guess: in the example
>
> 	git grep test -n
>
> ...
>  2. Focus on "argument" instead of "filename" so that the message
>     could still apply: something like
>
> 	fatal: option '-n' must come before non-option arguments

I think this one is the most sensible.  There may or may not be a
file called "test" in the working tree, and the user may or may not
meant to look for a pattern "test".  What is wrong in the sample
command line is that "test" is not a dashed option and yet it has a
dashed option "-n" after it, and your version clearly explains it.
