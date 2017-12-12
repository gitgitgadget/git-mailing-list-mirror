Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2131F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbdLLTPF (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:15:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55767 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751688AbdLLTPE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:15:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DB31C79AA;
        Tue, 12 Dec 2017 14:15:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yj0lw9Ot7fxENVcutkrcvXmDXrQ=; b=KNM9Vj
        zyWCcGXlBha+zfhDFXP5KeSNBiUetcrw/IaqEhck+Gf9NhyGbg9Bj5Kc96jJGU3O
        EkpAvGTdZIp0jTlaG2MI+SV48hsJRLeDdInd6qRF++HkGFyME6HMFC40C4Pp6fx/
        ZCOW1rHDSQl2BduQ/ylOvXy8hV34zHbCp4b/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qSc1oxs4isQ1ZqjHPjCJFu/H9eKULzfx
        O6c++zGl1bgccC98siVnE3QY+mX+QaDoIGog8ufQV9NXzLG7Bj9/No+K0sbRZ6EE
        1u6RpqNY7JLuI62EkrrxV623M2co7TRQLjXOV1qHjlZ/XopkRNofqPLI4ROwam4G
        lzUwkENdIEU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C2BCC79A8;
        Tue, 12 Dec 2017 14:15:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 388DBC79A5;
        Tue, 12 Dec 2017 14:15:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
References: <20171210212202.28231-4-t.gummerer@gmail.com>
        <20171211210948.6867-1-szeder.dev@gmail.com>
        <20171211214255.GA24597@hank>
        <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com>
Date:   Tue, 12 Dec 2017 11:15:00 -0800
In-Reply-To: <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com> (Lars
        Schneider's message of "Tue, 12 Dec 2017 16:54:04 +0100")
Message-ID: <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0DD3886-DF70-11E7-94A4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> You're right, it's my first time using travis CI and I got confused
>> about how the .travis.yml works, thanks for catching that.  Will
>> re-phrase the commit message.
>
> Szeder is spot on. If you fix up the message, then this patch looks
> perfect! Pragmatic (= very good!) idea to combine GITTEXT_POISON with 
> GIT_TEST_SPLIT_INDEX :-)

I am failing to guess the real intent of the smiley here.

If split-index code is so easy to break, I do not think it is a good
idea to combine it into the poison build.  In fact, the poison test
is useless on a codebase where other/real breakages are expected to
exist, because it is about seeing messages meant for non-humans are
not passed to the _() mechanism by sloppy coding, and the way it
does so is to corrupt all the messages that come through the _()
mechanism.  If we do not even produce a message when a correct code
_should_ produce one, poison test would catch nothing useful.

I wonder if it makes more sense to update ci/run-tests.sh so that
its final step is run twice with different settings, like so?

 ci/run-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index f0c743de94..15a5f5a6cc 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -8,3 +8,4 @@
 mkdir -p $HOME/travis-cache
 ln -s $HOME/travis-cache/.prove t/.prove
 make --quiet test
+GIT_TEST_SPLIT_INDEX=LetsTryIt make --quiet test
