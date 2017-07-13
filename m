Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB3F2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdGMXsV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:48:21 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33230 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdGMXsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 19:48:20 -0400
Received: by mail-lf0-f54.google.com with SMTP id z78so45287289lff.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 16:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WCMrQDTAD9CR3vyfSWVzOtjsis9UZD3+D4cwGGQn59o=;
        b=geCNOoIQ6PyQRiQ38Yvu6Md4YdwrrucNXX6wXvt3opTr1f0eM77X3p9rz5wEaT3SQu
         LHyvcT+Myq5i+B30d6kNjoDvdRvqB+s96j3vQZIM+EbvaAjZ2VPqTipVp6xd57sU8pUV
         hUTcT3b9A19JnDx5Z1AWDf1Hpas7kExnUarNPvmKYoj9sw0LtjaXBT0RhEqH/VbriDer
         gTaHhmtXEU9CtQjG426T7wS/EzhMlSnHkXlObXbeCKLPJlOIVmcFozRCMIgLnt1sZv3s
         f7ggtOpqMKkHniPwyZXMvhuiahE+b926x/BG1dUz2HWf3A4M5Eqy98umde6NvpG1jRWa
         46YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WCMrQDTAD9CR3vyfSWVzOtjsis9UZD3+D4cwGGQn59o=;
        b=Yf1B8UqZwRmn/itqa6UrAv876trZWSWZYSCnsQAhTzFyvfWUDkFrfwAjEsqRgTXc+9
         LvULHwm/qG9qaJXKpBUgyPW1TREGzit7CSPmLbpDh3eyqu7gilqd0S7nPxv0zspwUXIb
         B1GqMkOLKG5BNNtz5xLylwzQ7BpD4gacm2F8ecsvkXsG+4Jix5CanV2beMyVg+ElwVX4
         Bc7O8SOWShNAXQDcFPGg94AlkdXpbbZJbpk8PdWZLkaIIzflH9pt/Jb6PAmxqq7xYmpb
         lde/HCUOjMmNMIbLTuzNuBr2exTjtt8XATa7jAQKDZ04MCCUL0WFnJMx2ZfiIrGJ/jvY
         Nsxg==
X-Gm-Message-State: AIVw112eBRzq9QF0WdQx4jmDT9eApOyvDEhvTBC63L2gDE4kTPGDhIUs
        IFXhchMhhBxTFNhTOUwrOjO8u4t4N1gdiHE=
X-Received: by 10.25.79.9 with SMTP id d9mr2299259lfb.133.1499989698650; Thu,
 13 Jul 2017 16:48:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.83.7 with HTTP; Thu, 13 Jul 2017 16:48:18 -0700 (PDT)
From:   Ben Reed <benvreed@gmail.com>
Date:   Thu, 13 Jul 2017 18:48:18 -0500
Message-ID: <CAEAWK2Nso0uFnn29B6=m=iV6-HjAEFTrrUg+b+7QzRhQ8TpZ6g@mail.gmail.com>
Subject: Strange behavior with Git add -p in version 2.13.3
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I updated Git to 2.13.3, and now selecting 's' to split a
change on a call to `git add -p` is not working. It's showing the list
of options as if 's' is not a valid choice...

Particularly, I'm getting...
Stage this hunk [y,n,q,a,d,/,e,?]? s
y - stage this hunk
n - do not stage this hunk
q - quit; do not stage this hunk or any of the remaining ones
a - stage this hunk and all later hunks in the file
d - do not stage this hunk or any of the later hunks in the file
g - select a hunk to go to
/ - search for a hunk matching the given regex
j - leave this hunk undecided, see next undecided hunk
J - leave this hunk undecided, see next hunk
k - leave this hunk undecided, see previous undecided hunk
K - leave this hunk undecided, see previous hunk
s - split the current hunk into smaller hunks
e - manually edit the current hunk
? - print help

Is anyone else having this problem? Does anybody know how to resolve
it? I'm running on macOS Version 10.12.5.

Thanks in advance!

-Ben
