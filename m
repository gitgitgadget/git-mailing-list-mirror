Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9EF1211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 22:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfAFWsk (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 17:48:40 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44484 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfAFWsk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 17:48:40 -0500
Received: by mail-lj1-f180.google.com with SMTP id k19-v6so36546907lji.11
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 14:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=r4KQhnC5bdWXGwh2YJ0P4IjvfbVUWz/FCN0JPqnlbZ0=;
        b=PK3AlO31JIg8dw/TjHlBFgd8rz/vU4WUhai1WDTWoxizuV/8ekuvJLLj91udkt/YUp
         ZLPOkdDPYIpVpQ35VqFXimLVy7CvYCvH3V9f2uTQPPzLdsTMtGsv8ZbIOgyeMrOsBjy1
         QlCDwTHdJagPkOitSRXlSFLSUDKKMJb/l8Z/3Od9DBLExi4ldrBm364zrXkDVbsM2Vxf
         y+KPveOIlukSNvuSS45rrItmlGC+liLqmK6SJSLLdrbkK3OLNAtkwYV2o+j1pQlxyscG
         bqg6hj4qakhZU3r086m4JJFTLZl5BTrKKO7V0+lrEtJHXngFlChXAbMdBRHeNTIMMx5X
         H90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=r4KQhnC5bdWXGwh2YJ0P4IjvfbVUWz/FCN0JPqnlbZ0=;
        b=jSFY1D1QP6rvGHLjdJyCCpusCXhuyw73bCabXRc0CJJ0rtnFdIoL8oi6Or3ZKAozKU
         RcrmNuy+GW5nprwI4D00+CU3YG6logQh960e2K6JrjAPWlMmYNSyUsHJfMUYhOyPlEjN
         3Efb80o02gVJrQhyYEq2wgogXZZcaFOykaqL7DNtgbIpcyQR2UzeumBCQcTMgLsvn9uf
         BSXKa9WA+jtIaOgz10xqZxhbrRCFVVSqtTrr3YqAI1pB1bSUkInvBRcZlur8+W8ZIX1r
         tTLT/hD72AmpfLEnT2y421xCyKjfg28qNLlAMhVjM9BVXBEtr2C/nbSKIXTuZiXga1Ry
         iryw==
X-Gm-Message-State: AJcUukfi268WEE5qw9TeUFTinKeovAmUoNh4mQq/8/14OjYfltN7TIuK
        OGCj7h5pR9+3ohyAmB8L/OdW+OAa
X-Google-Smtp-Source: ALg8bN73ye+W+ktV3NVRjK3pxqBvQKohKONWZUhwDhBc0GkzzUYl/mSGdP5V6mG2ubYC8flX9anaOA==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr31786016lja.19.1546814917833;
        Sun, 06 Jan 2019 14:48:37 -0800 (PST)
Received: from fractal (c-3e3f70d5.031-170-73746f28.bbcust.telenor.se. [213.112.63.62])
        by smtp.gmail.com with ESMTPSA id b22sm12306881lfg.32.2019.01.06.14.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 14:48:37 -0800 (PST)
Date:   Sun, 6 Jan 2019 23:48:32 +0100 (CET)
From:   Peter Osterlund <peterosterlund2@gmail.com>
X-X-Sender: petero@fractal.localdomain
To:     git@vger.kernel.org
cc:     Luke Diamand <luke@diamand.org>
Subject: "git p4" fails when perforce login not needed
Message-ID: <alpine.LFD.2.21.1901062337420.5908@fractal.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When I use "git p4 sync" to update a git repository from a perforce depot, 
the operation fails with error message:

     failure accessing depot: unknown error code info

When I run "p4 login -s" from a shell it reports:

     'login' not necessary, no password set for this user.

The following patch fixes the problem for me:

--- /usr/libexec/git-core/git-p4~        2018-12-15 14:51:07.000000000 +0100
+++ /usr/libexec/git-core/git-p4      2019-01-06 23:23:06.934176387 +0100
@@ -332,6 +332,8 @@
              die_bad_access("p4 error: {0}".format(data))
          else:
              die_bad_access("unknown error")
+    elif code == "info":
+        return
      else:
          die_bad_access("unknown error code {0}".format(code))


Not sure if this helps, but running "p4 -G login -s | hexdump" gives:

00000000  7b 73 04 00 00 00 63 6f  64 65 73 04 00 00 00 69  |{s....codes....i|
00000010  6e 66 6f 73 05 00 00 00  6c 65 76 65 6c 69 00 00  |nfos....leveli..|
00000020  00 00 73 04 00 00 00 64  61 74 61 73 35 00 00 00  |..s....datas5...|
00000030  27 6c 6f 67 69 6e 27 20  6e 6f 74 20 6e 65 63 65  |'login' not nece|
00000040  73 73 61 72 79 2c 20 6e  6f 20 70 61 73 73 77 6f  |ssary, no passwo|
00000050  72 64 20 73 65 74 20 66  6f 72 20 74 68 69 73 20  |rd set for this |
00000060  75 73 65 72 2e 30                                 |user.0|
00000066

Best regards,

-- 
Peter Osterlund - peterosterlund2@gmail.com
http://hem.bredband.net/petero2b
