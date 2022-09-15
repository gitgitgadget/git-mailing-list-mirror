Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D50ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 10:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIOKtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIOKtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 06:49:31 -0400
Received: from mouta.mpi-magdeburg.mpg.de (mouta.mpi-magdeburg.mpg.de [193.175.52.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA2320
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 03:49:28 -0700 (PDT)
Received: from mra01.mpi-magdeburg.mpg.de (gw.mpi-magdeburg.mpg.de [193.175.52.21])
        by mouta.mpi-magdeburg.mpg.de (Postfix) with ESMTPS id 2D0BD1808B9
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 12:49:27 +0200 (CEST)
Received: from group.mpi-magdeburg.mpg.de (group.mpi-magdeburg.mpg.de [192.168.30.29])
        by mra01.mpi-magdeburg.mpg.de (Postfix) with ESMTPS id 0344534B1
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 12:49:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by group.mpi-magdeburg.mpg.de (Postfix) with ESMTP id F26514C0BB6
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 12:49:26 +0200 (CEST)
Received: from group.mpi-magdeburg.mpg.de ([127.0.0.1])
        by localhost (group.mpi-magdeburg.mpg.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oh2-0qdVKusj for <git@vger.kernel.org>;
        Thu, 15 Sep 2022 12:49:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by group.mpi-magdeburg.mpg.de (Postfix) with ESMTP id A9C934C0DC2
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 12:49:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 group.mpi-magdeburg.mpg.de A9C934C0DC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mpi-magdeburg.mpg.de; s=79A81916-278E-11ED-A060-BB62192A9E10;
        t=1663238966; bh=BXsXhbjgqRSrUt6d3nQ1UEn0xj5pLHkwFrI25zSDYCY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fOQmOqj3rOiSQPCL9IdoKQGYPXEa658w4uYOsBYHkww4KTMuKGRIrf/jFz6ZROZkO
         Lz3cs5TXcAojlk6INwwUHBcGtvWol2aDk5KWKK3BldoMGEDYJdGAxkspl37f/wyY0n
         It8sdumx6/wZxq0sxOlz53sO+EaMiH15Wr58DCusiH9A6vrmC5c+BmBWJcicK309T/
         ADEIxykFDixx0hlleZBHvJ1b6blQJI4Fffr0GmWnP7DbBVmkyry5P+WEPIivzcLYxm
         GmWJ1RcxX5qq2NeUiJrNcKFitEQm8Rou6wHIIZaA0Y0DaOcapYlr/4taFmbrCLFWnE
         our8fYMVLL5+g==
X-Virus-Scanned: amavisd-new at mpi-magdeburg.mpg.de
Received: from group.mpi-magdeburg.mpg.de ([127.0.0.1])
        by localhost (group.mpi-magdeburg.mpg.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bNN5WPGBKEVW for <git@vger.kernel.org>;
        Thu, 15 Sep 2022 12:49:26 +0200 (CEST)
Received: from group.mpi-magdeburg.mpg.de (group.mpi-magdeburg.mpg.de [192.168.30.29])
        by group.mpi-magdeburg.mpg.de (Postfix) with ESMTP id 971044C0BB6
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 12:49:26 +0200 (CEST)
Date:   Thu, 15 Sep 2022 12:49:26 +0200 (CEST)
From:   Jonas Schulze <jschulze@mpi-magdeburg.mpg.de>
To:     git <git@vger.kernel.org>
Message-ID: <1678038401.2138998.1663238966604.JavaMail.zimbra@mpi-magdeburg.mpg.de>
Subject: Adding existing repo at sub-sub-directory as submodule
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.30.29]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF104 (Linux)/8.8.15_GA_4372)
Thread-Index: ZlYmwaokx1LwQallbeb/WGPKsj1SJQ==
Thread-Topic: Adding existing repo at sub-sub-directory as submodule
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone! 


Is the following a bug? I am working with git v2.25.1. I hope I won't annoy anyone with a duplicate of an existing/known issue. I'm new to working with mailing lists as well. 

# Problem Description 

I would eventually like to add a submodule to `extern/foo` that is checked out at a particular tag. As I cannot `git clone`/`git submodule add` that tag directly, I have to first checkout the default and then check out the desired tag. If I do so from the repo's base directory, everything works as expected: 
```bash 
git clone <URL> foo 
pushd foo 
git checkout v1.1.1 
popd 
git submodule add ./foo 
``` 
where the last one prints 
``` 
Adding existing repo at 'foo' to the index 
``` 

If, however, I do so with a target directory one level below, i.e. `./extern/foo` instead of `./foo`, 
```bash 
git submodule add ./extern/foo 
``` 
tries to clone `<current remote URL.git>/extern/foo` into `./foo` and fails: 
``` 
Cloning into '/path/to/repo/foo'... 
remote: 
remote: ======================================================================== 
remote: 
remote: The namespace you were looking for could not be found. 
remote: 
remote: ======================================================================== 
remote: 
fatal: Could not read from remote repository. 

Please make sure you have the correct access rights 
and the repository exists. 
fatal: clone of '<current remote URL.git>/extern/foo' into submodule path '/path/to/repo/foo' failed 
``` 

Using `git submodule add ./foo` from within `extern/` does not work either (`Relative path can only be used from the toplevel of the working tree`). 

# Expected Behavior 

Given the documentation `git submodule --help`, in particular the part of `add` where it says 

> If <path> exists and is already a valid Git repository, then it is staged for commit without cloning. 

I would expect the output 
``` 
Adding existing repo at 'extern/foo' to the index 
``` 

# Current Workaround 

Adding the submodule first and then updating it works: 
``` 
git submodule add <URL> extern/foo 
pushd extern/foo 
git checkout v1.1.1 
popd 
git add extern/foo 
``` 

# Feature Request 

It would be nice if I could do something like `git submodule add -t v1.1.1 <URL> extern/foo`. 


Thanks in advance! 

Jonas
