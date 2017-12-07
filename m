Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766B920954
	for <e@80x24.org>; Thu,  7 Dec 2017 20:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbdLGU2q (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:28:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57611 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750779AbdLGU2p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:28:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFB91C3BA2;
        Thu,  7 Dec 2017 15:28:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rkdea/Yh+qR7Qso+1fejjsKnKdY=; b=MtEJne
        +wmSUCo2Fa/BOXwHA+HnmzEEwK11z+UaaJtKEjOyXGwTfMURMVqwqJ4T51Xmy375
        cTqg82hyTVCf4x8CAXCwcCYjnd43KVLu5h3j1/fy/dZlOAsvBwDIYfEees+BYefN
        9VYY3ymYUNFAosw83vIDvSZFYndXkoItBdpCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DrqjDQb3erHdpHlvodSII93Ll+YL/846
        0ETeH/g6cyWOLyHUfdEsY7xFLkl0MBrvjSCSIbEF/jGLJYosqKV+Ni26ETvioPlf
        1PGhyyCrjMIw3SqVIvoYk4G8G7vy8DLagYB1gT1I0N9IP971OMKEY5KuezE0ii86
        5pWxE+Z2jfY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5C84C3B9F;
        Thu,  7 Dec 2017 15:28:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1916DC3B96;
        Thu,  7 Dec 2017 15:28:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     KES <kes-kes@yandex.ru>, git <git@vger.kernel.org>
Subject: Re: Feature request: Reduce amount of diff in patch
References: <372261511885370@web21o.yandex.ru>
        <CAGZ79kZt7hysp9Yzj8==nz9FAu3V4KduG9kH2KxhdEK5CTBiqA@mail.gmail.com>
Date:   Thu, 07 Dec 2017 12:28:42 -0800
In-Reply-To: <CAGZ79kZt7hysp9Yzj8==nz9FAu3V4KduG9kH2KxhdEK5CTBiqA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 7 Dec 2017 12:13:47 -0800")
Message-ID: <xmqqtvx2cmf9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3865F772-DB8D-11E7-A04B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Nov 28, 2017 at 8:09 AM, KES <kes-kes@yandex.ru> wrote:
> ...
>> May you please fix the git to generate minimized patches?
>
> You can use a different diff algorithm.
> ...
> Soon we'll have another diff algorithm "anchor" that tries to
> keep a given line out of the +/- but rather move other lines around
> the line to give equal results.

While all of the above is correct, my understanding is that none of
them would produce a patch that KES wants to see.

And we shouldn't ;-)  The two changes KES shows in the message are
not equivalent.
