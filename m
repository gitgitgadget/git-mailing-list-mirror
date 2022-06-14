Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011DC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 21:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbiFNVed (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiFNVec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 17:34:32 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF722656B
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:34:29 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=matthieu.moy@inria.fr; spf=None smtp.helo=postmaster@zcs-store5.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of matthieu.moy@inria.fr is inclined to not designate
  128.93.142.32 as permitted sender) identity=mailfrom;
  client-ip=128.93.142.32;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="matthieu.moy@inria.fr";
  x-sender="matthieu.moy@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@zcs-store5.inria.fr) identity=helo;
  client-ip=128.93.142.32;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="matthieu.moy@inria.fr";
  x-sender="postmaster@zcs-store5.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.91,300,1647298800"; 
   d="scan'208";a="41047672"
X-MGA-submission: =?us-ascii?q?MDGr4VRwKSHdNBURAT9u3EBxP+ZHBe1eIhJjdY?=
 =?us-ascii?q?YEKqtiocxrmdxcdDi1I0XC0mgrfGlgREBqVG39o7S9tWJiZ76r0Sfpb0?=
 =?us-ascii?q?VcE53ajQO2CeWDMePVsy21B3uz5ja197seXxivR4/V6gP9GZoxlB5I5Q?=
 =?us-ascii?q?riGU2WtYx6ojycGn+flPP4xg=3D=3D?=
Received: from zcs-store5.inria.fr ([128.93.142.32])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jun 2022 23:34:27 +0200
Date:   Tue, 14 Jun 2022 23:34:27 +0200 (CEST)
From:   Matthieu Moy <matthieu.moy@univ-lyon1.fr>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <739656227.13381886.1655242467295.JavaMail.zimbra@inria.fr>
In-Reply-To: <0aff4d49e5934d11870a3c6bfecf1af0@SAMBXP02.univ-lyon1.fr>
References: <xmqqwndk10gg.fsf@gitster.g> <0aff4d49e5934d11870a3c6bfecf1af0@SAMBXP02.univ-lyon1.fr>
Subject: Re: [PATCH] t3701: update tests fixed with builtin add -p
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.97.204.116]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4257)
Thread-Topic: t3701: update tests fixed with builtin add -p
Thread-Index: AQHYgB/zqkFGzRayy0WIlN2GXEY2fPFRGMUo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Todd Zullinger" <tmz@pobox.com> wrote:
>
> -test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
> +test_expect_success 'split hunk "add -p (no, yes, edit)"' '
> 	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
> 	git reset &&
> 	# test sequence is s(plit), n(o), y(es), e(dit)
> @@ -562,7 +562,7 @@ test_expect_success 'split hunk with incomplete line at end'
> '
> 	test_must_fail git grep --cached before
> '
> 
> -test_expect_failure 'edit, adding lines to the first hunk' '
> +test_expect_success 'edit, adding lines to the first hunk' '

The magic of open-source: find a bug, write a test, try to fix the bug, give up, and wait for someone else to do it :-).

Thanks!

-- 
Matthieu Moy
https://matthieu-moy.fr/
