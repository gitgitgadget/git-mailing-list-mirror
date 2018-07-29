Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C65208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 17:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeG2SkT (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 14:40:19 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33293 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeG2SkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:19 -0400
X-Greylist: delayed 1490 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2018 14:40:18 EDT
Received: from [192.168.129.4] (x004.home.local [192.168.129.4])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6TGiPIp12976156
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 16:44:25 GMT
To:     git@vger.kernel.org
From:   Michael <aixtools@felt.demon.nl>
Subject: git broken for AIX somewhere between 2.13.2 and 2.13.3
Message-ID: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
Date:   Sun, 29 Jul 2018 18:44:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Several years ago I had downloaded and packaged git-2.10.1 with no real 
issues, and it has been working fine. Deciding it was time for an update 
I downloaded git-2.18.0 and built from scratch.

After testing lots of version - the the last 2.12 version worked; 
git-2.13.2 works but git-2.13.3 does not.

root@x066:[/tmp/xxx]git clone git@github.com:aixtools/hello-world.git
root@x066:[/tmp/xxx]git --version
git version 2.13.2
root@x066:[/tmp/xxx]ls -l
total 0
drwxr-xr-x    3 root     system          256 Jul 29 16:37 hello-world

root@x066:[/tmp/xxx]git --version
git version 2.13.3
root@x066:[/tmp/xxx]git clone git@github.com:aixtools/hello-world.git
Cloning into 'hello-world'...
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 3
Receiving objects: 100% (3/3), done.
fatal: pack is corrupted (SHA1 mismatch)
fatal: index-pack failed

p.s. - what surprises me re: git-2.13.2 - no messages about 'Cloning 
into ...', which version 2.13.1 did give.

I guess a bisect is the next step - between version 2.13.2 and 2.13.3. 
Other suggestions welcome!

Michael

