Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393D62090A
	for <e@80x24.org>; Mon, 20 Mar 2017 20:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756229AbdCTUTL (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 16:19:11 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34454 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756048AbdCTUTI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 16:19:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id x35so18911224qtc.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=ZtMyZZ/4OVM/kQmuOF4H4WGx9dRUhlt+zV3HBPcDHT4=;
        b=XOyueZ0ixcQerlPU3k81dn8Z5C29aOvWJ0LNJtqKSO3EDwaOFEWKzDcflPEH1OV/ZW
         dZSKcy3B6/HULvrSpiA3Ivr+gisjEGLAxBtdGWeI+hyHUpzlsGCnOzFrRNb5UH9C6bhJ
         h3P3eKw9JsMAN83wE7swAoPSLyby1CtKN4NGFifHFsKEi2Z+rKPk8pYzqHOut8MGjLXE
         xt+TF/+zAFq5k2F3RboW+K27GVge85zDKtvcx3oTqx8oWeC8xJlNtfCC22IyFk7LEqV9
         JLbNTKHrEptvKver67Y+WtP09lRrgRfOnZPGnYkzRrp6js3WXRCtR3ZfoIhg32v0BPDR
         wEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=ZtMyZZ/4OVM/kQmuOF4H4WGx9dRUhlt+zV3HBPcDHT4=;
        b=CB0YuV0UxSw+nYNqm89gcej5GsD47/V1lQ4Q1/iBwe6Hc5TrDJtnkGRk9AoM2N22NH
         g6NgvF43w2hGk+yY3aZHyVx+/ok5vzlkcIT7Y0ZlvjRA7Y84BhfMKENGQxBOG/ioCWop
         D4qpc9PN3R6E47BKcEWVVXXwpPMfLjNruUSc99HT/cuqIMuIV5xkKYvnEkihHqxuAgdN
         maDGu+A6aLfUV4bX0nz08ruUJa58Ccf4bujIS0Ku9Wip2O5l5uz7UNj5VUVgxkualVKj
         7/1YuY6x/XtuRSgYL4LUc8sdSapocDLqWiAyLrzhUHpoF7/ZTu2QctvzubwLmP+mfhAx
         X3dA==
X-Gm-Message-State: AFeK/H2GBSouI/sDlcoeYl5e36WpmpuIihKnWuUPvqfednjZgURz+hgHVZi7+pPjkkWSnA==
X-Received: by 10.200.51.92 with SMTP id u28mr30622083qta.151.1490041101124;
        Mon, 20 Mar 2017 13:18:21 -0700 (PDT)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id n84sm13155787qki.42.2017.03.20.13.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Mar 2017 13:18:20 -0700 (PDT)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'git'" <git@vger.kernel.org>
Cc:     "Jeff Hostetler \(jeffhost@microsoft.com\)" 
        <Jeff.Hostetler@microsoft.com>,
        "Ben Peart" <benpeart@microsoft.com>
Subject: Safe to use stdatomic.h?
Date:   Mon, 20 Mar 2017 16:18:20 -0400
Message-ID: <000801d2a1b7$1ec41620$5c4c4260$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdKhtiqZ4jbgVZRzQeeUIKbnh6RzBA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My college Jeff is working on a patch series to further parallelize the
loading of the index.  As part of that patch, it would be nice to use the
atomic_fetch_add function as that would be more efficient than creating a
mutex simply to protect a variable so that it can be incremented.  I haven't
seen any use of atomics yet in Git, nor anything that includes
<stdatomic.h>.

GCC has supported them since 4.9 and Clang has supported them by default
since 3.3.  Are there any compilers currently in use by Git that don't
support these C11 functions?

Thanks,

Ben


