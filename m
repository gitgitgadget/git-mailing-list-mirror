Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF59BC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840AC2082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="da5qPjTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBDVKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:10:40 -0500
Received: from mout.web.de ([212.227.15.4]:52493 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBDVKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580850635;
        bh=Hc7KZRUncuvWsvwImxDrhsIqRUABXMGJpevPAUtjcQo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=da5qPjTzBqwniXie09DIk58h4onPwWkcX0QbIbcjiUBhANzUe0Y+XjN4lebO/mTx6
         aUsrOZSkIKMO55vjAOHnM4MpXq10PKOU+heuOVDYZ4cE+uU9UvW/5Yh9aI1F/2O+N1
         WJSP8zSz5sxJEDaNkZSuEa2UIlROlwwOY9R0Gt/4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lb289-1jMthT3OxN-00kgqx; Tue, 04
 Feb 2020 22:10:34 +0100
Subject: Re: bug? illegal text in commit log
To:     "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200204010524-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
Date:   Tue, 4 Feb 2020 22:10:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200204010524-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6nzTHFh3Jf7Bz3KjHg9MUGfAz5EmN5AgAaMnpqN+6ofpCbELnlW
 9OIWggIi8yWMcqrAOXZJ0UZzWqT/O4IX99iNpGKe8WOoAJiXJA9BagVXGg5dGk4/LciK712
 BEO0a8SCzPJFv5809iJpQ4dcKuq21rfdii0q7o730hruIXb7JMGLRfugyyS/t2EcBPN+drp
 arQU7JRpcK0M2puleYEVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G/NCa0TUlDI=:BHNU/vRJyCowZQd4z0UC+H
 wWNqk3gFHZru74400+oH1kcn3pSqfLmjrI8P8L4qnkrJEvNmPlOj30BHvzDpAEe/LnP6ac8CY
 D8lvr91wGMG7lEER2xmPpeifVPjIGpRAa9JZAT3KyP9bjRlUsRwzSsZvU4uJGSBmKMJ/GJIt0
 gwOW4DzOvT5S9YRHSHTj6LCbc2emFsYiGC5DB5qMRqWZbWiXDq6+4TWZtm8o1jukO62dH5M7f
 51DeJyVrJHexdn/JaIPGi9IBuIJn4Db64x/xzVOXy7S0bIEtHAT5QLKmrRIGh8FeeEJv3vKxt
 SYP3aaL/Bs+wU5wWvoi4qUGbfMt9uE8lJvPXhUvQihhn8rZVtG3GGCL0lIp3k9dUKyNH2zgl8
 YWywYKVFKkoch5aFoyJzKfuLA0KvSs/Y73EzMS2pE7TZ/ix45F+p+xEyyOMIfFg2pbRzR3H+7
 HajDtFGazh960vbf+hGgIL/s/f1xcyFAhiy8Y7y7LckQ5iCAVv2C37q/2dryUS6kPBFL7W/I6
 LMOTOsw4C1VwfrExv+fcglJ0dv/TWO3eH8QfaO/u3cu399gMgvWTvN1uUwRYYsZ/6Qr12YT9b
 wKVdnFd+gF/7OS9UZw8xRp+cjVbiQ8of8hskXSoE6NV+WKcNzrg/NEbxxMzOnG1PhTpj5YTSO
 KbUkFyEUO4sApKrQjAf7ajy9BnaZIJtPH4B+oEU+jdV2Ncm4qV7r2KvtPOeFPvBOerlW/NUWV
 ZsPzB7pK8yJm1tKvF3xKIqlIt7r4U3wZgk7xQdXPttbehG4bzV1TGWIhsqkFREYOLD/VMLNPi
 3i8LbYAJSkTkTX1hg/ZyBTllpJDFYQpGUkFBwegw10Hdo5APReJ/2dTcYqn9AhE+ZiGR1M67G
 BsjkKYQsmNoGNX3CS7dmXS8o54byeyBwkdQzupXIk3q8eJHJ9lSeNMrs9nldfrSP5EfMdlvx7
 L4A5ocl/kFbLAq+DyM+mCa9AbCb18BB4rV/TotbRs6a5diZjOty6BFDNPM4SdPwPhaj/JdonP
 o+9PfjmUHSVnx1ZLqvhAJygXgGUK3ZItanPull1h2wASvPfSywPDSqygE6koK16DktPPjL3ie
 nhT/CnleBfrECcbvMVIQHY6aJNKpykFsZHrVt0KQazurGj8KHV9IwP+qHHWFZWh2bCR25OU6h
 YFwS7Qdtk1+cwPhE1ulxtafdLgnOpRxzi/KKKoSd++IwpfiD7d8F+UfRHTZE/KlfhczFvi2pE
 Ae/o4oVjvLTJ2A/jf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.02.20 um 07:14 schrieb Michael S. Tsirkin:
> It seems that it's not too hard to make commits such that
> the standard way of git format-patch -> email -> git am
> fails.

> A work around is "don't do it" - avoid putting anything that looks like
> a unified diff in the commit log.
>
> However:
> - Users don't know what other restrictions exist
> - User sending the patch has no way to detect failure,
>   it's only visible to user receiving the patch

Putting a diff in a commit message can be useful, and forbidding it is
hard to justify.

> Ideas:
> - validate commit log and warn users?

That's only better than the status quo insofar it turns the issue from
a hidden pitfall into an open one.

> - find a way to escape text in git format-patch, and unescape in git am?

Like a Lines: header specifying the number of lines in the commit message?

Ren=C3=A9
