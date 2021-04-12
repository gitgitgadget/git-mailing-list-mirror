Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D172C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 12:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE5611AD
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 12:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbhDLMeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:34:03 -0400
Received: from out2.migadu.com ([188.165.223.204]:36400 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240164AbhDLMeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 08:34:02 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618230823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVgaTTE/+/WtHoZkF5ymRENm6P5f3NRkU/NK5d3wOac=;
        b=LCbxR7xh/8J1YiWfQCjwt1CSbeRJhT2zKWleUPr8Pth/6EPORjnO5ltGZEzq77wRrHnTnx
        t1RQeyJb5SWypnnIguA0Zb8HTTlWprbdRMtrJUnd2QCeY1bxWoWSlZdAdAIFWpxKqVWbHf
        V/Px3B0YqO7kWqb0EMJiPAXBgPry7A/pW4jPsknN7/7z03WhQCY/dJd894fhe3zC25tqjv
        71/a2RrDYd3aRsL0jr7FDXEIcXC4zYKAzGyGSbFcid26Bo4tu4pS5I2nMdJt62eLE0j/sa
        ure64/aTH8WrZU7xUMatj0L9wJZI4LkRSExBxLk4X44L8DVlhy4WnIZ9cJmIqw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Apr 2021 08:33:42 -0400
Message-Id: <CALQY92B6OVL.2Z59Y6W51BU4Y@taiga>
To:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com> <87blakgaxr.fsf@evledraar.gmail.com>
 <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga> <878s5ogagz.fsf@evledraar.gmail.com>
 <875z0sg8t9.fsf@evledraar.gmail.com> <CAKZTYI6U0WY.36DC3N1E4R7D2@taiga>
 <87zgy4egtp.fsf@evledraar.gmail.com>
In-Reply-To: <87zgy4egtp.fsf@evledraar.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun Apr 11, 2021 at 3:56 PM EDT, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
> I suggest we don't compromise and just go with whatever you're OK with :)

Well, if you're giving me an opportunity to not drag this out into a
multi-phase rollout, then I'll take it :)

Another option is to forbid an unknown value (which is almost certainly
(1) wrong and (2) causing users to unexpectedly use plaintext when they
expected encryption), file a CVE, and pitch it as a security fix - then
we can expect a reasonably quick rollout of the change to the ecosystem
at large.
