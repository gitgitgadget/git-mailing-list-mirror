Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D271FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 11:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbdBGL1j (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 06:27:39 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37575 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbdBGL1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 06:27:38 -0500
Received: by mail-wm0-f50.google.com with SMTP id v77so150192610wmv.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 03:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peakgames.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=jn7DHxocsfK9XKurU8UO43i4AkpaiRm96JiSqHEREko=;
        b=rIk6C6tkdF6iFVd7O/pJogJhPiqfSFlNpMCkGzwCqxrAEwOWyysimLpTa0lahzumBj
         IU6GUUwi39+X6fmI+s++bU9Cs/kGknyCu3cGJUDC760gZpNmfpH0JZZfhJH0Jr/7/G34
         mwDag79B1NOdApMv8gJGead+3oELz4KdF7Fpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jn7DHxocsfK9XKurU8UO43i4AkpaiRm96JiSqHEREko=;
        b=cCgVKvOyRYUJewp2WhmjpTwmdPzBAi2kiNxlRfmECxDYGDvlkCHYku/nTR9BkYTNZ8
         XhFvpWwr/KHvnOqqMy09YHCXk8M3YwKCSFD2xUlbQscvNnz85nUeyCmZ+Lta7qrU1hRW
         khDYxED8xLp0urn8yE1hkfzFNZsBYcHZtFK8xsU9bFcTvBS/qF1VxLhwMi2u9VY/yX/8
         QX01aVSu9lUnXxqGqn4q2LEURB6MFVy5PEw5QW4S71pZ86yIbq3f7O9uXvdlCPzvppU2
         wBRA//I22cdJB3hskKJK0DmHzwU5h9pfHAkVJ05iQAFDOifAOBxKu3jApczOj3BJYThR
         p77w==
X-Gm-Message-State: AIkVDXL9jH1gMvJWBcjv0p7CZM3k6FvevQtW2gZDfjhELeyOQiKkBIQkUc0kyU7hOeGMHqRnZYJIAKy+B9Oz/2ma
X-Received: by 10.223.164.207 with SMTP id h15mr13327578wrb.142.1486466856606;
 Tue, 07 Feb 2017 03:27:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.35.196 with HTTP; Tue, 7 Feb 2017 03:27:36 -0800 (PST)
From:   Serdar Sahin <serdar@peakgames.net>
Date:   Tue, 7 Feb 2017 14:27:36 +0300
Message-ID: <CAL7ZE5xYVM6=C+SJLJ2HMFZ2gvuduw8p0UnS0RnBaXibj0mgDw@mail.gmail.com>
Subject: Non-zero exit code without error
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When we execute the following lines, the exit code is 1, but it is
unclear what is the reason of this exit code. Do you have any idea?

git clone --mirror --depth 50 --no-single-branch
git@github.hede.com:Casual/hodo-server.git
Cloning into bare repository 'hodo-server.git'...
remote: Counting objects: 3371, done.
remote: Compressing objects: 100% (1219/1219), done.
remote: Total 3371 (delta 2344), reused 2971 (delta 2098), pack-reused 0
Receiving objects: 100% (3371/3371), 56.77 MiB | 2.18 MiB/s, done.
Resolving deltas: 100% (2344/2344), done.

echo $?
0

cd hodo-server.git/

GIT_CURL_VERBOSE=1 GIT_TRACE=1  git fetch --depth 50 origin
cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee
14:12:35.215889 git.c:350               trace: built-in: git 'fetch'
'--depth' '50' 'origin' 'cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee'
14:12:35.217273 run-command.c:336       trace: run_command: 'ssh'
'git@github.hede.com' 'git-upload-pack '\''Casual/hodo-server.git'\'''
14:12:37.301122 run-command.c:336       trace: run_command: 'gc' '--auto'
14:12:37.301866 exec_cmd.c:189          trace: exec: 'git' 'gc' '--auto'
14:12:37.304473 git.c:350               trace: built-in: git 'gc' '--auto'

echo $?
1
