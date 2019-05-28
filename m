Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D521F462
	for <e@80x24.org>; Tue, 28 May 2019 08:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfE1Iwk (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 04:52:40 -0400
Received: from mail-yw1-f46.google.com ([209.85.161.46]:46472 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1Iwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 04:52:40 -0400
Received: by mail-yw1-f46.google.com with SMTP id x144so3462196ywd.13
        for <git@vger.kernel.org>; Tue, 28 May 2019 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y5WipblxtzDjQTJwJUd8wm+5WZPNwL02HxkzI42R/zU=;
        b=BkF2SLtZM6EtDS9x/oq0EtcXmNXSg3Ie+gAi3Qyzj57D/hPEBeTJ3nILvzG1STVrBE
         xgWZz7cxMkdD85bjDW1g2NkrKCL2zQ5Gw3ys9Vr6+g3mTTO4evPP8JlRUaPqn/jdygR5
         IECGWAceaJWr+r/ZnfAqkznGRDCVBVDDIxp9ue6AOPlHQGPUFuNXsAp7pSSAUStCry9D
         +0AR/wdw2FJEzFCc0yfplan8Sql7nG1/kij2nSANyaLBuuUSMPMdI+2VrrbzfYp+7XU8
         ixYh/byi2lqgxeXTGkAjKyFqhemU7tYvabThFxLmDwh3rvuenY80TbFvCOUMNPMLNrce
         yaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y5WipblxtzDjQTJwJUd8wm+5WZPNwL02HxkzI42R/zU=;
        b=cpRMfA7SBU8FfYDudeTNGLWZ5+FncHJfovxamuJgxaVtAOjgEq39qNtJ8tYQLWOv0M
         9SLOcWW9IK2/kC8FtjkrollIyUQ5a0Y+2DXh+cWbflafZF5jKlx2nYPc52ikyI7kzB+Q
         c9XOyr5vxzSSB/q8rrDHWvRM5vI0j7ARLsHyGlM6agZORbULPZZkGYJBHIwJrZOqjncg
         kPP2y0lVHhtehKFPlEYj3a8CZ3YayKvGvdP/DIwwzCL3HanvBq7w6A8w1zWhVEnbF/Qz
         krmro/Wqq38vXwURz1WhdsRMbof+dDWIA7YtS7wfBUO19TBOWSFy85oUE7JeS3fM4DLg
         GAFA==
X-Gm-Message-State: APjAAAWS8Z41oRihhTObli0WNj4VouA2aCl+IS2rkHxBdBBqIJGoF1mV
        hYvMxky9TN4SvkapIshq96slh3cieRhEN3Thbny83mRg
X-Google-Smtp-Source: APXvYqzEbVbm3os3yhx1qinVN9wtLL/hoLU5kwi/yBa3vaNxSwAou7pMfltj9HPCgvb6w/xUyzwbvhG2nM0sBB6cpi0=
X-Received: by 2002:a81:454:: with SMTP id 81mr57258094ywe.210.1559033559381;
 Tue, 28 May 2019 01:52:39 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Tue, 28 May 2019 11:52:02 +0300
Message-ID: <CAHMHMxWzchXG_Ct3=n9OP=3Q-ENjt7BkGQ2iWDAE3eYhv4MpyQ@mail.gmail.com>
Subject: `git stash show` "forgets" about untracked files
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I have saved some new untraced files, along with some tracked files in
a stash, in order to start making small commits.
However, it seems that doing `git stash show`, will leave no trace
about untracked files being bundled inside.

For example:

#                                 tracked -- untracked
user@host:repo/folder$ git stash push -u file.ctrl file1.ctrl
file2.ctrl file3.ctrl file4.ctrl -m 'New feature with untrackeds'
Saved working directory and index state WIP on feature/auth_saml:
03cd4d56538 fixup! drop! squash! NGFW-16257 QA: Configure Identity
Provider with Ansible with asd2
fatal: pathspec 'folder/-m' did not match any files  #[1]
error: unrecognized input
user@host:repo/folder$ git stash show
 file.ctrl | 4 ++++
 1 file changed, 4 insertions(+)
user@host:repo/folder$ git stash pop
file1.ctrl already exists, no checkout
file2.ctrl already exists, no checkout
file3.ctrl already exists, no checkout
file4.ctrl already exists, no checkout
Could not restore untracked files from stash entry
$  git --version
git version 2.21.0

---------------------------------------

I understand that I could probably have staged them, and then commit maybe?
I didn't want that at the time though

---------------------------------------

[1]: This also seems to be a bug.
I understand I wrote it wrong, but, since I haven't used `--`, I am
not sure if `git` has the right to assume that `-m` is a filename.
However, the command has finished correctly.

=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82
