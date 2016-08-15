Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46D02018E
	for <e@80x24.org>; Mon, 15 Aug 2016 11:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbcHOLU3 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 07:20:29 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:35322 "EHLO
	mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbcHOLU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 07:20:29 -0400
Received: by mail-ua0-f170.google.com with SMTP id n59so68750854uan.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 04:20:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=tmr0jooNnQduChEnPlX0HF2ijth86cs7ncb2LP2LiAw=;
        b=ll9DzGiX4XUMifkWOIi1br9CnyThYjoy2I2+uMLQ6VV84itw8fEMvTl4uPI5ZTPyYs
         gU37Vu5RWw4ZXlKZcK3gtmpgmiJvVh5qQ/3zzf1zfmS7LpNU/wrCR4veQd2wXJc0uJJ2
         tiTXtIOsulkxl1PdQXNwXmZGYnbO7dnNJOuT0Mitno7eNrERt0wsp9fCRI2UY0A5hUcs
         2etGckFXRbLCkrQwinS0qcMhbSobqhGXNxBgnHjjLO//VEmLHJK2xNZZ3Jynul4Fx/af
         5OBRfLA/2F1BzUE65zkDGuw2stP6HuUa5xzUUrnPbsH1w2Ys2uJ1Ep3/7vaz46u3n0hm
         sd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=tmr0jooNnQduChEnPlX0HF2ijth86cs7ncb2LP2LiAw=;
        b=AYozGcec2V4bzIAY+/6HrjSYG9pnyf6KRHa4957eKm3t78ANzur5WhhNqFgvBULqB2
         REL1+iA+070SzvD9qoGrn9BewFC/Hp8DWp6VfJlt1EgzNGgTBbDxn97J08bfrRKUfVmZ
         wApPqfMTwYAciW98WYbQTXczRL+f4oxyTZ0CdbXm0aj0z7S1+7d7HZp23c1tGOZ6tzkv
         5Jxj6sY4mFrbwoRovRdQXYhb0382oVvsEnRPlBK19+9vQwYmH8fld8ygAVLowfI/PMty
         TY0mn5f1YNk4krB+TNH6kHM2Z/zDlyHLf7vObOBG5zl6iCegpABBaKLCUibcqN0JXuE2
         fOJQ==
X-Gm-Message-State: AEkooutkkeSINY9r1c/5Wdh5mFSqkXheYsnli60fjJTPY/occkBJJ/RmVa+HWAXOwzoi/qo0MgIOWBehhCQVgA==
X-Received: by 10.31.106.196 with SMTP id f187mr7426958vkc.61.1471260028095;
 Mon, 15 Aug 2016 04:20:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.69.172 with HTTP; Mon, 15 Aug 2016 04:20:27 -0700 (PDT)
From:	Arkady Shapkin <arkady.shapkin@gmail.com>
Date:	Mon, 15 Aug 2016 14:20:27 +0300
X-Google-Sender-Auth: j9OwGE397O45lwdnTN_sFypJuMc
Message-ID: <CAB-zwL28qUBO5PrRznH9KmLJZUHO65_J-DxvPP+NHZEuofKh9Q@mail.gmail.com>
Subject: Git shallow clone branch doesn't work with recursive submodules cloning
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I am trying clone repository by tag with recursive submodules init,
but for one submodule it doesn't work.
What I'm doing wrong?

>git clone https://github.com/grpc/grpc.git --recursive --depth 1 dsad5

Cloning into 'dsad5'...
remote: Counting objects: 7475, done.
remote: Compressing objects: 100% (4695/4695), done.
remote: Total 7475 (delta 2593), reused 5610 (delta 1265), pack-reused 0
Receiving objects: 100% (7475/7475), 4.85 MiB | 2.55 MiB/s, done.
Resolving deltas: 100% (2593/2593), done.
Checking connectivity... done.
Checking out files: 100% (6820/6820), done.
Submodule 'third_party/boringssl'
(https://github.com/google/boringssl.git) registered for path
'third_party/boringssl'
Submodule 'third_party/gflags' (https://github.com/gflags/gflags.git)
registered for path 'third_party/gflags'
Submodule 'third_party/googletest'
(https://github.com/google/googletest.git) registered for path
'third_party/googletest'
Submodule 'third_party/nanopb' (https://github.com/nanopb/nanopb.git)
registered for path 'third_party/nanopb'
Submodule 'third_party/protobuf'
(https://github.com/google/protobuf.git) registered for path
'third_party/protobuf'
Submodule 'third_party/zlib' (https://github.com/madler/zlib)
registered for path 'third_party/zlib'
Cloning into 'D:/Work/conan-packages/dsad5/third_party/boringssl'...
Cloning into 'D:/Work/conan-packages/dsad5/third_party/gflags'...
Cloning into 'D:/Work/conan-packages/dsad5/third_party/googletest'...
Cloning into 'D:/Work/conan-packages/dsad5/third_party/nanopb'...
Cloning into 'D:/Work/conan-packages/dsad5/third_party/protobuf'...
Cloning into 'D:/Work/conan-packages/dsad5/third_party/zlib'...
error: no such remote ref c880e42ba1c8032d4cdde2aba0541d8a9d9fa2e9
Fetched in submodule path 'third_party/boringssl', but it did not
contain c880e42ba1c8032d4cdde2aba0541d8a9d9fa2e9. Direct fetching of
that commit failed.

>git --version
git version 2.9.0.windows.1

-- 
WBR,
Arkady Shapkin
