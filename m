Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66351F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 15:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfHPPSC (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 11:18:02 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.208]:57035 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbfHPPSC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Aug 2019 11:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliancedata.com;
        s=selectorSC; t=1565968680; i=@alliancedata.com;
        bh=l4hm1bOS6vwcxD7cxyow80h/FSb3ZJYb/DN7AF/aCsE=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=EF40N2vz4XBXuFi/L+aY8A5jZ4ne/WsTs/ribdU0TfbXwWXp+MFhbBAHI4+2eYYna
         Tt2adCZBcJKRpVDgYlZugV8EY87HHdVCJ9X6odp8DCQTmYJeaIWanZ6K6+OQC6CSrM
         w0461l/ba8xlMLPVp/qT9JpnKWKW6pt9VgjMPANoHj4yfpNlz2ZPzC6Y/u3eeMjqpa
         hHkhH6/CuaP527wx8i5ZN9ins7ktGgrfWOj09vGTl5Q+YnfqKKImHAXHnwlrLuRDhu
         EvrmQ/Lp9eAPkZOKwW9PlO2xQnPftNGmeJXN5ee/HL13+wgHWy+YltZJbzZDLujvmj
         2aFdCq7wbuFkQ==
Received: from [67.219.247.51] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-d.us-east-1.aws.symcld.net id 4F/E1-14628-729C65D5; Fri, 16 Aug 2019 15:17:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRWlGSWpSXmKPExsWSoa9nrqt+Miz
  WYPEiVYuuK91MFi+P7WVyYPLYOesuu8fnTXIBTFGsmXlJ+RUJrBl/Xk9hLPglXPGsfwd7A+MN
  4S5GLg5GgaXMEpsWt7NCOMdYJB7veskO4RxilPi/ZxYLiMMiMIFZYv+HO0wgjpBAB5PE8zunG
  bsYOYGc64wSy05ZgdhsAoYSq/7vBYuLCGhK3Oi8wAJiMwvoS3z6cwComYNDWEBJ4vH1GIgSZY
  n/h/oZQcIiAkYSfVO5QcIsAqoSO2/dAOvkFYiUeH3lGjPEpkCJFW97WUFsToEgif1/WsDijAJ
  iEt9PrWGC2CQucevJfDBbQkBAYsme88wQtqjEy8f/WCHqYyVWz4WYIyGgIPH552EWCFtW4tL8
  bkYI21eiqecrO8hpEkBnbnkRC/K5hMBjRokHq89A1WhJPP23lx3ClpJYeP4LlJ0hsaP/CFSNu
  kTLx3lQu2Qk5k08xwwxaDqbxImdD1kmMOrPQnL3LKB9zMCQW78LKqwoMaX7IfsscFAISpyc+Y
  RlASPLKkbTpKLM9IyS3MTMHF1DAwNdQ0MjXUtdYyO9xCrdFL3SYt3UxOISXUO9xPJiveLK3OS
  cFL281JJNjMA0k1LAqbCDse/oa71DjJIcTEqivOVTg2OF+JLyUyozEosz4otKc1KLDzHKcHAo
  SfBKnQiLFRIsSk1PrUjLzAGmPJi0BAePkghvNUiat7ggMbc4Mx0idYrRmGPCy7mLmDmOzF26i
  FmIJS8/L1VKnLcXpFQApDSjNA9uECwVX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzKsFMo
  UnM68Ebt8roFOYgE6xPBcKckpJIkJKqoFJ4/D8nTpbdxz2fPfejjvqdWCSh33/2sLiafotK7f
  v/pJ+Lbhz6ttvcTZnskrYudh2S6iZ1ip3ts792fR7+uTz2xet/nd8m+p5VZ6/0pp6ESsZ0mdE
  lVq17J/+OGXW/ruZ07qk++df8ZFvWHGVIWH+CtlDyzs3X7Vl61yX+1SnnHfjNaVPxypui6jFL
  ROse3P6odtOuflnn287+0ll5aMJRhZnNVxflHxPZvJjYJ7IeaX38WHp0wyuW6yck1XNmDY1T/
  PkPSce7cD2+qPJoX8vbWdrhaw6+sx/wbxNy8UYM5sY4w/X2zF110baZIrwSH237Ha11j6+5Px
  Xpt82fcnKrsVrV788f/7i9E+/Be1jlFiKMxINtZiLihMBJIMicEAEAAA=
