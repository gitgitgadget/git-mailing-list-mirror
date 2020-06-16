Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B650C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26912098B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgFPQTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:19:50 -0400
Received: from catv-176-63-13-128.catv.broadband.hu ([176.63.13.128]:11025
        "EHLO anvil.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730786AbgFPQTo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 12:19:44 -0400
X-Greylist: delayed 22514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 12:19:44 EDT
Received: from localhost (anvil.localdomain [local])
        by anvil.localdomain (OpenSMTPD) with ESMTPA id c364c9ec;
        Tue, 16 Jun 2020 16:19:39 +0000 (UTC)
From:   Alex Smith <alexsmith@gmail.com>
To:     msuchanek@suse.de
Cc:     Whinis@whinis.com, alexsmith@gmail.com, don@goodman-wilson.com,
        git@vger.kernel.org, gitster@pobox.com,
        konstantin@linuxfoundation.org, sandals@crustytoothpaste.net,
        sergio.a.vianna@gmail.com, simon@bocoup.com, whinis@gmail.com
Subject: Re: Rename offensive terminology (master)
Date:   Tue, 16 Jun 2020 18:19:35 +0200
Message-Id: <20200616161935.151957-1-alexsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616141441.GH21462@kitsune.suse.cz>
References: <20200616141441.GH21462@kitsune.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> It allows changing the name of the branch that is created by git init
> using a configuration variable. Nothing else.

And I'm all for it. Having an QoL feature to do something that you could
already do is always welcome. We only care about what the default is, for
reasons already mentioned.
Having an extra flag requires user input, the user knows about that their
main branch is something other than the default master.

Most user won't be using this flag, and they will stick to the default. And
when they start using a service, that service also assumes that the default 
name is the same. These services are probably already configurable to change
on which branch they operate because git also allows to change it already.

But many people will just stick to the default. When these services change
this assumption, everyone else who relied on it has to explicitly set the
service back, or rename.

One example is shields.io https://github.com/badges/shields/issues/5215

Changing the default is frowned upon because it solves nothing and just
causes problems, as other services has to change their assumptions.
(And this doesn't make them bad software as others said
previously. If you have to interact with a repository remotely without being
able to ask questions first, you have to make assumptions to provide optional
parameters, and these optional parameters will only be set if you know that
you don't use the expected default, and many people already did, breaking
their setup when the service provider changes this assumption)
Giving the ability to change it more easily than before, is a welcome change.

What git can't control anyway is what GitHub, GitLab and the others will do,
and they already can without changing anything. If GitHub decides to break
these services and cause fragmentation, that's a thing not to be discussed
here.

And if they do cause fragmentation and git will be the last to keep the
convention, it will sadly have no choice but to bend, just to mitigate
further damage.

