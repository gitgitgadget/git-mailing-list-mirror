Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF73A1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 00:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfAYAzx (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 19:55:53 -0500
Received: from proofpoint8.lanl.gov ([204.121.3.47]:53718 "EHLO
        proofpoint8.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfAYAzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 19:55:53 -0500
Received: from pps.filterd (proofpoint8.lanl.gov [127.0.0.1])
        by proofpoint8.lanl.gov (8.16.0.22/8.16.0.22) with SMTP id x0P0pd7M049643
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 17:55:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lanl.gov; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=lanl; bh=8oR9E9/UB7/MX0oIwkpbIRc+CsuPAIMqzpe4o6isS80=;
 b=eKg/ybyeUu0ik5pbmNy/3wz6QvQ8R59LTVPgxmQhAleDeOU6VSRsoidoi5Vcr7uy1b5P
 mFavyDhlEWFpG7W9VfyBn2fWLjzTwUXWmA7acqoAHm4hnl2VWKRteH/I4UuGp5a35rCH
 mVAKb1EiYb+tDNQ8y2JhtRfzI46AViVZthjfsAFoVmM23Y1vSg3YIyDz1QSut4Pcnfgg
 Xe6bNQvDcXSeQnUpqO3NcTsmiwCevw0dDihd2DKbyT8NY4IXoKryJWza2PU6GKluP93w
 /nLROC+lqf6Uxyn9JTG0Valf84zdTb2d+L5xA5WvZf+c954h+soyp0rMYAss2kxMxOF1 AA== 
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
        by proofpoint8.lanl.gov with ESMTP id 2q41j6bthu-1
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 17:55:52 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id A77C9F285D1
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 17:55:52 -0700 (MST)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from EXG16-P-MBX05.win.lanl.gov (exg16-p-mbx05.win.lanl.gov [128.165.106.185])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 91888F285C9
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 17:55:52 -0700 (MST)
Received: from EXG16-P-MBX01.win.lanl.gov (128.165.106.181) by
 EXG16-P-MBX05.win.lanl.gov (128.165.106.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Thu, 24 Jan 2019 17:55:52 -0700
Received: from EXG16-P-MBX01.win.lanl.gov ([fe80::700b:f586:da83:655b]) by
 EXG16-P-MBX01.win.lanl.gov ([fe80::700b:f586:da83:655b%7]) with mapi id
 15.01.1591.012; Thu, 24 Jan 2019 17:55:52 -0700
From:   "Israel, Daniel M" <dmi1@lanl.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Writing merge strategy?
Thread-Topic: Writing merge strategy?
Thread-Index: AQHUtEi4c0OWN5XtNEi+nANxOEz/FQ==
Date:   Fri, 25 Jan 2019 00:55:52 +0000
Message-ID: <244FE6CE-C045-4EC9-8C3F-8D16CF4D09EB@lanl.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3273)
x-originating-ip: [128.165.106.138]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC90AD15C1008D43991B1D5A92A4547E@win.lanl.gov>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=609 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901250005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBuZWVkIGEgY3VzdG9tIG1lcmdlIHN0cmF0ZWd5IChub3QgZHJpdmVyKSBmb3IgYSB0b29sIEni
gJltIHdyaXRpbmcsIGFuZCBJ4oCZbSB3b25kZXJpbmc6DQoNCjEuIElzIHRoZXJlIGRvY3VtZW50
YXRpb24gZm9yIHRoZSBBUEkgYW55d2hlcmU/DQoNCjIuIERvZXMgZ2l0LW1lcmdlIGFjdHVhbGx5
IGRvIGFueSBtYWdpYywgb3IgY291bGQgSSBqdXN0IHJ1biB0aGUgc2NyaXB0IHRoYXQgaW1wbGVt
ZW50cyBteSBtZXJnZSBkaXJlY3RseT8gIEluIG90aGVyIHdvcmRzLCBpcyB0aGVyZSByZWFsbHkg
YW55IGRpZmZlcmVuY2UgYmV0d2VlbiBhIG1lcmdlIHN0cmF0ZWd5IGFuZCBhIHNjcmlwdCB0aGF0
IGNyZWF0ZXMgdGhlIHRyZWUgSSB3YW50IGFuZCB0aGVuIGNvbW1pdHMgaXQgdXNpbmcgZ2l0LWNv
bW1pdC10cmVlIHdpdGggbXVsdGlwbGUgLXAgYXJndW1lbnRzLg0KDQrigJQNCkRhbmllbCBNLiBJ
c3JhZWwsIFBoLiBELg0KUGh5c2ljcyBWZXJpZmljYXRpb24gTGVhZA0KWENQLTQ6IE1ldGhvZHMg
JiBBbGdvcml0aG1zDQpNYWlsc3RvcCBGNjQ0DQpMb3MgQWxhbW9zIE5hdGlvbmFsIExhYm9yYXRv
cnkNCjUwNSA2NjUgNTY2NA0KDQo=
