Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE38D1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 22:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbdFSW1E (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 18:27:04 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36046 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752538AbdFSW1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 18:27:03 -0400
Received: by mail-pg0-f53.google.com with SMTP id u62so34832258pgb.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3KY1troMV/sh8n2Mwp+8y979RYpgMrnnr6O1KePngo=;
        b=r7L7GMVdGShRygJAVKNM5O6MDTNfZ/edYgydPxufZtm8zWCU3BXQSkLoSlHBhL1k5x
         Ne7bpnBevtSsVuAuqNs8N1SGwds5rAjoM+2Jco+XnQrqWb4QP4sXhJ641IjfV7fxcrEd
         Z6mUM9/XAecQ+hp7HjmTd6EB4slS6cggKd9UP0do7V/ie9HnRNXg1bsSmyIpvY8HTZvx
         pqZlHgCagBGBgKN4qXBgGhkia7/on9xAz2s5GF+Ki5YhSS5cfr2hGy2v8ChVMTQTMlI4
         0hzfDnnkt/4J+hpgNZjJ5o6Yxmop6ATDQ2i+3YdwQf+056JdxJZURuync9+r0KCoT6Jv
         M42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3KY1troMV/sh8n2Mwp+8y979RYpgMrnnr6O1KePngo=;
        b=bqhCKkv1K4AIG2enwRLe3DVtV9Mnb3yzQ5ZLrbDISc+EIOTftiqLDeYKo4JnJAXbFH
         3H3G8ciqLqsSx+y8vs0YIFNhaRQbSi18szLK+5n7qZXWZUGgwryKO9RzRaKQPgKowCvG
         34p01IYK9zQ3rAy5lzDnnFPWe1LqcDd3DPuQ48mDy/DQyWGh/DIcVS0c4bvV+rufXjNP
         8DtL68um0kknU3OljqZqIgnDoD7OQxLfbJVOCBHWJQ1pIZqdrA/CItMXX61SrsmDanLB
         LkcRr0xLhgu7/WsRWcz2nLZ9dZ1t5d8pVasRNfyd7ZgouOGXTaIDCEBXSlFkWvTCWCru
         LvbA==
X-Gm-Message-State: AKS2vOwkWJcGDe68t/9g8aG/rfIFjVhDI0hdv1NHa86pSfPe/R9h0/oG
        Vj8jFXAfOc7c6Mia
X-Received: by 10.98.208.1 with SMTP id p1mr27113346pfg.219.1497911222964;
        Mon, 19 Jun 2017 15:27:02 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:9b4:2c5a:b9fa:688d])
        by smtp.gmail.com with ESMTPSA id 62sm21076315pfz.39.2017.06.19.15.27.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 15:27:02 -0700 (PDT)
Date:   Mon, 19 Jun 2017 15:26:58 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     <eero.aaltonen@vaisala.com>, <git@vger.kernel.org>
Subject: Re: Behavior of 'git fetch' for commit hashes
Message-ID: <20170619152658.4559bce4@twelve2.svl.corp.google.com>
In-Reply-To: <20170619104936.706eff69@twelve2.svl.corp.google.com>
References: <14e804c6-0798-8bbd-b182-66c3cd2b870c@vaisala.com>
        <20170619104936.706eff69@twelve2.svl.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 19 Jun 2017 10:49:36 -0700
Jonathan Tan <jonathantanmy@google.com> wrote:

> On Mon, 19 Jun 2017 12:09:28 +0000
> <eero.aaltonen@vaisala.com> wrote:
> 
> > For version 2.13.3

Firstly, exactly which version of Git doesn't work? I'm assuming 2.13.1
(as written elsewhere in your e-mail), since 2.13.3 doesn't exist.

> > However, the workaround for descbibed abot for git version 2.7.4 no
> > longer works. The result is always
> > fatal: Couldn't find remote ref
> 
> I'll take a look into this.

I tried to reproduce with this script, but it seems to pass even at
2.13.1:

    #!/bin/bash
    rm -rf ~/tmp/x &&
    make --quiet &&
    ./git init ~/tmp/x &&
    ./git -C ~/tmp/x fetch --quiet ~/gitpristine/git master:foo &&
    ./git -C ~/tmp/x fetch ~/gitpristine/git "$(git -C ~/gitpristine/git rev-parse master^)"
    exit $?

Commenting out the first fetch line produces, as expected:

    error: Server does not allow request for unadvertised object <hash>

And I have not seen the "fatal: Couldn't find remote ref" error you
describe.

As Stefan alluded to in his earlier e-mail [1], I made a change recently
to how "git fetch" handles literal SHA-1s in commit fdb69d3
("fetch-pack: always allow fetching of literal SHA1s", 2017-05-15). In
this case, I don't think that's the cause of this issue (since that
change, if anything, makes things more permissive, not less) but that
might be a point of interest in an investigation.

[1] https://public-inbox.org/git/CAGZ79kbFeptKOfpaZ23yK=Zw9mJ0_evqPstHKkD1HSCaP_pC5g@mail.gmail.com/
