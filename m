Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA56B20401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbdF0UeQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:34:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34617 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbdF0UeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:34:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so3048283wmg.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9e/dbW6S03NxrAKyVPppsOC2fZy/h5Fhi/qcybLK0s=;
        b=bSdmWPZ7zfEY0X3Hw+3yKonWFG++PMJU54ttM2S/JqTLrHe4saDUi1ikHmYr+cxI12
         M3DDSbZ6G257K4eEaobV9GRebHgvWkObiRy9Jh9ShyqWQPWGlSE5zO2SSBZuQ/oYX1H4
         /QA/3Y3SVg+Az1MBvjBwWU0tdRBAMz1tVzCiCo0vcATapKtm8kWywkorAItfUUJme+Qf
         uBtyBcPoApU4C4mqVDDsvOEhr2iozfQRWlXneYcgDlsy9LvNp+i1EDR2AIBd+CsDbsgq
         Du6vUg1FY6ABte64PzekDPs/DJ8WEFWx3850fg4UlePeI6U0/gtI8qEYOHR7H/jWzAEF
         xp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9e/dbW6S03NxrAKyVPppsOC2fZy/h5Fhi/qcybLK0s=;
        b=jvNkmTzC0BVBT39Jz60PpDGt4nVKyfRggRCul7XhtALjzZGrfjTJeGm2n4C2wOjlhR
         a9xpCN8W5CiNHOM3jkJKKAYvqKfTu/As1Tt+RHzDmcRZelynSo7EuLbBUpx5++rGGaKz
         cyyczHuzrPe3thuxa7HvE7z0P4YtZpPMkpQqlEPeebXByh1rpunmVyIJqfGCbIrnbKjb
         nj4SwLHXN4Lzk6xVGKIHBEtY5qc3pa9k031/+OutXDWsoBtmdKP0VumJAQ8A2el/55gK
         Ea6KistmY5sZyGiV4qmtrXt15a34sEhqIGOMJnzMon1t2CdaQ3fbZ+Q67w7fSKa/YK+O
         PQKg==
X-Gm-Message-State: AKS2vOz9IIXQWPVzUW+CCjbiIWFDX/DVKErx1AgWBbVPB0PwYt2r+wUx
        7Bsyln9cO6QYXthXGgk=
X-Received: by 10.80.165.38 with SMTP id y35mr5134215edb.64.1498595637735;
        Tue, 27 Jun 2017 13:33:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a18sm104862edd.23.2017.06.27.13.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 13:33:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] update sha1dc from PR #36
Date:   Tue, 27 Jun 2017 20:33:45 +0000
Message-Id: <20170627203348.19827-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v2 addressing comments to the v1, tbdiff below. Just fixes the
subject line on 1/3 & gets rid of the redundant _BIG_ENDIAN detection
for Solaris, we can just use __sparc (and indeed we did before this).

Junio C Hamano (1):
  sha1collisiondetection: automatically enable when submodule is
    populated

Ævar Arnfjörð Bjarmason (2):
  sha1dc: correct endian detection for Solaris (and others?)
  sha1dc: optionally use sha1collisiondetection as a submodule

 .gitmodules            |  4 +++
 Makefile               | 16 +++++++++++
 hash.h                 |  4 +++
 sha1collisiondetection |  1 +
 sha1dc/sha1.c          | 73 +++++++++++++++++++++++++++++++++++++-------------
 5 files changed, 79 insertions(+), 19 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

    @@ -1,6 +1,6 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

    -    sha1dc: update from my PR #36
    +    sha1dc: correct endian detection for Solaris (and others?)

         Update sha1dc from my PR #36[1] which'll hopefully be integrated by
         upstream soon.
    @@ -96,22 +96,15 @@
     +
     +#if defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
     +/*
    -+ * As a last resort before we fall back on _BIG_ENDIAN or whatever
    -+ * else we're not 100% sure about below, we blacklist specific
    -+ * processors here. We could add more, see
    -+ * e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
    ++ * As a last resort before we do anything else we're not 100% sure
    ++ * about below, we blacklist specific processors here. We could add
    ++ * more, see e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
     + */
     +#else /* Not under GCC-alike or glibc or <processor whitelist>  or <processor blacklist> */
     +
    -+#ifdef _BIG_ENDIAN
    -+/*
    -+ * Solaris / illumos defines either _LITTLE_ENDIAN or _BIG_ENDIAN in
    -+ * <sys/isa_defs.h>.
    -+ */
    -+#define SHA1DC_BIGENDIAN
    -+#else
    ++/* We do nothing more here for now */
     +/*#error "Uncomment this to see if you fall through all the detection"*/
    -+#endif /* Big Endian because of _BIG_ENDIAN (Solaris)*/
    ++
     +#endif /* !SHA1DC_ON_INTEL_LIKE_PROCESSOR */
     +#endif /* Big Endian under whitelist of processors */
     +#endif /* Big Endian under glibc */
2: 63a5d0cb2a ! 2: 28750d3c24 sha1dc: optionally use sha1collisiondetection as a submodule
    @@ -79,4 +79,4 @@
     --- /dev/null
     +++ b/sha1collisiondetection
     @@
    -+Subproject commit 56ab30c4c998e1e7f3075705087a2f0c4c4202d7
    ++Subproject commit 9d3a0b3783afab335a1819543d039cf2980577bb


-- 
2.13.1.611.g7e3b11ae1

