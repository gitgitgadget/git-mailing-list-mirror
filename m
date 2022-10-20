Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19443C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 15:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiJTP7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJTP7A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 11:59:00 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD71B7F1B
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 08:58:58 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o22so169635qkl.8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yi1/Tm1HTdY4qZIGFKFGl16B7NiK9SOzG5qjtqQzKNU=;
        b=mzTWuoNMbrZTSiKpQCM+iV3bql8CWSOPF6r5DzCm9Oi/6Uc3gOdysszUtOo9EwFnaP
         YHbjhrj+2liv4l3NM5ciTtLaAsGBSvCqBRC/mzfBlF6l4whGZ+O9pyXV04Qg3p+SZqvV
         5hOcWpjZ1xOgoAnI4xFIB5X51MiZ1fYX520IlXI4T5ESNiuWecR53zftuiIUJ5z2cVlB
         XH4L4cd6BQtMj9hoWlDuqVxMNka5y9Ab05eLkz/OZ1e23/bbar/w/XY5Z3oaUD36b1fG
         nHa2yeDN6aVkC7rPxhTMg7osFpbu28JWMKPxMKOOAv1OeTs09EyfZOidOP+J0ZKVZF3K
         8Psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yi1/Tm1HTdY4qZIGFKFGl16B7NiK9SOzG5qjtqQzKNU=;
        b=XsXWD8m8+eeZo78fnLBucc4FzGMlkrHhtAI1HWiLNuGCquDE4FpGC+puS/eDQU6083
         CF0gQE6XEJ/nQj0rRXPTSwym2Kk8u4Rh+F+VXzw++T41Cxcsd+nuXPyi1xA9THHeMuU0
         +A/6rq893SJMfjkSh+Wv711o7u3Q9c6vFAKvPZev1LcdqoGnoZtZOqtiwKSsUWm+VNyN
         hPuUT64aTLO1CDMHyhlPy+f/EpGiHYtOPS2hSZCSgqSPqiQNEex+dP0wuycT62dXsR10
         ZO7hxOsfNbGMm4sttvDcm1G2rStxJ7I8maQ4YYHz47HAb/7hvax08u8oX500m/LPpNRz
         tvlg==
X-Gm-Message-State: ACrzQf3u5kjPMUmXb1AyCK4+zB8PbP/APxYkCNMVauA5FUX7TFsb0ReU
        Vx2Wbt1mQt+rEapKmBBs2veRMYqvyJs=
X-Google-Smtp-Source: AMsMyM4kYYfeFgk6LiSBEjvmfdNVEYsRiA8XbtC7C1fZnxrWBMLhJ9me2thuaPVK+QTauwQVQ5oLZw==
X-Received: by 2002:a37:b0c:0:b0:6ee:d16c:b046 with SMTP id 12-20020a370b0c000000b006eed16cb046mr9577370qkl.45.1666281537389;
        Thu, 20 Oct 2022 08:58:57 -0700 (PDT)
Received: from smtpclient.apple (99-46-141-114.lightspeed.sntcca.sbcglobal.net. [99.46.141.114])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a13e300b006ea7f9d8644sm7249819qkl.96.2022.10.20.08.58.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:58:56 -0700 (PDT)
From:   "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>
X-Google-Original-From: "W. Ekkehard Blanz" <Ekkehard.Blanz@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Cloning remotely under git for Windows not working
Message-Id: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
Date:   Thu, 20 Oct 2022 08:58:54 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am almost certain this is not a bug but a deficiency in my =
understanding.  But I can't be certain.  Here it goes...

I copied an existing and valid bare git repository to a brand new =
Windows 11 machine (10.0.7.181) into D:\gitDepot\test.git

The problem is that from any other machine on the LAN (Kubuntu 20.04, =
Raspberry Pi running buster, an M1 MacBook Pro running macOS Monterey =
12.6,  and a Windows 10 box), I cannot clone it remotely.  I made sure =
ssh works correctly on all machines.  If I clone locally on the Windows =
11 box where the repository resides, it works just fine.  Version of git =
on the Mac is 2.30.1, on RBPi 2.20.1, the one on Linux is 2.25.1, and =
Windows 10 and Windows 11 are running the git version 2.38.1-6  I =
downloaded the day before yesterday. Since both Windows boxes are =
running the latest version of git (for Windows), I'll focus on these.  =
Here is the output from trying from the Windows 10 machine via the LAN =
(but Linux, RBPi, and Mac are equivalent, modulo the dreaded backslash =
quirks on all non-Windows machines):

   $ git clone 10.0.7.181:D:\gitDepot\test.git
   Cloning into 'test'...
   username@10.0.7.181's password:
   fatal: ''D:\gitDepot\test.git'' does not appear to be a git =
