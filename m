Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDBD20A26
	for <e@80x24.org>; Sun, 17 Sep 2017 01:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdIQBkG (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 21:40:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60866 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751451AbdIQBkG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 21:40:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24315AC421;
        Sat, 16 Sep 2017 21:40:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KeYDQ5l0MNWKUzgjwCnqdf95CJI=; b=Ns07Hp
        Z4FNZZOxqkEZ0f3XbVRuFmwOj0FkhWcCR15oxxme0AV1uL0QDTYgbs4yEKNOIYg2
        C++obCYD01THxkOR6OWCQZpzycOwWZfQlWTjwjVoMAdgNavwfPTwPchqzjmi81O2
        L1Pdy5JELPvuPMPPmVvbugTdMp4Sen1JpUBlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z09Buoh2eQBYTL0vp5Q3ol7s7jIRBkeR
        DrtTlo+XR1Nh6PKCMm2MYvtDoJ2kLpyCZndZdUyQIm5GB8uqLN+C81rK5YwzuSLq
        FxKKuWigcbGa9ApLDpd/yWKhDMLWyjlubypmdAzx1vr3q0jCK4jFKXzcBSOlXXU0
        eWgRWg8Z9Uc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 152C9AC41F;
        Sat, 16 Sep 2017 21:40:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A6DFAC41D;
        Sat, 16 Sep 2017 21:40:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shikher Verma <root@shikherverma.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
References: <20170906093913.21485-1-root@shikherverma.com>
        <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
        <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
        <CAGZ79kZO_u21JeAsNq7p7X88i0wmP6kJcg=JbKp62Bxdm4d4Uw@mail.gmail.com>
        <20170916072106.yxpwmndzif3lr2dp@weakknees.security.iitk.ac.in>
Date:   Sun, 17 Sep 2017 10:40:01 +0900
In-Reply-To: <20170916072106.yxpwmndzif3lr2dp@weakknees.security.iitk.ac.in>
        (Shikher Verma's message of "Sat, 16 Sep 2017 12:51:06 +0530")
Message-ID: <xmqqa81uumq6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20CBA94C-9B49-11E7-A6ED-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shikher Verma <root@shikherverma.com> writes:

> This might be a good starting point for a sample hook if we choose to go
> that way. As Junio suggested.
>> This would not deal with concurrency as it re-uses the
>> same worktree, but illustrates what I had in mind
>> for the git history of that special ref.

That's Stefan; I wouldn't have suggested any approach that uses the
blob whose sole purpose is to serve as a temporary storage area to
pass the information to the hook as part of the permanent record.


