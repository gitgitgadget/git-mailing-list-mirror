Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F94320898
	for <e@80x24.org>; Thu, 20 Jul 2017 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935664AbdGTSYK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 14:24:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59217 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935408AbdGTSYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 14:24:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DE5C8B452;
        Thu, 20 Jul 2017 14:24:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iAtGl7Dvds0emT11S+uVWQb2ZP8=; b=Qzz3I4
        0uz3nsjYYd5OjGe0T/PXh+8DWkM2atDZIWC09Inu0WSQBkjNTOhfuWWhxsLbfFed
        PFiMkUF4aiEHDILIrbaz9DpC/KnU1otPPfNBPxmAKBVOYpyVfKieSKgwyL8ZrTyk
        Vc5IeDBDllGM6lOaXtY1hzVQ/091vipAizyUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uUcSGFboNz6xOImoxmG4flSWaAAckQrR
        qVgTGA9kANjfZjIyfKG1VEHHf0HxgmUfj5eT5xpntEKPTFFSg2v0Mb2pOIEJTNWM
        fNLQ7GKxR/67V1eEo8LCuhCmKeIcp1HYDyxp5+khYZDqDpGwZ1BcdthHaPpJAP7Y
        DFpbR+oqN2k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 864158B450;
        Thu, 20 Jul 2017 14:24:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E756E8B44F;
        Thu, 20 Jul 2017 14:24:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
        <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
        <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 20 Jul 2017 11:24:06 -0700
In-Reply-To: <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 20 Jul 2017 11:19:29 -0700")
Message-ID: <xmqqk233klvd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E6DC410-6D78-11E7-B787-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The use of "make pot" from the top-level is already described in
> po/README, so the only thing that we need is something like this
> change.  I'll follow up this message with a sample output from the
> updated process to ask others to sanity check the result (they are
> tiny) in a separate message.

Without the Makefile patch in the previous message, I ran "make pot"
and saved the resulting po/git.pot to git.pot-old.  And then after
"git reset --hard", I applied the Makefile patch and ran "make pot"
again, which gave me an updated po/git.pot file.  The difference is
shown below.

As expected, these look sensible to me.  All the hits from 

	git grep '_(.*PRItime'

are included in the difference.




--- git.pot-old	2017-07-20 11:17:29.608343390 -0700
+++ po/git.pot	2017-07-20 11:18:14.744342564 -0700
@@ -8,7 +8,7 @@
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2017-07-20 11:17-0700\n"
+"POT-Creation-Date: 2017-07-20 11:18-0700\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -1388,17 +1388,67 @@
 msgid "in the future"
 msgstr ""
 
-#: date.c:122 date.c:129 date.c:136 date.c:143 date.c:149 date.c:156
-#: date.c:167 date.c:175 date.c:180
-msgid "%"
-msgid_plural "%"
+#: date.c:122
+#, c-format
+msgid "%<PRIuMAX> second ago"
+msgid_plural "%<PRIuMAX> seconds ago"
+msgstr[0] ""
+msgstr[1] ""
+
+#: date.c:129
+#, c-format
+msgid "%<PRIuMAX> minute ago"
+msgid_plural "%<PRIuMAX> minutes ago"
+msgstr[0] ""
+msgstr[1] ""
+
+#: date.c:136
+#, c-format
+msgid "%<PRIuMAX> hour ago"
+msgid_plural "%<PRIuMAX> hours ago"
+msgstr[0] ""
+msgstr[1] ""
+
+#: date.c:143
+#, c-format
+msgid "%<PRIuMAX> day ago"
+msgid_plural "%<PRIuMAX> days ago"
+msgstr[0] ""
+msgstr[1] ""
+
+#: date.c:149
+#, c-format
+msgid "%<PRIuMAX> week ago"
+msgid_plural "%<PRIuMAX> weeks ago"
+msgstr[0] ""
+msgstr[1] ""
+
+#: date.c:156
+#, c-format
+msgid "%<PRIuMAX> month ago"
+msgid_plural "%<PRIuMAX> months ago"
+msgstr[0] ""
+msgstr[1] ""
+
+#: date.c:167
+#, c-format
+msgid "%<PRIuMAX> year"
+msgid_plural "%<PRIuMAX> years"
 msgstr[0] ""
 msgstr[1] ""
 
 #. TRANSLATORS: "%s" is "<n> years"
 #: date.c:170
-msgid "%s, %"
-msgid_plural "%s, %"
+#, c-format
+msgid "%s, %<PRIuMAX> month ago"
+msgid_plural "%s, %<PRIuMAX> months ago"
+msgstr[0] ""
+msgstr[1] ""
+
+#: date.c:175 date.c:180
+#, c-format
+msgid "%<PRIuMAX> year ago"
+msgid_plural "%<PRIuMAX> years ago"
 msgstr[0] ""
 msgstr[1] ""
 
