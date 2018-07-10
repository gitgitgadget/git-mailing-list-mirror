Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920931F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbeGJSxd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:53:33 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:34489 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbeGJSxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:53:32 -0400
Received: by mail-io0-f201.google.com with SMTP id w23-v6so20105948ioa.1
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mnZbsd4PjwUOsgtIqZRT/Yfbfls6cxSe0qhbdYDIBVg=;
        b=bW+EXuQuvupo4EuLYj0gargFOCV4/ATK3F4WQgIbizPFCW2Wr6Pm4r57INhafp9Rqy
         qZuCuwKCM4OhVdGFTRJaDIp6AqqJMEz31QW4MSuKviQe4939eA14VcD7Gd/1IwjVGdJ/
         vudpqGHTWryHfhmzH1JLky6YIRtsHF+9RbBgcWSgXskkN97jjorc9BynjccDSHz3WX50
         x5EA2QF+SCZZ//OAdQzU2pDnLWKG5qRRVQIy6AjOL2E4RoP8/hX/RVXEWXO1iclfLafZ
         p+D3Ijxpdo6Bu1m0N35x08AYgJ8cG1aVJvk8PYLe1lihdccyFgH45/G1UPURDJj47mMT
         JZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mnZbsd4PjwUOsgtIqZRT/Yfbfls6cxSe0qhbdYDIBVg=;
        b=fXfv6rVcO5uSO450y4HxKBBtQ+xYQdHEVFlr/SuP4rVXe7qU3lAddXg9GSGoIofzsX
         raWudeTulelUe33cr6J5Iq7yyAM67xMMqoB2V0k3jLbralL12cWhkUdJ2/TmfYtXcnFp
         Zx1I2Mgom3d7TlA+f7u4ZLzETGRI4nbbtT9I8T9rTxFz/NpFWKdnw+WOjGIlwb3Grm7P
         /R3hzNoWDxTEEX6owWI2uX90JM6EBhFP4qt1mDB/b1E7ecVfGgxZ+HoeK4RbuGbc9wzq
         F2sFyuSFUrLOvnS1C5GmJwt0wGxk8zVCBtLWdDH5gw7/bFPQxeTOlAaW9R5A6DfzVPJw
         8Csw==
X-Gm-Message-State: APt69E21IwclQ/C6Yf5z40bevpxmdL2OkBif7P5l9zwlv8H6HtuNk7Cc
        PN0Xr3P53TtGC6qQZmTVMONtovT+Z8xd
X-Google-Smtp-Source: AAOMgpeyinGa35zf69XlEV/25cT7ONmlZviKV/+2o5uXRZTyHJ5UFZdi9yoX+zowTqbGFuL1DRP6EjQqf1Lo
MIME-Version: 1.0
X-Received: by 2002:a6b:bf47:: with SMTP id p68-v6mr11290534iof.82.1531244760057;
 Tue, 10 Jul 2018 10:46:00 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:45:50 -0700
In-Reply-To: <CAGZ79kb4RS-KxEX+x07XsFiGwgG+1AiRUha=zcxexe1=RLL8kg@mail.gmail.com>
Message-Id: <20180710174552.30123-1-sbeller@google.com>
References: <CAGZ79kb4RS-KxEX+x07XsFiGwgG+1AiRUha=zcxexe1=RLL8kg@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 0/2] Re: [PATCH v3 14/20] diff: add an internal option to
 dual-color diffs of diffs
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is developed on top of 4a68b95ce2a6 (your series here)

This is an attempt to explain the previous email better,
specially the second (yet unfinished) patch, but the resulting
emit_line_0 is way clearer in my mind, dropping the 'first' character
and instead having a 'char *sign' that (a) we can color differently for
dual color and (b) can have multiple chars, the refactoring for the multiple
chars would need to happen at a slightly higher level.

Feel free to draw inspiration from here, but if not that is fine, too
(as I did not fully understand the word diffing problem yet, this may add a
burden instead of just taking these patches).
I can send up a cleanup series after yours lands, as well.

Thanks,
Stefan

Stefan Beller (2):
  diff.c: convert emit_line_ws_markup to take string for sign
  WIP diff.c: clarify emit_line_0

 diff.c | 84 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

