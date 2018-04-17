Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3DE01F424
	for <e@80x24.org>; Tue, 17 Apr 2018 08:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeDQImI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 04:42:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49258 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeDQImH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 04:42:07 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7159B5C0582;
        Tue, 17 Apr 2018 10:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1523954526; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=17nSnfeZTHLFpmJyeEBa3O1l4OaOmRmtqeLF0H3PjYU=;
        b=D4D8IsIcmvyNqCMlkAgF30SyWRURS5Bo3ECFufECnjiMwKUfRL1KgLWfFSzulpTerS1Ecx
        AcVJTOlKw/E0BD00CcCd7meHPtoleWvHnBOYCLJDS4JNjV9CSCVX4pfJI1sDDbnYdR1Pms
        laSOJSxwPON/HCjV5fLhL4j146QIfkk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Apr 2018 10:42:06 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     git@vger.kernel.org
Cc:     digetx@gmail.com
Subject: git send-mail sends with duplicate In-Reply-To/References header
 fields
Message-ID: <997160314bbafb3088a401f1c09ccb08@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Using git format-patch --thread + send-mail leads to
In-Reply-To/References headers added twice (with the very same value).
This is not allowed according to RFC 5322 Section 3.6:
https://tools.ietf.org/html/rfc5322#section-3.6

Ideally probably git-format-patch should be smart about whether
In-Reply-To/References are already present...

I noticed this after looking through emails catched by my spam filter
more carefully. It seems that this particular violation is penalized
quite harshly, leading to those emails landing in my spam folder. It
seems that there are multiple kernel developers which use the above work
flow and hence send emails not adhering to spec...

--
Stefan
