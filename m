Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4404C20133
	for <e@80x24.org>; Tue,  7 Mar 2017 00:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754294AbdCGAKR (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 19:10:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58310 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753672AbdCGAKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 19:10:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0DC172298;
        Mon,  6 Mar 2017 19:08:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NT7Ztg3SeuGRsL9ycL2IEtfzaJ8=; b=mZ1+oA
        6PDFBNJWzRUPLBvzMrKAJBfrWuy+aRX1K0SW1DIkKdJxI2oE/LkXjAO4OSuCPmg8
        BWWNBt7t7DtsVbr/X4g37j89c2AG2PJS1Z4C9PjGcZQzXe3mmAhOygVWi4HIpBkM
        oER756ZlxBBvURo127nPcA6NV474sCTwNDK4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EgE3p1BQyEPtGZMvhu9TqvDHAluaxhnI
        DqwBxaGyjKKJ5cFU8Hf7Y7tbNXOs8od1hgEhq6Oa0yloCpBABUbXxx9hlY0aIS0F
        LXgMz4o8/LeKeR0qyPh+aKrrd39n2uc9dTyyMwQ3cV4LWzl/luBen9egreVb5G9D
        vKlsHmPntC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B993872297;
        Mon,  6 Mar 2017 19:08:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E5B772296;
        Mon,  6 Mar 2017 19:08:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Request for Documentation] Differentiate signed (commits/tags/pushes)
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
        <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com>
        <CAGZ79kZU+-5D0bHSA1duRLnvjb+P67AzGhESS6J1z5qtO8SXsQ@mail.gmail.com>
Date:   Mon, 06 Mar 2017 16:08:46 -0800
In-Reply-To: <CAGZ79kZU+-5D0bHSA1duRLnvjb+P67AzGhESS6J1z5qtO8SXsQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 6 Mar 2017 14:52:37 -0800")
Message-ID: <xmqq4lz6ymlt.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C09AF6E-02CA-11E7-9007-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> "tag -s" also has the benefit of being retroactive.  You can create
>> commit, think about it for a week and then later tag it.  And ask
>> others to also tag the same one.  You cannot do so with "commit -s".
>
> ok, so there is *no* advantage of signing a commit over tags?

Did I say anything that remotely resembles that?  Puzzled.

If the reason you want to have GPG signature on a commit is not
because you want to mark some meaningful place in the history, but
you are signing each and every ones out of some random reason, there
is no reason why you would want "tag -s" them, so you can see it as
an advantage of "commit -s" over "tag -s", because to such a
project, all commits that are not tagged look the same and there is
no "landmark" value to use "tag -s" for each and every one of them.
