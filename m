Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163952055E
	for <e@80x24.org>; Thu, 26 Oct 2017 00:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932141AbdJZAUo (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 20:20:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:51175 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdJZAUn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 20:20:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id b6so1182837pfh.7
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HwaBNIKcbcxAqlUoZ801TmIY1rMEmACmgxeiQJg3MfA=;
        b=YkdcfMTXpBUb/khvw+rr5Lgnl3TKxdo0QhH9sMt/vLMPKnqHb49XQFcDKwPNqnZlVC
         wqX4Wtbo1li+aCEGI/NHxSk/XERaJD+bRF72PWGly0paXd9yL5XHnskyQRsULXGq3/nB
         JK6ZGGrPpQjiTIOoWqQ8AeWas0RDEciclMyz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HwaBNIKcbcxAqlUoZ801TmIY1rMEmACmgxeiQJg3MfA=;
        b=FvAB8mGlT5gqKfG+K3H7r6p6XqqQ3S8dpouDp6u1pOQZBT7cR+AD1XkBUKeUnpL/kK
         KmIgU4RWcjhFD7S1meD+q/vq4KuPTz3FuYR1h9zC3j8b7OuCpFawpWIk/ILc1FX8ctUf
         vvPBxXRpuppoKnme2Nv1r3RvfsNx63YcJGdeI7dAIA/c+MLvGZ/PU+0oCtDK5bt2DVmc
         gNg4tZJOU5u7sOHt7LfXWHHjCq3en0kHyatnMx5gDBshNLgzV5Bec/Y/MUidlHSke4nk
         7r5aFfipdt29sdzF89QXBQOeObd6DY+aO9Q8NQSbMw3DKtSbBbLah7295QuVgBsNG8JX
         VOlw==
X-Gm-Message-State: AMCzsaVwoGgtWR2oVp/C0iH5gsqFqIb8O2UTCQdtKHyHZrJcdVFFIaXu
        /CMK94vAooaFfh5vCxLq2M4BZg==
X-Google-Smtp-Source: ABhQp+QQRIdJ3CMTyPZBtgMuKdmKpqlTseaZkCom8Xad+UJ3MCRLEPSAbnlbSC8tzJmEl4Gw9SNlTg==
X-Received: by 10.98.65.27 with SMTP id o27mr3715703pfa.327.1508977242447;
        Wed, 25 Oct 2017 17:20:42 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-vrrp2.corp.dropbox.com. [205.189.0.162])
        by smtp.gmail.com with ESMTPSA id e70sm7087988pgc.15.2017.10.25.17.20.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 17:20:41 -0700 (PDT)
Date:   Wed, 25 Oct 2017 17:20:33 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 1/4] fsmonitor: Watch, and ask about, the top of the
 repo, not the CWD
In-Reply-To: <alpine.DEB.2.21.1.1710201457180.40514@virtualbox>
Message-ID: <alpine.DEB.2.10.1710251700300.9817@alexmv-linux>
References: <20171020011136.14170-1-alexmv@dropbox.com> <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com> <alpine.DEB.2.21.1.1710201457180.40514@virtualbox>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Oct 2017, Johannes Schindelin wrote:
> This is super expensive, as it means a full-blown new process instead of
> just a simple environment variable expansion.
> 
> The idea behind using `PWD` instead was that Git will already have done
> all of the work of figuring out the top-level directory and switched to
> there before calling the fsmonitor hook.

I'm not seeing that PWD has been at all altered.  The following does
seem like a better solution:
------8<-----
diff --git a/fsmonitor.c b/fsmonitor.c
index 7c1540c05..4ea44dcc6 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -121,6 +121,7 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
        argv[3] = NULL;
        cp.argv = argv;
        cp.use_shell = 1;
+       cp.dir = get_git_work_tree();

        return capture_command(&cp, query_result, 1024);
 }
------8<-----

I'll re-roll with that.

> Did you see any case where the script was *not* called from the top-level
> directory?

Merely calling `git status` inside a subdirectory is enough to for the
stock watchman config to report that it's in a "new" directory:

    $ watchman watch-list
    {
        "roots": [],
        "version": "4.7.0"
    }
    $ git status
    Adding '/Users/alexmv/src/git' to watchman's watch list.
    On branch test
    nothing to commit, working tree clean
    $ cd builtin/
    $ git status
    Adding '/Users/alexmv/src/git/builtin' to watchman's watch list.
    On branch test
    nothing to commit, working tree clean
    $ watchman watch-list
    {
        "roots": [
            "/Users/alexmv/src/git/builtin",
            "/Users/alexmv/src/git"
        ],
        "version": "4.7.0"
    }

As I understand it, that means that it then loses all performance
gains in the new directory, as it spits out "all dirty."

 - Alex
