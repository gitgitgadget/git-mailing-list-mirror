Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EABB1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 15:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756410AbdLVP5G (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 10:57:06 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41796 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdLVP5F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 10:57:05 -0500
Received: by mail-ua0-f195.google.com with SMTP id q13so19931366uaq.8
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TQtPHcDCL3WwBXL/0+9AQ35WJMcMrkfS16lvGZh5oYA=;
        b=PVvrS7zHgw+DMGUPsKiYlY4wmLeKc0I9Ht8mkwZki+c/uNjnYANdAP5jO7NXQvKsKa
         2+cIgQoRWlBKSjC4ngx+CIo9p55x6VIIcWtFyeBvnFD3m4ayqiQnb1l5ibSaFfPSUPUX
         xF0IRRNZvmC3R0JuINEb3GrRUEunSwNqLxY1aKuHe3ne2dKI0WyjpOAtceysIzUY/skv
         Q2XXxfnAwMAzG8L3iQV6x/RBtwX7yvYjsRDKnlcYpzFcAUfsY7f07g4N2L+mlN6XrKUi
         QzFT8ji9Yg3MALdjkuFGJOu7I1KFAer7l+ke7gsrbtvhkRFDwFxb2I2o+1pQE+61Oymn
         wJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TQtPHcDCL3WwBXL/0+9AQ35WJMcMrkfS16lvGZh5oYA=;
        b=oOUmHhDGdtdk+o257/lVjIjO6ERiDaGyNiM22a4pD7E2sGoTxhd4lOPRh3NbPTE3BL
         ULd5gLAqesyN5N0JzAVFQ9nnVyDJ5QYmKJzKzPtSgNDziuQCFfSGFIDS516D5adMBwU9
         vhI5UzKzGH8TEjJbwb4kca8vW/y2o8Nj/Pb3IJK7zSsVEz5bo5ruWq6zdmKbZ30YAb4a
         Sqj4pFUcvgYckTlOSjmn4Sbm/jCQHs4Tfp2ttQ3gMF+Jt96ObfL1Voq8SJLX3Vh75TMJ
         UNPHeIopa75977sVrmL/joUIuTmH7zAjD4ag/1DZ6jBFEFR0l3eV43bBIUjXctek+jvM
         Z8og==
X-Gm-Message-State: AKGB3mJCmBDRYKtS7BQiPAY4MxVUQwGpIHXYf7JQ0nnQyMnfe/c8MXY0
        heEeWsdZjYDfVLikyR3YzDKMKzmgZNPorAsBXAw=
X-Google-Smtp-Source: ACJfBotkuTQdp9gR0/X9jZQmLkq4HLwpsrpTJRWU7FGDUZI8j/Pu2eU7LlA5sL89GmCRBAwA16aAotC86dHqzuCNWm8=
X-Received: by 10.176.25.199 with SMTP id r7mr15715936uai.62.1513958224336;
 Fri, 22 Dec 2017 07:57:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.112.3 with HTTP; Fri, 22 Dec 2017 07:57:03 -0800 (PST)
In-Reply-To: <CA+P7+xojknncFrP5qCB4EKG0MAoTUqFWS5g3Bj+Jq2_RO0fA3A@mail.gmail.com>
References: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
 <CA+P7+xojknncFrP5qCB4EKG0MAoTUqFWS5g3Bj+Jq2_RO0fA3A@mail.gmail.com>
From:   Cristian Achim <brancoliticus@gmail.com>
Date:   Fri, 22 Dec 2017 17:57:03 +0200
Message-ID: <CAEW+b66pCqTBz6o_aTK0byyKsDc8HRfHuqKf64Ob6pBtL9w2Lw@mail.gmail.com>
Subject: Re: Usability outrage as far as I am concerned
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Can you show the output of "git remote"

# in usb_subfolder
$git remote
origin
$

#in home_subfolder
$git remote
$

> and also
> clearly explain with details the layout of what the folders are and
> what is or is not a repository?

Take the following update into consideration and then reread my first
email hopefully with improved clarity:

'home_subfolder' is the path on disk inside my user account home
folder in the 'home' root folder to the initial repo from which I
meant to do a backup.

'usb_subfolder' is the path on disk in the 'media' root folder to the
initial empty folder into which I wanted to do the backup above that
points into a usb stick I mounted in the default Kubuntu KDE file
manager way of mounting usb stick folder hierarchies.

Current situation is that 'git log' in both home_subfolder and
usb_subfolder show the same hash with only one branch in both. From
usb_subfolder 'git pull home_subfolder' is broken as in the original
message.
