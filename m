Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9476DC433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6132722268
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tj2SDVFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbgJRTt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:49:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61234 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgJRTtU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 15:49:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92C2D10FFAC;
        Sun, 18 Oct 2020 15:49:17 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=2IYcY6Xjwuo2x6MO/171FME651E=; b=Tj2SDVFOGV9xTuv1MXjL
        C9fo95uf/hj6Utziw7ZBhwtd7ImgvzQoGNnNDopJymnswSVzCrAPuDh+n8hOOtOd
        FZzSTNognKyXWqvNfYq2qRosZE0hNO8Ug9UmPxkYarBb/Oe3NcO7BkSS7SIb5z4K
        tuatG6i0E6I3lrjeWbKsI2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=sasl; b=pZDx8PuMijLOQaFkMELJJ/7VEkHwqTqRxFleGK8jWReEt/
        j3291IbNxh4m9D++3cqwPLVqCQqlx2Dxl3n+six+iLws0Sx90VF5cEG/8122sZtf
        hPgZlA1U1pmKvW002WLqkFpzOJaMrIH1dAYhXJra5vVHyfNjtBLDUJFtkXm20=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A4A710FFAB;
        Sun, 18 Oct 2020 15:49:17 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BBF1710FFAA;
        Sun, 18 Oct 2020 15:49:13 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] Claryfing the meaning of the sign-off
Date:   Sun, 18 Oct 2020 12:49:09 -0700
Message-Id: <20201018194912.2716372-1-gitster@pobox.com>
X-Mailer: git-send-email 2.29.0-rc2-130-g9dc1ca14f3
MIME-Version: 1.0
X-Pobox-Relay-ID: FFA8CF96-117A-11EB-8BC6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here is to tie the loose ends, based on inputs to the first
round.

 * [1/3] is new; this is a preparatory clean-up to dedup two very
   similar paragraphs in the existing documentation, thanks to the
   idea by Philippe Blain.

 * [2/3] is text taken from Bradley's patch to update the manpages;
   thanks to the preparatory clean-up, we no longer need to
   duplicate the new text.  Grammofix pointed out by Ted Ts'o has
   also been applied.

 * [3/3] clarifies what sign-off means to _this_ project.  This step
   hasn't changed from what has been queued in 'seen'.

For those who missed the original, it appears at=20

    lore.kernel.org/git/20201015215933.96425-1-bkuhn@sfconservancy.org

Bradley M. Kuhn (1):
  Documentation: clarify and expand description of --signoff

Junio C Hamano (2):
  doc: preparatory clean-up of description on the sign-off option
  SubmittingPatches: clarify DCO is our --signoff rule

 Documentation/SubmittingPatches  | 25 ++++++++++++++-----------
 Documentation/git-commit.txt     | 10 ++--------
 Documentation/merge-options.txt  | 11 +----------
 Documentation/signoff-option.txt | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/signoff-option.txt
