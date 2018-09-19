Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847B11F453
	for <e@80x24.org>; Wed, 19 Sep 2018 14:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbeIST47 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 15:56:59 -0400
Received: from st14p37im-asmtp002.me.com ([17.41.209.31]:43981 "EHLO
        st14p37im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731815AbeIST47 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 15:56:59 -0400
Received: from process-dkim-sign-daemon.st14p37im-asmtp002.me.com by
 st14p37im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) id <0PFB005003MUVX00@st14p37im-asmtp002.me.com> for
 git@vger.kernel.org; Wed, 19 Sep 2018 14:18:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1537366731;  bh=aPDawEZuN2lprUoPwLpiCqRBGAJ2pwAm3TyF+r22Rck=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=sME2bDrHst/c0PLyxCBEMFoNQVryK65QvnsNL017dfjUq6bEvW9L3q6WMbJd3k54e
 23BLobZDWbmRyJSW5v/7/WY2fAUeMQrzkb/RitrL0D66ZXJaUy/ODgc2kTQNVPuhIc
 UazcXolDowYQBmKFZMY5uwT3qDe6o9Dc9MokwbC5S3Q8QJ/u52B0/zteDOi+i9QEzQ
 BS0B8c+1MTdx05E5JcM0QA4ifX9kyNeDocffLgQIAw5y9lldAnGg9zoT2zspEihIrL
 9rNFBitgzGuigs1/iMdbYjatZFVMV7zxMXoi1586awmFhVK/mJ6Oxgs5gGTSQeBpzZ
 DG+7IUfADF7oQ==
Received: from icloud.com ([127.0.0.1]) by st14p37im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) with ESMTPSA id <0PFB00GXB3RCRH00@st14p37im-asmtp002.me.com> for
 git@vger.kernel.org; Wed, 19 Sep 2018 14:18:50 +0000 (GMT)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=2 suspectscore=1
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=2 clxscore=1015 mlxscore=2
 mlxlogscore=173 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809190144
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-09-19_08:,, signatures=0
From:   Vasily Korytov <vasily.korytov@icloud.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Git 2.19 ignores default system language in Mac (2.18 or earlier did
 not)
Message-id: <1B4739BD-812E-43E7-B7E6-D6B9CD0D0B3A@icloud.com>
Date:   Wed, 19 Sep 2018 17:18:47 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

$ locale
LANG=3D
LC_COLLATE=3D"C"
LC_CTYPE=3D"UTF-8"
LC_MESSAGES=3D"C"
LC_MONETARY=3D"C"
LC_NUMERIC=3D"C"
LC_TIME=3D"C"
LC_ALL=3D
$ uname -mrs
Darwin 16.7.0 x86_64
$ git --version
git version 2.19.0

In Mac=E2=80=99s system preferences I have three languages: English =
(default), Russian, Ukrainian.

After update to Git 2.19 Git=E2=80=99s output suddenly appeared in =
Russian.
I can use `export LANG=3Den_US.UTF-8` to switch it to English back, but =
it=E2=80=99s very weird.

Did not find any related things in changelog, so assuming this is a bug.=
