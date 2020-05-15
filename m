Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A44C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 12:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88EB52074D
	for <git@archiver.kernel.org>; Fri, 15 May 2020 12:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgEOMDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 08:03:38 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgEOMDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 08:03:38 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9L64-1j3e6s2icW-015MOA; Fri, 15 May 2020 14:03:34 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 592326511DD;
        Fri, 15 May 2020 12:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 47q5YwmESJs4; Fri, 15 May 2020 14:03:34 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.8.5.45])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 09DDF64E76E;
        Fri, 15 May 2020 14:03:34 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id ABDA7804FB; Fri, 15 May 2020 14:03:33 +0200 (CEST)
Date:   Fri, 15 May 2020 14:03:33 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Gary Oberbrunner <garyo@oberbrunner.com>
Subject: Re: Possible git bug in commit-graph: "invalid commit position"
Message-ID: <20200515120333.GA4677@pflmari>
References: <CAFChFygiaMsUJC5Kfpnk26DLWbY0gPdNJpZ_gLMf4utZ6_oZxA@mail.gmail.com>
 <CAFChFyi5J-mb+rshtF7U2m=MtPzEPUa+V1_qbEXC=-LdQ218yA@mail.gmail.com>
 <d4313777-ce8c-0b64-997e-17cb719c9ab8@gmail.com>
 <CAFChFyhZYm88cCo6X_XikT=HRQG9Pp0vyveXmAuComFUJYjRcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFChFyhZYm88cCo6X_XikT=HRQG9Pp0vyveXmAuComFUJYjRcA@mail.gmail.com>
X-Provags-ID: V03:K1:h91x2+LugzNVu0yRiuqOfyGoQBgMZbax4wo2KQJF0CjnNX7py/B
 omdQih4x3RuUMtF8tSgseuLER/4iz+3MsQLxEMFLw3WHanDgDf7GENA39Y0K5ie/hYEFngh
 3ZiUqRTva7BWNwXOM2N69YLC5/FDdA1UQKOrPknJqljFXo2lsEZnAGBU5/8S0CgTqxLspzi
 kTEmgOd8TksEz5Pqn4bZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3GwRoMcwx0k=:eVmkU9jep0bXTRH+VLHd58
 jTuJUr+sHxZ0hnU0KJtxvrCpNo725k2o8DxDPggjcMsWJFX5F9DXDqo3E6wB1pzhUZ0LASMu5
 cMCilTfdOuywxY5K4zg3HZfLRukt3RLHExAE0d5H9Cauk1sOHVgvk82fudueLMqHyMyTFlpEB
 nQmHb5ZqYVlif3NXJUfBMixeddiCZhsIw9rVlXJTU5x1bfEPq0JFedXMhraQzJHYsBWaXB3fD
 jsBGHcjx48OCJT3Je6S5XGx/B8yiVIRbZusJSYK/UtuLw498dcWOmdTbX5vE+UmmwKcpPlTHf
 fjZpILRZaX/TTZ4cacv5DZTz2ZT8OQR4RE9Wcd1OE45S3jwdBfoRKY0ftLZgnJ9LIyA4AytWm
 hCDwMcQ0iniEbZ/R9thjg1FaiHUQ51k//SseJLeK4vrYBYKbe1weITfWyELw84qE6UTM2ewqM
 2bnh1z1GGaSmr/d0zeVh4i8pKnCBSzdBOcWcKhvKsPvnR9VVJKlrpb3jEjBMsfKCYAqcGLyl3
 384C846dKzb7DTOf0DguGX8qQqzoC6QRdd82dIDNWVQ62nG94w0qsDKB0g6s+WHaU21NEKk8N
 2kWsbNgTcqeKwFkqrcgOXuiNKNHtFFKZAiJPF/PV+43S52WugU58y5mSMH6pl8gOSaaZ4Uzon
 1o44ULM7lCoHgQg/1IZwnDijdRMnWvQyOMSnnI4+f3HSs1K3iIP2uJC3Obi5BBcFzXLxoUi5A
 ZVtdoSYLgWis0h2O19NOvJCtD2yHwP2xsqkNguDUxZGp2etzDGkbb3e/sCb2GpVO2ItZ77/Yg
 Mtzrp9tWqhB/87LkXMoNDgbe3Om5zvPWGXvFsDfRXLWC5BmtomPxEP2TlfNCxBaCrEKnFTp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gary Oberbrunner, Tue, Feb 04, 2020 23:33:42 +0100:
> Sorry for the long reply delay; the bug went away and only just showed
> up again. Here's the info you requested.
> I'm now running git 2.25.0.

I hit a very similar problem today with 2.26.0. Also in a submodule.

Removing and regenerating the commit graph did not help and I did not have the
commit-graphs directory (only a file). "git commit-graph verify" does not find
anything. Switching writeCommitGraph on and regenerating the commit graph
makes no difference.

I can trigger it reliably by visiting the broken(?) commit in supermodule with:

    git show --submodule=log <commit>

I see nothing special in the commit invovled. It is just a single commit in my
case, and the commit is a merge of two branches.

Regards,
Alex
