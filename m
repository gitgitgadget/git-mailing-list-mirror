Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BDC001E0
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 00:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjG1Anh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 20:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjG1Ang (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 20:43:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD9435A0
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 17:43:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 529B223FEC;
        Thu, 27 Jul 2023 20:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sXlpap4oW2cI
        zPuBQeBo7gVlD3cKmPujkmqnL4FUkeA=; b=E2NY5mbvl18yuttuYbA/qMbyypOx
        JGpNUxvlMWoomnFju2jZHOMihk0ldrkbBkRd5HdcBbma7r0O2cKkL9R3qun76QFw
        yv34b2FyX7Yv8IXPiUK+XKQTLZBtRkTS92rIDBKzS83yYQb+27qFs18N8Ausk0UB
        1/ocAKiORzqfEKo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49C8023FEB;
        Thu, 27 Jul 2023 20:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D3F1A23FE9;
        Thu, 27 Jul 2023 20:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4] MyFirstContribution: refrain from self-iterating too much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g>
        <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
        <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com>
        <xmqq7cqkanm9.fsf@gitster.g>
Date:   Thu, 27 Jul 2023 17:43:17 -0700
In-Reply-To: <xmqq7cqkanm9.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        27 Jul 2023 17:25:18 -0700")
Message-ID: <xmqqmszg987u.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BEFFEF78-2CDF-11EE-BD90-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finding mistakes in and improving your own patches is a good idea,
but doing so too quickly is being inconsiderate to reviewers who
have just seen the initial iteration and taking their time to review
it.  Encourage new developers to perform such a self review before
they send out their patches, not after.  After sending a patch that
they immediately found mistakes in, they are welcome to comment on
them, mentioning what and how they plan to improve them in an
updated version, before sending out their updates.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

The inter/range-diff with my v3 was totally useless, but here is to
show three minor edits I made to Linus's version I am responding to.

 * Simplify parenthesized "because it may be the case that".

 * As if you were "a" reviewer, as we do not designate "the
   reviewer(s)" to a patch.  Anybody can (volunteer to) be a
   reviewer for a patch, and you can be, too.

 * Stress that a single polished patch that comes later (because it
   took time to polish) is vastly preferred than flurry of "oops
   this is better" updates.

    --- /var/tmp/b	2023-07-27 17:38:56.928040307 -0700
    +++ /var/tmp/a	2023-07-27 17:38:36.100067020 -0700
    @@ -1,7 +1,7 @@
     Please give reviewers enough time to process your initial patch befo=
re
     sending an updated version. That is, resist the temptation to send a=
 new
    -version immediately (because it may be the case that others may have
    -already started reviewing your initial version).
    +version immediately, because others may have already started reviewi=
ng
    +your initial version.
    =20
     While waiting for review comments, you may find mistakes in your ini=
tial
     patch, or perhaps realize a different and better way to achieve the =
goal
    @@ -9,7 +9,7 @@
     reviewers as follows:
    =20
      - If the mistakes you found are minor, send a reply to your patch a=
s if
    -   you were the reviewer and mention that you will fix them in an
    +   you were a reviewer and mention that you will fix them in an
        updated version.
    =20
      - On the other hand, if you think you want to change the course so
    @@ -26,5 +26,5 @@
     new version of your patch. Rather than seeing the initial version ri=
ght
     now (followed by several "oops, I like this version better than the
     previous one" patches over 2 days), reviewers would strongly prefer =
if a
    -single polished version came instead, and that version with fewer
    -mistakes were the only one they would need to review.
    +single polished version came 2 days later instead, and that version =
with
    +fewer mistakes were the only one they would need to review.

Thanks.


 Documentation/MyFirstContribution.txt | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirs=
tContribution.txt
index ccfd0cb5f3..dd46f751b7 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1256,6 +1256,38 @@ index 88f126184c..38da593a60 100644
 [[now-what]]
 =3D=3D My Patch Got Emailed - Now What?
=20
+Please give reviewers enough time to process your initial patch before
+sending an updated version. That is, resist the temptation to send a new
+version immediately, because others may have already started reviewing
+your initial version.
+
+While waiting for review comments, you may find mistakes in your initial
+patch, or perhaps realize a different and better way to achieve the goal
+of the patch. In this case you may communicate your findings to other
+reviewers as follows:
+
+ - If the mistakes you found are minor, send a reply to your patch as if
+   you were a reviewer and mention that you will fix them in an
+   updated version.
+
+ - On the other hand, if you think you want to change the course so
+   drastically that reviews on the initial patch would be a waste of
+   time (for everyone involved), retract the patch immediately with
+   a reply like "I am working on a much better approach, so please
+   ignore this patch and wait for the updated version."
+
+Now, the above is a good practice if you sent your initial patch
+prematurely without polish.  But a better approach of course is to avoid
+sending your patch prematurely in the first place.
+
+Please be considerate of the time needed by reviewers to examine each
+new version of your patch. Rather than seeing the initial version right
+now (followed by several "oops, I like this version better than the
+previous one" patches over 2 days), reviewers would strongly prefer if a
+single polished version came 2 days later instead, and that version with
+fewer mistakes were the only one they would need to review.
+
+
 [[reviewing]]
 =3D=3D=3D Responding to Reviews
=20
--=20
2.41.0-470-gbfce02c22f