repository
   fatal: Could not read from remote repository.

   Please make sure you have the correct access rights
   and the repository exists.

However, if I fetch the repository "manually" via scp and then do a =
local clone it works fine (also from all machines):

   $ scp -r 10.0.7.181:D:\gitDepot\test.git test.git
   username@10.0.7.181's password:
   config                                                100%  121     =
0.1KB/s   00:00
   description                                           100%   73     =
0.1KB/s   00:00
   HEAD                                                  100%   23     =
0.0KB/s   00:00
a    pplypatch-msg.sample                                 100%  452     =
0.4KB/s   00:00
   commit-msg.sample                                     100%  896     =
0.9KB/s   00:00
   post-update.sample                                    100%  189    =
11.8KB/s   00:00
   pre-applypatch.sample                                 100%  398    =
24.9KB/s   00:00
   pre-commit.sample                                     100% 1642     =
1.6KB/s   00:00
   pre-push.sample                                       100% 1352     =
1.3KB/s   00:00
   pre-rebase.sample                                     100% 4898     =
4.8KB/s   00:00
   prepare-commit-msg.sample                             100% 1239     =
1.2KB/s   00:00
   update.sample                                         100% 3611   =
225.7KB/s   00:00
   exclude                                               100%  240    =
15.0KB/s   00:00
   e00b8814a1502d039e414ab8b7f4cc6db09d19                100%  276     =
0.3KB/s   00:00
   c32d48e6a1f8565577b6bf38cf9c87cc3f27e3                100%  170    =
10.6KB/s   00:00
   d0e1b3f59681c198dd066aa1ccfb7ccc4ccb65                100%  154     =
9.6KB/s   00:00
   c598083bac8d98539e8996e87c29bfd5a9d4ec                100%  512     =
0.5KB/s   00:00
   72eead39a0eb2a4d6ebc9f4b3d5a7860b95cdb                100%  115     =
0.1KB/s   00:00
   ec0cf7914a321321405aab9491e93e71e65f2d                100% 9490     =
9.3KB/s   00:00
   9df99cfcc422638c5636cf13678a2d67de8523                100%   61     =
3.8KB/s   00:00
   66097a1d6a592f1f196c4d45888c0a8e195691                100%   11KB =
734.5KB/s   00:00
   3a86067e8b10fcd17d8867aa26a88d7a93e871                100%  353    =
22.0KB/s   00:00
   eb7a3ee75f5b48c9299af193bcbc1d8ec4d3e8                100%   28KB   =
1.8MB/s   00:00
   8137b522b296b3783ad16f9ea9bbf3d438579d                100%  149     =
9.3KB/s   00:00
   a1a88bed6d2233680f0094518274c39f816ecf                100%   61     =
0.1KB/s   00:00
   47a804d61fe31a3bb13d15631a49f1f528cfac                100% 1321    =
82.6KB/s   00:00
   0fb2b0097776a995e3e0a11bcf38e5759f2518                100% 3042   =
190.1KB/s   00:00
   3759072a0ec683f85b8a5fcb2f2b3bf85692ed                100% 6206     =
6.1KB/s   00:00
   046b8a0c60dfab54ec715679c54a0b4ee6b8ae                100%   25KB   =
1.6MB/s   00:00
   1e945c271391c8425345fb8dc783a8752d4472                100%  128     =
8.0KB/s   00:00
   6204a8c67be9495f1ecd670434db75753b6057                100%   61     =
3.8KB/s   00:00
   39016db7b32b856d7f6da6df5b5d38c9adb98b                100% 1228    =
76.8KB/s   00:00
   cf723c9aed423486bbf5868a3b90235c716184                100%   52     =
3.3KB/s   00:00
   f02a9669aea7e8f391231964eaa110fda1153c                100%  312    =
19.5KB/s   00:00
   96f887fec5ec650580e50f55e5f68f97cfa8c1                100% 8196     =
8.0KB/s   00:00
   c21047fc7cb4f966cfe17ae0fba12069485f99                100%   13KB  =
12.9KB/s   00:00
   f9d3b669d739cc8378dc37ec580ccbb1367160                100%  192     =
0.2KB/s   00:00
   a70e6aa5c23ccac057c4ec2dc6e40fc5654a6f                100% 1226     =
1.2KB/s   00:00
   48f9dfa0778cd6739fa82a298d4e0faf25ced7                100%   16KB   =
1.0MB/s   00:00
   d4ed9ef7b9b75952f492dcf98cceb5ac724930                100%   18KB   =
1.1MB/s   00:00
   697ca031699da9e97595c1667333656448b6e4                100%  473     =
0.5KB/s   00:00
   1a288797d99f1f194952b83a2b5aeebad7dbcd                100%  346     =
