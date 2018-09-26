Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B15A1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 06:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeIZNDi (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 09:03:38 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:34313 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIZNDi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 09:03:38 -0400
Received: by mail-yb1-f169.google.com with SMTP id 184-v6so10909722ybg.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VbW3oxelilY3sGslGcU+1syihWYMGPJVEl+xvkIv0xM=;
        b=aeCXFcmmXe0kTl0WuCwhRYZ/x9IFnsqruQXP8iuQ5G3KzrGhuh+/zR0y0NFB6yIUOc
         /ujTdvzhxGc11xPHDwmLbabw+rhTz/JNNFRBYVWpYY9Qy2OpLuvlmSU1soMIRO3rDVaD
         wSJbEpWG7HB3uEylGYoLXwpUn134lkycCXOWWIqFdtJFwdoYyQCsjmojeDyTMmtxalDx
         Gvlgc5/kLAtMvAK9ylSi0bKqbuZhDbhjnHtQBbXME7pb+fxrn1gSODrsryae+YtmlvvS
         waw/tRLv1Djpzi3cN+2DuYj4BPYoyeZY8lF0zc65oIJPQcXR+e61+dSi3/1khgzGJDr7
         avOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VbW3oxelilY3sGslGcU+1syihWYMGPJVEl+xvkIv0xM=;
        b=QQpAQxbTu/rOZc6aK6FzgOBbDdYq9hKqiERvkJC/5TCs5LoNOBgS0aaWATAPCKHyeA
         XPvrPaeLfwpSkbyIGA9EyWVK2IVJlqFG20oQjto04vmYZO4BJEBBfbYYzvhk7PUlb63w
         SBzRzbqq/LiZ0A8ogjlHKINjK1obpKqdHGhSNP98Na38G8qdv/9oNl3Isamb2OlD/wNa
         3lsMv7wKI4IOW6B0iZjYGsfBHuXSvLUdMu+8CHk+VzsNF9tspR0MwCJx+4Q2VGYBj1lb
         H2DlY+RBPesA/cQS90Oau3n3Ed7bHBgc5P/XxaIKFKSBziH/c62vUy5XnHn8qM+sz1XK
         523A==
X-Gm-Message-State: ABuFfojqbkCeS4p/bmC2qrOLsSkQ8fKE/porQLuChXsvTKh675o6TCFI
        Cx9DnXQMJuqp4/EIEclovKAAyMO3gfrb7T12f200yQrhKIU=
X-Google-Smtp-Source: ACcGV61N58kgjcnEDgU4iPCesJp1ijAaAGIgHw0K2xAtntyjkilhmqbelbcm43tAIllIgTqXlVdOQXL1rWTxdaBXmiQ=
X-Received: by 2002:a25:bdcd:: with SMTP id g13-v6mr2348062ybk.253.1537944732795;
 Tue, 25 Sep 2018 23:52:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:248c:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 23:52:12
 -0700 (PDT)
From:   Alexander Pyhalov <apyhalov@gmail.com>
Date:   Wed, 26 Sep 2018 09:52:12 +0300
Message-ID: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
Subject: t7005-editor.sh failure
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007b9bfe0576c0a9b6"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000007b9bfe0576c0a9b6
Content-Type: text/plain; charset="UTF-8"

On updating git to 2.19 we've suddenly got t7005-editor.sh test failures.
The issue seems to be that generated "e space.sh" file can't handle
files with spaces.
Instead of 'echo space >$1' it should be 'echo space > "$1"' or git
editor fails when gets file with spaces in name.

The patch is simple:



-- 
Best regards,
Alexander Pyhalov,
system administrator of Southern Federal University IT department

--0000000000007b9bfe0576c0a9b6
Content-Type: text/x-patch; charset="US-ASCII"; name="0005-t7005-editor.sh.patch"
Content-Disposition: attachment; filename="0005-t7005-editor.sh.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jmisj5sa0

LS0tIGdpdC0yLjE5LjAvdC90NzAwNS1lZGl0b3Iuc2gufjF+CU1vbiBTZXAgMTAgMjE6Mzk6MTMg
MjAxOAorKysgZ2l0LTIuMTkuMC90L3Q3MDA1LWVkaXRvci5zaAlXZWQgU2VwIDI2IDA5OjQxOjMw
IDIwMTgKQEAgLTExMiw3ICsxMTIsNyBAQAogZG9uZQogCiB0ZXN0X2V4cGVjdF9zdWNjZXNzICdl
ZGl0b3Igd2l0aCBhIHNwYWNlJyAnCi0JZWNobyAiZWNobyBzcGFjZSA+XCQxIiA+ImUgc3BhY2Uu
c2giICYmCisJZWNobyAiZWNobyBzcGFjZSA+IFwiXCQxXCIiID4gImUgc3BhY2Uuc2giICYmCiAJ
Y2htb2QgYSt4ICJlIHNwYWNlLnNoIiAmJgogCUdJVF9FRElUT1I9Ii4vZVwgc3BhY2Uuc2giIGdp
dCBjb21taXQgLS1hbWVuZCAmJgogCXRlc3Qgc3BhY2UgPSAiJChnaXQgc2hvdyAtcyAtLXByZXR0
eT1mb3JtYXQ6JXMpIgo=
--0000000000007b9bfe0576c0a9b6--
