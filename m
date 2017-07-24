Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A8E203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756103AbdGXU5W (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:57:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60229 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756093AbdGXU5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:57:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6258935D1;
        Mon, 24 Jul 2017 16:57:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PMLGGI7J8TSFvCSciMgkY2Spb1M=; b=c+kPK8
        bvb6db2Gn2qkW0VN/+adlvADOvFNClwQ2PJ+TEXoYAZBbWq8k7I6gX4iqG2aYrKF
        Frf9xmBmorivtG14rFwzot6EkVYbrhO4hA2ssoSmYJUkAWHlXf+phHB4VS8RiBcO
        6JDjx68ZQvxw9eFc8scsleoVtAnRRJozlQIMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dK75oIKlLGtHfHFRaubnP7BH+VqlPknc
        Wb6gPj1ClCRVi23G2XVBTftiUt5drftF2WlI+22cU8ATx/uihBkqA3k9UyNjvdSW
        /q1sH8RzM9Ihk8kQ6mCOvuIJKtKj9pxfZOelvfryMmeKZAHUykPNX+UMd8++qxzF
        xmIGVGMxP1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDDAC935CF;
        Mon, 24 Jul 2017 16:57:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C8BA935CE;
        Mon, 24 Jul 2017 16:57:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
References: <20170724173601.19921-1-sbeller@google.com>
        <20170724180312.GE13924@aiede.mtv.corp.google.com>
        <CAGZ79kaYzHzSdDZuMpM6UFXLon0SME-nC=9_09PLhLEADfuscw@mail.gmail.com>
Date:   Mon, 24 Jul 2017 13:57:11 -0700
In-Reply-To: <CAGZ79kaYzHzSdDZuMpM6UFXLon0SME-nC=9_09PLhLEADfuscw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 24 Jul 2017 12:07:48 -0700")
Message-ID: <xmqqinihd048.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA4FD33A-70B2-11E7-9B0E-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  Are you saying
>> the current behavior of updating whatever branch HEAD is on (which,
>> don't get me wrong, is a wrong behavior that needs fixing) bypassed
>> the reflog?
>
> No, I am not saying that.
> I am saying that updating an unrelated branch (which is dragged into
> the affair just because HEAD points at it) is very subtle thing, as any
> commits on that branch can be considered safe (it is on a branch, right?)
> but the detached HEAD is the default unsafe mode we currently have.

Then it is not a data loss as you claimed in the proposed log
message, but is something else, no?
