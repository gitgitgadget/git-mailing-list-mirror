Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339FBC25B06
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 01:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiHOBEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 21:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiHOBD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 21:03:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A595DFE5
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660525436;
        bh=bVaMRpLuk7pSdvdkQ6PRv0niYU40d3XgrM3kbBeDoso=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=CimJfEZG2Yc8JHz4SZMT3Hij72Iv80MAwH5kyZVe+wUi5LVLAbRz5NqdF3oiBIjT9
         7nE54S6UkBpI4LwNnT+E6xrMkaCmmETTUbj9lcwj1YC5yfzt35Wr0COiPls7QHqjpk
         XV+q2O1jkWZ9SfImElh60pFeUKhkVjQJZhgDdhV4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.119] ([93.233.14.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1oFSQL1A4D-00AGJf for
 <git@vger.kernel.org>; Mon, 15 Aug 2022 03:03:56 +0200
Message-ID: <2ce1bf38-f2ac-b18e-d246-313fa4ac1428@gmx.de>
Date:   Mon, 15 Aug 2022 03:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To:     git@vger.kernel.org
Content-Language: de-DE, en-US
From:   Christian Gmx <christian.tallner@gmx.de>
Subject: Feature Idea: Documentation of Project Structure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O1uK4rAftKO2vLc7rOyaN8hLS+BDlf1fe8AWTl/oSvjH9WBdM4b
 UBUCBSpqTdJNjgep0Y5G7Ulloc0YnCI58fVgS7FKWOEiAtPT7XU9Ypn53tB0Kh9nlGmfo1l
 COqCRBL5yWOZpu6M29p4w1h0vX0C8OAcEvC+ZU79Dyx/RXoBWyIvY9DtQtb8RIaQbokuvzg
 pOstvAfqk5Qh8M7K4SMRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3aXi+htbIfQ=:Vkm/7EuvkJFJez+XqD2o7N
 Sf0PQsTlBISDakJNVp64cB/tqchB/NUyE3PiESWGp11OU5IoG9/Z50v9EJppIX5XgqI0AgrTV
 mnfMNw+pr21NVPFtEU9870JAwfAuVPrWcafDKLCkyJtJhM0ua/WnS/ZUpZh6Rvpwk+Z68OJgf
 sauINzpWpYUYZYs5mEe6gq68kgs6BsRH7Cvb8scDti9fWPVi7ZRaogvy9RE2W8hVW/wtQE2/U
 SjFL05c4kcRtr9ImzhydKF6p6pTpznfmVfIwUbK8gJvIFCQpl23WuhEX9bhbZehiUosnTSxpE
 R2v34Bws6nOOlAS7D/YHOXwmYToI4paTp5JBXUGQR4cA+boum6OJsdZrRsS/KxBwcFJ6jY0b5
 8+BjLZgIx6cF0TADUFgh+ElE78yptLZiPf94BhmkbGjupMgJ71K0gxlc7DIp6jVxW6eKuWdoD
 RAV167YT3ONx378X77PUyp5F7HcDBTFOt6CC9bHC2pJiSSSfDqDgGgPmwRU/yBdwbI5RbKPxh
 XB6/ta3mbpBBNYzvoeOex6D5VmduVwKTra2bOXIYIpdk3wwgxQE0rgWbkzf5Ws1sBfIUoNIOt
 xOmNVqw2wZ4RQcorMLdgCg/f/SbZUGU4rOsNRafFun80MvUKlrpdLTVUYrzDWiQ7d1+PuoNqN
 K6zAOVBPEO1MHxsrf/fuKc0f8qVL8ho0bQLK8pO5r1JrB6M5GHkK2+j9RrnS9L38XloQUroDE
 KRK7vwG+AgfS+NBv/P5SqoElWPI1nXrTIAbmfO0CyFEx8U2O2WLOpBw7aSwucfvpJWVpH/Ou8
 fbTcEq+6JyevqTQjL/Z5Eb32ifukHtATynWdELxleiomMaKVCIlSXnfedqcnDVKuIbBMn2XI/
 CEkqwC7AV9ZmtEGhvZkOWc/YVBSKu0UTtDanx6ZwpVsc7pk0BIwnRIXGEqtyvvxfL0OtPPVZ6
 CMLLFT00ZfwfuRxJ5srrPBBi6heThdAydNZSHjkdKw5BNhttJiO7Okkxs1Uvyf9rZgtzRiE+t
 7LoaR2fu2PMmnGVOcO3KSe7i4QefH8hfDyv2brTrtZTuZU/5cN8ktlwg/kRG0JYKPDr6kx3fu
 rZ6sMRxk85P/llfr/Bm45Rtt2jDqwNKFWVDE8pPXZMoPirgnFAVkKnpYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When browsing Github repositories, I thought it would be a nice feature
if you could annotate the directories of a project with documentation
comments that explain what is inside the specific directory. If this was
possible with Git, then GUIs like Github or Gitlab could include them.
The idea would be based on Java package Javadoc files which make it
possible to document packages, which I usually do to explain the project
structure.
I think it would be great for OSS, because it would be easy for anybody
who browses a public repo to understand the project structure and maybe
participate without having to read through the documentation.

=2D-
Best Wishes

Christian Tallner

