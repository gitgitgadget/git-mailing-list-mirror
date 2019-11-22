Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E58C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 11:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49BF20704
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 11:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfKVLnF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 22 Nov 2019 06:43:05 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:47208 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbfKVLnF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Nov 2019 06:43:05 -0500
Received: from [85.158.142.199] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 21/38-12313-5C9C7DD5; Fri, 22 Nov 2019 11:43:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42JR/eJUqXv05PV
  Yg/OHBC26rnQzOTB6fN4kF8AYxZqZl5RfkcCa8XdeL1PBRP6KH/v/sjUw7uLpYuTiEBJYyygx
  +9IsZgjnIKPEumPTgBxODjYBRYm2OdPYuxg5OEQE9CX6LoiChIUFPCReXdwKFfaVuHHADiQsI
  qAnMX/dFyaQMIuAqsStfWBhXgF3ifVzvrCA2IwCshKPVv5iB7GZBcQlbj2ZzwRiSwgISCzZc5
  4ZwhaVePn4HyuEbSCxdek+FghbQeLp135WiF4diQW7P7FB2NoSyxa+ZobYJShxcuYTlgmMQrO
  QrJiFpGUWkpZZSFoWMLKsYrRMKspMzyjJTczM0TU0MNA1NDTWNdU1MjDWS6zSTdJLLdVNTs0r
  KUoEyuollhfrFVfmJuek6OWllmxiBMZASiHr6R2Msz691TvEKMnBpCTK+2zj9VghvqT8lMqMx
  OKM+KLSnNTiQ4wyHBxKErziJ4BygkWp6akVaZk5wHiESUtw8CiJ8B4ESfMWFyTmFmemQ6ROMV
  pyTHg5dxEzx8Gj84Dku5+LFzELseTl56VKifN2gjQIgDRklObBjYOljEuMslLCvIwMDAxCPAW
  pRbmZJajyrxjFORiVhHmnHQeawpOZVwK39RXQQUxAB/1YdA3koJJEhJRUA9OS7bF2USYr5+b4
  ROl03NNb4F8895ngl18fjzxdUn7wQ1IJm8ruBXI2DgazUpMTfN05ZxdG9e9dvfp23vW06MqqG
  qVs4SzGNKWvD+uS/+gzbN+68eSS7yK2Vp7np19YOv38d8/7j19viBCWfVSV9OfZHJZa4dJbUU
  xHNyqx1P6ZE3vw/qFmrgkaU0t7XrLZL1g8qXp+ZfTnd/f2r1xb8bRQ4s+FVu5I//1dCz6X1Fn
  Nj1t5y+OfQqP72Y0KskwPX240vqVpPDuTR7fsy9L4qGtv+Y/eO2B5ZGZ5ofcUyYKlrdsiXgp3
  dXgU/5mx4e6E+PC53y5f2mCnsFKpPa50Lff9a/nzr67TeM/JIrKJd46dEktxRqKhFnNRcSIAC
  46a25QDAAA=
X-Env-Sender: eda@waniasset.com
X-Msg-Ref: server-27.tower-244.messagelabs.com!1574422980!1108972!1
X-Originating-IP: [37.244.66.121]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=waniasset.com,-,-
X-VirusChecked: Checked
Received: (qmail 22706 invoked from network); 22 Nov 2019 11:43:01 -0000
Received: from unknown (HELO smtp.waniasset.com) (37.244.66.121)
  by server-27.tower-244.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 22 Nov 2019 11:43:01 -0000
Received: from WCL-EX13MBX-DR.wcl.local (10.45.7.24) by WCL-EX13MBX.wcl.local
 (10.45.7.22) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Fri, 22 Nov
 2019 11:42:59 +0000
Received: from WCL-EX13MBX-DR.wcl.local ([fe80::fc09:9ae7:1670:cbe1]) by
 WCL-EX13MBX-DR.wcl.local ([fe80::fc09:9ae7:1670:cbe1%12]) with mapi id
 15.00.1263.000; Fri, 22 Nov 2019 11:42:58 +0000
From:   Ed Avis <eda@waniasset.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-log diff formatting options: some turn on diffs, some don't
Thread-Topic: git-log diff formatting options: some turn on diffs, some don't
Thread-Index: AdWhKVNYf1VeeiWrRyWq/41zjcEDdQ==
Date:   Fri, 22 Nov 2019 11:42:58 +0000
Message-ID: <55ab4d09c51446c6b23abbb1c92441d6@WCL-EX13MBX-DR.wcl.local>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.45.11.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you run git log -c this implies the -p flag.  But git log -r does not imply -p, even though both -r and -c are flags which exist to 'control the formatting of diff output' according to the documentation.

I think that all the flags listed in that section should implicitly turn on -p if it wasn't given.  (I'd also be content if they died with an error when -p wasn't given, but that could break existing users.)  The current behaviour is inconsistent and a bit of a headscratcher when 'git log -r' produces the same output as plain 'git log'.


To learn how we protect privacy, please use this link (https://www.qma.com/gdpr.html) to read our Privacy Notice.

This email and any files transmitted with it are CONFIDENTIAL and are intended solely for the use of the individual(s) or entity to whom they are addressed. Any unauthorised copying, disclosure or distribution of the material within this email is strictly forbidden. Any views or opinions presented within this email are solely those of the author and do not necessarily represent those of QMA Wadhwani (QMAW) unless otherwise specifically stated. An electronic message is not binding on its sender. Any message referring to a binding agreement must be confirmed in writing and duly signed. If you have received this email in error, please notify the sender immediately and delete the original. Telephone, electronic and other communications and conversations with QMAW and/or its associated persons may be recorded and retained.

Please note that your personal information may be stored and processed in any country where we have facilities or in which we engage service providers. If you provide personal information to us by email or otherwise, you consent to the transfer of that information to countries outside of your country of residence and these countries may have different data protection rules than your country.

