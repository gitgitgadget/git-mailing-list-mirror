Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06FF31F406
	for <e@80x24.org>; Tue, 19 Dec 2017 13:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935639AbdLSNlw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Dec 2017 08:41:52 -0500
Received: from mail11.clearstream.com ([194.36.229.254]:48952 "EHLO
        mail11.clearstream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935516AbdLSNlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 08:41:51 -0500
X-Greylist: delayed 795 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2017 08:41:51 EST
X-IronPort-AV: E=McAfee;i="5700,7163,8749"; a="3039632"
X-IronPort-AV: E=Sophos;i="5.45,426,1508796000"; 
   d="scan'208";a="3039632"
Received: from unknown (HELO FRPGBS02.oa.pnrad.net) ([172.20.221.251])
  by cinkdu41.nw.lan with ESMTP; 19 Dec 2017 14:28:10 +0100
Received: from mail pickup service by FRPGBS02.oa.pnrad.net with Microsoft SMTPSVC;
         Tue, 19 Dec 2017 14:28:10 +0100
Received: from frpdlpm01.nw.lan ([172.20.221.130]) by FRPGBS02.oa.pnrad.net with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 19 Dec 2017 14:28:09 +0100
Received: from mailp4.deutsche-boerse.de (unknown [172.20.221.130])
        by Forcepoint Email with ESMTPS id B12F6E9C1841FB6CC582
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:28:09 +0100 (CET)
Received: from FRPEXCH03.oa.pnrad.net ()
          by mailhub.deutsche-boerse.de (V2)
          id vBJDS9YW015166 for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:28:09 +0100
Received: from FRPEXCH03.oa.pnrad.net (10.250.16.251) by
 FRPEXCH03.oa.pnrad.net (10.250.16.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1261.35; Tue, 19 Dec 2017 14:28:09 +0100
Received: from FRPEXCH03.oa.pnrad.net ([fe80::dd2b:f5ff:fe75:fbcc]) by
 FRPEXCH03.oa.pnrad.net ([fe80::dd2b:f5ff:fe75:fbcc%22]) with mapi id
 15.01.1261.035; Tue, 19 Dec 2017 14:28:09 +0100
From:   Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: difftool uses hardcoded perl shebang
Thread-Topic: difftool uses hardcoded perl shebang
Thread-Index: AdN4ynjtgQyTw2MFQ5+aXKvEwXrtnAAApmkQ
Date:   Tue, 19 Dec 2017 13:28:09 +0000
Message-ID: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bjprotectivemarking: <?xml version="1.0" encoding="us-ascii"?><sisl
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema" sislVersion="0"
 policy="5e216652-7cb1-42d3-a22f-fb5c7f348db5" origin="defaultValue"
 xmlns="http://www.boldonjames.com/2008/01/sie/internal/label"><element
 uid="id_classification_internalonly" value="" /></sisl>
dbg_attribute_name: 
dbg_classification_id: 2
dbg_classification_name: Internal
x-originating-ip: [10.250.0.103]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginalArrivalTime: 19 Dec 2017 13:28:09.0848 (UTC) FILETIME=[364C5F80:01D378CD]
X-GBS-PROC: 1JczaXQMQy9miy47ZgvkEJUB9nLc6ZVkag/D6jsB6Og=
X-GRP-TAN: FRPGBS02@8268CCD72D3F4158A9973C77CCA2848A
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The below email is classified: Internal

When running git difftool:

>git difftool
Perl lib version (5.10.0) doesn't match executable version (v5.16.3)
Compilation failed in require at <path>/git-difftool line 2.

First line in my git-difftool is:
#!/usr/bin/perl

I am using a specific perl that I cannot change. Similarly, I cannot change the git-difftool file. I would like the difftool to use the perl form my PATH. 

Maybe it would be better to use #!/usr/bin/env perl?
-----------------------------------------
Diese E-Mail enthaelt vertrauliche oder rechtlich geschuetzte Informationen.
Wenn Sie nicht der beabsichtigte Empfaenger sind, informieren Sie bitte
sofort den Absender und loeschen Sie diese E-Mail. Das unbefugte Kopieren
dieser E-Mail oder die unbefugte Weitergabe der enthaltenen Informationen
ist nicht gestattet.

The information contained in this message is confidential or protected by
law. If you are not the intended recipient, please contact the sender and
delete this message. Any unauthorised copying of this message or
unauthorised distribution of the information contained herein is prohibited.

Legally required information for business correspondence/
Gesetzliche Pflichtangaben fuer Geschaeftskorrespondenz:
http://deutsche-boerse.com/letterhead

