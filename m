Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1FC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiGUJH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiGUJH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:07:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D83D3B944
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:07:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk26so1295666wrb.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x0G9glQuHcJf+jgw3eIAa/Hm7oJujcP/0wQq0zpT66w=;
        b=S6I6mh69hTn3YuFGp9j+h5vwX/5OedK+bv0+cxi5W/hTBTWEjfc+f6cRC9hQwC3W99
         iezCS81NJiZmblD5mRe12ftunx6R+Cp2qi9MXXWj+zvYx4h4GiqPcBf0FyciNygMM24T
         86oI9cT7Bv6zju9IDrFze2lb995fIbkLAtKKe/u752BCDreGVk9bcXUhOKnsZkESiGxG
         KHp+bdN52EDPmLCpBQU6Deq9EBUSU0sHj2Dk716qq0OiJ/6WfAFJgSHouOJXXyIuBAdp
         H769Fx90oT1K70MeL7dmX//9lTRcsE0Ibb4gpxfwhobIcEVnjwTLhj8fiBrRGnQIxeoK
         WljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x0G9glQuHcJf+jgw3eIAa/Hm7oJujcP/0wQq0zpT66w=;
        b=p5x/WaiHEOaFPqIkWqcWjYTwNyhsQuCzVVj8F0sGfq+kRBW7ngQeE6/F9oO4T0HaEQ
         TK/2NQsIMivWPQXWWAgu1HifecFQWoJRo2muVjOTYK17SyYv5BC8RaIvYTxDXRb+NBBL
         w3kJaTrwSubD9Joip3fyad86lIg97tkTwZBt/mjcrG+7Vpor7O/Go+csTMLrlx5yzEQi
         VJ6Kvy084YL2oiNwkutINkbrDviztfww7AxtKpwj8JdQZJXvvXLRu+1brpJNA6FKkvdx
         AyWcZA+LLHRUugYXY5bwSxSonIBb1dnGRsQNAcnlb7mEDRAyvc3uwz+D/h751M6mSNKO
         qa7w==
X-Gm-Message-State: AJIora87R7gQAu+lE1BmRLLk6GTi0XYLeSHXRAxXr/WyzDv+22+DkrfT
        H8njmlM/Dm3DbdajHHfLct1CKboc1xg=
X-Google-Smtp-Source: AGRyM1vVWKNQVkY8yvM5Yih5EHmnRw8DRP7kSBEstzmJEplWDclV/w0EC273PMKgD5iIfwXSh/NGmg==
X-Received: by 2002:a05:6000:1f0b:b0:21d:6dae:7d04 with SMTP id bv11-20020a0560001f0b00b0021d6dae7d04mr34027588wrb.414.1658394443656;
        Thu, 21 Jul 2022 02:07:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm1258958wrf.84.2022.07.21.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 02:07:22 -0700 (PDT)
Message-Id: <87e7809b75acedc5f099bf79c6d3544e06fe2c61.1658394440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1285.v3.git.git.1658394440.gitgitgadget@gmail.com>
References: <pull.1285.v2.git.git.1658134679233.gitgitgadget@gmail.com>
        <pull.1285.v3.git.git.1658394440.gitgitgadget@gmail.com>
From:   "Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:07:19 +0000
Subject: [PATCH v3 1/2] git-p4: fix bug with encoding of p4 client name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Kilian Kilger <kkilger@gmail.com>,
        Kilian Kilger <kilian.kilger@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kilian Kilger <kilian.kilger@sap.com>

The Perforce client name can contain arbitrary characters
which do not decode to UTF-8. Use the fallback strategy
implemented in metadata_stream_to_writable_bytes() also
for the client name.

Signed-off-by: Kilian Kilger <kkilger@gmail.com>
Reviewed-by: Tao Klerks <tao@klerks.biz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-p4.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8fbf6eb1fe3..e65d6a2b0e1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -854,12 +854,12 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if bytes is not str:
                 # Decode unmarshalled dict to use str keys and values, except for:
                 #   - `data` which may contain arbitrary binary data
-                #   - `desc` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
+                #   - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
                 #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
                 decoded_entry = {}
                 for key, value in entry.items():
                     key = key.decode()
-                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile') or key.startswith('depotFile')):
+                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile', 'client') or key.startswith('depotFile')):
                         value = value.decode()
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
@@ -871,6 +871,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
                     continue
             if 'desc' in entry:
                 entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
+            if 'client' in entry:
+                entry['client'] = metadata_stream_to_writable_bytes(entry['client'])
             if 'FullName' in entry:
                 entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
             if cb is not None:
-- 
gitgitgadget