X-Env-Sender: Edwin.Dyer@alliancedata.com
X-Msg-Ref: server-31.tower-423.messagelabs.com!1565968674!13842!1
X-Originating-IP: [104.47.46.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=alliancedata.com,-,-
X-VirusChecked: Checked
Received: (qmail 26971 invoked from network); 16 Aug 2019 15:17:55 -0000
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) (104.47.46.55)
  by server-31.tower-423.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 16 Aug 2019 15:17:55 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHfAbT4GOX65DCEeWjOAMadkyCVMZ48Sg6fHt2clJhn/e2Tc6+FLPZq6vj1tRTWM6ZCUA9joxoACcHUuv8msUkrvMPHq5Qab0mpQIMb+QJRS5ItFZ9LfmLb994gglVF9sZeGUZH2Go65HE0L2nBINIF78ub0vSAMjsV1KNIdfI765whfbEytzWrHa1jbsudDm6fWn35yFwE5j11pKAty/CMiSJ5/BfnkSFfAl18F0CYTj9Ng8MAEXtrzyPAqWWcu6Y+UKaTz2oq8FbHhvLWaPIZ6QxSg3mSmXnPmsxaGUP3qFMJm3U9lIhTa/9ndgkKv9JTrQO/QVk+8RVYBu3NtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abo3kvOz3+pyHFtzobw2NzGzbDHupT2RQLGu24CO5BA=;
 b=aQ6iMCLfxQiUWg849OrHZT1xdDazjFl8FRqYZj8DCFJM2OnzoCpl1LHajLhZ793i8fuLDfUFqePnY8yn2nlKMNmyY9Ogbcz6qRenx1Fwnd4zATwAYmTuGdbC0zd/45IwO3XTpMXpt0ANUEtT/2TQU8nA7vbby+sl6teRePSIV9lKIAkC+es7sXyuPUB6lj+hrObBZb5XDP1Z5xbrk9sdrEit++/ixa+mnZgR0kM9K8LMT+JmAyv9McD2EB5gkLgBZaDFEHhmzEKGg4QPcvKjGMZK7xgIR8KRgiKLC9bP3sqpxwKvnNTXawCpk17mNVNFWg11Q1suOGAaczj8++SXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alliancedata.com; dmarc=pass action=none
 header.from=alliancedata.com; dkim=pass header.d=alliancedata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliancedata.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abo3kvOz3+pyHFtzobw2NzGzbDHupT2RQLGu24CO5BA=;
 b=X9tWto66vK94PznbxoExmaZjJb4w1gMaPwHivLGCotldd9uhhxUghpu5OMoYgWlyPE+J9QGs5lNjkCe1I4mgyOwaooegiBqJNuXWNfzTxGepcLXl1159+UyIaKIB8TsumI+edNeCHdSh05c/o+itim0vCL2YB4oeQzjSWUFnizs=
