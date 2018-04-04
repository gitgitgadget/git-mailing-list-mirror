Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0621F404
	for <e@80x24.org>; Wed,  4 Apr 2018 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeDDRHN (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 13:07:13 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51413 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbeDDRHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 13:07:12 -0400
Received: by mail-wm0-f50.google.com with SMTP id u189so7848826wmd.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KKSWH2Sw+LpBdZ6MEfN2Wc+m1q9UlIwIKufq1PhtEx4=;
        b=PDEcm/UF52NePNsMAwFF5DPIHd7K5FBpe2DT5DRwN/Kvzwo/Pp66UdxIpR45rHKsEs
         uSzJ/BdWJQm79BZcDan5OyCwtfQ/X2K521gkc+ceIUj3c52dAdBeIITUeieLTRqm+qZp
         PauMdIT4m/aeuZ131EYuTw1B9P8yAPPHHatpuf3R//IIKWccyLRe7EoYUvxzgkKuuAN2
         dSPVaeZWQDFj3tjDtuVmrL/5Z7DmiecUlWO6x2m8M0Dt2ajoGSLQIPVkESuPCF/Igka2
         0bLfNniYGwq3afOM9IXIP+EhRcWv4Z8JF/VWVDh+ZtxtVySgKhJJhWDnvuwr/FXgTor4
         ok4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KKSWH2Sw+LpBdZ6MEfN2Wc+m1q9UlIwIKufq1PhtEx4=;
        b=IHcSXJ9Daei2pe/djirVd1ou4Qq8TTt38Q7E61mR8I7BDN4JcPyKqcQtcYm/MgZ6HO
         4h4QmarLX5+8WJQd+tAfHD32RqS56cEO4lQoPWtl5Rbr/G81dVpScimgdNGqgtfMMyJv
         nYPU7nE7dNEuy0tCE7NuDe6tRCSUTjEwoqmQY+5xIpjnkumSF5ihh1SkNTCJ6nY6kTUE
         OPiWJ6gpFvmH8w3I5PN2C7TmUzqZXovQsFm5KHoPIyxv++FZqV11VdnHUrhZdNUukG2Z
         qrr3Eujtv+AmqCWJaMFuDIu04N8yPF2CxllI4Tbtk7ZYhzn/nEnJ2liR3E2kiPhP4abB
         TBZA==
X-Gm-Message-State: ALQs6tBr+Yfxuq8BiFZ8BxP2knH8KkNCusUe20xMO+dZgTA6hQo9ZABk
        MWpjs/gLjyP+iM1hFAjFGUhLDVe7txG1wjgbAE3fJxYaUpE=
X-Google-Smtp-Source: AIpwx48nAGT1XmXHfPaSaed7yYilYOiXPo6JdUJL/Ian5R2K/2jmfMZGEHCuH/lKpe4TKyMFI/gdqLRG2A2tJtRZ1LI=
X-Received: by 10.46.85.196 with SMTP id g65mr11692598lje.10.1522861630469;
 Wed, 04 Apr 2018 10:07:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Wed, 4 Apr 2018 10:06:49 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
Date:   Wed, 4 Apr 2018 10:06:49 -0700
Message-ID: <CAKk8ispGB2cxCxVpmabf7ASU3bSTLdMPbSQeAdYNom_JL=O0Bw@mail.gmail.com>
Subject: Errors testing on macOS High Sierra version 10.13.4
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I built git on a mac osx laptop and got some errors when testing.
I ran ./ci/run-build-and-tests.sh and three of the tests had failures
that appear to be associated with character encoding:
...
    BUILTIN git-whatchanged
    SUBDIR git-gui
    SUBDIR gitk-git
    SUBDIR templates
+ make --quiet test
*** prove ***
[07:58:38] t0204-gettext-reencode-sanity.sh ...................
Dubious, test returned 1 (wstat 256, 0x100)
Failed 1/8 subtests
[07:58:39] t0050-filesystem.sh ................................
Dubious, test returned 1 (wstat 256, 0x100)
Failed 2/10 subtests
[07:58:42] t9822-git-p4-path-encoding.sh ......................
Dubious, test returned 1 (wstat 256, 0x100)
Failed 3/6 subtests
[08:00:55] t9001-send-email.sh ................................ ok   132492=
 ms
[08:01:00] t3421-rebase-topology-linear.sh .................... ok   139911=
 ms
[08:01:08] t3404-rebase-interactive.sh ........................ ok   146923=
 ms
[08:02:42] t3903-stash.sh ..................................... ok   101289=
 ms
...

And here is one of the errors from t0204:

$ cat t0204-gettext-reencode-sanity.out
Initialized empty Git repository in /Users/wink/prgs/git/git/t/trash
directory.t0204-gettext-reencode-sanity/.git/
# lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
# lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
...
++ eval_ret=3D0
++ :
ok 7 - gettext.c: git init UTF-8 -> UTF-8

expecting success:
    printf "Bj=C3=B3 til t=C3=B3ma Git lind" >expect &&
    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" git init repo >actual &&
    test_when_finished "rm -rf repo" &&
    grep "^$(cat expect | iconv -f UTF-8 -t ISO8859-1) " actual
++ printf 'Bj=C3=B3 til t=C3=B3ma Git lind'
++ LANGUAGE=3Dis
++ LC_ALL=3Dis_IS.ISO8859-1
++ git init repo
++ test_when_finished 'rm -rf repo'
++ test 0 =3D 0
++ test_cleanup=3D'{ rm -rf repo
} && (exit "$eval_ret"); eval_ret=3D$?; :'
+++ cat expect
+++ iconv -f UTF-8 -t ISO8859-1
++ grep '^Bj? til t?ma Git lind ' actual
error: last command exited with $?=3D1
++ rm -rf repo
++ exit 1
++ eval_ret=3D1
++ :
not ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
#
#     printf "Bj=C3=B3 til t=C3=B3ma Git lind" >expect &&
#     LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" git init repo >actual &&
#     test_when_finished "rm -rf repo" &&
#     grep "^$(cat expect | iconv -f UTF-8 -t ISO8859-1) " actual
#

# failed 1 among 8 test(s)
1..8


Of course on travis-ci there are no failures so I dug deeper and found
that travis-ci is running 10.12.6 (I added a call to system_profier in
ci/run-build-and-tests.sh) where as I'm running is 10.13.4:

+system_profiler SPSoftwareDataType
Software:
    System Software Overview:
      System Version: macOS 10.12.6 (16G29)
      Kernel Version: Darwin 16.7.0
      Boot Volume: Macintosh HD
      Boot Mode: Normal
      Computer Name: Travis=E2=80=99s Mac (294)
      User Name: Travis (travis)
      Secure Virtual Memory: Enabled
      System Integrity Protection: Enabled
      Time since boot: 5 minutes

Not sure, but maybe I've got something configured incorrectly.

Suggestions anyone?

-- Wink
