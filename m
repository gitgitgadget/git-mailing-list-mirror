Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C011C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47542074D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JwLYFyux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCWRKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:10:01 -0400
Received: from mout.web.de ([212.227.17.11]:54615 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgCWRKA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 13:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584983398;
        bh=eewUwcp4SmaVsbGsLv0inKmeBqIcK9Ja4SHVtqwqkX0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JwLYFyux95AuBgH0YguXRhStl5Z1EFWhy5Dw+lFTH5V1EqMR4yzXYEq9t6RAv72Uj
         rC5VN8YSH1i8XT5qQeSMPW3pPIiQtchNvXyjFxoU6qAlju8tWizVHe70paUNan/0+b
         OrnMGDjITAfl7aEuvquB9FeNJpEIskdNyPRz7gZ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvBMs-1jPXTI3EJe-010IGT; Mon, 23
 Mar 2020 18:09:58 +0100
Subject: Re: [PATCH] import-tars: ignore the global PAX header
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fce519db-5ad4-270f-abcf-0e26549486cb@web.de>
Date:   Mon, 23 Mar 2020 18:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JvWjJDMQnwu90Rtsaz6KYDdYYwqTVSDt7teLSpXjgNooTyxbdpZ
 dj0QgtgTbnoznhdoz2WW/hVL+4P6mXgu/tyDKEKlypggXbFkTUpZQMUhEAg/sfvb78xU3Lb
 W7jCTsrYerqdp53vjQzGmxt1paMonx7R14T3JkndscK7IrgPpkaF0IqQllkuGNlKylwkUYs
 zP80uiMcp2AVcn65Ld0QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YAmas6+ZuPs=:otbkkPR2ca6J+BisOP+x/V
 Yjdm2sNypqOtK7RTwlgD2ah2HE/seu78T6DoI0y6KIeGZaOgxAmtWUszRdc40fZdGzKn0jbJh
 uc4Iy6pSLpOFBmX+tCSXWDclFFaald8uVwbeo1agrWTHDmqTnUf8+AAcfCsriL6HyDlXYuwlr
 3Vvs0v++RVB4bgZDVV0D+z1Uky5KJzbbnJlgW0pg8rw+Fq8qVGZqP6dsxkJZr4TYw1q2mgliz
 hPZwcjucBQs0+SWcINBbQ/7DM2fHe6cuhLy2HEARidMwL+uYuTHsXw+v83tEFAhUuEkKV1VUu
 jdNAMqBoMPmBlj9O0F+HjJe+iadKCxxB1q6mtotVOth1Iz7lD7UI1EavsDuYLOtWZGB/DnOY2
 vg9igYBzmGmu9oOifVnDXx9rmNnJ5BK7vDO31A6C/JbVFEiXqPLznqi2vYvV4Cb1I0ssZ0DIQ
 F34E8e/hQJwm4mybypvXqD2CCxJ76i0bp7akhAUYcT9HfeLpORk2r87VV3ed109rwN4obScJG
 A8zEbeKq7/+4yPli18BThvk/nedJ6h5ZNkfjZHROtcjIrudMIbWFQDQxnL87De2a5s+2yt/Qr
 x3PulQHyobuTrYIOBvsRDUf+ZGJEKZbfIQcwmON+wRbnVbRsjk9nno5uChP6t6TS+QYEwKTI3
 tLjpFCF5NOnlQUBMZicfySNUk/focrOQcOgTfN4tagK/u/N2uzb/ODiP5O3ta1ph1rzp2XMlp
 wrR28gnjB2KcXVv1m7l18U32Mw5Q05D9dm4WEJcydOoGykynonqBbcVxO9CyjSGmnz27u12/U
 CZ9oOtxe6/X+Of1JKoZm39oq6I5/oH49tI0lvKLuC3oA6RDX1Rk8sIea/kTCiOVRcMziPdWb/
 Xt7kDZkCvh2F71+cB0fFUi7va1+JJ9diVKBfEaTZfrDJU+t2OPPmXnix9hB9zIAthoXxWxdY8
 xXZfu8QJLRMNHmUPkdww3SXfjCvvhQef8MUJwqm78IrLFeoB+fZEkpreEouRL9AJMhhVv+Nrr
 0eG/35gruid/NmpabHGBC7K+0oSFRFi03sbilcbBNIBumGB7Oe0AOanPV1WL6MSGyCjzkERGR
 01Ffr7/UNNmCDjpJR1CqDlvsB755EqSE62hBtxFbJkeQklFz0eS1Rn9Yp+p647IqHcnlnOe1W
 Rz9jJHiQr35Yz4+jwKAi4dh1R5W9aj7rr31C5dSJq63ZocjFnEfcBXLjmvE7PL82h4StQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.03.20 um 14:08 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Git's own `git archive` inserts that header, but it often gets into the
> way of `import-tars.perl` e.g. when a prefix was specified (for example
> via `--prefix=3Dmy-project-1.0.0/`, or when downloading a `.tar.gz` from
> GitHub releases): this prefix _should_ be stripped.
>
> Let's just skip it.

git archive uses a global pax header to pass the ID of the archived
commit as a comment, and for mtime values after 2242-03-16.  Ignoring it
in a simple importer seems reasonable for now, but I don't understand
how this relates to prefixes.  Is it because the header is treated as a
regular file with the full path "pax_global_header" (independently from
any prefix for actual files) and can thus be placed outside the expected
destination directory?

Thanks,
Ren=C3=A9
