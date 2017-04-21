Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE7C41FAA1
	for <e@80x24.org>; Fri, 21 Apr 2017 21:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1042053AbdDUVIe (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 17:08:34 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:37286 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041425AbdDUVIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 17:08:32 -0400
Received: by mail-it0-f50.google.com with SMTP id a140so739048ita.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackthorn-media.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=hV2K46VFDshzj5GZGnol/ezkfobcpJb8GXw96+5GWRc=;
        b=l1VnSbX1mWkDIJ6PgL5vgwCb8hASeh1UPi/aqHkHIi09BBQRW5pLP9k3bJTjJidBOy
         1IytMp1lvi+uofKp1YRkMUhZjJzVVa9JNpcR150gCjHqohmLSzax6noihTfF19V/Mqf6
         D+mn/d0ER1JbSlbTfZu8i5LE19OIwT8BEY4ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=hV2K46VFDshzj5GZGnol/ezkfobcpJb8GXw96+5GWRc=;
        b=nhSO476mP/55pVSgFx176DqFsB7sWLnw5TwBcpBl542Fwb9wNjwzxpilG4OFodUHBD
         KDswZ6lRZgkguuQK0ZEHP2EzurwdcIbsobi7Nr6w7sNou07xwRJchZHzHEUn4MbNDkl8
         8Mt9BaDtme64bvbymGKZPLoQIx5gzbooPqsKIHVApUTjRJqvf7xtDPtBBJltJZ+5xrfE
         HEFH8aEufD/wh5ch6tVGddtlBj+bEN5NCCgIBO6WnaTyW2JD5zaG+d3VHIPToiI3KYhJ
         ySM6WQ1BbTNUJUjVxiPl9faQSrB0JadqCfoTsXqCWeiL9y5cw61FA8shLByksUT6qSrY
         gLOw==
X-Gm-Message-State: AN3rC/71BYZ3IHU/Kxhp5xFKsh+qj0afyHUCO4CmduuAVuCwHizVdUXE
        Fc4/Lah2wd6raxO7TIez1w==
X-Received: by 10.99.167.71 with SMTP id w7mr14180697pgo.138.1492808910687;
        Fri, 21 Apr 2017 14:08:30 -0700 (PDT)
Received: from [10.10.2.117] ([38.88.196.250])
        by smtp.gmail.com with ESMTPSA id s136sm17630716pfs.70.2017.04.21.14.08.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Apr 2017 14:08:30 -0700 (PDT)
From:   Keith Goldfarb <keith@blackthorn-media.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Git archive doesn't fully support zip64
Message-Id: <3C736801-6BB8-41CC-88FF-C42FC853A736@blackthorn-media.com>
Date:   Fri, 21 Apr 2017 14:08:28 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git,

git archive, when writing a zip file, has a silent 4GB file size limit =
(on the inputs as well as the output), as it doesn=E2=80=99t fully =
support zip64.

Although a zip archive written by git which is larger than 4GB can be =
often still be unzipped, it won=E2=80=99t be fully useable and some =
tools (e.g. zipdetails) can=E2=80=99t read it at all.

I suggest either git should be changed to fully support zip64 or it =
should give a proper error when either an input or the output is too =
large.

Thanks,

K.


