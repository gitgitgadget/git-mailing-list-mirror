Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E86C20188
	for <e@80x24.org>; Fri, 12 May 2017 08:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756145AbdELIF1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:05:27 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37684 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755747AbdELIFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:05:22 -0400
Received: by mail-wm0-f46.google.com with SMTP id d127so5787017wmf.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smarthead.ru; s=smarthead;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=BWKf3UcKFqUZEUUFwBYMWkhy4/3VOLiAKt0t3NwLrIo=;
        b=ndRLIWD9XNuxj2AcqEFmQZ+ONNaSIr8NcP9VhXR5Ouy2yto1c+zc6tpK+yeZo8KGWi
         W4RdwLrS7ICwPwPCZTbcw7+Bo2nPvrNzVD8EO6LdpELFEoDxjFD6nQ57Rmtvd7BODF/w
         FLpJRuNpHevYK8oqSIKUYwpjWggL+nlsAKuHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=BWKf3UcKFqUZEUUFwBYMWkhy4/3VOLiAKt0t3NwLrIo=;
        b=Kn4bOFgmON+lik8GsQ/MaL+j70J4TNp2UcI5EiQbap7+SI+iwYMZV35IOGXXoAJ1YC
         KlhNKdCYWawDl5zfxpu/uKhquLPQ6hqwDnhjGN04PbklTtF/KP4a60dQ49xAHYfTugCN
         u/TE+2MCl7xDMh0oxmMNIsy9Rrwu+mtddKQX63Jasu3YTo9AqqakRbpbFn5v/eFlGSFK
         dvUc4Zd14fgNOSAz817WN8fC99QSYd9eA50JZpQOOgSyqwBvvLyZdY5a4hFkAMFG5n9x
         Fm15RWrvb8erdYRlGgAEJXZzfwigTY1abga6HAJcA6fAF5HxaJyiAOYyPBkFXIIA9yZG
         O2sQ==
X-Gm-Message-State: AODbwcAw8w3DVFqndyafo0K52DZWNMHsMxEHtppKJHUNIxPGEMCe4Hex
        uzqaSX4DAZdnq6tB
X-Received: by 10.25.213.197 with SMTP id m188mr680549lfg.41.1494576320667;
        Fri, 12 May 2017 01:05:20 -0700 (PDT)
Received: from [192.168.155.40] ([77.72.250.174])
        by smtp.googlemail.com with ESMTPSA id q184sm434718ljb.31.2017.05.12.01.05.19
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2017 01:05:20 -0700 (PDT)
To:     git@vger.kernel.org
From:   =?UTF-8?B?0KDQsNC50YbQuNC9INCQ0L3RgtC+0L0=?= <anton@smarthead.ru>
Subject: Git credential helper store flushes randomly
Message-ID: <cdedf063-5f53-04c9-5ac0-2acf7e26696e@smarthead.ru>
Date:   Fri, 12 May 2017 11:05:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

I have very strange git credentials store behavior on one of my servers.
I Use Ubuntu 14.04 LTS and git  2.10.2. The server have multiple users 
with multiple projects, so they have got many different git credentials 
to different repositories.
I set git config --global credential.helper store, but the credential 
record strings from file ~/.git-credentials for one specific user 
disappears randomly. Especially for one specific repository.

I do not see any TTL for git credentials in credential.helper store on 
git documentation, so I can't even imagine, what could cause such 
strange behavior.

Is this a known problem and is there any solution to fix this problem?


Best regards,
Anton.
