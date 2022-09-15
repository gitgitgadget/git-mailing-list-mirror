Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB38FC6FA89
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 16:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIOQLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIOQLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 12:11:05 -0400
X-Greylist: delayed 238 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 09:11:04 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F17C1F0
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 09:11:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93E531B8647;
        Thu, 15 Sep 2022 12:07:06 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=d8TNSD7FaF+2ZrOfDsPLLGfo/
        Xd/JgbMI4bWDIj8brM=; b=IbLNexRDUOvLfAiowb9kpjqeLKiEuNVANDizzwyDV
        4zBbu14L7lg+RUAMBeBBBp9XRb2YPt8SbrhBBpfavs3/jWUiy4fgNn+nZF5M7tqL
        MFyVfUAeldSsQ6/oSgmEnA5PETKnTuuGc/UtUO9Q9Ikd3i1oVK6RJxDbeTdUenN4
        4g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D0061B8646;
        Thu, 15 Sep 2022 12:07:06 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2050F1B8640;
        Thu, 15 Sep 2022 12:07:02 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] environ: document GIT_SSL_NO_VERIFY
Date:   Thu, 15 Sep 2022 09:06:55 -0700
Message-Id: <20220915160659.126441-2-gitster@pobox.com>
X-Mailer: git-send-email 2.37.3-780-gd940517dcb
In-Reply-To: <20220915160659.126441-1-gitster@pobox.com>
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 6F4E02FC-3510-11ED-88C3-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the name of the environment variable is mentioned in
"git config --help" from http.sslVerify, there is no description for
it.  Add one.

Note that this is not a usual Boolean environment variable whose
value can be yes/true/on vs no/false/off; the existence of it is
enough to trigger the feature named by the variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0ef7f5e4ec..1b7e37e79a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -682,6 +682,11 @@ for further details.
 	plink or tortoiseplink. This variable overrides the config setting
 	`ssh.variant` that serves the same purpose.
=20
+`GIT_SSL_NO_VERIFY`::
+	Setting and exporting this environment variable to any value
+	tells Git not to verify the SSL certificate when fetching or
+	pushing over HTTPS.
+
 `GIT_ASKPASS`::
 	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
--=20
2.37.3-780-gd940517dcb

