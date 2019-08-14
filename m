Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4A61F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 11:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfHNLu7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 07:50:59 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34567 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfHNLu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 07:50:59 -0400
Received: by mail-ot1-f51.google.com with SMTP id c7so9016086otp.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SpEjgGy4rjHRpz+jjkgyAFS5o92nCTSW2YdjHIiEESo=;
        b=erzjkZI+DGRT6zoi9rV0vA+mGLWrYI03sWMAPDLGpJ7Sw6J5Hs/DvXrr1rD7NVMHNH
         pt9Xvm12kQ11iEpF2qCIcSOp05HwqiTPRwlH+XGtDnFkhFp+PqcRqQBwmR+6PiDpXKHq
         mZgOrNJDJxAh749qtk3yIIB8bWo6Kcz/NLoPsZuUMFJKqSlHn2Av5BtZeqmc7D1YCtxJ
         8U+odsMw+gnPRd7675Kc7anL2141fGMELf+swORXuodAwhN/P5SxW3uEL0guvojLOtqa
         TZZgGbhkih4y5Y0uE+vwUho0J0Eg6Q8KZPTNSt9WeTPsZ7EKfg+IfnnVy28U7TLSiIlZ
         oOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SpEjgGy4rjHRpz+jjkgyAFS5o92nCTSW2YdjHIiEESo=;
        b=mMjyw/zLi8ZPL1FKR4Bbp6bMPnSlguYJgs9fzWMxF4KRN9k3JmPI0mN3Myj+OcJvCT
         AuVYw8+tWgU2deQzHHHL3gVbqIASS3fMkHyDs2lTqzoIENUzP30WgVg0iip94qFfYDPK
         Egl2vTjZZLaU3zzGtN7NMG2K4DX5ViUKD7keIFb4Njjc739pq84Cd+N2mZ8VWtXZ08Vr
         Z4f96z7sWzbuPLrBCgsSdr1fOrQacaQuA++zBL6VNfeS/smz4PAIRVWPxT5v7zO6715z
         lrNbPcZoeUwZ2pETjyC8TufVMr3Sm6olU7qhlNfk2oYq94L2UhXGnP5wuJJ8pf9e14Gk
         eXbA==
X-Gm-Message-State: APjAAAUEqulfHM2GjJDOOEdXBaii2yfkP3yWGGsr/HmJIEPA24MGS049
        fX0/3TzMh/dHJC1OTUx42DIxuWa9gAnDk8ZrW7+kqME1nCUaqw==
X-Google-Smtp-Source: APXvYqyb60WPsXbtPqmVAAqQr76GOred6HmRjFW8hDrGzS3eb2mgMXp2Ecfo2mXJI1jQU1b5aO/YcGb7hQ6+Mgr4r+0=
X-Received: by 2002:a6b:8ed7:: with SMTP id q206mr36986308iod.120.1565783458395;
 Wed, 14 Aug 2019 04:50:58 -0700 (PDT)
MIME-Version: 1.0
From:   Bo Zhang <zhangbodut@gmail.com>
Date:   Wed, 14 Aug 2019 19:50:47 +0800
Message-ID: <CAO=KXnspgZa=R9=8wvPY-Y8pvuAah-D+Jc4CM_+cdemYGUJ09A@mail.gmail.com>
Subject: Potential asterisk expansion bug in Windows Git Bash?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

Not sure if this is the correct channel to submit a bug report for
Windows Git Bash. Please let me know if I did anything wrong.

Today I noticed that on Windows Git Bash, the asterisk (*) is
incorrectly expanded even when it=E2=80=99s in a quote or following a
backslash (\). I=E2=80=99m wondering if this is the correct behaviour (whic=
h
seems like to me NOT).

Step to reproduce (in Windows git bash):

zhb@zhb-PC MINGW64 ~/Desktop
$ bash --version
GNU bash, version 4.4.19(2)-release (x86_64-pc-msys)
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

zhb@zhb-PC MINGW64 ~/Desktop
$ cat 1.sh
echo $1

zhb@zhb-PC MINGW64 ~/Desktop
$ bash 1.sh '*'
$A 1.sh 1.txt

zhb@zhb-PC MINGW64 ~/Desktop
$ bash 1.sh "*"
$A 1.sh 1.txt

zhb@zhb-PC MINGW64 ~/Desktop
$ bash 1.sh \*
1.sh 1.txt

Thank you very much.

Regards,
Bo Zhang
