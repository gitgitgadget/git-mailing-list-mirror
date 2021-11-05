Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96303C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 01:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D3961246
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 01:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhKEBlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 21:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhKEBlK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 21:41:10 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02A4C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 18:38:31 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id v20so14375653uaj.9
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 18:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=0MPPqzRv5tbR35AcPWbM4ZQ0Kt1zBRDvDNv/hnPAYfo=;
        b=DUFiPDvcAg8AuzoxeEr0r+FNHligQQ83Yvm6e+LPoAD/1hJMPwazORfycTdsnnwcum
         JwlPelVtesHeatlS5+W9qbTy0D0qNFBTpkhPNr3k+ugGuuacjtMCuOE9p2rannH3mv/J
         775en1MpAp7SCZK3sQDzb9b2ZN2ZJVVaSPNa478N15cZvVWiUOxBTlP5VotzBKDVrnmB
         cms8JmMo/iuHajPEpRmx+KBSy6rrA/drYGGxZ5J7DLrzts7hZIrnjeg2EMjCe98691m7
         eE1Sk4Jf6dyWp2FQw/Mb1A2Ds54GENPdD8G+uuRVQJw0rkR4NGD5PDJ3tRErIA9Mkb1y
         0IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0MPPqzRv5tbR35AcPWbM4ZQ0Kt1zBRDvDNv/hnPAYfo=;
        b=V2+D96PgRL1YuxNXomduZRnwKEeba7U1iYVXXKf4pp0ztMUki6h+DUTX+G6ZIxSVS2
         9iKOKrxUSEc5ji9edUJOMxF+5J0pooRhhPDmL88aPWOq/BDjmXeOFP0IB59Dy6Wqz0D7
         LcQD/G8MKIg/2qcWXKIRSLDxZ6ZQ7hk8Y/36bEpVoK54AVO0qgn0HPtjUh4hu4L4H2X8
         yIFOrAnrgjoKer2orlKe5roRpdqbt8oJ3Dh0a6jkxRt4Qdo6ZK4+VFgez/0OrVoKk74z
         NxVSFtGhaBIoWfbu7fsZKgl8PiKpr9FfLgaR3jiuOk4rBmvn5ryhUfAThXmYyiMyttMe
         QxPQ==
X-Gm-Message-State: AOAM531jPyLGVPovBbXSBqdGpIWyRx4Pnk3YyttlGOlO4HJmz2OwwVi6
        yExkTM/90qaF5J4AeV3w1QWO+UwWzWZp3xoaCJxSShSBRJ4=
X-Google-Smtp-Source: ABdhPJyXhwABEZEygeb7S7nCovpsH5a9+6WKM5rW1HVzhso1Ewv0KcDRdO0YzcssFXGwroYfKS7LFILndL0AQFzDrMA=
X-Received: by 2002:ab0:6446:: with SMTP id j6mr61412294uap.121.1636076310928;
 Thu, 04 Nov 2021 18:38:30 -0700 (PDT)
MIME-Version: 1.0
From:   Austin Stephens <austinjstephens@gmail.com>
Date:   Thu, 4 Nov 2021 19:38:20 -0600
Message-ID: <CAO++afGMFu5XBQ7aSMJD4KraTQ+pbo5ksq3zULwFt01zj4HWHA@mail.gmail.com>
Subject: 3-way diff tool support
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When might you be able to implement this? 3-way merges are doable, but
I was hoping to be able to have my diff tool (Beyond Compare) be able
to receive a 3-way diff from git without having to manually check out
a copy or modify my repository's state.
There are multiple Stack Overflow questions regarding this.
