Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D2C20365
	for <e@80x24.org>; Wed,  4 Oct 2017 16:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdJDQLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 12:11:22 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:54738 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdJDQLU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 12:11:20 -0400
Received: by mail-pf0-f179.google.com with SMTP id m28so1546878pfi.11
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=TUi3fjzjHdIwgOG62Imi9QIuR8xj6yDHgh1NbjzueGc=;
        b=RPQWHg0MRk/sgdiuAfQaw5eRFkY6AtpC0aWFJhm/sVcpIqlV+woXclrOgEykM04GRI
         bca8Rx+r/2tBRucwh6kf+E5HgvvFHvn43GAJ5xxV4b3fiEDmeldDzMjsvPMLM3FklOXv
         eGiphUGPlOeCdw9XcBxvmKCW/W8woqMb17c59J2anv9t9XrmoMRE7MxYcu5jBtdlWSo8
         Z0rCewgQNzy1ECBX/6eFLfqsGePcQ6nRBMYQX0wJe8xMbLHGVWUA3drDjYHKtGYvcsEe
         XM8qjj3EuMD3eYTGnh62eAhTqsKMXvRHvypqTG1qtiIDw58rp/ci4GaPdRU2+Mfz6I5O
         fIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=TUi3fjzjHdIwgOG62Imi9QIuR8xj6yDHgh1NbjzueGc=;
        b=ZJrySX0vsgNs5rxj9/QhqPgsT1z+b3C8k0Ebn6jpbvip+kUz9m2vNCN5dqTA9244Ms
         bDnyh4I8gaAFVdzknI/0uoGG26tyFrK+ZyMtkFgNsBilGoOamUYgnIAJTE/ecO3Ll6kr
         m311FUOw1Mhr9hRKrB+Iqo0Y1slrg7fJ0PCBSghnY3BHF/S7qO4L0K1VQbIA4Pl4N3Sn
         p0HrzVInItzuA51HrX1GMPvo87fuuPGmeZg7HVu/CRblEEPnoDvFoGtrBBTPwlx4Z3O4
         ogqdO1iTjgmVvo/wO3DQsj9IkhzuVMuDFktNjvp9OWQ+5j8ADdj/h0+00t1vVroxkrKk
         2e9Q==
X-Gm-Message-State: AMCzsaXFdOQWELwak3kW3LjOS7k8IeN02fFA1wlgX2Txrr5vH6TIVV7M
        363wPDaDlTbtPj9UT3KH8QyY5NcY
X-Google-Smtp-Source: AOwi7QCIks1nrKkx7u7GciO6wX+DV27BWO4B+u525427KRbNGGAJYpcnjXizs4OE+vwxiRp/B/pR6w==
X-Received: by 10.98.60.21 with SMTP id j21mr6420515pfa.312.1507133479608;
        Wed, 04 Oct 2017 09:11:19 -0700 (PDT)
Received: from mix-director-10 (astound-69-42-0-111.ca.astound.net. [69.42.0.111])
        by smtp.gmail.com with ESMTPSA id b22sm25249326pfh.175.2017.10.04.09.11.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 09:11:18 -0700 (PDT)
From:   Ernesto Alfonso <erjoalgo@gmail.com>
To:     git@vger.kernel.org
Subject: disable interactive prompting
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
Date:   Wed, 04 Oct 2017 09:10:48 -0700
Message-ID: <87tvzehp13.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Waiting for git-push synchronously slows me down, so I have a bash
alias/function to do this in the background. But when my origin is https, I
get an undesired interactive prompt. I've tried to disable by
redirecting stdin:

git push ${REMOTE} ${BRANCH} &>/dev/null </dev/null

but I still get an interactive prompt.

Is there a way to either

1. disable interactive prompting
2. programmatically determine whether a git command (or at least a git
push) would interactively prompt

Thanks,

Ernesto
