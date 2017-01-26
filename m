Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA441F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 13:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbdAZNaW (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 08:30:22 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:58651 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbdAZNaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 08:30:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 379151E2FA7;
        Thu, 26 Jan 2017 14:30:18 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SHRlxuom5SbQ; Thu, 26 Jan 2017 14:30:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id C2E8C1E2FC6;
        Thu, 26 Jan 2017 14:30:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BDUXLdOTIlZI; Thu, 26 Jan 2017 14:30:17 +0100 (CET)
Received: from [192.168.178.64] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 3D6981E2FA7;
        Thu, 26 Jan 2017 14:30:17 +0100 (CET)
Subject: Re: SubmittingPatches: drop temporal reference for PGP signing
To:     Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
 <20170125002116.22111-1-sbeller@google.com>
 <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>
 <CAGZ79kaRdtKD7DNJRWXsyg07GbTM4OsKUmHHcFczEMJA1YK2KA@mail.gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <baff65ba-1e98-d5a7-5b5a-a50a7fc723ee@tngtech.com>
Date:   Thu, 26 Jan 2017 14:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaRdtKD7DNJRWXsyg07GbTM4OsKUmHHcFczEMJA1YK2KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> 
> Yeah I agree. My patch was not the best shot by far.
> 

How about something along these lines? Does the forward reference
break the main line of thought too severly?

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 08352de..c2b0cbe 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -216,12 +216,12 @@ that it will be postponed.
 Exception:  If your mailer is mangling patches then someone may ask
 you to re-send them using MIME, that is OK.
 
-Do not PGP sign your patch, at least for now.  Most likely, your
-maintainer or other people on the list would not have your PGP
-key and would not bother obtaining it anyway.  Your patch is not
-judged by who you are; a good patch from an unknown origin has a
-far better chance of being accepted than a patch from a known,
-respected origin that is done poorly or does incorrect things.
+Do not PGP sign your patch, but do sign-off your work as explained in (5).
+Most likely, your maintainer or other people on the list would not have your
+PGP key and would not bother obtaining it anyway. Your patch is not judged by
+who you are; a good patch from an unknown origin has a far better chance of
+being accepted than a patch from a known, respected origin that is done poorly
+or does incorrect things.
 
 If you really really really really want to do a PGP signed
 patch, format it as "multipart/signed", not a text/plain message
@@ -246,7 +246,7 @@ patch.
      *2* The mailing list: git@vger.kernel.org
 
 
-(5) Sign your work
+(5) Certify your work by signing off
 
 To improve tracking of who did what, we've borrowed the
 "sign-off" procedure from the Linux kernel project on patches
