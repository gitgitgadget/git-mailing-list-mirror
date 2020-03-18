Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A69C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593002077A
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 18:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0iI57sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCRS76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:59:58 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:43919 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRS76 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 14:59:58 -0400
Received: by mail-lf1-f43.google.com with SMTP id n20so18002483lfl.10
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 11:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Zka7qyoUDxkeisTG+Z9ezDIHrx2Zf8j9Wp1eNapfw1s=;
        b=f0iI57schgIXZZn1O+cmmdEqirh8dcXAd8EEGKHbARPjhCVpgGusKbzD31S/cf1qLN
         vQCPWe4JfUbqJ8Hv4mAtyADYEKjK8ymWCKvha3ip8isR5/Que/p98KMIdXKTOi6/s5US
         JW2mYtdHyJyCtFLUHWjAeuPqH0aY63S/CStD3Ej2fPL2TQAw8330xap5H0lNTsdiCnm8
         KFMx4G63cEL/xQjfAU+uTmRCQlFbSSfxPvvsBXwVh/cyqWQOX92u9ANCcp6y67HsYE3h
         M1Q2rUWM1JdeSr4u0gwS40CSbZ4cnbLHJ1mhzgdQ7ezk88FFONSnHfKEXZrzLUXE7noJ
         toeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Zka7qyoUDxkeisTG+Z9ezDIHrx2Zf8j9Wp1eNapfw1s=;
        b=eaM7pS+2eRqZIEextItX21ZFNPumTDUKAMI5RnwmXbzQ9B7gWT3QD1S2kfdSeQrZjY
         J645nxNXvanVDNzovVo2abngzqTcXkghJUF/j1uTAhbY02chBrq+4bAR+r58Ad9ylnWh
         P6KmYMKj9KwjYQSQVuVCXbldmL+E1QFMRZKiNrRjKsbrctgupH2ajDNCdLVQwGIIukED
         XkrTYe8iZ97rZZH5aN+Ni57G5GejYnMrRI3US6zGM8D1zSKlNdhHHu+RLSm7bJmjumd4
         Tf0A0S8sAs3ipaMC+Og91wJfpJSqiFq6iMPz+dLrHFVUNcQiApg/G4v+anKQE3nBABRx
         uyQw==
X-Gm-Message-State: ANhLgQ2xm3v1HWWC3gFIpSdoZR3yN2nkSoXZVAMum3f0ds2tECpTM8Js
        Zk5XXueKykMn6pSaV2dOWD0DwD5jvOX8HxIn2Ut3DpY2bSw=
X-Google-Smtp-Source: ADFU+vvu2tFrSSBWt3iW8MbFTaF817Gt1oJr80fHm7k4EFQLQCcU5uz2jtCh7/7dehUSIGwUaru0F2em3S/UfiJgzCk=
X-Received: by 2002:ac2:5c5c:: with SMTP id s28mr3851109lfp.100.1584557996211;
 Wed, 18 Mar 2020 11:59:56 -0700 (PDT)
MIME-Version: 1.0
From:   Harshit Jain <harshitjain1371999@gmail.com>
Date:   Thu, 19 Mar 2020 00:29:44 +0530
Message-ID: <CACuU+s9BsWVCMXpp6KgJ-NaDuadcegZ2kVSMmuAYO9YquTK8LA@mail.gmail.com>
Subject: [GSoC] Microproject for git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I am Harshit Jain, a senior undergraduate student pursuing bachelors
at IIT Delhi. In the coming summers, I am really looking forward to
contribute to git as a part of the GSoC program. And for the same, I
am working on the "Use test_path_is_* functions in test scripts"
microproject. As a part of the same, I found a few test scripts where
the 'test -f' can potentially be replaced by 'test_path_is_file'
function. I changed one test script and it works fine. So, should I
just commit this change now (the change looks very trivial to me) and
if not, how to proceed from here?

Kind regards,
Harshit Jain
Senior Undergraduate, IIT Delhi
