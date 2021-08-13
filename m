Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B4FC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B7C6109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbhHMGYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 02:24:07 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:54449 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbhHMGYH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 02:24:07 -0400
Date:   Fri, 13 Aug 2021 06:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628835818;
        bh=tNh0+cKWePIwRasqg8IqLM8OehsY+sLbKK3546Rspkw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=V1wzLOSo/eRVRGhoxrX4xz5n4jy1pKxPvAun7ojLzj8bMkWiLZq9j9pXrM8lMoyGf
         9i6qlR8X9wLC8HBlhpb+050f3r36rAsLsV/2dtilqlzrhMoH7MjKScjKkuV4/MHQT9
         o9NpkwUjTj3Tlj3+fzNWbAGUtKJDWrxYJhsswobtgKvMMEOb/7SrbyhgUgnITPRtsV
         gC44NvIKzwQyNbLqXjyiY6GDzahAFsOpD1fevq3Sb9ATK91Vcd12QGTrfAsUzSl+7V
         eBLUsApR4eUenBj9AdUsCqjbKzNI9AMdV81TkYRahBD5rHFo2wVuV+3tW8lwbAX83S
         GdfBQAbr4Qo0w==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     kim@eagain.st, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, sunshine@sunshineco.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH v6 0/3] upload-pack: treat want-ref relative to namespace
Message-ID: <20210813062237.10403-1-kim@eagain.st>
In-Reply-To: <20210809175530.75326-1-kim@eagain.st>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Round six:

* simplifies the test helper in 1/3 as per review discussion
* rephrases the doc change in 3/3 to make it read less dense
* 2/3 only updates the tests to use the revised helper

CC'ing Johannes Schindelin as suggested by git-contacts.


Published-As: https://github.com/kim/git/tree/ka/namespaced-want-ref-v6

Kim Altintop (3):
  t5730: introduce fetch command helper
  upload-pack.c: treat want-ref relative to namespace
  docs: clarify the interaction of transfer.hideRefs and namespaces

 Documentation/config/transfer.txt  |  14 +-
 t/t5703-upload-pack-ref-in-want.sh | 208 ++++++++++++++++++++++++-----
 upload-pack.c                      |  18 ++-
 3 files changed, 192 insertions(+), 48 deletions(-)

--
2.32.0


