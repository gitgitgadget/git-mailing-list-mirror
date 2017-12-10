Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187721F407
	for <e@80x24.org>; Sun, 10 Dec 2017 20:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbdLJUXr (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 15:23:47 -0500
Received: from a27-62.smtp-out.us-west-2.amazonses.com ([54.240.27.62]:60400
        "EHLO a27-62.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752015AbdLJUXq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2017 15:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1512937425;
        h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:Feedback-ID;
        bh=xQhqMHE3nJpRtS0T6pUk+9xryyff7f9oNkOk4zSOeZk=;
        b=A2Ldyq6LnB9q/GIcJNxtc1mYMKSpKdHI7M4YvCvsAkI215s0s6yCEg2IOS7VRzDb
        X6VNqJC+b1KveqwQzCtRD8hEZS8RJoc/YWRF+aITn5ySdqbL5xV+i1SWqxIK3pkeuWJ
        hi/8pmw/QIBe4wjIPC7UXZItlMYceFd9HTGYk/2Y=
Message-ID: <0101016042190a3b-091dfab3-e010-4fbe-94e7-739ae3090883-000000@us-west-2.amazonses.com>
From:   "mqudsi@neosmart.net" <mqudsi@neosmart.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: SSH port ignored when ssh:// prefix isn't specified
Date:   Sun, 10 Dec 2017 20:23:45 +0000
X-Mailer: sendEmail-1.56
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-660011.932560341"
X-SES-Outgoing: 2017.12.10-54.240.27.62
Feedback-ID: 1.us-west-2.PCEy91/Vd+GU67P48MglE9FKtQG6qQD9MhgwC/YKQRM=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-660011.932560341
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Greetings,

It appears that for non-standard ports to be specified for ssh-based
clones/checkouts, the leading "ssh://" prefix must be applied. I am unsure if
there's a reason for this or if it is simply an overlooked idiosyncrasy in the
parser.

Basically, while `git clone ssh://git@example.com:2222/path` works, the same
with the `ssh://` prefix doesn't, and attempts to establish a connection to
port 22 instead: `git clone git@example.com:2222/path` (I'm not sure what it
will do with the `:2222` should the connection actually succeed).

Mahmoud Al-Qudsi
NeoSmart Technologies


------MIME delimiter for sendEmail-660011.932560341--

