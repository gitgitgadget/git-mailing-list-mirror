Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9FE1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 23:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756255AbdCGXx5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 18:53:57 -0500
Received: from forward3m.cmail.yandex.net ([5.255.216.21]:53495 "EHLO
        forward3m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756438AbdCGXxn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2017 18:53:43 -0500
X-Greylist: delayed 1728 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Mar 2017 18:53:42 EST
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [95.108.130.59])
        by forward3m.cmail.yandex.net (Yandex) with ESMTP id 3BD072149C;
        Wed,  8 Mar 2017 02:22:04 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1j.mail.yandex.net (Yandex) with ESMTP id EFCBD3C80D2B;
        Wed,  8 Mar 2017 02:22:02 +0300 (MSK)
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Mg9YKJBWLl-M1QaoZ7r;
        Wed, 08 Mar 2017 02:22:01 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1488928922;
        bh=zj80eRyjM1N3JxxW+Ret0jc5w1hVp+AWB/fT/VC75A8=;
        h=Date:From:Reply-To:Subject:To:Cc:Message-Id;
        b=U1aBiR50qFIuIIXQVpGbqtQOqrSbgUBoT0F02lFcHaMwxaTmi99/1UtyTSiIX15x8
         r27PSNc51OhMchXFeodR1w3miYjkp04ZEvrZ4k5R+WHf/lxcA1tnPCaeks+qitEIT3
         uOaos/E9AckzD+ALmA0r8aXDN9wqkuggrgfAAhHU=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-Suid-Status: 1 0,1 0,1 0
Date:   Wed, 08 Mar 2017 02:22:00 +0300
From:   Valery Tolstov <me@vtolstov.org>
Reply-To: 20170304172648.GB27158@hank
Subject: Re: GSoC 2017
To:     t.gummerer@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Message-Id: <1488928920.8812.2@smtp.yandex.ru>
X-Mailer: geary/0.11.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Decided to rewrite module_clone to use connect_work_tree_and_git_dir
as my microproject by suggestion of Stefan Bellar.
https://public-inbox.org/git/CAGZ79kY+1E-wg0-uzGJmE+haOE+1WCmg0Eux7rWGtkU_aBDQ9g@mail.gmail.com/

It seems that connect_work_tree_and_git_dir needs to be slightly changed
to deal with submodules. Because path to config file for submodules lies
not directly in .git directory we need to know whether the path is
submodule or not. Can I use submodule_from_path to determine this?
I mean what if NULL result also indicates error sometimes?

Another possible solution is to pass the flag indicating
that path is submodule or not. But I think this solution is bad.


Regards,
  Valery Tolstov



