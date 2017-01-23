Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742F820A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdAWSgr (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:36:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751769AbdAWSgp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:36:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A685C620A8;
        Mon, 23 Jan 2017 13:36:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UUX5OsqI84TSF6j4+/V+d+0ks6g=; b=cK89iH
        HwenD+1qNJPKyqUUpiJW0qqYRvFVUAYBlAu1srPt1TgNPMtT7/pssf6o/ymv7BbN
        b9dLXOuy4pT524vXpXqc8pYxZkn6zP2otGFHrCBX0QGYBsTW1dt4daqEXS7s1H17
        u7+yVF4kxsVeyh29YC6W3AUXXqu7E2nYiU0Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZxKs02bO6wtuNBqd6alE+pdeLyb6pWyz
        1i/70X366gieC/qM/a9B6PSwnYt6L9ABy3YiksxzTZ2OppDHQNnVxhhdq0COrKDb
        6rtWPT6lplP6ehQjDO+Aed7l2k4WFysHS3fLtTm8rpAjDbIKLB+MJFxjfJplr/rq
        72aVe6Hr2rY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DAAB620A4;
        Mon, 23 Jan 2017 13:36:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C5256209E;
        Mon, 23 Jan 2017 13:36:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame: add option to print tips (--tips)
References: <20170122212855.25924-1-eantoranz@gmail.com>
        <CAOc6etaQ-fDWn38YzXkGOC0fSan1vrxjVDUXS924nBXWTTrhNQ@mail.gmail.com>
        <xmqq1svuvh0y.fsf@gitster.mtv.corp.google.com>
        <CAOc6etY5odte=TKyWX3Wf1BVaNTfDeA-xsGOKiyuH88HZgqFDQ@mail.gmail.com>
        <xmqqlgu2u0qx.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPPx2vDJVf=uk0iUJ2sh9DxWwp2Lp1k-APz9n=7NYMN5uQ@mail.gmail.com>
Date:   Mon, 23 Jan 2017 10:36:30 -0800
In-Reply-To: <CAFZEwPPx2vDJVf=uk0iUJ2sh9DxWwp2Lp1k-APz9n=7NYMN5uQ@mail.gmail.com>
        (Pranit Bauva's message of "Mon, 23 Jan 2017 22:03:45 +0530")
Message-ID: <xmqqr33tsjwx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD0473E6-E19A-11E6-83E3-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> We can probably make it useful with some extended efforts. I use
> git-blame and I sometimes find that I don't need things like the name
> of the author, time, timezone and not even the file name and I have to
> use a bigger terminal. If we could somehow remove those fields then
> maybe this would be a useful feature.

I admit that I didn't recall the option until somebody else told me,
but I think "blame -s" or something like that for that purpose ;-)

