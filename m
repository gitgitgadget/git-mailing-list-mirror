Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805BE2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 15:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757495AbdCUPtk (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 11:49:40 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35979 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbdCUPt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 11:49:27 -0400
Received: by mail-vk0-f44.google.com with SMTP id j64so84047152vkg.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uV7ogg99Rvu/ne/nQ7iC0iXqBSmLb1Ka5r8hJjWGNvM=;
        b=TzDWEJe2QQM73fdZBrDRNrYVjy0jVx4NSzzOIiAhNtfxV45ledsLDJAKS9NsV0UUlb
         vPWqn8L23onOoSmEyHl6TDIJchHxTWJjVMH6oTCmh6jzNVesw4t66hNFpDR9Hpls/oby
         cnFqTyvNRJUC/qs5ogsFZzS8LTxx5bQiXYKWPed8HhLB+CIrtrgg6Eq8y5bseMMTgll9
         Ijv9WC9QJRvmyG7g6OxYd/omrAm0JEJB561Nz9l2YVBw3mndKJ37Z3NM4Vd+kvxrlPuc
         TxUxSskaBk5f/6ukxhQ5u1BJdrwEy4PG2jtvYV0IjaJRbBgshuVHgWoNGYTYaXlJ4RxU
         fq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=uV7ogg99Rvu/ne/nQ7iC0iXqBSmLb1Ka5r8hJjWGNvM=;
        b=KiaTXeq3w0uFFWY6V/SZHoK1jmhA7jJ/Hb/y7/Ikh0vicQE1uTObkhZ45+0Jzwkiw/
         hi9Nbv2bi7KS9CM6PIIFoON2H44Fh8b0NX7ZCt/wjWjUHIIi/Q4yFg2AJc5K6iUCeQjf
         DQY4uq8ERr1CA8/EllKOXORovmCpQHe6Od9gfhpmCsjod/ZPc88N6dGA5GMbtA7t9A8z
         ++Kudj6fPmcbyCnWAD6HDc74hasU4jQxicfsRmcvxRgqG0vLLvaYLQDG86wah9NtBg6i
         tZ7pKDX2ps/K5Bd/Z8Q53J9JTaEjifXboBicrLU32xo4t2/eiapiBRFjfJQUuC8+iGfn
         bM3Q==
X-Gm-Message-State: AFeK/H0DmBJRLLxCEvgr7CA441jOyduHBh/spjtBy6L37N+qHXJKuLkn475PmpRqndLd3Q==
X-Received: by 10.159.36.75 with SMTP id 69mr15618687uaq.173.1490111366184;
        Tue, 21 Mar 2017 08:49:26 -0700 (PDT)
Received: from localhost (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id f195sm4963649vke.8.2017.03.21.08.49.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2017 08:49:25 -0700 (PDT)
Date:   Tue, 21 Mar 2017 15:49:21 +0000
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <royger@FreeBSD.org>
To:     git@vger.kernel.org
Subject: Issues with git send-email and msmtp
Message-ID: <20170321154921.3jgn4ktcop4shct2@dhcp-3-128.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm trying to use git send-email with msmtp, and I have added the following to
my .gitconfig:

[sendemail]
	smtpserver = "/usr/local/bin/msmtp"

This seems to work fine, except that sometimes git dies unexpectedly after
queuing a patch to msmtp:

Died at /usr/local/Cellar/git/2.12.0/libexec/git-core/git-send-email line 1350, <FIN> line 3.

I'm guessing there's some kind of race, because this is not 100% reproducible,
sometimes succeeds while others simply dies with the above message. As you can
imagine, this is specially annoying when sending patch series.

Has someone seen similar issues when using send-email and msmtp? Am I missing
something in my .gitconfig?

Thanks, Roger.

(please keep me in the Cc since I'm not subscribed)
