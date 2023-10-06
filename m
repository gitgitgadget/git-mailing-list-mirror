Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4719E81E1E
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 17:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjJFRPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJFRPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 13:15:04 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1BBF
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 10:15:02 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65af7d102b3so13793056d6.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696612501; x=1697217301; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MaZU7x4IgRpB25Osq9M4uHJCO+0x/Lmr5+/lC2TJhu0=;
        b=gRspIyd06t/Il4FrfJC56T7FiLtNWJmjU0QkvXx7PT/VeCUNhdeNUlj4+8Glp+92w6
         +m2W6FQdrCPyY5MgsFBk8t3boQUQIdznyJHW4/yrjcSaAvh9iHcRW1OnZSfvwzVCa5OF
         xOC7CBMvECFR3nVbQlVy+hYvqoWY1DWaToKrgwotGFD933fFMRLgbtyCLOHRy+fmqhQW
         mMvLxhtF2l1VkQmiqpOKKy+McZ/W9hg+jJugd6luSwg3mWtEICzXWvXg56gJjegKSWrH
         QCWwUQuurqBDd8kKsO79amEd9IynETBbZ5d4yjQ/30/RVWpdAJZ25heY99bVgVevzalo
         LoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612501; x=1697217301;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaZU7x4IgRpB25Osq9M4uHJCO+0x/Lmr5+/lC2TJhu0=;
        b=aYMTSD0GTnkm/axdfQ6xLFuyz5Aoaz7LjpkQ8PZKb3KTd7zujePNFS5NvrJYsNRKau
         tZSv4LouDMDxXjGASJW96EkNlSRAMdCLNe79A0TvHMIALY8rz3xTcjHPyRuMGry5exSf
         EOdwVPdgj7hE1xITW7Ou7VSJAG8BKuZjntWwko/wbaFQRt/yYZfmGpup380HXIbLIkYe
         3ko/qFqKCRer572+80WMpaDoxb9pqhklOrVaIdiXwpqQgFrXIfbcXL/xWeNKBrCZeLbg
         x5o/vHC7AAjRB6FNoQO/YxQa9a5JUcN1w0Uktj8zu40ucyaYzuvl0e1qOKKKL4+Ic5Cj
         NPNw==
X-Gm-Message-State: AOJu0YzAB0p+/gE0D3EAVhqBp4oEMI5g/ZIAhVGO0Jnc3pfBpIyrOKd+
        yJYhncofHxa7L5cw03xVmm7RSDyzhUI/3s9BVUKhX2SgfAI=
X-Google-Smtp-Source: AGHT+IEtJJmAFMpYW8neq06jPpees8romGwkxDOTCqSH8iEOHSvbqH9TXU5mU3OtvFl/XMMG/vIwsedpXtd1fgqO2Nc=
X-Received: by 2002:ad4:57a1:0:b0:65d:d:a114 with SMTP id g1-20020ad457a1000000b0065d000da114mr8756378qvx.55.1696612500757;
 Fri, 06 Oct 2023 10:15:00 -0700 (PDT)
MIME-Version: 1.0
From:   matthew sporleder <msporleder@gmail.com>
Date:   Fri, 6 Oct 2023 13:14:49 -0400
Message-ID: <CAHKF-AvUxH1Ar3Xijjb4_8N+_kssPHZVHqQSAE9kDGRfTYHyxw@mail.gmail.com>
Subject: gpg.ssh.defaultKeyCommand docs bug?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://git-scm.com/docs/git-config#Documentation/git-config.txt-gpgsshdefaultKeyCommand

This command that will be run when user.signingkey is not set and a
ssh signature is requested. On successful exit a valid ssh public key
prefixed with key:: is expected in the first line of its output. This
allows for a script doing a dynamic lookup of the correct public key
when it is impractical to statically configure user.signingKey. For
example when keys or SSH Certificates are rotated frequently or
selection of the right key depends on external factors unknown to git.

---

The command does not actually work (for me, git version 2.42.0) with
key:: prefixed.

It only works if I cat the public key as-is.

I only figured this out because the docs previously said it took the
format of ssh-add -L, which also doesn't not contain key::.

I am using this script for my "dynamic" key discovery:
#!/bin/sh
f=$(ssh -G $(git remote get-url $(git remote|head -1)|awk -F':' '{
print $1 }') |grep -E '^identityfile'|sed 's#^identityfile ##g')
cat $(eval realpath ${f}.pub)

Thanks,
Matt
