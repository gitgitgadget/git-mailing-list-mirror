Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5AE20248
	for <e@80x24.org>; Sat,  9 Mar 2019 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCIOg7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 09:36:59 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:38240 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfCIOg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 09:36:59 -0500
Received: by mail-it1-f178.google.com with SMTP id l66so701706itg.3
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 06:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7AA83X36aTPOcpvxsy4SGxv4jNz6rHWJky3dLnW+cvY=;
        b=JfUgUHTrhnoePRslGtEZvPBmGQxxo4bSZ5XST9Hx8SUw14J+9nNpg3MHbRONmRsUqi
         mmeENH0uJI+C3LRx6Di7UYtLFyaJEjesl30DoMLTtsXVhl8/Z0o4z661HmeRJHitgna6
         q/gz6jqyemuVxevJzbWlKv1icvC7uIazcR3g8g+VdJvbvnuQ69etvna6K/VUU8bHOa/b
         4W1OwkhjrhV0W6lkeUnuYZcp9eZorVN93I2N91M1jijxay+NHBRkrWDd4CpM59VEJz9n
         hyWXPPVH0M8eLMiVjSHRsLmg49TvVtQmzavHtMtBr4oUAZuZaoXnyFXYJzTItvpYp0q3
         /+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7AA83X36aTPOcpvxsy4SGxv4jNz6rHWJky3dLnW+cvY=;
        b=hxErECyMFtxPURVZW7UUwRYx58nczCip9P81FTLTFkfTECT1DYgJx5ZDPzzuFz5LNJ
         SzJzwfkKT0YfIamAzXIuXuxEGnL0wYurEShxCZdqR8yGnNkgPknOxzqmDTaOnZjxS0wl
         ItBUhsavZLEteaSWqCGLLqgnVHk8l9Q5mIJF0WGa42L1RbzfJJAiimSMcpvIdu7KrvX3
         /9EQAT8B0L5zTXH9x6B3MmH6I40SNLFLMqDt3Ffx5wJp87t1htdXrnAgCEhRO+cMGetn
         dUSjL2K9yrjUnKaAIJPprRLmSMAIONr++Vk9w0Z2WoV9RvzZZukqs9FWYQwvxmbjcSOM
         WVzA==
X-Gm-Message-State: APjAAAWxfU1fINddGaDgLQRU3RD69oOSqlVstk8RPV/Sew5jOMv1VU5U
        48/hNtkKXJlBD8LmYNpWTuO7hw2Joh2mpYJNk/S3GWen
X-Google-Smtp-Source: APXvYqyvv/4ExHX0MSC5iOwt9f+5N5ZQsf+gH+tSpcO/VMbV6A4GPinoUQYvthkrkI7FLh1dBDr5iSrCd77kLvyW+5M=
X-Received: by 2002:a02:a88b:: with SMTP id l11mr7835591jam.54.1552142218101;
 Sat, 09 Mar 2019 06:36:58 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 9 Mar 2019 09:36:34 -0500
Message-ID: <CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com>
Subject: t0028-working-tree-encoding.sh test #3 data
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm experiencing a failure in t0028-working-tree-encoding.sh. The
first failure is test #3. The source states "source (test.utf16lebom,
considered UTF-16LE-BOM)" but it looks like a UTF16-LE BOM followed by
a UTF32-LE stream.

Am I misunderstanding the data presentation?

$ ./t0028-working-tree-encoding.sh -v -i
...
ok 2 - ensure UTF-8 is stored in Git

expecting success:
        test_when_finished "rm -f test.utf16.raw" &&

        rm test.utf16 &&
        git checkout test.utf16 &&
        test_cmp_bin test.utf16.raw test.utf16

Updated 1 path from the index
source (test.utf16lebom, considered UTF-16LE-BOM):
|  0: ff   |  1: fe   |  2: 68 h |  3:  0   |  4:  0   |  5:  0   |
6: 61 a |  7:  0
|  8:  0   |  9:  0   | 10: 6c l | 11:  0   | 12:  0   | 13:  0   |
14: 6c l | 15:  0
| 16:  0   | 17:  0   | 18: 6f o | 19:  0   | 20:  0   | 21:  0   |
22: 20   | 23:  0
| 24:  0   | 25:  0   | 26: 74 t | 27:  0   | 28:  0   | 29:  0   |
30: 68 h | 31:  0
| 32:  0   | 33:  0   | 34: 65 e | 35:  0   | 36:  0   | 37:  0   |
38: 72 r | 39:  0
| 40:  0   | 41:  0   | 42: 65 e | 43:  0   | 44:  0   | 45:  0   |
46: 21 ! | 47:  0
| 48:  0   | 49:  0   | 50:  a   | 51:  0   | 52:  0   | 53:  0   |
54: 63 c | 55:  0
| 56:  0   | 57:  0   | 58: 61 a | 59:  0   | 60:  0   | 61:  0   |
62: 6e n | 63:  0
| 64:  0   | 65:  0   | 66: 20   | 67:  0   | 68:  0   | 69:  0   |
70: 79 y | 71:  0
| 72:  0   | 73:  0   | 74: 6f o | 75:  0   | 76:  0   | 77:  0   |
78: 75 u | 79:  0
| 80:  0   | 81:  0   | 82: 20   | 83:  0   | 84:  0   | 85:  0   |
86: 72 r | 87:  0
| 88:  0   | 89:  0   | 90: 65 e | 91:  0   | 92:  0   | 93:  0   |
94: 61 a | 95:  0
| 96:  0   | 97:  0   | 98: 64 d | 99:  0   | 100:  0   | 101:  0   |
102: 20   | 103:  0
| 104:  0   | 105:  0   | 106: 6d m | 107:  0   | 108:  0   | 109:  0
 | 110: 65 e | 111:  0
| 112:  0   | 113:  0   | 114: 3f ? | 115:  0   | 116:  0   | 117:  0

destination (test.utf16lebom, considered UTF-8):
|  0: 68 h |  1:  0   |  2: 61 a |  3:  0   |  4: 6c l |  5:  0   |
6: 6c l |  7:  0
|  8: 6f o |  9:  0   | 10: 20   | 11:  0   | 12: 74 t | 13:  0   |
14: 68 h | 15:  0
| 16: 65 e | 17:  0   | 18: 72 r | 19:  0   | 20: 65 e | 21:  0   |
22: 21 ! | 23:  0
| 24:  a   | 25:  0   | 26: 63 c | 27:  0   | 28: 61 a | 29:  0   |
30: 6e n | 31:  0
| 32: 20   | 33:  0   | 34: 79 y | 35:  0   | 36: 6f o | 37:  0   |
38: 75 u | 39:  0
| 40: 20   | 41:  0   | 42: 72 r | 43:  0   | 44: 65 e | 45:  0   |
46: 61 a | 47:  0
| 48: 64 d | 49:  0   | 50: 20   | 51:  0   | 52: 6d m | 53:  0   |
54: 65 e | 55:  0
| 56: 3f ? | 57:  0

test.utf16.raw test.utf16 differ: char 1, line 1
not ok 3 - re-encode to UTF-16 on checkout
#
#               test_when_finished "rm -f test.utf16.raw" &&
#
#               rm test.utf16 &&
#               git checkout test.utf16 &&
#               test_cmp_bin test.utf16.raw test.utf16
#
