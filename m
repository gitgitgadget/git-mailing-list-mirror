Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6E21F404
	for <e@80x24.org>; Mon, 11 Dec 2017 17:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdLKRCN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 12:02:13 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36882 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdLKRCL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 12:02:11 -0500
Received: by mail-wm0-f49.google.com with SMTP id f140so15451189wmd.2
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UmmtBj8qYpKl0LPN8v/k6K4yuIVMiRAcb0N0LB0NHvw=;
        b=p6KCXNZdlZ4/abC90D8Y6Er0S2vbL6drRh3dGfz4xIrrb4bMAqybbkF4lH8DJk0a+Z
         nBk4mbgc/5AySeJN372tayGzpFd3fNY+j4+vV0KSqy40lPfZQ881BMfw6YR2lysXD1Mj
         3ROCKuRYImuPwLviXrkh0BlPhiUiIxwP/kc6borYB635fw4hpA0qy3qLtrWyvTbG7HsI
         1ETiPbS9p5X1Jyjl7qT/hiN5tyl/Fl1p+fYi8G8vPmA1U43++E20hYzUV1kRnSngZcVJ
         W5XTOoObBCBMyvEyqNIpXkuDJ5kMecdEWFCgLcFOheIxmsW1OrASkT19GbxhTkvCWW9u
         5hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UmmtBj8qYpKl0LPN8v/k6K4yuIVMiRAcb0N0LB0NHvw=;
        b=KWrZ6Tokbga857vKRMwaObNJg/WtHE00Ns37snOuL/6BEEuTx629O1++sdYoUUsShB
         629zgPEQOpcbCu4JPoMkXusKaHUr9iJBDjmts5lcAFNBH3FJL2v1UhmW4pLhqze9ENJv
         9vr2aTs8gU/sB2uEBf1fap/3cxrN9NTkgYStq75RoPIGtzTqWavcx0KnBJvBe87tSFZk
         6fwbGmOTc89aIy2+F2j5hohNxvPKC4Vx/3lmrUn1euyLD2oO3WDDOLWIrScJ7oT0w4bR
         gQmvImf+/p1+54XaWheRcF3QxB6QgwpL7eO/fuOnnn3pWJ0U4yNJlO4XAakoz5d+3iMZ
         aqgA==
X-Gm-Message-State: AKGB3mLwEq7wXk1IuqEi9+HG8oaoVM6j0AN4MQJJBBYmxa+noVUXKTwy
        2swdIdknieinGsUWIoHCR8+ZlPBrplJyELUprPJ+lSCv
X-Google-Smtp-Source: ACJfBotf52WIr5ZAOtnljU2EPuOrBLo4sXuqwfzyKY0rZEUQUbChEWDvlQycszwm82HXXaYN43WgM2jIMjNg8cEMwm8=
X-Received: by 10.28.51.133 with SMTP id z127mr1504175wmz.84.1513011730049;
 Mon, 11 Dec 2017 09:02:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.165.153 with HTTP; Mon, 11 Dec 2017 09:02:09 -0800 (PST)
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Mon, 11 Dec 2017 18:02:09 +0100
Message-ID: <CAJ+F1CJB+fOJmYpDQtjn1kLa-wk=oUeQGjO7q=N2igYhVG0tiQ@mail.gmail.com>
Subject: Shared clone from worktree directory
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

For better, or worse, I encountered a script doing a git clone
--shared from the working directory. However, if clone --shared is run
from a worktree, it fails with cryptic errors.

Ex:
elmarco@boraha:/tmp/test/wt (wt)$ git worktree list
/tmp/test     4ae16a0 [master]
/tmp/test/wt  4ae16a0 [wt]
elmarco@boraha:/tmp/test/wt (wt)$ git clone --shared  . clone-dir
Cloning into 'clone-dir'...
done.
error: object directory /tmp/test/.git/worktrees/wt/objects does not
exist; check .git/objects/info/alternates.
fatal: update_ref failed for ref 'HEAD': cannot update ref
'refs/heads/wt': trying to write ref 'refs/heads/wt' with nonexistent
object 4ae16a066ee088d40dbefeaaae7b5578d68b4b51
fatal: The remote end hung up unexpectedly

Is this a bug? If not, a nicer error message would be welcome, as well
as man page note.

thanks

--=20
Marc-Andr=C3=A9 Lureau
