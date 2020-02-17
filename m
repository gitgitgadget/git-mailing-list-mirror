Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA382C2BA83
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2F420725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0QCa2SL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgBQIC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:02:57 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36810 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgBQIC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:02:57 -0500
Received: by mail-ed1-f45.google.com with SMTP id j17so19617277edp.3
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EPMHmZxSRCRtVkAlrvMTtoiadJdH7v1FSo+qhCQATa4=;
        b=Z0QCa2SL6gJqAKWUODeD2ZdFNgprDvytZ7ykt65JKwqYoTTiHEzP+s7NrsAkUmG1nS
         Y712y7itMz1H03xH4a/EZVjGJgQu8yqd0yAW2/3RRcPSG4ihqghceYFMifrEG0iYDbgb
         HaMQgv4yoseVxbOXeV5cJ+bYlxgZaJQ9q0TZh9nXAA2s/wPhHhrVjiYJFo9fAoF2n60f
         S0dWXaJJ6DjiaAD/O+8ML0/u5C2tIYWZMNba/aIR+xd1rr2JTPfl8GDu1wcu4+GejKkF
         /DbnAcPEp/OiUuu2BN2W8+u6Vw4FKLZmHSTQRTBA2p765xR6VQ+0bxlVtbts7Ii9sIab
         7cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EPMHmZxSRCRtVkAlrvMTtoiadJdH7v1FSo+qhCQATa4=;
        b=GsGS4EjThRTSaF5GfoLwlac99lPRFQksYlMWWfV9KO/eg3iwSjA1dEQ7VgSFhXFNUY
         j9pmqiqTtJEe0JNw4Cxb9kM600kXwoWrOpbdjXdhlE89BgthyhSLvI/enpK4C9iGBPy2
         62r49EuB/KFbWVZotzaoAA7ZUhl8oapqbNpfByxHKoIX/dUTKUdbnyxbKv/iZhQirz2k
         xr8Mm5aDesimTEAS539mNPz6Nogzf8ig2kEqLnbpkcIm1JN1Mg3hdvPn113siGd8dNaj
         tpR1tegsN24GWygUUXzlNb23suwah6A0WdBUKJBcqpfXYLGKTiyRjhESlrHzhfbHYxvp
         X2Ig==
X-Gm-Message-State: APjAAAWzJW8E1WybR98lsLkgnkulp5Z2lodAvwSY99o4QeUx1W5MvCeH
        s8wffl1NPECh1oT75ywxd3WC5TZalvJWuWNmZRpvjQR38JE=
X-Google-Smtp-Source: APXvYqzQ7LtHilzmRtcwdrH1wvsokNi7qrj29NgJEbaCKoc4SOnJOpeywdKiscfmgaVQlH/U0SXplgYSWeDJH92dKBI=
X-Received: by 2002:a17:906:5f9a:: with SMTP id a26mr13843323eju.138.1581926575231;
 Mon, 17 Feb 2020 00:02:55 -0800 (PST)
MIME-Version: 1.0
From:   Manish Devgan <manish.nsit8@gmail.com>
Date:   Mon, 17 Feb 2020 13:32:44 +0530
Message-ID: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
Subject: Bug: Git: Clone: University Network: No Output on Terminal
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am a university student from India and I was trying to clone the
xfwm4 git repository from the git-url :
https://git.xfce.org/xfce/xfwm4
I was trying to clone this repository over my university network and
it didn't work. I worked my way around by using my mobile
wireless-hotspot for the same and was able to do it just fine.
The next day I tried doing the exact same thing since I couldn't get
an answer from our university if any such firewall was blocking me
from cloning it. But this time instead of failing to reach the url the
command ran with the following output:

gabru-md@bhaalu:~/Desktop$ git clone https://git.xfce.org/xfce/xfwm4
Cloning into 'xfwm4'...

after waiting for a few minutes the command didn't fail but it didn't
show any output/stats like it does when I try to clone a repository
from Github which is definitely not blocked on the university network.
for eg.

gabru-md@bhaalu:~/Desktop$ git clone https://github.com/gabru-md/stl-cpp
Cloning into 'stl-cpp'...
remote: Enumerating objects: 186, done.
remote: Counting objects: 100% (186/186), done.
remote: Compressing objects: 100% (128/128), done.
remote: Total 186 (delta 92), reused 146 (delta 56), pack-reused 0
Receiving objects: 100% (186/186), 105.58 KiB | 256.00 KiB/s, done.
Resolving deltas: 100% (92/92), done.

Furthermore the interesting thing is that I expected that my attempt
at cloning the xfwm4 repository might have failed but it surprisingly
did not. The command did clone the xfwm4 repository for me but it
didn't print out any stats/output during that time.

After searching on DuckDuckGo I saw that adding flags `--verbose
--progress` will allow me to achieve the desired functionality. I
tried doing the same and the output is given below.

gabru-md@bhaalu:~/Desktop/test$ git clone --progress --verbose
https://git.xfce.org/xfce/xfwm4
Cloning into 'xfwm4'...
gabru-md@bhaalu:~/Desktop/test$ ls
xfwm4
gabru-md@bhaalu:~/Desktop/test$ cd xfwm4/
gabru-md@bhaalu:~/Desktop/test/xfwm4$ cd icons/
gabru-md@bhaalu:~/Desktop/test/xfwm4/icons$ ls
22x22  48x48  Makefile.am  scalable

It is evident that the cloning worked perfectly fine but there didn't
seem to be any output on the terminal. At first I was convinced that
it was network error because it couldn't reach the target url but now
it doesn't seem to be a network problem.

I am not quite sure if this unfamiliar behavior while cloning a
repository is a bug or not hence I thought of reporting it. Also,
Apologies if this is not a bug but something which is known already.

I am currently running git version 2.17.1 on my Xubuntu.


Thanks and Regards
Manish Devgan
manish.nsit8@gmail.com
