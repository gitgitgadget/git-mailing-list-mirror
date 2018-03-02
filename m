Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38A91F576
	for <e@80x24.org>; Fri,  2 Mar 2018 11:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946445AbeCBLei (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 06:34:38 -0500
Received: from mail.aegee.org ([144.76.142.78]:51372 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946437AbeCBLee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 06:34:34 -0500
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org w22Bagc3030666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1519990603; i=dkim+MSA-tls@aegee.org; r=y;
        bh=GYhKBRgaIqamO/268jAk1feWs1EUXKcFUmRVkLDZisE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M8cWmzd5tr6WiqdL5MOGFhRj/ZvdcohKNuTq0JG918GWh9hs6hlgVRreznauclziW
         mME5aQlyXPofcGlrECh4f7ohQAlX3X8UBg/AXKhH+9Md0P8cRaqOR+kZPDno1PXtc2
         L9OMkKKXrJp8b+K/ik8D/4LrnNYAiqI6MC+QYX0f9GKmFfKjN6zHmR8xC7tM0S4uT7
         FEkTpnlZs1wROnpuEKOVLUfgHSjjIaU7m8c8AS/XSUrEqW8FSk3EkjwnOYWdhdnDjF
         KKvjd4sX0mVfz1ZLSOCgYTDBBhXS95NXTuro8+rJjxznF8p6s8zQCl0iTlp+DzkOIj
         sBCOMXHbqGk7aJpl8M55jX24jY/MBAnngIqCOOS/z/1Dme6xXjTYY/rS+xs4L8SiYD
         bjt9YPWZSZdLa4zpOwdaEbfnG6tSDTqCmjWVEDOgFU2T0zvFXdg0aBiNM51xK6z9eM
         19B4SAupeN934gLt4xmY22mdZmcTRB++VD5RKCWGFGk13T84pagKA0u8BXYZb918Nl
         0H59rtquvdAuvoTWbQV25TkSExbcsqG1t7Cy9UYGv0c3E97++WS1IP1SIdmfr5tuvg
         +y2CJp/Apzuxi45kDW2jF8PgQUx59d+wcnI4CIjCjGOdZlsbfRFvCkh+l8NNIvg+Ss
         4/BtqI/BaBcKhGDOa9aDfOMQ=
Authentication-Results: mail.aegee.org/w22Bagc3030666; dkim=none
Received: from [10.128.8.92] (port-87-193-154-82.static.qsc.de [87.193.154.82])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id w22Bagc3030666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Mar 2018 11:36:42 GMT
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
 <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
 <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org>
 <CAPig+cTPFSbT7WxyoNEOSg=3Ft1pVzkgieGp44kHnZ9=NbYsqg@mail.gmail.com>
 <CACsJy8BUKCG-yiYX3ouMVa44iEo0swHpTkhW3ho_T0PCP81DSw@mail.gmail.com>
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Message-ID: <b34d74fa-f4c7-fb4a-49df-cd7ebd996d95@aegee.org>
Date:   Fri, 2 Mar 2018 12:34:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BUKCG-yiYX3ouMVa44iEo0swHpTkhW3ho_T0PCP81DSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.3 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Duy,

thanks for your answer.

Your assumption is correct: when renaming the directory apparently I have not adjusted /git/A/.git/worktrees/B/gitdir to the new location.

I fixed the situation by renaming /git/B to /git/B.bak, creating a new worktree pointing to /git/B (with branch g), then deleting /git/B and moving /git/B.bak to /git/B .

Consider adjusting the documentation as suggested below, possibly using a different wording.

Regards
   Дилян

On 03/02/18 00:56, Duy Nguyen wrote:
> On Fri, Mar 2, 2018 at 3:14 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> As far as I know, there isn't any code in Git which would
>> automatically remove the .git/worktrees/B directory, so it's not clear
>> how that happened.
> 
> "git worktree prune" does, which is called by "git gc" and that was
> actually executed from the command output in the original mail.
> 
> Дилян Палаузов did you move /git/B away manually? For example, you
> originally created "B" with
> 
> git worktree add /somewhere/B g
> 
> then you do this at some point
> 
> mv /somewhere/B /git/B
> 

Signed-off-by Дилян Палаузов <git-dpa@aegee.org>
---
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 571b5a7..33655c4 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -15,8 +15,8 @@ DESCRIPTION
  -----------
  Runs a number of housekeeping tasks within the current repository,
  such as compressing file revisions (to reduce disk space and increase
-performance) and removing unreachable objects which may have been
-created from prior invocations of 'git add'.
+performance), removing unreachable objects, which may have been
+created from prior invocations of 'git add', and calling 'git worktree prune'.
  
  Users are encouraged to run this task on a regular basis within
  each repository to maintain good disk space utilization and good
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 5ac3f68..4b0d32f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -82,7 +82,7 @@ with `--reason`.
  
  prune::
  
-Prune working tree information in $GIT_DIR/worktrees.
+Prune working tree information in $GIT_DIR/worktrees.  Called implicitly by 'git gc'.
  
  unlock::
  
--
2.10.0.298.gc59cecb
