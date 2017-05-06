Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F894207D6
	for <e@80x24.org>; Sat,  6 May 2017 08:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbdEFIiT (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 04:38:19 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33547 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdEFIiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 04:38:18 -0400
Received: by mail-oi0-f42.google.com with SMTP id w10so9499758oif.0
        for <git@vger.kernel.org>; Sat, 06 May 2017 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/3meKEaW8zajXtudWhcpEbU055S7cGuojJAuLVxrmHU=;
        b=btXjwPGXS9WwVuaIBZ/gQh4FRGZ5LLNhiNXXCGQg4NlR/uoP9LwvegfmgiRftsKvRN
         HvDQ6LZM8jVUV4tBQ0PzEw8gEmIB6Qkn4UuKgmE74SkGhKytI8RKK9Vs9J0VDvb0HW5y
         nJmpBwqNqkdsqp7AS/c4h0FMNZ9ZmG2VY84IMVuyy8ZMH01ABfKtov+Q12M2AQ6Nz1tV
         6JN+T8sgVxqLgnCjjuIx9J81wjwMoxeIeRD2ep420mwIzKaLWJISAOnEqNtCSeEx7CWd
         eeXNkOSKmG/iDxLSJUfeyX25jlKwNbRD5C57ItyyeoIbKufNlisArzZJykxYhIYJE+3W
         9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/3meKEaW8zajXtudWhcpEbU055S7cGuojJAuLVxrmHU=;
        b=GW0yJq40SQ46VZ6bXWn+TIRk6PoycVdqPlJqlMzgWHCYb9vUezBcYv6zuqUbxaiH38
         KLMAXrX6QM/XTv3hGbyzKgtcu/uBVlVoHqv4PtgGwBhCLpW+clHLDV/UytHMl18TTtYu
         F8HKu6NtnNF1U/nroyXhb3+BlhHncroREauTH9eFgNAIiQ6GYAi5AtKuRBB2egV0znOO
         YrcNMq+BBQxHV8MxuBaQv9e74A/AlxOTdGzMgGmn/YIzyMzEHyBbWyMD5UkdwrBYynC3
         lLKlZZucPMPb5iJdn68OBItCLZyxmaFG+ACHWYINJb+8n6SrYRNRNCwP6nd7aN09w6E6
         73QQ==
X-Gm-Message-State: AN3rC/6jIZLwDEZuzO3lnBA7YGqc8Yq/XjC+8Y1hCJsQ/UANSjeFc2qC
        ecXQtqRoTM0CuIrbM+qyJ0x103PoC/mp
X-Received: by 10.157.42.111 with SMTP id t102mr17275714ota.123.1494059897194;
 Sat, 06 May 2017 01:38:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.38.41 with HTTP; Sat, 6 May 2017 01:37:56 -0700 (PDT)
From:   Ciro Santilli <ciro.santilli@gmail.com>
Date:   Sat, 6 May 2017 09:37:56 +0100
Message-ID: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
Subject: Add an option to automatically submodule update on checkout
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a must if you are working with submodules, otherwise every git
checkout requires a git submodule update, and you forget it, and
things break, and you understand, and you go to stack overflow
questions http://stackoverflow.com/questions/22328053/why-doesnt-git-checkout-automatically-do-git-submodule-update-recursive
| http://stackoverflow.com/questions/4611512/is-there-a-way-to-make-git-pull-automatically-update-submodules
and you give up and create aliases :-)
