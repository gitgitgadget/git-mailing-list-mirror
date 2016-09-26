Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025E0207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 18:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162370AbcIZSBz (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:01:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52967 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034290AbcIZSBz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:01:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u8QI1jZI032632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 26 Sep 2016 20:01:45 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8QI1laD008936;
        Mon, 26 Sep 2016 20:01:47 +0200
Date:   Mon, 26 Sep 2016 20:01:47 +0200 (CEST)
From:   Gustavo Grieco <gustavo.grieco@imag.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <48506427.8357405.1474912907126.JavaMail.zimbra@imag.fr>
In-Reply-To: <xmqq37kmtukf.fsf@gitster.mtv.corp.google.com>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr> <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com> <790613313.8353074.1474912139102.JavaMail.zimbra@imag.fr> <xmqq37kmtukf.fsf@gitster.mtv.corp.google.com>
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using
 git 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF43 (Linux)/8.0.9_GA_6191)
Thread-Topic: Stack read out-of-bounds in parse_sha1_header_extended using git 2.10.0
Thread-Index: UIIrBiEClFKQi9A0s0XYvpJ5kX5kvw==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 26 Sep 2016 20:01:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8QI1jZI032632
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: gustavo.grieco@imag.fr
MailScanner-NULL-Check: 1475517709.12692@DkmOrAmtXkns489DfsYjMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fair enough. We are testing our tool to try to find bugs/vulnerabilities in several git implementations. I will report here my results if i can find some other memory issue in this git client.

----- Original Message -----
> Gustavo Grieco <gustavo.grieco@imag.fr> writes:
> 
> > Now that the cause of this issue is identified, i would like to
> > know if there is an impact in the security, so i can request a CVE
> > if necessary.
> 
> I am inclined to say that it has no security implications.  You have
> to be able to write a bogus loose object in an object store you
> already have write access to in the first place, in order to cause
> this read-only access that goes beyond what is allocated, so at the
> worst, what you can do is to hurt yourself, and you can already hurt
> yourself in various other ways.
> 
