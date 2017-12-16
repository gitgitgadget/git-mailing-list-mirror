Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD2C1F404
	for <e@80x24.org>; Sat, 16 Dec 2017 07:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbdLPHuo (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 02:50:44 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35576 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdLPHuo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 02:50:44 -0500
Received: by mail-vk0-f48.google.com with SMTP id y187so6931471vkd.2
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 23:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=D1zttVX5ymv3y0hSlLgTGD5Sn2UiAwJQomEaE657L28=;
        b=C3BgOAvDfKV2tWo+uW8OORZGsQh9DeTLBTyMTZNxkMBocxGqxPI9kDHITHiSZYWfMw
         ZoqU8g5wCAjWHcZupyljZ6vwdI6PJXwBIBEoo7QRG1Wm/FUKyDUAnnj0kRBNTHJglGSU
         qVf5TyMB28xUAhvAKRTTl2nWrneZiJr9by8EfEa4HKVNxZZdzBjL4/BNFVVrjVloWyKZ
         s5xZYA4lC57GHBao3HcIIHmnToQeh0AYD77a0x/Wq8tMbdlm51mfPMQSoFOxyzxasi8K
         HC/Hdn5dCh+Oe0j43twwUpwpyWVxLB/6VlYW5X+s2xuUy5ZAbuQ/WaQLRjqT9DIafWCT
         cr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D1zttVX5ymv3y0hSlLgTGD5Sn2UiAwJQomEaE657L28=;
        b=JR346nZyanO2lafzw8ijgqZevoL0vvRImtzwDMGVFQuVKOCM1P9JHXzIl2sQc3YtqH
         4tXAKr39btZrTE74fbk+HjvnTfoE9uwwIEofE2I3sJKH9cdBpBhdy9RBfiglj3OYOIW3
         +0XH/t2t+UNe7WNrTLYB2s+OhWJI/L+80Yoru+oaJFGSK9+yPwbDOcLosZHwLTdkFarq
         B7jy5LB+Hewm1pwk4bNY8JLGXsFpGFFvGjtp0zBu5aOj6kiP6cSLAlYGNL9pmoK5t5gO
         yR3MyJuqurJns0jEefN8/uWNotXxnEnFES9OI8nqwKV7pccg5W5ENU8MyMzEyA8xjXv1
         1DiA==
X-Gm-Message-State: AKGB3mLcQQRYWksgN6kybNyv9iHyIhHS9FQD8cvacqNVyJxaQI0aeLJ6
        9sXL8BNXeoYJXFneQvHy8N8gpfHzPviHLtudeVf8Bvpf
X-Google-Smtp-Source: ACJfBou1UhLVgYiQwux0Dxf0s2hW9I2OSGo5t4bEQxQXNg/0GQELLDiU/3hXu6h6jM6L+AEBQmCL7AbLkZvf9Nf1QAA=
X-Received: by 10.31.32.147 with SMTP id g141mr15579361vkg.9.1513410643055;
 Fri, 15 Dec 2017 23:50:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.25 with HTTP; Fri, 15 Dec 2017 23:50:02 -0800 (PST)
From:   Asfand Qazi <ayqazi@gmail.com>
Date:   Sat, 16 Dec 2017 07:50:02 +0000
Message-ID: <CAFTSPUV1E+jCMHzx+rq9Y1agthxcYrzDVY-rThTNCG7BfnPeTg@mail.gmail.com>
Subject: Trying to use insteadOf trick to use different SSH keys for separate
 github accounts - not working
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Here's what I'm trying to do, that i need your help with to make work:

I have 2 github accounts, each with their own SSH key: my home account
(default SSH key) and my work account (alternative SSH key). I can
create a virtual hostname in my ~/.ssh/config like so:

Host work.github.com
     Hostname github.com
     IdentityFile ~/.ssh/id_rsa-work

and then clone repos with:

git clone git@work.github.com/MyCompany/la-repo.git

However, I'm trying to use Go, which needs to access every repo host
as 'github.com', and won't support my little SSH hostname trick by
default.

I found out about the 'insteadOf' setting, and thought it would work.
So I added this to my global git config:

[url "git@github.com:MyCompany/"]
insteadOf = git@work.github.com:MyCompany/

and left the SSH hostname setting where it was. Then I tried doing:

git clone git:github.com/MyCompany/la-repo.git

But it won't work. With GIT_TRACE=2, I get:

$ GIT_TRACE=2 git clone git@github.com:MyCompany/la-repo.git
07:46:27.627557 git.c:344               trace: built-in: git 'clone'
'git@github.com:MyCompany/la-repo.git'
Cloning into 'la-repo'...
07:46:27.629623 run-command.c:626       trace: run_command: 'ssh'
'git@github.com' 'git-upload-pack '\''MyCompany/la-repo.git'\'''
ERROR: Repository not found.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.


Can anyone help me with this?

Thanks

Regards,
     Asfand
