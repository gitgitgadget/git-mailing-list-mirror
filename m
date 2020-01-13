Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB617C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A564820678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=clicktherapeutics.com header.i=@clicktherapeutics.com header.b="VDJaSrJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgAMABH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:01:07 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:32945 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387422AbgAMABH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 19:01:07 -0500
Received: by mail-qv1-f47.google.com with SMTP id z3so3312273qvn.0
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 16:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clicktherapeutics.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id
         :references:to:date;
        bh=VjSSe8HvRzm/MvlkQRJhQA1cbmpD1lWtrKTTcuI8rSs=;
        b=VDJaSrJKLjaT+W40p4ECD4roV9ypO6EqGiUdMYsXnRU6nxcbaGTyT3DsfS69NkiVNF
         05gzSP4MTcrLG2mbp7jOVFJUy/DNGnUtXZeUid1RBc6sKq4q0dSBgncj6E/JdSAOtiHN
         NEKAhJ4jtkJX7Z9R0nBheCxZj50QLILi6AWaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:references:to:date;
        bh=VjSSe8HvRzm/MvlkQRJhQA1cbmpD1lWtrKTTcuI8rSs=;
        b=pRxrQK0MudzFiqvqHkC+5JCnEJUrSgRoY38f/mBIRQofPWEzXXbQgE8ZrDi+tcs8Qy
         nLCX6ioax0nBzreutalhjDEE/l+f9AAiacyP0eWRzIHxY4+L//4MwW4R32o6LUzYiyVR
         MGc97EyeLntHK/M3Bsxb+XrvemSQZH2Yh7lKMd6BtmTJXJR1kd1eTYQ2ls4gtfe3WNXX
         WsQmghrTJftQKXEKjiZQaHLSwg9pJuJqJLCJAyijN9+cXvL6fvm8EdZ6JGHo8SnaYsO8
         0wF3LsNPJKnpC37uNi4xv36vYkx8s2kA3BAe+JJlq/96T6NqdI7iwlCNW1IhC0DRGEXI
         wB0A==
X-Gm-Message-State: APjAAAUc5fczdD3MbNPcenlu6f1TB3cOvTWeAIGO2/QFeSkMKoCyiKk7
        6eN0R2Y4IWfxkGXONmZpDV291bk9yny0KQ==
X-Google-Smtp-Source: APXvYqwiGMyKPgWNeztikMkGFK56tUvYA/G40YRHQYLXgEFgfoMwHY1W/lgu9DS2geVsYhjtakNsKQ==
X-Received: by 2002:a0c:edc2:: with SMTP id i2mr13396626qvr.62.1578873665979;
        Sun, 12 Jan 2020 16:01:05 -0800 (PST)
Received: from ct-l-m-030.lan (pool-100-35-103-210.nwrknj.fios.verizon.net. [100.35.103.210])
        by smtp.gmail.com with ESMTPSA id p19sm4778616qte.81.2020.01.12.16.01.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 16:01:05 -0800 (PST)
From:   Jude Guan Wang <guan@clicktherapeutics.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Fwd: Issue with Git Branch
Message-Id: <29742805-4992-47E6-9889-F55F5EFBBFF1@clicktherapeutics.com>
References: <56F9DC91-740F-47C7-9C2A-B6B1EC3A12B6@clicktherapeutics.com>
To:     git@vger.kernel.org
Date:   Sun, 12 Jan 2020 19:01:04 -0500
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:
	I noticed something weird with my git command. In my local =
environment I seem to have a branch named `-D`:

	And I don=E2=80=99t remember how I was able to create a branch =
like that. I tried to do git branch -D/-d this branch but seems not =
working. I=E2=80=99m assuming the branch infos were kept in .git folder =
so my question is if there=E2=80=99s anyway I could remove this invalid =
branch from that folder? My git version is 2.24.0. Thanks for any help =
in advance.

