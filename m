Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04531F453
	for <e@80x24.org>; Fri,  2 Nov 2018 02:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeKBLgA (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 07:36:00 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:34853 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKBLgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 07:36:00 -0400
Received: by mail-io1-f46.google.com with SMTP id 79-v6so370260iou.2
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/Vxrpke9pUyqQTAlZf9kdVmsZVP4bErW53/WOD0dC/I=;
        b=U+h2G3fOsAuX/QnSlgAUaDxBrXUiscYZqJYQra17590/TMGP2RSlzqsgkBZjdN5k++
         Q6yCZZKgnBOQEkT+dZ62+3icaUGxf19rBOfjHIqK2M0FTAWIMfX3DDJdCzMuLyxali+k
         Awxu8xwngCwYkmexcI+jYzpFDXaplyOa/pn42/h0mqUdxGC71aoaHblbFMt8KQkuCp7Q
         ZcQyLDQ4YonvK0X1L4wRrEfqyMagpu0Fgwu4YGrDxUKLkLMGubykKYY0zQQJJqJRx5Za
         YlS6cKGLHUImx1n8VNqV766amSiWwF68T45IY1DZ/h9Wrl2GWnPzS5VXI+P8/Ptleqak
         PIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/Vxrpke9pUyqQTAlZf9kdVmsZVP4bErW53/WOD0dC/I=;
        b=prd0Yq5GtsGJjIHj5cewUErgOd+ULXr92w7E9PXKck/9rnDS5/II7iayxDfVjgn1A0
         ec7whF6/qRjFmtArw+DE9O4m1PUqqoWBxIbxMKzclQuSPPPh2/NFxrQ5Z6wjg/8SPJV2
         VMKZGIACEkk52DyrS4h+ur2hSCV76bNWHbe4DKHpiaAhhzBWnkhdmZs9CL64KK4c3hp5
         OyRtvKwsL8QZklZJt1SdhbVaYrGEThCdcybwA/r4r3hf1IcNXzFGX6RBLNtQkKjwyyRH
         de+yWmsK4Gpfm16K374T0zB1gk7uxDxAL0Hd8RCzCOeXdiP09COoBFmn7DsuMixT7CUj
         6Wvw==
X-Gm-Message-State: AGRZ1gJrIAUfvZTMIR8MGGvnf4EduVLTzaWJ5DZZbS+7UjDDnHeW/uYx
        c99lSRlozQ6DaX+ceFvalTfXvF/vyhsGJ+GPAlmak7Dl
X-Google-Smtp-Source: AJdET5esjD5N1O19JUsRw7maV7qZk2PQWz86Iuf34zZol8ZuL72oPLLFQ8Jv9e24HRvHd7TOELIofja/OVNNiZIdKw4=
X-Received: by 2002:a6b:7f4d:: with SMTP id m13-v6mr7344613ioq.16.1541125831673;
 Thu, 01 Nov 2018 19:30:31 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Adri=C3=A1n_Gimeno_Balaguer?= <adrigibal@gmail.com>
Date:   Fri, 2 Nov 2018 03:30:17 +0100
Message-ID: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
Subject: git-rebase is ignoring working-tree-encoding
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I=E2=80=99m attempting to perform fixups via git-rebase of UTF-16 LE files
(the project I=E2=80=99m working on requires that exact encoding on certain
files). When the rebase is complete, Git changes that file=E2=80=99s encodi=
ng
to UTF-16 BE. I have been using the newer working-tree-encoding
attribute in .gitattributes. I=E2=80=99m using Git for Windows.

$ git version
git version 2.19.1.windows.1

Here is a sample UTF-16 LE file (with BOM and LF endings) with
following atributes in .gitattributes:

test.txt eol=3Dlf -text working-tree-encoding=3DUTF-16

I put eol=3Dlf and -text to tell Git to not change the encoding of the
file on checkout, but that doesn=E2=80=99t even help. Asides, the newer
working-tree-encoding allows me to view human-readable diffs of that
file (in GitHub Desktop and Git Bash). Now, note that doing for
example consecutive commits to the same file does not affect the
UTF-16 LE encoding. And before I discovered this attribute, the whole
thing was even worse when squash/fixup rebasing, as Git would modify
the file with Chinese characters (when manually setting it as text via
.gitattributes).

So, again the problem with the exposed .gitattributes line is that
after fixup rebasing, UTF-16 LE files encoding change to UTF-16 BE.

For long, I have been working with the involved UTF-16 LE files set as
binary via .gitattributes (e.g. =E2=80=9Ctest.txt binary=E2=80=9D), so that=
 Git would
not modify the file encoding, but this doesn=E2=80=99t allow me to view the
diffs upon changes in GitHub Desktop, which I want (and neither via
git diff).
