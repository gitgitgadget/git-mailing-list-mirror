Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E06D1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeFGOE4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:56 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43318 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932774AbeFGODp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:45 -0400
Received: by mail-qt0-f195.google.com with SMTP id y89-v6so9922166qtd.10
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AVDMtIHfkl3f8MU9C45gUIJDFYqSW2nJqKkp/gZMFDA=;
        b=uxRaMfeLDkeOTVLc6D9Qr+Dn6qYvxPtLl+NRzIqzKkN/aL+uEScAe6oPopyXlbaM8R
         pQP2L7eE+IZ10VijCKu1dYqDF+KgKpmyy66o/Tsxrubkux1VtfhB3Zycd7W3oUYYj1e8
         j23QE/zt1sTdf0w7vyFoyM/13Q2HhR8jxrDDnIIv8CxP6el2mvvmFkz74zm73U3SaAdI
         1M6Sm2KxGlwQQXRzyGy+daHBgkrdlu3FpDhecJZRcNyGaFYq9lkst0nkXxX/cPGRjNZ1
         mdfVJc91sHP3t6jucY8szmD3i+9jC/Km3Jeaxs0zqNeckm4paouOcsff0jnT0H4+uDuD
         9LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AVDMtIHfkl3f8MU9C45gUIJDFYqSW2nJqKkp/gZMFDA=;
        b=sD66u0lSYn7yGOHDLALsdS+JYb3sT0r/ryaFQbt8kwSkbY6ReQjG8cfqQZFmGlceXa
         DnUhEhnsdydrc9p3RSNBdb8e873I87oZkQbu8Z5ArKYm2Szc9DxRRGpVew135tcNb9P6
         8xsKHxX1Vd2PG3DNaro6XC/eOPSZVxj9/WlLgpQnO4dkbd+CRZDeQhQ8DZLpfGPjB1ks
         df9K96aCuFY7q+JhyT/GOtnIXCCCpEiWAaPa6AxeUttOa4nbi3cOc5hCxhMjHRnI6wgi
         GCH9+jSKREdtXIugp6sFweN+XJb96JBhbFdw82hXYOE9f351ZC+ncNIHnAb5h5/Htjmo
         5UHg==
X-Gm-Message-State: APt69E3zZO3iqIDj3YY0VhDzeuRkRNEm/2Gx0VmAxSNB5UOVRSF0iyEJ
        PxzaAQN2l4v3vGa6CS1HWiNtEHrS
X-Google-Smtp-Source: ADUXVKLJj/ktPxpzHPAibNerx8SB59V8SEKa8zk9i9DPxLDfQh8l2FcmwOlNIdllsvTcvb+nLCGSjQ==
X-Received: by 2002:a0c:ad69:: with SMTP id v38-v6mr1731237qvc.120.1528380224888;
        Thu, 07 Jun 2018 07:03:44 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:44 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 02/23] midx: add midx format details to pack-format.txt
Date:   Thu,  7 Jun 2018 10:03:17 -0400
Message-Id: <20180607140338.32440-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index (MIDX) feature generalizes the existing pack-
index (IDX) feature by indexing objects across multiple pack-files.

Describe the basic file format, using a 12-byte header followed by
a lookup table for a list of "chunks" which will be described later.
The file ends with a footer containing a checksum using the hash
algorithm.

The header allows later versions to create breaking changes by
advancing the version number. We can also change the hash algorithm
using a different version value.

We will add the individual chunk format information as we introduce
the code that writes that information.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt | 49 +++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 70a99fd142..17666b4bfc 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -252,3 +252,52 @@ Pack file entry: <+
     corresponding packfile.
 
     20-byte SHA-1-checksum of all of the above.
+
+== midx-*.midx files have the following format:
+
+The meta-index files refer to multiple pack-files and loose objects.
+
+In order to allow extensions that add extra data to the MIDX, we organize
+the body into "chunks" and provide a lookup table at the beginning of the
+body. The header includes certain length values, such as the number of packs,
+the number of base MIDX files, hash lengths and types.
+
+All 4-byte numbers are in network order.
+
+HEADER:
+
+	4-byte signature:
+	    The signature is: {'M', 'I', 'D', 'X'}
+
+	1-byte version number:
+	    Git only writes or recognizes version 1
+
+	1-byte Object Id Version
+	    Git only writes or recognizes verion 1 (SHA-1)
+
+	1-byte number (C) of "chunks"
+
+	1-byte number (I) of base multi-pack-index files:
+	    This value is currently always zero.
+
+	4-byte number (P) of pack files
+
+CHUNK LOOKUP:
+
+	(C + 1) * 12 bytes providing the chunk offsets:
+	    First 4 bytes describe chunk id. Value 0 is a terminating label.
+	    Other 8 bytes provide offset in current file for chunk to start.
+	    (Chunks are provided in file-order, so you can infer the length
+	    using the next chunk position if necessary.)
+
+	The remaining data in the body is described one chunk at a time, and
+	these chunks may be given in any order. Chunks are required unless
+	otherwise specified.
+
+CHUNK DATA:
+
+	(This section intentionally left incomplete.)
+
+TRAILER:
+
+	H-byte HASH-checksum of all of the above.
-- 
2.18.0.rc1

