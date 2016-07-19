Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4232018F
	for <e@80x24.org>; Tue, 19 Jul 2016 20:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbcGSU7u (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 16:59:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33636 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcGSU7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2016 16:59:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so4162310wme.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 13:59:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=ssIiWvUWRnDLVq1NbTm+UgCTYCyWZ52/KLEWMCadc9g=;
        b=ik/gOzdma4UiTz91QIGeJbA0eXgFj9SZ4XFR5WQnMW9GLF73hgfoPjnPT7rbjW932g
         NyrQ4Wv+bjsSfK8BR1snA8LuaAzSYLoueaTFJrACwtqbRv9qoAKY27EKnzWWpdJk8Yvy
         dhBtkyrI4S1Hdbr3IHyxV65ZT2QG6kGQBJWnR4uYMtCFt7TaLYZPhc4kA293zXvcVSIV
         YxQrLxMJJOSq96LJrZXNamusraKoKrHzLjijZcGlUzkcaW4ERpCMSvXyNTa8s9Y0xi4e
         OMLaDp2iKlISNSPOJGEJrMLZtIThZejTOQ4i6WFSI3Ib63Rc9OkCksszZHPUvj9l72At
         fxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=ssIiWvUWRnDLVq1NbTm+UgCTYCyWZ52/KLEWMCadc9g=;
        b=I/J24zk4aMwvoT8ZfOEVKGRR/qvfMcdR0jRrXgB53Eq6MpUABaBFLPUgdeWaizW2v1
         e0r3WBuO9ZFWJ3PqXgJd48EqJiLG17sSTazvngS/O/tB5ZRiYC5p/8RNBu+cglK8T01d
         ob/HPMbrbtm8aN9Qzu4N8b1BT6dQvz8z3MMiggui3vRpS7YNOZswhEYVytYP6nWYCNN8
         RcXci9hgrTDZhFjdthRsR2D6WEPyZ1SX7p251Jx0WmYsT/sJ7ZxieYTk9v6SUpVytDlI
         aSS8MWiTxbsk7S4cZHQGT/aKIoIt72hGHGLTLXTamhUWkgdLKzhoupDJzswFnCNN2pQi
         qM1Q==
X-Gm-Message-State: ALyK8tLqo9uKiGpQJFTtvJO1sEPsWbE+Wnhb0O85ZBt3ce5T2qMlA0o3bft26Ir8CHbYuA==
X-Received: by 10.28.173.205 with SMTP id w196mr6422786wme.86.1468961987903;
        Tue, 19 Jul 2016 13:59:47 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA0C8.dip0.t-ipconnect.de. [80.139.160.200])
        by smtp.gmail.com with ESMTPSA id c139sm26068360wme.4.2016.07.19.13.59.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jul 2016 13:59:47 -0700 (PDT)
From:	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: Current state of Git worktree used with submodules?
Date:	Tue, 19 Jul 2016 22:59:59 +0200
Message-Id: <005DA57F-8976-43A1-B833-D5EFADC75BEF@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To:	Duy Nguyen <pclouds@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

some time ago Michael wrote in a blog post [1]:
"It's not recommended to use git worktree with a repository that contains submodules."

Plus "Documentation/git-worktree.txt" states:
"Multiple checkout in general is still experimental, and the support
for submodules is incomplete. It is NOT recommended to make multiple
checkouts of a superproject."

I wonder about the current state of this limitation. Is the statement still valid? 
If yes, do you know if someone is working on this? If nobody is working on this, do
you have some pointers for me what the main problems are?

Thank you,
Lars


[1] https://github.com/blog/2042-git-2-5-including-multiple-worktrees-and-triangular-workflows