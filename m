Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5416E1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 07:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbcFUH5c (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 03:57:32 -0400
Received: from parmail04.iap.socgen.com ([207.45.249.188]:11108 "EHLO
	parmail04.iap.socgen.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcFUH53 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 03:57:29 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jun 2016 03:57:28 EDT
X-IronPort-AV: E=Sophos;i="5.26,502,1459807200"; 
   d="scan'208";a="387296796"
Received: from unknown (HELO fedher-ext.hermes.si.socgen) ([175.128.206.141])
  by parmail04.iap.socgen.com with ESMTP; 21 Jun 2016 09:50:44 +0200
Received: from unknown (HELO HUBSEC666.hermes.si.socgen) ([175.128.206.34])
  by fedher-ext.hermes.si.socgen with ESMTP/TLS/AES128-SHA; 21 Jun 2016 09:50:47 +0200
Received: from MMXDC2640.hermes.si.socgen (175.128.14.28) by
 HUBSEC666.hermes.si.socgen (175.128.206.34) with Microsoft SMTP Server (TLS)
 id 14.3.235.1; Tue, 21 Jun 2016 09:50:47 +0200
Received: from MMXDC2642.hermes.si.socgen ([169.254.4.63]) by
 MMXDC2640.hermes.si.socgen ([175.128.14.28]) with mapi id 14.03.0235.001;
 Tue, 21 Jun 2016 09:50:47 +0200
From:	"LUCAS Thomas (EXT)" <thomas.lucas-ext@sgcib.com>
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Filters should be parallelized if needed
Thread-Topic: Filters should be parallelized if needed
Thread-Index: AdHLkZ45NC7KHPYQTCymoWxWKkp2Jg==
Date:	Tue, 21 Jun 2016 07:50:46 +0000
Message-ID: <ABCC694798EF214E91DB2ACCA61703690BBADA33@MMXDC2642.hermes.si.socgen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [175.0.0.27]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Setup:
- 2.9.0.windows.1 x64 on a windows 7 16g ram, ssd
- No particular installation settings, default.

Details:
- Running git from either a cmd or GitExtensions,  I encountered an issue while staging or checkout of lfs files. I am processing 3000 files for a total of 500MB.
Files are proccessed sequentially which is too slow for this amount of files, while lfs offer in some cases a way to run it from the command line in parallel, I think the git filters should be run in parallel. I think there is no need (or I am forgetting something) to run it sequentially.

If I were to use a filter processing files in a parallel way, I would have my time to checkout these files be reduced from 1h30min to 1min30s.

What actually happened instead?
- This is a no go for our enterprise to use git-lfs because this is too slow.

I can't give you my repository because it is confidential.

Anyway, I hope you can do something about it.
*************************************************************************
This message and any attachments (the "message") are confidential, intended solely for the addresse(s), and may contain legally privileged information.
Any unauthorized use or dissemination is prohibited. E-mails are susceptible to alteration.   
Neither SOCIETE GENERALE nor any of its subsidiaries or affiliates shall be liable for the message if altered, changed or
falsified.
Please visit http://swapdisclosure.sgcib.com for important information with respect to derivative products.
                              ************
Ce message et toutes les pieces jointes (ci-apres le "message") sont confidentiels et susceptibles de contenir des informations couvertes 
par le secret professionnel. 
Ce message est etabli a l'intention exclusive de ses destinataires. Toute utilisation ou diffusion non autorisee est interdite.
Tout message electronique est susceptible d'alteration. 
La SOCIETE GENERALE et ses filiales declinent toute responsabilite au titre de ce message s'il a ete altere, deforme ou falsifie.
Veuillez consulter le site http://swapdisclosure.sgcib.com afin de recueillir d'importantes informations sur les produits derives.
*************************************************************************

