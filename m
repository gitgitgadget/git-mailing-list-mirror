Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9A1AB34D
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882657; cv=none; b=dCnZn6kvWyoLabWVZidnA/vqVjMdqjuDdinmhtwKhi3qen21QmJxcQkf3brO9JX4p4InzyxoDE1mLaPaKRNt8wlqQlUete9KL8KsmY3ehFo7lGPMXWk0J73CI+TlSE74zkY93bFGqkd26jjlNQcMhOYDaMfw6v6jIOCyz3SczJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882657; c=relaxed/simple;
	bh=qp8oNkSX8fsLBQ+kHbbXLhR3uvxN6+z7okMmsXuRuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZsCyWbTok7IDFcGES8krjYQzWoGFWyxmc5dENMfjoyffvDT92nPREsrnu89eArJEFQGr4meMS1Q2h844MszZ+FLImoFMDGEGZDOpjk0xl496/8bGzKWpmm/ZAb+TYWPnyQmTmr45ywvw1nhCzGt0d1ooM+QYlf4sRQFDVey068E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=0GFKMshQ; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="0GFKMshQ"
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id EA59D11F75F
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:14:33 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 396C611F741
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:14:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 396C611F741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1718882066; bh=hQccVvBM0YmZq0zQb9kUBzV43dPczkgK92BmrUJCuco=;
	h=Date:To:From:Subject:From;
	b=0GFKMshQyWS9tapYzvnO3uWOqEkEC+8nL86RVo6tB7/3ZV5MTgeTbxRSRmDcrWmgR
	 Z6IY+V6qoqXgV4I421/NEKJJIJOQe878btUEPkmyyQ7z40ToGHTYBcfc1G3cdkzt0K
	 8GeptNgPKNXhlR/RjxC5vq+ytwiokz1eU2LMVZdg=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 3024420038
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:14:26 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 276B940049
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:14:26 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 9AC82A003B
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:14:25 +0200 (CEST)
Received: from z-prx-6.desy.de (z-prx-6.desy.de [131.169.10.30])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 75BAEC008A
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:14:25 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by z-prx-6.desy.de (Postfix) with ESMTP id 6B69B2400EB
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:14:25 +0200 (CEST)
Received: from z-prx-6.desy.de ([IPv6:::1])
 by localhost (z-prx-6.desy.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id InnDfvmNra3s for <git@vger.kernel.org>;
 Thu, 20 Jun 2024 13:14:25 +0200 (CEST)
Received: from [192.168.178.50] (dslb-088-070-180-117.088.070.pools.vodafone-ip.de [88.70.180.117])
	by z-prx-6.desy.de (Postfix) with ESMTPSA id 2B3C52400E4
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:14:24 +0200 (CEST)
Message-ID: <0fd230f6-a5c5-463d-8584-651ceff3cf99@desy.de>
Date: Thu, 20 Jun 2024 13:14:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: git@vger.kernel.org
From: Paul Millar <paul.millar@desy.de>
Subject: bug with git describe --dirty --broken
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

mkdir test-container
cd test-container
cat >Dockerfile <<EOF
FROM docker.io/debian:bookworm-slim
WORKDIR /work
RUN apt-get update && apt-get -y install git
EOF
podman build -t test-image .

mkdir test-repo
cd test-repo
git init echo "Hello, world" > README
git add README
git commit -m "Initial commit" README
git tag v1.0.0

git describe --tags --dirty --broken

podman run -v `pwd`:/work --rm -it --entrypoint '["/usr/bin/git",
    "describe", "--tags", "--dirty", "--broken"]' test-image


What did you expect to happen? (Expected behavior)

I expect git, when running in the container, to identify that the repo 
is clean.

What happened instead? (Actual behavior)

When run within the container, git identifies the repo as dirty.  The 
'podman run' command returns

v1.0.0-dirty


What's different between what you expected and what actually happened?

The 'git' command is running within the container.

Anything else you want to add:

I believe the problem comes from two parts.

First, when running within the container, the files seemed to be owned 
by user root.


12:51 $ ls -l
total 4
-rw-r--r-- 1 paul paul 13 Jun 20 12:45 README


12:49 $ podman run -v `pwd`:/work --rm -it --entrypoint '["ls", "-l"]' 
test-imag
e
total 4
-rw-r--r-- 1 root root 13 Jun 20 10:45 README


This results in an inconsistency between the ownership information 
contained within the .git/index file and the ownership information on 
the filesystem when git is run within the container.

Second, when 'git describe' is run with the '--broken' flag then the 
'.git/index' file is not updated.  The ownership inconsistency then 
triggers git's belief that the repo is dirty.

If the '--broken' flag is remove from the 'git describe' command then 
running the command directly and from the container give the same output.

12:51 $ git describe --tags --dirty
v1.0.0

12:55 $ podman run -v `pwd`:/work --rm -it --entrypoint '["/usr/bin/git",
    "describe", "--tags", "--dirty"]' test-image
v1.0.0

In this case, running the 'git describe' command (both in the container 
and directly) will update the '.git/index' file, and the correct output 
is presented.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-21-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.90-1 
(2024-05-03)
x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show