0.3KB/s   00:00
   97221cb62140eee86e7f80b45ebd04fe1e784e                100% 4230     =
4.1KB/s   00:00
   b1d494272ea2dfb8addeedc1abae2a9525a6db                100% 5286KB  =
11.0MB/s   00:00
   be14b6ca07ec33a6e16eea1d4f20dfddcba242                100%   15KB =
934.7KB/s   00:00
   327f00a5e3d39ab26f31624f14fb92ffc0c0e6                100%  123     =
0.1KB/s   00:00
   60c427270571c5f7969be8788950fba8a5d25d                100%   67     =
0.1KB/s   00:00
   f04fdac6a7b9d3cfb770935598e31630467261                100%   57     =
0.1KB/s   00:00
   4d9e5c78f4a5169b64c203af4082a6af541947                100% 1285KB  =
11.5MB/s   00:00
   26811e96806b32ce1b4a6afa117019138e1ff4                100%  361    =
22.6KB/s   00:00
   f0ead32a6f3474aa5a7a7ba12ddd41bd984304                100% 1283     =
1.3KB/s   00:00
   59f9296fd040acabd82e8a84f6cc3810e2e67a                100%  163     =
0.2KB/s   00:00
   fc047898f76e98193156d1dd950c3d7e50313a                100%   91     =
0.1KB/s   00:00
   b068c7ee703eb9453cf978a949b72b2e020e06                100%   47     =
0.1KB/s   00:00
   ffd799dd73a30048a0b6f04cb2bb1903b0689b                100%  576     =
0.6KB/s   00:00
   af9f6d91e1e0e2024e2cb9ac58bd4f03ebb020                100%   10KB  =
10.3KB/s   00:00
   ecb9773ee8ce57b4ff9104e905501210da4b37                100% 5882     =
5.7KB/s   00:00
   0302f3c44719a8090f369d4c4629446d11aef5                100%   10KB =
661.6KB/s   00:00
   4f3f58113f38aa98047b2755b40b6d6674cf35                100%   34     =
0.0KB/s   00:00
   09072d04386ca2afa0452095d9021e010894fd                100%  128     =
0.1KB/s   00:00
   c53e58f37b94543f8beb3819420c3ac27a2af8                100%   20KB   =
1.2MB/s   00:00
   16ae5c7f5d00feeb07a606365603599defe239                100%  127     =
0.1KB/s   00:00
   f809c244616c959d03bef395d5c369d9f520cc                100%   23KB   =
1.5MB/s   00:00
   6f3c953426d5d5f21cae1eaa0c1ba27e40fa38                100%  118     =
0.1KB/s   00:00
   3065a17ed65c29f23900569b64ec37735f9a60                100%   12KB  =
12.3KB/s   00:00
   c2ef0ad78241501d7a81ba5783d2fd40228bc9                100% 3042     =
3.0KB/s   00:00
   e975729c28be52899d3d43d7b4401f8620dfdf                100%   54     =
0.1KB/s   00:00
   750a6987c92051791f9181e36163cc5153dfc2                100%   53     =
0.1KB/s   00:00
   8545065990b7f8151de35c8c42848362b8f9f9                100% 4645     =
4.5KB/s   00:00
   3b4fb5ebc46da0099d20ff80b72b37a1664915                100%  347     =
0.3KB/s   00:00
   1c9a1d08c5ecf9514f10f3e0bcfa5686ed5015                100% 1108     =
1.1KB/s   00:00
   16f45a7c5247e5545e9b68ac4ba0302e3e38c2                100%   41     =
0.0KB/s   00:00
   e5472bf040c3abac797a1808d52a37accef908                100%  155     =
0.2KB/s   00:00
   9debb4f1edc4d8037a9c65f88e8db84ee7e82b                100%   66     =
0.1KB/s   00:00
   b1f628ec7edc4bf1350404487a7b1628e6964a                100% 1213     =
1.2KB/s   00:00
   4d7ab37934fe3f947461d457676ab8f89dd6d2                100%   59     =
0.1KB/s   00:00
   861e8bffdc11c0543dc1c171d51889998d0215                100% 8423   =
526.4KB/s   00:00
   31324c0717c453964f7df10e2109db58067a82                100%   32     =
0.0KB/s   00:00
   3d2f943bacc4c880d1556a5c8ced0ca83617ee                100% 1158     =
1.1KB/s   00:00
   3d02b50f64878cb11da95d825b11cde8d93538                100% 1670     =
1.6KB/s   00:00
   18a7cd54ab74d640ad3db5d3f3ef09208b38cf                100%  150     =
0.2KB/s   00:00
   c3719819d3747071fb5f43ef89cb97f33feca9                100%   21KB  =
20.7KB/s   00:00
   055971279b30e9e99f59f0345824cb19b7c512                100%  115     =
