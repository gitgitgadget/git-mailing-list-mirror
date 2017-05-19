Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5DAE2027D
	for <e@80x24.org>; Fri, 19 May 2017 23:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbdESXoa (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 19:44:30 -0400
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21071 "EHLO
        sender-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932591AbdESXo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 19:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1495237436;
        s=zoho; d=calebevans.me; i=caleb@calebevans.me;
        h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=943; bh=T5cbiXoTRbKRT0KVlSrwRJC0XYCn2p6X5VPinpmbZy8=;
        b=EXk5k7zXzGf5fwHzdCeoCjat8mhbqnWiFUSV9m2dP7Vaw3gRNoZ80eHiYMeVrkSI
        UVJQGwMnMhQdJ9KFs7yIQV5Bpps3SP1JcNTVw+9TyRqti7EMV8T33qPaLFC39ZcyxcH
        p3ce1UdlJlHTStTbJThbbTAxeiksbJF7Y2ggCWoY=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1495237436103599.1718121931498; Fri, 19 May 2017 16:43:56 -0700 (PDT)
Date:   Fri, 19 May 2017 16:43:56 -0700
From:   Caleb Evans <caleb@calebevans.me>
To:     "git" <git@vger.kernel.org>
Message-ID: <15c2318a2c4.1100a44f3621653.6175207833450352995@calebevans.me>
In-Reply-To: 
Subject: Git log.decorate can't be overridden in global config (v2.13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently updated to Git v2.13.0 (macOS Sierra via Homebrew), and I noticed that the default --decorate option for `git log` has changed from --decorate=no to --decorate=auto. I'd prefer to keep decoration disabled to minimize clutter in the logs, so I try disabling it in my global .gitconfig (~/.gitconfig) like so:

git config --global log.decorate none

However, this does not seem to disable the log decorations. Running `git log` again still shows the decorations. Strangely, running `git config log.decorate none` does seem to disable decoration, but I would prefer not to do this on a per-repository basis. I can only suspect that this is a Git bug, as my log.decorate global config setting is not being honored. I have already confirmed that my repository's .git/config is not overriding my global preference.

I hope this should be a simple issue, but please let me know if you have questions.

Thanks,
Caleb Evans



