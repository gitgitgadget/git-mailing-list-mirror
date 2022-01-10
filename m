Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF94DC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 12:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbiAJMxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 07:53:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:56285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245667AbiAJMw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 07:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641819177;
        bh=ex+DjRBvN4yMhgaDCx73iJnT/Ch0izCo4dpiuK1O1/E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PYtK8ZSmEq/N8y672fimVfMqAe56XEq1hbY01Ab2Phk8Ho+Z9cjr4/c8paiJPhB/N
         BaN8opEXkWJMY9b9aHvNet2w0FQ5yV3VVKhbhH/AaYIvBusZYquDWQf/ww5rjpXOkx
         +6AJ7o+c1hvMqh3duPf8i+G06J0zOWgke+zNcZbs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1n3Lnm1kUV-005IuK; Mon, 10
 Jan 2022 13:52:57 +0100
Date:   Mon, 10 Jan 2022 13:52:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sebastian Richter <Sebastian.Richter@HTW-Berlin.de>
cc:     Imi Admin <imiadmin@htw-berlin.de>, git@vger.kernel.org
Subject: Re: Problem with credential.helper=store in git 2.32.0.windows.2
In-Reply-To: <1c331bdd51b424022bfd598c71d7d666@HTW-Berlin.de>
Message-ID: <nycvar.QRO.7.76.6.2201101349550.339@tvgsbejvaqbjf.bet>
References: <8838ac786ed46b841e4172824b80564b@htw-berlin.de> <nycvar.QRO.7.76.6.2201092246520.339@tvgsbejvaqbjf.bet> <1c331bdd51b424022bfd598c71d7d666@HTW-Berlin.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sUDX564SXeC+AyiobTtBUWPrs7N554JOB7ZVgqWND2vrymxAJPc
 zVgLhu1GU2diDjVvvYf5r2pN1uF8F1G4sLRkpND9+r3VNGjhddfMM8g7hElVm/TMfcKxoWP
 bxMreG2rPb97syRTQxa0YVQoISz6ffXJS7t5nySKclaSVxDhtdgqKQ3AwSyfZ2dMHDCNHB+
 PUo/C4QVUWcf44hZOuAxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v3NyO8zGSFc=:Uo1biG2tfmaDFXxgGyFHE4
 pCHg41QaNMaEGD/5Q7dG5GHFo0/OSHITQTM3HUV9A7JP+Y8gy1jVnZEQ9ATh8tsrExMxexbd+
 4WIRcRzXpFoAQM6QVfvvW/7HKmjPRjjeC96ER9Djw7RZgXQQprwIBSYtVg2pnb5ZEhVh14C9m
 uQ3h7dBUgUYNF51TqhKxck0cbFYa+O0MP558n+75g+kGyWBiSzTiGLjlJpukTOjHQxXUF+257
 uIK7cz5dJnJt6CA/5NoNAHM1rJTnUh0aaWD+orfZNdeYGdhNfudVPa+zQY5vP7y7QwStiRweS
 jpqqzUBRdAVKzaWyxg4+gKqflqHcIBT7gyo1n+ccALzIq9lCXBdHLZMGxprkQIyqohXVQs6vM
 uMrdqm2XaH5Y1u0ynBSCzbZEPEHbSs9oD/A1fV0ZbQOTo1TFW2xpsfxNvMma5NgM5hqP7YVq5
 mrO6LKgwJNKF6phgU1BEF5ToRo8caPq7HvY7RdLB19B5hPnUls89mBN3FdUX3TRmBoUlfwtE2
 hER3FeJMfiHTW4zh0Qw60gSaUYRTqPEEIHhkumiAvu4HbM24KncE0XDzOt5sm5qLGhftkS+wJ
 uoO2MmowPSAP35fh+DGzd9wRTblaDUElpWXFaHlPposQ+9vUq6QKHJnsHsukoeRJxQvEVfVwN
 cWjYWRRXHNiTZJ2ZcZU9rcgB8Hui0dCZNe888TnYqu4tGFkhPKmd4qzml3f2YXgg96zcLotgD
 z/jFMOa7bAJKn1olSmb594grjsLzBAFJRrQZiVjtluEyuNVD8M5t5pjfcR4pTtJn8jeZGjwSh
 k02HbwPQdVlZP8jfkUn344Kn06YxnlLWiABJXJ9z8Z0Gr3OUjl0B10YiurrwsxwSGyQAJWFmB
 4tvLl1hY9chuvoDrZW9oyh06jc9Xoskrhv8NDzT6lbO6Uglqa3lFpcgcoJQNJ9WtEJHHNXiE2
 JvGGf5RPPiN2hZmcctT5EsScFvJvFdx6IkdLySSCpx7rT/SxlMbIvokhZwW3XgOqdziUv4862
 GBiSpTVfocr7s7NCMPwHA7l8G3rr/ZXBTrZ7HkNPK0wdaRie4sdg4Kb1C/k0fK+UIjwG/R0Ur
 qdyhqWB3tnHDm8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Mon, 10 Jan 2022, Sebastian Richter wrote:

> thanks for clarifying this. I'm using 'git config --system --unset
> credential.helper' before setting the file store in the local configuration
> now and it works.

I am not quite sure whether that is a good solution. You are changing the
system configuration for the benefit of a local configuration. That would
potentially break every other user outside of that repository that now
works.

My suggestion is to either go with my earlier recommendation and add an
empty `credential.helper` in the repository's config before the actual one
(and leave the system config alone), or alternatively change the system
config instead of the repository config in the first place.

Ciao,
Johannes
