Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A0220437
	for <e@80x24.org>; Sun, 19 Nov 2017 18:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbdKSSJL (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:09:11 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:44872 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdKSSJK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 13:09:10 -0500
Received: by mail-pg0-f50.google.com with SMTP id c123so5573338pga.11
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tVlM2knJZZyWBG1loFANeu/GLeQsAS3g/RPRPVkGXto=;
        b=M77CdRDzOB6gJPSDapSo0YuaFdKGd413OckeNip8mSR9+7hKalnCTEIyK/85paXz6G
         XthmRmsgUxcPzMgOSHJGC9yyN5h6OcfvABFfc1BdLr4RyU2tkUM+FQ3MvTufQiyLnQiF
         M8byKrcLaUhThehOsEq7go1Gh00DeRlqRkKrdVQD9wgkEVHjTpMamyah56sUd24bFPn9
         rNZxmtplUmxX/FPaIpUF0i9mi6FcK1kvNbwU106hAFpHMit9sWUcPvADxdWJsUFfVn9H
         4v7V6mKGCl/OWFJWGkvhadVdFDa4oQ8AVdtTlFxoWsJHd+udAIg+/sJ0lZCV+QXT395j
         LhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tVlM2knJZZyWBG1loFANeu/GLeQsAS3g/RPRPVkGXto=;
        b=g9+ubwlYSJkCrpFvZc0qgleAnB68s6n3SydbxjKJ9mNMvz/8jiR4LPiuRBmDXSTG0f
         HwNOpz9Tt3fbsj128CTGx3RZT3SC0+wgHEJQZ596NjPwIXgWX3hRo9wCaOrnzxtXEoEd
         Rv840wsvwXmGvS2TW6DAGSZCpxBHttKKwHj1QebIOXi72W94+gLJbiftzKOISOzh+ZuC
         YZLGnYfxKReLc8BNoz0D/Nocpz6aWBytFZutwk8kovOGiXtjJCPi1LI34fHCNJaWKxU6
         sUJSOlrxRbOXgIO8hZGmCYTVB/DOdJkMiNXM/9Y1SbDJwSvQONS5IoqzqyEa0LK7+nxV
         +fsA==
X-Gm-Message-State: AJaThX44NswAx9HkrWlUWs6SzZCM9GBzp5A/5crzuvTBI1CMFXabaSVt
        uNwgm3S+M1T7xxhrhU9FmyRj/NtcjNI=
X-Google-Smtp-Source: AGs4zMbd8g6TrB1hBf3z9CZzAPuSTvIj5qncNQ23xgmLNyeJqwJOwABGuU/dDSPD3h4Mh23Eata8aQ==
X-Received: by 10.98.112.71 with SMTP id l68mr7079674pfc.11.1511114949458;
        Sun, 19 Nov 2017 10:09:09 -0800 (PST)
Received: from ?IPv6:2405:204:72c8:8b21:b8b1:7c41:1a33:6334? ([2405:204:72c8:8b21:b8b1:7c41:1a33:6334])
        by smtp.gmail.com with ESMTPSA id m3sm14247070pgs.12.2017.11.19.10.09.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 10:09:08 -0800 (PST)
To:     Git Mailing list <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Can @{-N} always be used where a branch name is expected?
Message-ID: <38b4b665-18c4-5c95-f142-aedf33bc1b5c@gmail.com>
Date:   Sun, 19 Nov 2017 23:39:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was recently digging to find if there is any special syntax accepted 
for <oldbranch> in "git branch -m <oldbranch> <newbranch>" other than 
the plain branch name. I discovered the @{-N} notation. I was trying to 
play around with it and found that it didn't work as guaranteed by the 
last sentence  of the following paragraph in the "check-ref-format" 
documentation,


     With the --branch option, it expands the “previous branch syntax” 
@{-n}. For example, @{-1} is a way to refer the last branch you were on.
     This option should be used by porcelains to accept this syntax 
anywhere a branch name is expected, so they can act as if you typed the
     branch name.


In particular the following case doesn't work,

git init test &&
cd test &&
echo "Hello" >file &&
git add file &&
git commit -m "Initial commit that will be checked out" &&
echo "Hello world" >file &&
git commit file -m "Second commit" &&
git checkout HEAD^ &&
git checkout - &&
git branch -m @{-1} initial-commit


It failed with an error,

error: refname refs/heads/d21e72600673c670b3ae803488d0cebfa949e4c3 not found
fatal: Branch rename failed


Then I digged into why it didn't work to discover that @{-N}  just 
expands to a valid checkout and not a valid "branch name". So, the 
documentation  guaranteeing that "@{-N} acts as if you typed the branch 
name" seems wrong.  That makes me think that we should avoid misleading 
the user in the "check-ref-format" documentation.

So, should we update the 'check-ref-format' doc or am I missing something?

---
Kaartic
