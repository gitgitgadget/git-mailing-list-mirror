Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88D32023D
	for <e@80x24.org>; Wed,  1 Mar 2017 18:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbdCASkC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 13:40:02 -0500
Received: from mx1.riseup.net ([198.252.153.129]:39594 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbdCASkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 13:40:01 -0500
Received: from cotinga.riseup.net (unknown [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id E2A7C1A197D;
        Wed,  1 Mar 2017 18:28:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adrelanos)
        with ESMTPSA id 895A4403C4
Subject: Re: gpg verify git sub modules useful?
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <a9da4416-6437-a491-f461-c5e61d805b2d@riseup.net>
 <xmqqmvd6kykc.fsf@gitster.mtv.corp.google.com>
Cc:     Whonix-devel <whonix-devel@whonix.org>
From:   Patrick Schleizer <patrick-mailinglists@whonix.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <8cdd9f2d-415c-1b60-0017-bf973e8cf914@riseup.net>
Date:   Wed, 01 Mar 2017 18:28:00 +0000
MIME-Version: 1.0
In-Reply-To: <xmqqmvd6kykc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good questions, thank you for trying to figure out what I am asking. :)

Junio C Hamano:
> Patrick Schleizer <patrick-mailinglists@whonix.org> writes:
> 
>> When using git submodules, is there value in iterating about the git
>> submodules running "git verfiy-commit HEAD" or would that be already
>> covered by the git submodule verification?
> 
> That depends on what you are referring to with the "git submodule
> verification"

cd submodule
if ! git verfiy-commit HEAD ; then
   error
fi

> and more importantly what threat you are guarding
> against. 

All main (non-submodule) (merge) commits and submodule (merge) commits
are signed by me.

1) git --recursive clone main (non-submodule) git repository
2) cd git main repository
3) git verify-commit HEAD or git verify-tag tag-name
4) git submodule update

What if the main (non-submodule) git repository gpg signature was okay
but then after git fetched the submodules these compromised (MITM'ed) ones?

Does the having gpg verified the root (main git repository) ensure that
submodule commits are also quasi verified?

> "git -C <submodule-dir> verify-commit HEAD" may make sure
> that the contents of that commit object is GPG signed by whoever you
> trust--is that what you want to make sure?

> Or do you want all
> commits in the submodule history to be similarly signed because the
> tree of the superproject can switch to some other commit there?

I guess so.

