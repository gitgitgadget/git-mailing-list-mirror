Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFC9C55186
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 03:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E967620CC7
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 03:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="SoppB54C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDXDYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbgDXDYc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 23:24:32 -0400
X-Greylist: delayed 57791 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Apr 2020 20:24:32 PDT
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D58C09B044
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 20:24:32 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1587698670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=Z/CuT4ZkgO1SJ0dHEKews/jyZBeehuTyDcfdXMo3HXM=;
        b=SoppB54CqKpN+ic2kuFWoa76tnczpGY2TCOsi/SiisgvmyNbWl6tpcKmzL5jbDswLkZfbh
        ta2zXy4p6HgOzeQunLvqSbmkM9LHLI/uKqAv0yGyDWEVgSm8DAEec31spLb28cnz/13WOn
        CtMH0h7YJMHlHPcNzU8Jt+I95B9pvzc=
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <d26f8556-ed9b-5145-735b-d348449bb31d@kdbg.org>
Date:   Thu, 23 Apr 2020 23:24:28 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Johannes Sixt" <j6t@kdbg.org>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2] ssh: add 'ssh.keyfile' option
Message-Id: <C2947F3O0OB7.2XJGV8LYVERWN@nietzsche.my.domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Apr 23, 2020 at 7:24 PM, Johannes Sixt wrote:
> Then attach the invented name to the real host name and the identity in
> your ~/.ssh/config:
>
>=20
> Host other.github.com
> Hostname github.com
> Identity ~/.ssh/id_other_ed25519

This works for my purposes. The exact block I needed:

Host fake.host
  Hostname real.host
  IdentityFile ~/.ssh/alt_ed25519
  IdentitiesOnly yes
