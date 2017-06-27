Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E94A20401
	for <e@80x24.org>; Tue, 27 Jun 2017 13:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbdF0NbX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 27 Jun 2017 09:31:23 -0400
Received: from mail02.rohde-schwarz.com ([80.246.32.97]:64886 "EHLO
        mail02.rohde-schwarz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdF0NbV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 09:31:21 -0400
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jun 2017 09:31:21 EDT
Received: from amu316.rsint.net ([10.0.26.65])
          by mail02.rohde-schwarz.com
          with ESMTP id 2017062715161407-205737 ;
          Tue, 27 Jun 2017 15:16:14 +0200 
Received: from rus18.rsint.net ([10.0.33.18])
          by amu316.rsint.net (Totemo SMTP Server) with SMTP ID 605
          for <git@vger.kernel.org>;
          Tue, 27 Jun 2017 15:16:03 +0200 (CEST)
Received: from GMU01.rsint.net ([10.0.32.21])
          by RUS13.rsint.net (IBM Domino Release 9.0.1FP8)
          with ESMTP id 2017062715160199-2088 ;
          Tue, 27 Jun 2017 15:16:01 +0200 
Received: from GMU01.rsint.net (10.0.32.21) by GMU01.rsint.net (10.0.32.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 27
 Jun 2017 15:16:01 +0200
Received: from GMU01.rsint.net ([fe80::9832:f3b2:8965:c618]) by
 GMU01.rsint.net ([fe80::9832:f3b2:8965:c618%12]) with mapi id 15.01.0669.032;
 Tue, 27 Jun 2017 15:16:01 +0200
From:   Robert Siemer <Robert.Siemer@rohde-schwarz.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: submodules of submodules use absolute gitdir in .git file
 (instead of relative)
Thread-Topic: submodules of submodules use absolute gitdir in .git file
 (instead of relative) /ur/
Thread-Index: AQHS70ddtTno6xswW0WSIxWyFZfxpA==
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.9.40]
MIME-Version: 1.0
X-GBS-PROC: VoF57amzUJ7kRA4Y5MWqNlOg4OodcrtrOrKJrLwnXsY=
X-TNEFEvaluated: 1
X-RUS_SENSITIVITY: 10
Message-ID: <0d924a0671b642d2b8ba79af8d4fa0d7@rohde-schwarz.com>
Date:   Tue, 27 Jun 2017 13:16:01 +0000
X-MIMETrack: Itemize by SMTP Server on RSSMTP02/RSSMTP at 27.06.2017 15:16:14,
        Serialize by Router on RSSMTP02/RSSMTP at 27.06.2017 15:31:31,
        Serialize complete at 27.06.2017 15:31:31
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello everyone,

$ git submodule foreach cat .git

...shows that the gitdir registered in the .git file of submodules is relative. But if you run 

$ git submodule foreach --recursive cat .git

...shows that submodules of submodules (if you have any) have an absolute gitdir starting with a slash.

1) Can you confirm that behavior?
2) Am I right that this is a bug (at least because of inconsistency)?


Regards,
Robert