Received: from BL0PR01MB4865.prod.exchangelabs.com (20.177.206.85) by
 BL0PR01MB5281.prod.exchangelabs.com (20.177.147.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 16 Aug 2019 15:17:54 +0000
Received: from BL0PR01MB4865.prod.exchangelabs.com
 ([fe80::d1f5:243e:cca0:75de]) by BL0PR01MB4865.prod.exchangelabs.com
 ([fe80::d1f5:243e:cca0:75de%7]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 15:17:54 +0000
From:   "Dyer, Edwin" <Edwin.Dyer@alliancedata.com>
To:     Rick Tillery <rtillerywork@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: QGit 2.8 for Windows?
Thread-Topic: QGit 2.8 for Windows?
Thread-Index: AQHVU61ipxWwxFX57kWzCdbU5rOsGKb94yEQ
Date:   Fri, 16 Aug 2019 15:17:53 +0000
Message-ID: <BL0PR01MB486598133847E17E862E2D98F1AF0@BL0PR01MB4865.prod.exchangelabs.com>
References: <CAAZEOjv+y8y6z_stqqZFAVe6SqCH1upvhYPeqAY=w49EGdzK4g@mail.gmail.com>
In-Reply-To: <CAAZEOjv+y8y6z_stqqZFAVe6SqCH1upvhYPeqAY=w49EGdzK4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [205.144.62.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef433da6-8cd4-4315-999f-08d7225ce939
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BL0PR01MB5281;
x-ms-traffictypediagnostic: BL0PR01MB5281:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BL0PR01MB5281327FB4ECB0942770FE65F1AF0@BL0PR01MB5281.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(13464003)(189003)(199004)(9686003)(229853002)(6436002)(6306002)(4326008)(446003)(1411001)(26005)(53936002)(8676002)(81166006)(81156014)(6506007)(5660300002)(476003)(55016002)(53546011)(478600001)(66066001)(71190400001)(71200400001)(99286004)(256004)(11346002)(14444005)(486006)(2906002)(966005)(6916009)(25786009)(186003)(102836004)(76176011)(316002)(7696005)(3846002)(76116006)(6116002)(66476007)(64756008)(66946007)(305945005)(74316002)(7736002)(66556008)(66446008)(33656002)(8936002)(6246003)(14454004)(52536014)(7116003)(86362001)(460985005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR01MB5281;H:BL0PR01MB4865.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: alliancedata.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XlpdO48PDcpMfkwpSgZiH36lO93qvSyjBDGbWC182XvMMYp3hc8ZDdemZzhfKAn+ZaRYhHJdmN4qv+ekpBZhI5DLWr2wahWvfEo2QHU9XV65UDqo0HpyYuLuBrpZ8/7JpWSBjBPvOLUNitwRanDuU/yGCesr7yPrSQkMOjDdVhTai0hCgi4PKBQ2eFyMpXG/3uYps8ligtRfSxh/Wkrmd9LJ6m5ujTRmHNq/N5uRGO4TXmdqQBZzWWLFim6wLbll+ZZ5lolqZDoijmd05YpRwTsuscuGmSye2lZ7tWtE959YycOph48xWaK+6tJO26R8J9HdHzVn9hG+d7pA5Rf+FVVVy+Yw6a3ze7N0NTdwIWkudLoG9wR6nJSsNzbbbIgkhK0Jxsdhf/r+POKu18LpZimDuHDPHLcmFvWXRUEaljM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: alliancedata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef433da6-8cd4-4315-999f-08d7225ce939
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 15:17:54.0097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7a24eae8-33b9-449a-83f5-361634c821ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFqFGc27MTdGB4yiFBKrmiQEAKdwlqJQUJKS0htF/9rHu3aB7aQ4Yz4uu3SqrDLgv/DROxJlotp1zxXGqgXHPivEzBya3VqL79VhuJPNqUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB5281
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tm90IHN1cmUgaWYgdGhpcyBpcyB0aGUgc2FtZSB0aGluZyBvciBub3QgYnV0IEkgZm91bmQgdGhp
czoKCmh0dHBzOi8vZ2l0aHViLmNvbS90aWJpcm5hL3FnaXQKCkl0IGxvb2tzIHRvIGJlIHYyLjYu
IE1heWJlIHRoaXMgbWlnaHQgYmUgb2YgdXNlPwoKQ2hlZXJzLAoKRWQgRHllcgpBc3NvY2lhdGUg
RGV2T3BzIEVuZ2luZWVyCgpBbGxpYW5jZSBEYXRhIFJldGFpbCBTZXJ2aWNlcwozMDc1IExveWFs
dHkgQ2lyY2xlLCBDb2x1bWJ1cyBPSCA0MzIxOQpPZmZpY2U6IDYxNC05NDQtMzkyM3wgTW9iaWxl
OiA2MTQtNDMyLTM4NjIKCgoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogZ2l0LW93
bmVyQHZnZXIua2VybmVsLm9yZyA8Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxm
IE9mIFJpY2sgVGlsbGVyeQpTZW50OiBUaHVyc2RheSwgQXVndXN0IDE1LCAyMDE5IDU6MDcgUE0K
VG86IGdpdEB2Z2VyLmtlcm5lbC5vcmcKU3ViamVjdDogUUdpdCAyLjggZm9yIFdpbmRvd3M/CgpR
R2l0J3MgUkVBRE1FICgKaHR0cHM6Ly9naXRodWIuY29tL3RpYmlybmEvcWdpdC9ibG9iL21hc3Rl
ci9SRUFETUUuYWRvYyApIGRpcmVjdHMgbWUgdG8gdGhpcyBtYWlsaW5nIGxpc3QsIHNvIGZvcmdp
dmUgbWUgaWYgdGhpcyBpcyB0aGUgd3JvbmcgcGxhY2UuCgpJcyB0aGVyZSBhIGZ1bGx5IGJ1aWx0
IHZlcnNpb24gb2YgUUdpdCAyLjggZm9yIFdpbmRvd3M/CgpUaGUgbGF0ZXN0IFFHaXQgZm9yIFdp
bmRvd3MgSSBjYW4gZmluZCBpcyAyLjMsIGZyb20gMjAwOCAoIGh0dHBzOi8vc291cmNlZm9yZ2Uu
bmV0L3Byb2plY3RzL3FnaXQvICkuIFRoYXQgdmVyc2lvbiBlbmNvdW50ZXJzIGFuIGVycm9yIGV2
ZXJ5IHRpbWUgSSBsb2FkIGEgcmVwbyAoZGVwcmVjYXRlZCBjb21tYW5kICJnaXQgcmVwby1jb25m
aWcuLi4iKSwgYW5kIEkgc2VlIHRoaXMgaGFzIGJlZW4gdXBkYXRlZCBiZXR3ZWVuIHRoZW4gYW5k
IG5vdy4KCkkgZGlkIGF0dGVtcHQgdG8gY2xvbmUgYW5kIGJ1aWxkLCB1c2luZyB0aGUgaW5zdHJ1
Y3Rpb25zIGluIHRoZSByZXBvLCBidXQgYWZ0ZXIgc2V2ZXJhbCBob3VycyBvZiB0cnlpbmcsIHRo
ZSBiaW5hcnkgSSBwcm9kdWNlZCB3aWxsIG5vdCBsb2FkLCB3aXRoIHNldmVyYWwgZXJyb3IgZGlh
bG9ncywgd2hpY2ggYXBwZWFyIGluIGRpZmZlcmluZyBvcmRlciBlYWNoIHRpbWUgSSB0cnkgdG8g
cnVuIHFnaXQuZXhlIChhbmQgdGhlIHByb2NlZHVyZSBlbnRyeSBwb2ludCBkb2Vzbid0IGFsd2F5
cyBhcHBlYXIpOgoKIlRoZSBjb2RlIGV4ZWN1dGlvbiBjYW5ub3QgcHJvY2VlZCBiZWNhdXNlIGxp
YkdMRVN2Mi5kbGwgd2FzIG5vdCBmb3VuZC4gUmVpbnN0YWxsaW5nLi4uIgpsaWJHTEV2Mi5kbGwg
aXMgcHJlc2VudCBvbiB0aGUgc3lzdGVtIGluIFxXaW5kb3dzXFN5c1dPVzY0CgoiLi4uVkNSVU5U
SU1FMTQwX0FQUC5kbGwuLi4iCkkgZG8gbm90IGZpbmQgdGhpcyBvbiB0aGUgc3lzdGVtLCBpbiB0
aGUgVmlzdWFsIFN0dWRpbyBmaWxlcywgb3IgYXZhaWxhYmxlIG9ubGluZSAoSSBkbyBmaW5kIFZD
UlVOVElNRTE0MC5kbGwpLgoKIi4uLk1TVkNQMTQwX0FQUC5kbGwuLi4iClNhbWUgYXMgVkNSVU5U
SU1FMTQwX0FQUC5kbGwKCiJUaGUgcHJvY2VkdXJlIGVudHJ5IHBvaW50Cj9xdF9tZXRhY2FsbEBR
UHJvY2Vzc0BAVUVBQUhXNENhbGxAUU1ldGFPYmplY3RAQEhQRUFQRUFYQFogY291bGQgbm90IGJl
IGxvY2F0ZWQgaW50IHRoZSBkeW5hbWljIGxpbmsgbGlicmFyeSBDOlxQcm9qZWN0c1xxZ2l0LXFn
aXQtMi44XGJpblxxZ2l0LmV4ZS4iCgpJcyB0aGVyZSBhIHByZS1idWlsdCAyLjggZm9yIFdpbmRv
d3M/CgpUaGFua3MsClJpY2sKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5l
ZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGJlIHByaXZp
bGVnZWQgYW5kIGNvbmZpZGVudGlhbC4gSWYgdGhlIHJlYWRlciBvZiB0aGlzIG1lc3NhZ2UgaXMg
bm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb3IgYW4gYWdlbnQgcmVzcG9uc2libGUgZm9yIGRl
bGl2ZXJpbmcgaXQgdG8gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBoZXJlYnkgbm90
aWZpZWQgdGhhdCBhbnkgcmV2aWV3LCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29w
eWluZyBvZiB0aGlzIGNvbW11bmljYXRpb24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91
IGhhdmUgcmVjZWl2ZWQgdGhpcyBjb21tdW5pY2F0aW9uIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5
IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwgYW5kIGRl
bGV0ZSB0aGUgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGZyb20geW91ciBjb21wdXRlci4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo=

