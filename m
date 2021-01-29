Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C7C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF28364E0B
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhA2VWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 16:22:54 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35643 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233293AbhA2VWx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Jan 2021 16:22:53 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8DB385C0064
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 16:21:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 29 Jan 2021 16:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=83bp+6
        OY7KhJuAENabXxajXIBkfE6IRXG6GVQCEwyTA=; b=nBFKSgl/tnEGM3rlv8CZif
        0/tXMI4/dYHKwitj/NvoCkNs4lQepUDVMIg6xQChlryJsnzZs2tNS0iEk540Rxth
        WrJ67rwijtmFvga0F2FK6W8013F9lH1l7Sq9blzOkUuBY0PR1E8x/p0BAmggzlox
        h+6HgdqZmLg95tvW5xmHU7p2d47UBKhBYKoGRvOFiRNCnHRJSUEa/XrfbPOnasSt
        qwJWoI7KkbmsXo5ACarK/kl/WlzvqZLhRpwUsCN3BtT8qdY8GlRRRLic9Mr+BWv0
        bFqLm6cVmlZkHMOVh+rwBweB9wQytNauZ3o0+hv7KtGubwUBNFkLP424QReyeD3Q
        ==
X-ME-Sender: <xms:anwUYEWNNRADa8szisDfxsXa4NrAJabn6p-HV7rtOaq1giwQihGWEw>
    <xme:anwUYIlAS10cNSphNa_WlC9TuY8D-0YVcAbNrHKJyr2qF3-2GFnDT50Brdzu-ydAO
    OrwE8wit6Ukcus_1Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtqhhmtd
    hhtdejnecuhfhrohhmpeevohhlthhonhcujfhurhhsthcuoegtohhlthhonhestgholhht
    ohhnhhhurhhsthdrtghomheqnecuggftrfgrthhtvghrnhepgffghfduvedvlefgkefgud
    fhgeefveekfefhheeiheeuhfetheehveevtddtleejnecukfhppeejuddruddvtddrudeh
    hedrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gtohhlthhonhestgholhhtohhnhhhurhhsthdrtghomh
X-ME-Proxy: <xmx:anwUYIbosZhuonLt52jvMTX2b4N6N5RnU3a1QLtStbQgRbXDX-j8QQ>
    <xmx:anwUYDXRE69RqzLp9IAeU-P8TJ2IzkSqdQQC952JQ85XanAgzQ_EEg>
    <xmx:anwUYOl1hWhzfOivyu355KtQnSAgKJBsBhW6g8H-8zF8I_2NBIYoxg>
    <xmx:anwUYEk6PJ4KxYWlRo9aXPoE-AQLxYH9kVCIYYzdLRDKr4EKNVSj5A>
Received: from [192.168.0.171] (pool-71-120-155-4.nrflva.fios.verizon.net [71.120.155.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4DCFE108005B
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 16:21:46 -0500 (EST)
From:   Colton Hurst <colton@coltonhurst.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Git Conditional Includes Question (possible bug?)
Message-Id: <1E4AB5E8-DD46-45CA-9A3F-C49F115BE0D4@coltonhurst.com>
Date:   Fri, 29 Jan 2021 16:21:44 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am attempting to use Git conditional includes, but it does not seem to =
work for me. Can you please help me find out what I=E2=80=99m doing =
wrong?

[Expectation]
When I run `cd ~/colton/github/coltonhurst.com` (this is a valid git =
repo) and then run `git config user.email`, I expect =
=E2=80=98colton@coltonhurst.com=E2=80=99 will be returned.

[Actual Result]
When I run `cd ~/colton/github/coltonhurst.com` (this is a valid git =
repo) and then run `git config user.email`, nothing is returned.

Is this correct behavior? It seems like Git is not recognizing my =
`.gitconfig` file, and the configuration is not set correctly.

I=E2=80=99m using git version 2.30.0 with on a Mac version 11.1 (Big =
Sur)
My main shell is: fish, version 3.1.2
I also have tested & have the same issues using: GNU bash, version =
3.2.57(1)-release (x86_64-apple-darwin20)

To reproduce, I have the two files at the listed locations:

`.gitconfig` at: `~/`, with the following contents:

[user]
	name =3D Colton Hurst

[includeIf "gitdir:~/colton/github"]
	path =3D ~/colton/github/.gitconfig

[includeIf "gitdir:~/colton/sourcehut"]
	path =3D ~/colton/sourcehut/.gitconfig

`.gitconfig` at: `~/colton/github`, with the following contents:

[user]
	name =3D Colton Hurst
	email =3D colton@coltonhurst.com

This is the output from `git bugreport`:

[System Info]
git version:
git version 2.30.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.2.0 Darwin Kernel Version 20.2.0: Wed Dec  2 20:39:59 =
PST 2020; root:xnu-7195.60.75~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.28)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


Thank you for reading,


cdh

