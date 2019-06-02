Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6652C1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 17:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFBRhC (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 13:37:02 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:53836 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfFBRhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 13:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1559497202; bh=NK/GwmIx/DmnptBgee6zKHQHsU2zqmVp45p97q5Eb4o=;
        h=To:From:Date:Subject;
        b=yJkbMWCS0B+kp419eXng9Y+nxg9coMN1QtdJG0golVFqxjkwicoGX9kWl+LtUqCOn
         fT5nk+oM/DuCvn9CkaMLJrKXVRpZ/ujfH6Lgtl7iSWcwXWwicjergIuV8DGNc5Czgh
         MWFiUtruNfPwLT8qiHqzbkZzM6s3moru6shPxnu8=
Content-Transfer-Encoding: quoted-printable
To:     <git@vger.kernel.org>
From:   Drew DeVault <sir@cmpwn.com>
Date:   Sun, 02 Jun 2019 13:37:00 -0400
Subject: [Proposal] git am --check
Message-Id: <BUJFK0ZEKP5I.16DDFWUTXGJTE@homura>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This flag would behave similarly to git apply --check, or in other words
would exit with a nonzero status if the patch is not applicable without
actually applying the patch otherwise.

Rationale: I'm working on an email client which has some git
integration, and when you scroll over a patch I want to quickly test its
applicability and show an indication of the result.

Thoughts on the approach are welcome; my initial naive patch just tried
to add --check to the apply flags but that didn't work as I had hoped.
Will take another crack at a patch soon(ish).
