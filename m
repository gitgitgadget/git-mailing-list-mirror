Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3D5C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 23:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E597A20780
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 23:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="g5x/8WJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395069AbgJZXAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:00:22 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:52136 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395066AbgJZXAW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 19:00:22 -0400
Date:   Mon, 26 Oct 2020 23:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603753218;
        bh=GX0Xde33tAP63/R7boRcsYBK+opMtcxKrLZ/EEPbTq4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=g5x/8WJ+rG3nXYEGNJONpk05VYpnVcGP2i9ojv+xpi8lApUcP3lt/CdhO9D47XBe0
         q8MiID2Axyb1jAS7OkItGrGDLy6TJv19LJkR7+C52YokgpI+jXAWZv4ocSu+UoDQaq
         UmEnV6azECoPlrGon6J9uPtwvDKmi6O6HvX2dsZ0=
To:     Jonathan Nieder <jrnieder@gmail.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test script
Message-ID: <AwF-WVCPGK9qyy3lWQ-aYXuvw7HTPjjGuvT4rbPjgoWZE0czToIU-aACj2oyRnkOevGWLQbDgtndt9dkMSGF-SFkNanPgao9yLuVYU1VURI=@protonmail.com>
In-Reply-To: <20201026220228.GD2645313@google.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com> <20201026205028.GC2645313@google.com> <xmqqwnzcd6jf.fsf@gitster.c.googlers.com> <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com> <20201026220228.GD2645313@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Monday, October 26, 2020 4:02 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

> (administrivia: the convention on this mailing list is not to top-post.
> When your mailer puts the cursor at the top of the reply, that's a
> signal to go through and delete the parts you don't want to reply to,
> before putting your reply below the bit you do want to reply to)
>
Understood, thank you.

> Thanks, Joey. I think we'd prefer a v3 since that gives you a place
> to put the commit message for the combined patch.
>
> Or if you prefer for Junio to take care of the squashing, an
> alternative is to write the proposed commit message here.

I've locally incorporated the changes and remain open to either option. The=
 proposed amended commit message would be;
Modernize the test by replacing `test -e` instances with
`test_path_is_file` helper functions, and `! test -e` with
`test_path_is_missing`, for better readability and diagnostic messages.
For instances when `${if_local_config}` is either '' or '! ' then
`test_path_is_file` will diagnose the directory and print a message if
and only if the result `is false` goes away.

Signed-off-by: Joey Salazar <jgsal@protonmail.com>

Does this capture the idea correctly?

> Thanks for your patient work,
> Jonathan
Thank you for all your input and guidance.

