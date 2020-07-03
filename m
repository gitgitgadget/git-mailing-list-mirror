Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF97FC433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 04:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F322067D
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 04:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tomaszubiri.com header.i=correo@tomaszubiri.com header.b="gfuoMN2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgGCEWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:22:14 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21338 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGCEWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 00:22:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593750131; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jYzD/mF2Z+beppEdDMAt6VNkcc337pq4EkvHwrWbdEzoiF74dmdpwvvyuueqXuy1LP/NWfIO07xkBe46co8hLCV/GkoB37K/h8G5DzPYAsslUwXSLv3HCzhLQ6Qnlt9wIZ5t6bnrx24I/kNbJYTeREcx3F5aAksyQVZ6fMa1Kdg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1593750131; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=tcprOcyiLl+TJ8G+is0i7IyB/tdRuMe/bIvKE51+CPo=; 
        b=VpIxaz15+veEJmN4tpYFO8yoEgohxzatMoKwyjcW8waMdTz0vF9SsidWgNnAZkEZeF5elzq2C9Xa/e0CCDGlcFi+rEmq4ZfgZX22JLIFWG/+WC4r72qGpfvIrolSdcZOr0xa4z6dfxda9rRI2opPQyTVtn1Sfj2LCwlkLBYjV1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=tomaszubiri.com;
        spf=pass  smtp.mailfrom=correo@tomaszubiri.com;
        dmarc=pass header.from=<correo@tomaszubiri.com> header.from=<correo@tomaszubiri.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1593750131;
        s=raiz; d=tomaszubiri.com; i=correo@tomaszubiri.com;
        h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=tcprOcyiLl+TJ8G+is0i7IyB/tdRuMe/bIvKE51+CPo=;
        b=gfuoMN2tx2bOJEvaZnmxg+QXttDrQkDyNuPh8b+DGbyueC0BxCc2XLSnVSd5tXLQ
        F6somoxfhurOxU9MsNXaQFVk8z0P37mxBH0DdUZpx35PItIFrHRwPOSXpQX0bHiTLOq
        bNMzscdLXra012nNs5TeLaYB5DAYPCEbkMpijljg=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1593750129721399.48116947775156; Thu, 2 Jul 2020 21:22:09 -0700 (PDT)
Date:   Fri, 03 Jul 2020 01:22:09 -0300
From:   Tomas <correo@tomaszubiri.com>
To:     "git" <git@vger.kernel.org>
Message-ID: <17312e90c37.fefa495d137526.1559287962218705021@tomaszubiri.com>
Subject: commiting a change from command line with newlines.
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm trying to write stanzas in my commit message, and naturally the ASCII newline character is the best tool for this, beautifully integrated throughout my whole system, from my keyboard to my screen.

My question is, how can I add a newline from the git command line without opening an external program like vi, atom, notepad, word etc...

Since I'm using a unix like system I even tried with pipes (and xargs, the necessary evil) but with something like "printf "a\nb" | xargs git commit -m" b gets interpreted as something else. 

Does anybody know of a way to adorn a commit message with newlines in a single git commit command? 
Thanks in advance.




