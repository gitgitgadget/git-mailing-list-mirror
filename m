Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1041FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 12:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbdFVMq6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 08:46:58 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33981 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbdFVMq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 08:46:57 -0400
Received: by mail-io0-f171.google.com with SMTP id c201so22272284ioe.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=UJGgV16YmtyulBikkpxqHy9U5m8GXHGd0IfxEocOUbc=;
        b=uC9UarPZSzfiD/WYNGP1fd5sCDQ9684Nux9rEm6b5HD90HQ/FGFI6rRtuMQVWrUfi5
         eNeXYBowpPeTLXZlEteVKnGUbMPWhviaYift3grcaL92Ruh7KdDbw4sfIb4FYq/HbqvD
         TLnUs4ZgM6EkKKfgupeqcsuoAMF1j9W1u++DF1/HsT66JiABKHvI+FhqVkOAZM1SCgvT
         XDZMwsVjS26KPMk93lIcPFWta+VaVnoYAdJIAbAf3AgJ1qtz/Wmm5pZH2APHMGdK/81e
         zIdtC1Ia2O5rbz/h9qQ4c4PWRPXqLECalpdZTXWUdDiAqNaQj49KbbSirrgMCEIJ1XMR
         SnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=UJGgV16YmtyulBikkpxqHy9U5m8GXHGd0IfxEocOUbc=;
        b=K5rf6wvWBkfN1po7yGw4xY15dY4DTd1HgI1EXhdPMccae6+QEowOvHe/JV365o/e3N
         +2P5ZIt5ZYrjnhF7UcuglWy8RwZq8ZXWi7uqmnDnxz/+GtzPxrT3gWVTY3cQvc+ich0M
         xqw+/9nz2zZcPct8cNBXkDPHSC8QurmIkYtQBo1jBTPa8o4Pd2xiPsWKhZbs7MRUDPEy
         cmXlhBCqseWrN4ilhajGAbPUJtt+JmALjJBFQpFhroQw5MnXAkkV16Dv7ObY9W5tUQGf
         cF+RcctW08Cn6BHZjwJZ2zNbYJakpD/Dfaor3lWAeam/fsALLD68Ba+zDmJFDGnOuvZS
         cA8Q==
X-Gm-Message-State: AKS2vOzgYApjoWRzwQbVYpWyltAD528ed043+o74yKkmBGm4LfNzwrkz
        Uv+39imbk2B9IKETUws=
X-Received: by 10.107.191.71 with SMTP id p68mr2022776iof.100.1498135606796;
        Thu, 22 Jun 2017 05:46:46 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id g198sm934174itb.29.2017.06.22.05.46.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 05:46:31 -0700 (PDT)
Message-ID: <1498135581.2089.1.camel@gmail.com>
Subject: Ambiguity warning printed twice ?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Thu, 22 Jun 2017 18:16:21 +0530
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Happy day everyone,

I accidentally noticed a weird behaviour of 'git status'. In a
repository I created a branch with the name 'HEAD' by chance. When I
run 'git status' in the repository it prints a warning about an
ambiguous reference about 'HEAD' which is expected but it prints it
twice which seems suspicious.

    $ git branch
      HEAD
      master
    * test

    $ git status
    warning: refname 'HEAD' is ambiguous.
    warning: refname 'HEAD' is ambiguous.
    On branch test
    ....

Any reasons behind this behaviour or is this a bug?


-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
