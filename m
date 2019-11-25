Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5F6C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE742084D
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfKYKrk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 25 Nov 2019 05:47:40 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:42754 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727568AbfKYKrB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Nov 2019 05:47:01 -0500
Received: from [85.158.142.100] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id C1/92-16685-321BBDD5; Mon, 25 Nov 2019 10:46:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRWlGSWpSXmKPExsWi+sWpUldp4+1
  Yg92L9S26rnQzWTT0XmF2YPK4eEnZ4/MmuQCmKNbMvKT8igTWjN6/O1gLdvJVbOiaztjA+Iu7
  i5GLQ0hgLaNE66eDrBDOQUaJ149uMncxcnKwCShKtM2Zxg5iiwioSUxsO8QCYjML6Et8+nOAC
  cQWFvCRmNH5jK2LkQOoxlfixgE7iHIriR0/zoCNYRFQldj6rY0JpIRXwF3i9Fs/kLCQQKnExG
  s/WUFsTgFLieWrX4DZjAKyEo9W/mKH2CQucevJfLBNEgICEkv2nGeGsEUlXj7+xwphG0hsXbq
  PBcJWkHj6tZ8VoldHYsHuT2wQtrbEsoWvwXp5BQQlTs58wjKBUXQWkhWzkLTMQtIyC0nLAkaW
  VYyWSUWZ6RkluYmZObqGBga6hobGuoa6RoYWeolVuol6qaW6yal5JUWJQFm9xPJiveLK3OScF
  L281JJNjMD4SilkvLWDsfPrW71DjJIcTEqivAzet2KF+JLyUyozEosz4otKc1KLDzHKcHAoSf
  BKr70dKyRYlJqeWpGWmQOMdZi0BAePkgjv6nVAad7igsTc4sx0iNQpRkuOCS/nLmLmOHh0HpB
  893PxImYhlrz8vFQpcV7z9UANAiANGaV5cONg6egSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5G
  JWHeOJApPJl5JXBbXwEdxAR0ENPMWyAHlSQipKQamLS+13NeYZormXjEqtiQacHltoywt8Xzj
  tcs3nhR75fI/vsvhcw9zn9+uOboNsuFjdHfBKfJTT579ehszfm5n1llBaUmKe3eZ2g4S9963d
  kVnabG/Pd7+cpn3boxLdJm26G1DPVrjr17dU8h4o2I0vGJM/YyrzSbOsNHuOqfwMWUjfkP8xN
  vZF09pH/PcjPH7+JTn365vbgqlZioVsaY9+xytfayJR7i04+9YZMTqe+QXpoXEMHTyM119E+m
  fvm8d0qX9B4pT3xtzrPPV/urdlHR4766Bj7v+ldTNh7qu9HYGrKOs2lip+GsNY7vRL9tc9zxd
  lcxs+IKxzWPlt24qG61JMMz8IzLUzefaSksX8KUWIozEg21mIuKEwFNOMtMwgMAAA==
X-Env-Sender: eda@waniasset.com
X-Msg-Ref: server-28.tower-225.messagelabs.com!1574678818!1203312!1
X-Originating-IP: [37.244.66.121]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=waniasset.com,-,-
X-VirusChecked: Checked
Received: (qmail 9216 invoked from network); 25 Nov 2019 10:46:58 -0000
Received: from unknown (HELO smtp.waniasset.com) (37.244.66.121)
  by server-28.tower-225.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 25 Nov 2019 10:46:58 -0000
Received: from WCL-EX13MBX-DR.wcl.local (10.45.7.24) by WCL-EX13MBX.wcl.local
 (10.45.7.22) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 25 Nov
 2019 10:46:57 +0000
Received: from WCL-EX13MBX-DR.wcl.local ([fe80::fc09:9ae7:1670:cbe1]) by
 WCL-EX13MBX-DR.wcl.local ([fe80::fc09:9ae7:1670:cbe1%12]) with mapi id
 15.00.1263.000; Mon, 25 Nov 2019 10:46:56 +0000
From:   Ed Avis <eda@waniasset.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git-log diff formatting options: some turn on diffs, some don't
Thread-Topic: git-log diff formatting options: some turn on diffs, some don't
Thread-Index: AdWhKVNYf1VeeiWrRyWq/41zjcEDdQAermFIAHZOY8A=
Date:   Mon, 25 Nov 2019 10:46:55 +0000
Message-ID: <cbfdbe62ad394abe9222c6e4d7875651@WCL-EX13MBX-DR.wcl.local>
References: <55ab4d09c51446c6b23abbb1c92441d6@WCL-EX13MBX-DR.wcl.local>
 <xmqq1rtz2v99.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rtz2v99.fsf@gitster-ct.c.googlers.com>
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

Thanks for your reply.  If the -r flag has no effect on 'git log' then shouldn't it be omitted from the documentation?
https://git-scm.com/docs/git-log has a section on 'Diff Formatting' but if I understand you rightly, a large part of that only applies to other commands.

Further, I would suggest that if the -r flag does get passed to 'git log' then it should give a warning.
(Ideally I would say an error, but there might be existing scripts that pass it.)


To learn how we protect privacy, please use this link (https://www.qma.com/gdpr.html) to read our Privacy Notice.

This email and any files transmitted with it are CONFIDENTIAL and are intended solely for the use of the individual(s) or entity to whom they are addressed. Any unauthorised copying, disclosure or distribution of the material within this email is strictly forbidden. Any views or opinions presented within this email are solely those of the author and do not necessarily represent those of QMA Wadhwani (QMAW) unless otherwise specifically stated. An electronic message is not binding on its sender. Any message referring to a binding agreement must be confirmed in writing and duly signed. If you have received this email in error, please notify the sender immediately and delete the original. Telephone, electronic and other communications and conversations with QMAW and/or its associated persons may be recorded and retained.

Please note that your personal information may be stored and processed in any country where we have facilities or in which we engage service providers. If you provide personal information to us by email or otherwise, you consent to the transfer of that information to countries outside of your country of residence and these countries may have different data protection rules than your country.

