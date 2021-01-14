Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3EBC433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626BD23B1A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 18:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbhANSas (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:30:48 -0500
Received: from mail.pdinc.us ([67.90.184.27]:47760 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbhANSar (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 13:30:47 -0500
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 10EIU14K019959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 13:30:01 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 10EIU14K019959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1610649001; bh=N+rq6ihc4lbjtJqa5OFd+/Xqxgq0RJdyfwY1ZtmZv3M=;
        h=Reply-To:From:To:Subject:Date:From;
        b=hWRfAq5nmEfHfnf4IJ9yl4OgP8SR1Ae9ONRLyOdUHCutEu7jLozKA6GfDfNUr0b6o
         kjlEh4TkrW6PyaD9ulVrTzdjJPZIYJ7IvHySUvvzszQ2nt+NYvkWxbg+urCJzxBSzK
         hGno2VsGsu8LphD6j56PUQgk3CrW0LEQJm5Bii1kOJu/c8kC+M/tYIZyzvzSrlXhl3
         h1VOOdgfyL//4qQUC6q/ixOxil22V4oIxzgk060ZY0B4wfswq8ozJcMibNOpIN+VY/
         oRTOOKVBvUWol2NwIt9qam1OZC/MVmoajZpNbCQVQSEPZGWW6nUS0SwZpqUReZ8yUr
         RscDkxbxYpGWw==
Reply-To: <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: add a blank line when a commit has no parent in log output?
Date:   Thu, 14 Jan 2021 13:30:11 -0500
Organization: PD Inc
Message-ID: <191201d6eaa3$4b585fa0$e2091ee0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AdbqoiHumHxGUT1TTLmPUqNTS8tiXw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take this git log --format="%C(auto) %h% ad%d% s%C(green)% aE" --graph --date=short

| | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
| | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
| | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)

One might assume 5505e019c2 and 3e658f4085 are related. But git cat-file -p 5505e019c2
tree 546c6b71f01e7fd086c8adb832518240b71a9075
author sam swindell <xxxxxx@xxxx> 1404878701 -0400
committer sam swindell <xxxxxx@xxxx> 1404878701 -0400

initial


Is there a way to have it look like:

| | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
| | |
| | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
| | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)

Or 

| | | #  5505e019c2 2014-07-09 initial xxxxxx@xxxx
| | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
| | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)

Respectfully,

Jason Pyeron


--
Jason Pyeron  | Architect
PD Inc        |
10 w 24th St  |
Baltimore, MD |
 
.mil: jason.j.pyeron.ctr...
.com: jpyeron@pdinc.us
tel : 202-741-9397



