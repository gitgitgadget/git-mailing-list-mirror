Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C2C433E6
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DC42073A
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 19:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=statefarm.com header.i=@statefarm.com header.b="Xv7t6N9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgGUTxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:53:06 -0400
Received: from mailpooledcoout5.statefarm.com ([206.80.132.155]:41026 "EHLO
        statefarm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730980AbgGUTxF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 15:53:05 -0400
Received: from statefarm.com (localhost [127.0.0.1])
        by bp31avo10 (Postfix) with ESMTP id 9EBA63003F0C
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 14:53:04 -0500 (CDT)
Received: from WPSFD3NK.OPR.STATEFARM.ORG (xdlpeml1p3.opr.statefarm.org [10.8.116.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by bp31avo10.opr.statefarm.org (Postfix) with ESMTPS id 8518D3003F0A
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 14:53:03 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 bp31avo10.opr.statefarm.org 8518D3003F0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=statefarm.com;
        s=20190701.statefarm; t=1595361184;
        bh=cWqtttGpq7+FM/LIk5eTGtuDxiyrejQb9kFypRekr1A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Xv7t6N9yZLZR/Qx1H1eiyFVn5ZfzT+RVrgELROENcaDGVCaRIAP2klXk62yvH6mfA
         g7XN8ONrZyELcT12gsolRYRsdJME4yvnkUi8n7hfhxGR6w5rA75gi8JTz9IiTR7Aps
         rhh70foJJIA9I1+xgGo9agCx9fCWo0vlNoEmFdxQQvf+emisQUUEw4hBgnzdraPDac
         aOb7cfisspPFfVh8Hd3CTwvAWIewzFjn6p/M9k0aacFZdh4GPz+QyxGSdg+1Blx8nf
         OkgasPy7yY8+LUq4T8FCBOqd3zqy3GzSswTmRsia3UBA3U4BZGPxiyrS0C6guQ/J++
         l4wUEp8vjnUkA==
Received: from WPSFD3NF.OPR.STATEFARM.ORG (10.8.108.46) by
 WPSFD3NK.OPR.STATEFARM.ORG (10.8.108.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.2044.4; Tue, 21 Jul 2020 14:53:02 -0500
Received: from WPSFD3NF.OPR.STATEFARM.ORG ([10.8.108.46]) by
 WPSFD3NF.OPR.STATEFARM.ORG ([10.8.108.46]) with mapi id 15.01.2044.004; Tue,
 21 Jul 2020 14:53:02 -0500
From:   Michael Garza <michael.garza.embv@statefarm.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
CC:     Michael Garza <michael.garza.embv@statefarm.com>
Subject: RE: Submit Git Bug
Thread-Topic: Submit Git Bug
Thread-Index: AdZffJMhXiztrOaUT8+KHzh+3jJ1GwAG6YvA
Date:   Tue, 21 Jul 2020 19:53:02 +0000
Message-ID: <bae4a7fd47f948e1856aec69a51b2ff0@statefarm.com>
References: <65b88444bf544024a434dbc25bd6a487@statefarm.com>
In-Reply-To: <65b88444bf544024a434dbc25bd6a487@statefarm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_261ecbe3-7ba9-4124-b9d7-ffd820687beb_Enabled=True;
 MSIP_Label_261ecbe3-7ba9-4124-b9d7-ffd820687beb_SiteId=fa23982e-6646-4a33-a5c4-1a848d02fcc4;
 MSIP_Label_261ecbe3-7ba9-4124-b9d7-ffd820687beb_Owner=michael.garza.embv@statefarm.com;
 MSIP_Label_261ecbe3-7ba9-4124-b9d7-ffd820687beb_SetDate=2020-07-21T16:33:59.1920333Z;
 MSIP_Label_261ecbe3-7ba9-4124-b9d7-ffd820687beb_Name=Internal Use Only;
 MSIP_Label_261ecbe3-7ba9-4124-b9d7-ffd820687beb_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_261ecbe3-7ba9-4124-b9d7-ffd820687beb_ActionId=063e02d1-5acc-44ac-876f-b590c21575c8;
 MSIP_Label_261ecbe3-7ba9-4124-b9d7-ffd820687beb_Extended_MSFT_Method=Automatic
x-originating-ip: [10.46.136.10]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1347-8.5.0.1020-25556.002
X-TM-AS-Result: No--21.080-10.0-31-10
X-imss-scan-details: No--21.080-10.0-31-10
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-TMASE-Version: IMSS-9.1.0.1347-8.5.1020-25556.002
X-TMASE-Result: 10--21.079500-10.000000
X-TMASE-MatchedRID: G3afYLZXqsbqB1T+fVNzTIoPuISj926gQcjPqCqAUTO8coKUcaOOvdPa
        SXiLjsu7K8VLPDcP9n5kVnj7rBUGjD6of06GuQ71TMWDInRbWXui7CU3As9HC7dHEv7sR/OwF8l
        NgsbZcW/51M9kjo24gS2rLpcvfj1Hmwcq+0U3UTZcliZU8mzTfTys/e8FCsngboe6sMfg+k89e7
        UvbyNKccuaydEXPqkmEl3R3+Zqra0ZJRdu4jl/f0q+yldh23d4gNVHXM3C8e7ylEfNwb6iLbqzp
        Qvjy9EAoau5RkZEpR0mkZ7GRs/VdagwcVpAQRTBfpXHFYWCQdejxYyRBa/qJRvnAn+JGL2oSKu0
        4OT068XdB/CxWTRRu4BQLWahPl6cftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? Initiated the cp.exe command to copy file(s) from one location to another.

What did you expect to happen? I expected to see in the Windows Sysmon Event 1 the entire command string.

What happened instead? The log captured is only that cp.exe was used.

What's different between what you expected and what actually happened? The difference is that the entire command string is not being captured.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.27.0.windows.1
cpu: x86_64
built from commit: 907ab1011dce9112700498e034b974ba60f8b407
sizeof-long: 4
sizeof-size_t: 8
uname: Windows 10.0 18363 
compiler info: gnuc: 10.1
libc info: no libc information available


[Enabled Hooks]
not run from a git repository - no hooks to show

Thanks,
Michael Garza,