0.1KB/s   00:00
   fb0be9e6ac2cb6efd431c63b5eb8358f90aa88                100%  276     =
0.3KB/s   00:00
   237ae499bd05a89a6cedb4a3a216bc0cdcb8ae                100%   61     =
0.1KB/s   00:00
   a7aa62597909bf8615ca96552cf9dc1009628e                100%  832     =
0.8KB/s   00:00
   1a64f7e4453187924f89b8729d62ea80224571                100%   63     =
0.1KB/s   00:00
   a7e2f442fd83d8b5cc4cd6acc3131d3ed855d6                100% 1669     =
1.6KB/s   00:00
   e1f3b8078738d0bf6714997bcb895e22650583                100%  788     =
0.8KB/s   00:00
   3a0a3e814e45ddec5028f1d9fe5ce1b9abf1d1                100%   52     =
0.1KB/s   00:00
   50e7a1578fb67ed1ec5ba4863280de07ce7243                100%  471     =
0.5KB/s   00:00
   e0050bd6dd296b8d16bd49a47ad5e678cadc44                100%  181     =
0.2KB/s   00:00
   f298c53e48946cb901374a1480c51ac479061a                100%  150     =
0.2KB/s   00:00
   dfe85001ee644fb75b0f1eee148d66b5494984                100%  305     =
0.3KB/s   00:00
   packed-refs =20

   $ git clone test.git
   Cloning into 'test'...
   done.

That tells me that test.git is (read) accessible via ssh with exactly =
that path and a valid (bare) git repository that can be successfully =
cloned locally, so it looks as if git was lying to me.

Just to make sure, I also executed git, git-upload-pack, and =
git-receive-pack via ssh to guarantee that I put them in the path that =
ssh sees on the remote machine:

   $ ssh 10.0.7.181 git -h
   username@10.0.7.181's password:
   usage: git [-v | --version] [-h | --help] [-C <path>] [-c =
<name>=3D<value>]
              [--exec-path[=3D<path>]] [--html-path] [--man-path] =
[--info-path]
              [-p | --paginate | -P | --no-pager] [--no-replace-objects] =
[--bare]
              [--git-dir=3D<path>] [--work-tree=3D<path>] =
[--namespace=3D<name>]
              [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]=

              <command> [<args>]

   These are common Git commands used in various situations:

   start a working area (see also: git help tutorial)
      clone     Clone a repository into a new directory
      init      Create an empty Git repository or reinitialize an =
existing one

   work on the current change (see also: git help everyday)
      add       Add file contents to the index
      mv        Move or rename a file, a directory, or a symlink
      restore   Restore working tree files
      rm        Remove files from the working tree and from the index

   examine the history and state (see also: git help revisions)
      bisect    Use binary search to find the commit that introduced a =
bug
      diff      Show changes between commits, commit and working tree, =
etc
      grep      Print lines matching a pattern
      log       Show commit logs
      show      Show various types of objects
      status    Show the working tree status

   grow, mark and tweak your common history
      branch    List, create, or delete branches
      commit    Record changes to the repository
      merge     Join two or more development histories together
      rebase    Reapply commits on top of another base tip
      reset     Reset current HEAD to the specified state
      switch    Switch branches
      tag       Create, list, delete or verify a tag object signed with =
GPG

   collaborate (see also: git help workflows)
      fetch     Download objects and refs from another repository
      pull      Fetch from and integrate with another repository or a =
local branch
      push      Update remote refs along with associated objects

       'git help -a' and 'git help -g' list available subcommands and =
some
       concept guides. See 'git help <command>' or 'git help <concept>'
       to read about a specific subcommand or concept.
       See 'git help git' for an overview of the system.

also

   $ ssh 10.0.7.181 git-upload-pack -h
   username@10.0.7.181's password:
   usage: git upload-pack [<options>] <dir>

       --stateless-rpc       quit after a single request/response =
exchange
       --strict              do not try <directory>/.git/ if <directory> =
is no Git directory
       --timeout <n>         interrupt transfer after <n> seconds of =
inactivity

and

   $ ssh 10.0.7.181 git-receive-pack -h
   username@10.0.7.181's password:
   usage: git receive-pack <git-dir>

       -q, --quiet           quiet


I also tried moving the directory gitDepot to the C: drive on the =
Windows 11 box - same result.

With that, I am at my wits end, as all the Internet had to offer (which =
was quite a bit) were fairly trivial but different cases (not to say =
that this one is not trivial, once I figured out what the problem is).

Is there anybody out there who can nudge me in the right direction?  I'd =
highly appreciate it!

Of course, if this is a "valid bug," please let me know what info I can =
provide
to report it properly and potentially help investigate iti further.


Cheers

Ekkehard

