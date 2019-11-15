Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835F41F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfKOOjU (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:39:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47008 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfKOOjU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:39:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so11219299wrs.13
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h68byMkZ99/9z2PEsbzPwBk83uBHSNmqOmFk/rIvv4w=;
        b=eO2HyrcIEwGkDVqjHckTDVXfsix/FFD56KWEj5WdlPDZ5N0pWB7UhwfWdEmgGnVbcx
         7Z3p+aPR3Ksv7UDzMevlGBUgPdPeiz8euozzbeTZ1Pn/keKu2hV+uffzzd4eH9jDlaaM
         EmU6K5VdvJFnnqwF/g/+g121spFk+S0EKvLS7NFx+EW0x/yZloiZetIQbC/SOAJem2//
         /qFkp4XBHxwLFW8B6zOTwzup/6gdEb2xkmUDJhXAYuvQhLnZxsmGCSAUtf7sF+ffhqoD
         GkdCyNO4hyDgUdolto/dmtQIsZciVMnwNQ3eJ5P2UNXsy5k+ub/HOpRTywtl51A6gGKy
         VKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h68byMkZ99/9z2PEsbzPwBk83uBHSNmqOmFk/rIvv4w=;
        b=DLwm0Z+FzP4/90EQOlVX0WX5ldEvyVM4qoXRdraHK4KfMWblwWY6QzdDsJxT9Nb3kv
         URkFS6F3CJrFuitFP7WHRHQWvHrRwLP5QcDL3JvMPM0n4G62ObinUmCtQoXFf0kisscl
         VH/1bGvOsJ0IWKx7GCZX5nrXRjioXGtKDAm4RJ/koip1KqAIqDeKy3rBlR8XJhwqVq89
         U/Wtd/E3xIDnPxH2J4ann5III2qlilCtuFvWG395Ylma75xuvWEUzzCy6RHDYqhKkWJW
         T2hzFEB8Nh4tlyyDxrpdn99S1P958/bkyniFrypVfmsONK7GU9OcEcDhK/zFE+pZJEoW
         2HYg==
X-Gm-Message-State: APjAAAV+NUFhezwdN49Yl1riPrcPqt4VSSbR63BnzBN5em6Jv2QwVEL0
        zy9hLQGCPGPrAxgsMQTF0OafuBb+
X-Google-Smtp-Source: APXvYqyOJVzEe6KbWjJI4f974tCth08tnkVDV66FHzyCXzyRgpqjou8dk0qPdugraPpHpUcVphVcnQ==
X-Received: by 2002:a05:6000:1083:: with SMTP id y3mr14955963wrw.290.1573828757842;
        Fri, 15 Nov 2019 06:39:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm9795154wme.11.2019.11.15.06.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:39:17 -0800 (PST)
Message-Id: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.git.1573679258.gitgitgadget@gmail.com>
References: <pull.463.git.1573679258.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 14:39:13 +0000
Subject: [PATCH v2 0/3] git-p4.py: Cast byte strings to unicode strings in python3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4.py: Cast byte strings to unicode strings in python3

I tried to run git-p4 under python3 and it failed with an error that it
could not connect to the P4 server. This PR covers updating the git-p4.py
python script to work with unicode strings in python3.

Changes since v1: Commit: (0435d0e) 2019-11-14

The problem was caused by the ustring() function being called on a string
that had already been cast as a unicode string. This second call to
ustring() would fail with an error of "decoding str is not supported"

The following changes were made to fix this:

The call to ustring() in the gitConfig() function is actually unnecessary
because the read_pipe() function returns unicode strings so the call has
been removed.

The ustring() function was given a new conditional test to see if the value
is already a unicode value. If it is, the value will be returned without any
casting.

These two changes should fix the immediate fail. However, I do not have an
environment that I can run the test suite against so I don't know if another
error will be uncovered yet. I'm still working on it.

v1: (Initial Commit)

This is caused by the return values from the process.popen returning byte
strings and the code is failing when it is comparing these with literal
strings which are Unicode in Python 3.

To support this, I added a new function ustring() in the code that
determines if python is natively supporting Unicode (Python 3) or not
(Python 2). 

 * If the python version supports Unicode (Python 3), it will cast the text
   (expected a byte string) to UTF-8. This allows the existing code to match
   literal strings as expected.
   
   
 * If the python version does not natively support Unicode (Python 2) the
   ustring() function does not change the byte string, maintaining current
   behavior.
   
   

There are a few notable methods changed:

 * pipe functions have their output passed through the ustring() function:
   
    * read_pipe_full(c)
    * p4_has_move_command()
   
   
 * p4CmdList has new conditional code to parse the dictionary marshaled from
   the process call. Both the keys and values are converted to Unicode.
   
   
 * gitConfig passes the return value through ustring() so all calls to
   gitConfig return unicode values.
   
   

Signed-off-by: Ben Keene seraphire@gmail.com [seraphire@gmail.com]

Ben Keene (3):
  Cast byte strings to unicode strings in python3
  FIX: cast as unicode fails when a value is already unicode
  FIX: wrap return for read_pipe_lines in ustring() and wrap GitLFS read
    of the pointer file in ustring()

 git-p4.py | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-463%2Fseraphire%2Fseraphire%2Fp4-python3-unicode-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-463/seraphire/seraphire/p4-python3-unicode-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/463

Range-diff vs v1:

 1:  0bca930ff8 = 1:  0bca930ff8 Cast byte strings to unicode strings in python3
 -:  ---------- > 2:  0435d0e2cb FIX: cast as unicode fails when a value is already unicode
 -:  ---------- > 3:  2288690b94 FIX: wrap return for read_pipe_lines in ustring() and wrap GitLFS read of the pointer file in ustring()

-- 
gitgitgadget
