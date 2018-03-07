Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5681F404
	for <e@80x24.org>; Wed,  7 Mar 2018 13:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeCGN5O (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 08:57:14 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:39817 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGN5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 08:57:13 -0500
Received: by mail-wr0-f172.google.com with SMTP id w77so2264831wrc.6
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=CQvllIo1iugGOu3ExX3nKv8wW1n1h0WSBa6GJD0zV8g=;
        b=FDP3vgaeEZ+bC4E4g9IotFCa4mO1fGob/pUilGxwvaBezTAe2SMsJ8V/m7r8y6VPjl
         V0GJLsxo1P0XPgx+j4wv4NfXLo23CBzBVircJuuMKzhJprUPWTI+z/AGUjGXK1bgqKq4
         7MWdH3qCqRRJgx/N1wMndcIr6dbSWNog784Jp4dcN9ODoeZ+MHeyOE3855VUl4YeE3nr
         bbAk6nPKxsoOwj/eF6g46VGVKZ7CUlA4pe88E9vlnxlguf3nFuTHHGRUSwo/TMtUmtdz
         QdHWZUxG4+tBvNL3O5kYJJIZrI5dnTpJVykzronsRlNJ0fyqoDUBRNwErdsC+qP1gLSP
         TwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=CQvllIo1iugGOu3ExX3nKv8wW1n1h0WSBa6GJD0zV8g=;
        b=mktbIu5q89d9CNQsOx6xiNFuefo3rQXrCofHls/u+gYpe2rwr0I9Zz2nG0cPxJyI0V
         3cT1tEqdlaF7YQqbLvM2PMB8m2jvVfkDZcPQi6zQZHUx4P88TBPwOf0V8FfmP4Zsr3z3
         KIm10HbhkJSh/Do07X8XF6R/nAzgC2+9tPbPQDBTCj46olVutCEh7pGfEYzgtqGcQIBH
         xPgIkufoOAi7JOzVyROc4c+k/SWVQZK/aWw/Y8nVAfCTkyVSQkn5YC+plKwL28ctNHZX
         mU3Fs1j3RwRFD1PVp0tvkBOdROJLkTFSv/lcoy/bcHfLgW1nZA+lZSSFLhniUdzGaOby
         oSbw==
X-Gm-Message-State: APf1xPBukmhMdej8JdKmugF3IXFoF9wNvno6HzUdwRi9Gy9jtxlIZkC0
        HuruQWh0P5lEKM7aZm7eVSSne6ol
X-Google-Smtp-Source: AG47ELsfLo67Zt0nT8bTpGABkAE/EuZdQNiH+r9f4LjyamSYvPSrjgy9PobroD4M0UqhV/UYlU/s4w==
X-Received: by 10.223.152.228 with SMTP id w91mr18290323wrb.74.1520431031444;
        Wed, 07 Mar 2018 05:57:11 -0800 (PST)
Received: from [172.16.4.30] ([84.88.84.116])
        by smtp.gmail.com with ESMTPSA id m7sm41611798wrm.35.2018.03.07.05.57.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Mar 2018 05:57:10 -0800 (PST)
To:     git@vger.kernel.org
From:   Derrick Stolee <stolee@gmail.com>
Subject: Partial Clone: Commands that could be problematic
Message-ID: <04927620-c5ea-ee70-2104-4a5a7a994e33@gmail.com>
Date:   Wed, 7 Mar 2018 08:57:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We discussed partial clone today during the contributor's summit. There 
were some concerns about some commands that would cause over-hydration 
of blobs that need server requests to resolve.

GVFS blocks "fsck", "gc", "prune", "repack", "submodule", and "worktree" 
[1]. I promised I would include this list. There are a few limitations 
on the arguments of the other commands, as seen in that code. These 
commands that are blocked are already handled in partial clone with the 
"promisor" pattern. The "worktree" limitation is only due to the 
file-system virtualization layer of GVFS.

We discussed commands like "git grep" that sometimes look at the working 
directory and sometimes crawls trees. That is a command that should be 
considered for batching object downloads, limiting the command to 
"hydrated" blobs, or limiting to a sparse checkout.

Thanks,

-Stolee

[1] 
https://github.com/Microsoft/GVFS/blob/2db0c030eb257beebf8e17f1c2ce72ffb166f533/GVFS/GVFS.Hooks/Program.cs#L120-L137

