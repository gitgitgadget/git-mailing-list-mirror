Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C6D202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 05:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbdKUFtg (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 00:49:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52871 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751284AbdKUFtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 00:49:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95A03BE47A;
        Tue, 21 Nov 2017 00:49:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c1h0f/HjcF1fsodiV80PM15/qzA=; b=veqklr
        fMUxKxTlixS6yoVWPzvbJf/IZ1Okxvk5I0YUmIzDuzhimTLdCjdJKBjaOLYHw4IB
        eSR8Yk5k8jmM5eaAB8UKo377+wqXotCRBtsfr0hUqBmbMH62JIB/pov1qL/qejZQ
        B2hqXAstKy/kAuXmuu+AgWZJXWfAY3lsYLX1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kvzEmZGHnsPq3UB2DXBpGz9ltiuV7JHh
        bgOxKpkSXirW0mDPi0MKz0Ixv3+VrJdXn3MGmGQgiquDwCxqPXqjnOlyLhoapfdq
        hUYcGScCdMOzr0KrGErQjXbxT59qatp9NaZv9CQWJTa+zRUTD5RIN6qRt2C44WiS
        41h/+B+aaZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E7D4BE479;
        Tue, 21 Nov 2017 00:49:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEF3FBE476;
        Tue, 21 Nov 2017 00:49:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Nikishkin <lockywolf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: core.safecrlf warning is confusing[improvement suggestion?]
References: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
Date:   Tue, 21 Nov 2017 14:49:32 +0900
In-Reply-To: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
        (Vladimir Nikishkin's message of "Tue, 21 Nov 2017 13:18:30 +0800")
Message-ID: <xmqqk1yki3kj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C02FA36C-CE7F-11E7-B806-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vladimir Nikishkin <lockywolf@gmail.com> writes:

> I want to have LF line endings in the repository and CRLF endings in
> the working copy. (Because I use windows-exclusive tools to develop.)
>
> But for start I have my code with LF endings, because I got it from a
> fellow developer, who develops on UNIX, with LF line endings.

I somehow suspect that perhaps the way you "got it" from the other
developer is wrong in the first place.  Did you make a zip archive
or something and extracted it?  That's a wrong way to do a hand-off.

If you "git clone" to have your own copy from the other developer,
then your working tree files will follow what your local convention
is.  Also you do not have to worry about malicious commands left
inside .git/config when you made a bit-for-bit copy of the
repository and the working tree.

