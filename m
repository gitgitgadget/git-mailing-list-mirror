Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945CF1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 15:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeBFP4T (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 10:56:19 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:43783 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeBFP4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 10:56:17 -0500
Received: by mail-lf0-f51.google.com with SMTP id o89so3412292lfg.10
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Fmo/F+0Vx3QZmxyJw8saVDWo0DJoYEkFfJXSO3hO9oY=;
        b=NdBs8/MKhuy3TgNmCzbjaeemPr05ua5SYy3XiymMOLGKEhlYIigWpOci72CIaVNW4Q
         8ZJ8zceVdp+zrXu137vEeWTQjQU+Oa8K3iEhoW6H0EWQ11aV6KzMgWMMqbT8TWWBPjXW
         kmVINJSFesd+xnVVshWTngd7S6a3OU+plIC3N+KYVv2mOa+bCyJnr62mukVvgLJ3HeOb
         +b1r8wXpEvNzgKGGIiWq2DgyqA9ktajiNtNATO6jsr6lD9fjvPYIjCzVUZmpSrMf4NbX
         b8mIrKok62g3xRfOWIi/NN6yFcz1WxAyBMkKFtdvfkFCuOLfYl0+Np7GKSgAGhgOA39q
         T94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Fmo/F+0Vx3QZmxyJw8saVDWo0DJoYEkFfJXSO3hO9oY=;
        b=Tj/JavkdFWPBM7HHllmF5WJ4IrXGQxv2tbQJxPMpE4hO3PLpmTFntKvpv8SyJgYVgr
         3IxPkmBTVrNXrEDFFeL5ictjbF2FYscTB1ExpcvzYCkVBIklTjg8ADDW9ipblsCSn8R/
         w6kHKbOAm0EEHfMO2l/eb9Kysb3N5oJ02GOg3SyrCqbgluTZcLahVjatzIbul/pAHifB
         BjpKZ0+n6dTSPS8LYDeFmw8qT7UvplABMxpPy3dR3ZK4lW4FpKDafy6KLsI1J3oVQTgb
         1/Msyc+VyBWeoDb9Bef5SzK6jw/G2dCGRlr6bGr5Q+cz1PNwk8e6vNAzQPvV4/SBpCFx
         CWNA==
X-Gm-Message-State: APf1xPCFZMg8lx/Rxnms1k+jlRXVLTWmlCDghQO5YvMrwekyHi5yqA+Z
        X5bc8RdK1wiytPxrG5HpgVyfyYyMFE4T7I1oeDcX+A==
X-Google-Smtp-Source: AH8x227FpCY/EpWMbVwuJGwkzVGWrdt+yHMHbkSMpOqO3tnefZx2mQTP+w9+sSZcx06DFf4aOYAwhHnz9kOaDAxCY+k=
X-Received: by 10.46.34.1 with SMTP id i1mr1994988lji.108.1517932575888; Tue,
 06 Feb 2018 07:56:15 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.64.66 with HTTP; Tue, 6 Feb 2018 07:56:15 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 6 Feb 2018 09:56:15 -0600
X-Google-Sender-Auth: sHpNDxo7XvaJ9O3HLiID3EqkxTM
Message-ID: <CAHd499A26paeZ=WgpdEkU233XbMrfVhgPGB3FHwaFObRKVqQDg@mail.gmail.com>
Subject: An option to ignore submodules in stash push?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't seen such an option, but I think it would be nice to be able
to ignore submodules when creating a stash. When I stash changes in a
directory, almost always I intend to only stash real files, not
modified submodules. When I pop the stash later, it gets disrupted due
to submodule conflicts. To avoid getting the conflicts in the first
place, it would be nice to somehow specify:

$ git stash push --no-submodules -- MyDirectory/

Would this make sense?
