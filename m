Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEBB20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbeLMPDi (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:03:38 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:35715 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeLMPDh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:03:37 -0500
Received: by mail-oi1-f171.google.com with SMTP id v6so1869452oif.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=BH8zGfm5RXWeVND0d8uQDGQIIgcOYnsl/0cZ85Noe6Y=;
        b=jc3jW4HZzd2Fild2bH0PW5b/H/rY39ZBI4t010Zlcz99PKQU7rue6YIjtw1cfVFxY2
         YzbgXKJv1huf+DyxPjVb/t6/jCo4YF2iVobLmLxk65oI3dX9gPxDYrAIKv8NZdy/eoLl
         eVMikjhmxIGxruxCDwa9o6O48ZpmPAUlNKtwFrKrHR6wRYdILHRrr8lI/jTEp3IrsKn1
         yFn9x7+e72XgZxh6PWHV9A+tEzC/cQKraO5kgzEzKwWStWR6LZOQrl7uwUrxovae1daV
         qJfQyJ7Z8hpdUCvirWO9lRQs4xc9ZZrKr+33D+z0p7Paos6tMqXaj4ZA989+NgDJuHsh
         4HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=BH8zGfm5RXWeVND0d8uQDGQIIgcOYnsl/0cZ85Noe6Y=;
        b=Iot9CcL+mzvdHkS14KOcXBoz7P7iA3NVN9e4cZmy+Lro5D1H/vkNnLWAD8aHBxpj4f
         JekCD+QcU7RG1WrdS1mBYEvLZ87JpSyyyST1rSQdd66qFijeH1mRi+yEfbJAjFSuwvMA
         Ch3J4/HSfXPbqjavDkDpcKwXcpSJ8gMEkRWNiOjdbl45+pJD06vuUB3fBRBVT25Nu1sI
         gZk5BdOfCUMDt+ipX1EJ9NkG25P9HKt7+MkxnSH31zebQWDxR1Nb3o9ZWDZF2gGxi2lw
         zxl5CTCY32mSPhcJPe5Byd4EYLDArpzH8yoJ0JnniJidwSOPJZiz9F/pavjaLVfTxlwa
         uuHw==
X-Gm-Message-State: AA+aEWYUq+TJTLGLVDWuNeWS4tm+NWU7JtvwrcDMEBRMJL1Fb47L/CAX
        +PaXo19psTDDW21dRPojqR3JtUiW+kk=
X-Google-Smtp-Source: AFSGD/VdxVzGCBLikqDo7L+ATgK/6Yg6TmQn3u7JChzehl0dbSyo3jhTUuq4f/8isGuMGrGyatPAvw==
X-Received: by 2002:aca:5c4:: with SMTP id 187mr2924959oif.20.1544713416081;
        Thu, 13 Dec 2018 07:03:36 -0800 (PST)
Received: from ?IPv6:2600:380:b228:97fe:ac0d:a826:745c:7356? ([2600:380:b228:97fe:ac0d:a826:745c:7356])
        by smtp.gmail.com with ESMTPSA id k13sm1559052otj.19.2018.12.13.07.03.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:03:34 -0800 (PST)
From:   Andrew Kharchenko <andrew.kharchenko@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Thu, 13 Dec 2018 09:03:33 -0600
Subject: Pre-commit hook does not work properly in recent version
Message-Id: <678FE577-1708-4B7A-8EE6-EBE2514A4D04@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16B92)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I found a bug in Git v. 2.20.0 and 2.19.x at least, where pre-commit hook do=
es not work properly.

OS: macOS High Sierra
Git: 2.20.0, 2.19.x

Description: pre-commit file should be marked as executable in order to recr=
eate the bug. When executing =E2=80=9Cgit commit=E2=80=9D, it silently exits=
 without any message.
It was found, that Git version 2.17.1 still works as expected.

=E2=80=94
Sincerely,=20
Andrew Kharchenko=
