Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DE320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 00:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeLKAzS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 19:55:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728640AbeLKAzR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Dec 2018 19:55:17 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 19:55:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com; s=selector; t=1544489716; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding:in-reply-to: references; bh=EzPMaIsWV/4y8pLHMoE3IvSfj5M0bhiCuE9Vc6XHgsY=; b=BVXV5Ly4sjQNC8vzOOhntOGllgLOmoaucQh2X9W3Oh5n8pvEUiLgxFZ3lqB8B1XInzXh0s/R3uOLjHoXCo7V6MZODg9UoG+euwounEy0f4YltPrkgVEf4tT2Gzb1ZcYDXT4GcLv4k6hsRAWhwu4z8WakEfXgoT+sr6o0/EqwzW8=
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam05lp2051.outbound.protection.outlook.com [104.47.48.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-A6Tm5rQGPXioipkWOwwtQg-1; Mon, 10 Dec 2018 19:49:00 -0500
Received: from CY4PR19MB1526.namprd19.prod.outlook.com (10.172.179.23) by
 CY4PR19MB0072.namprd19.prod.outlook.com (10.165.89.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 00:48:58 +0000
Received: from CY4PR19MB1526.namprd19.prod.outlook.com
 ([fe80::c99e:94f:64f9:b41b]) by CY4PR19MB1526.namprd19.prod.outlook.com
 ([fe80::c99e:94f:64f9:b41b%10]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 00:48:58 +0000
From:   Owen Ofiesh <oofiesh@maxlinear.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git clone fails with fatal: the remote end hung up unexpectedly
Thread-Topic: Git clone fails with fatal: the remote end hung up unexpectedly
Thread-Index: AdSQ60uDLF+dQT1fTw62id5DJduh2A==
Date:   Tue, 11 Dec 2018 00:48:57 +0000
Message-ID: <CY4PR19MB1526704FC790724C2DC68465ADA60@CY4PR19MB1526.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [207.43.172.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR19MB0072;6:DkyCkc/7Ej/qA7YEoiWmV1Iyf9o22ce6lPZq+v9SZ7Sh6lQ8gTQDwvOS0XwRaS6QyBOx5d5h53ptKT62qiswmzvgD3N4M7lf6s2+JXDA02m4XYXHKkQVt65Rlk0eBAI2ak3obphAlcAIGgJLKhv1HLWMg3qem8LmgDDTaBkLm405q3ha8ld5AoldGdj+n1mI4jr1vDWlzu3ASzVYqnK3BYDFBknce2BKOAVuUk92QsQ0s9NHc0NCYJo9iGtsRfcDGyWGOuwLjLYsTrJB3+beEPCuu1yr11uye0pXFvDqEykPP+tPWkB6/32vwd+H9Gwk+e6CymNK4IlolSB4Ehn+KCcZiXfzlXNWPjRlzPxccHaLTyztBOdr0GRgfH7mpfjLbOv6BoXe2cu1C2Nw1d6IkL0/2iwpjI4LUp0ZrUpJfTqMaVY2DLNATxOfIzS4mq4kjJktzSUp1Tnq9ZDZnmVXqQ==;5:k6HAxjG1b3nFUXHIXhlumScNYD6NJ2IZ5OUtFbbt/6EJozrFA9uKHQXdJAMnZGgsuNLUO86OidrPB4jzFkIhQdcH0E6qTZIcJCANmBj2s+SBJZGu7JbAKk0tD6P2IxjXk2a7KhKWQ3qqlyPlEVwNQYfgA4xHRdv1bIBhEWOfQUw=;7:k1DQswozmn82sxg0e13NmYm4EDU+nD+qHpAjCzUDtulaKYUpmC3GGywAyOp9BdBOIAAis/oudifZjCHubU2B111ermsVXRgz5vyxMhtBjJ9ik91aZ0/HeiwEHTKX930HQEQMBo38b9cTvnISrCwT5w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 15796619-b51a-4ce8-3f97-08d65f026f3c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR19MB0072;
x-ms-traffictypediagnostic: CY4PR19MB0072:
x-microsoft-antispam-prvs: <CY4PR19MB00720174E64563C8078957A0ADA60@CY4PR19MB0072.namprd19.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(4982022)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR19MB0072;BCL:0;PCL:0;RULEID:;SRVR:CY4PR19MB0072;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(33656002)(5660300001)(25786009)(68736007)(2906002)(14454004)(97736004)(7696005)(6436002)(186003)(74316002)(305945005)(6506007)(99286004)(26005)(102836004)(2501003)(7736002)(71200400001)(71190400001)(478600001)(6116002)(14444005)(86362001)(15974865002)(256004)(3846002)(81166006)(8676002)(9686003)(8936002)(53936002)(316002)(476003)(105586002)(1730700003)(106356001)(5640700003)(2351001)(55016002)(486006)(6916009)(81156014)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR19MB0072;H:CY4PR19MB1526.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8YYul3An0Uz3oc0Hv3tU3x3tNvut0+Pg17xpfED7AkM7ibhpbel9OvhdwAdUGItaHOFWhcvYrTaZ9BduoY21aTMd8YaaP90kzSex63be/RKz3n8WHCuSNXqwvxSIlNPKVqPT/dZr3/XX1ROt+A+0dvrMaavRUSEyq3Rh/5pQPyzpMzir9EVIyuibMk6n850II2JBPz9IEiLw0O7Wlq8O2wntuPyJ8XmOJlVMOOjxURwNlIzITR6ziqfOv1xD/LMjBuhscLgBgWOF1P7k0/Un0ZGmCgg//3FFcpfYCOv4vA+KfyVNuK8Utcl4nrHINUPW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15796619-b51a-4ce8-3f97-08d65f026f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 00:48:57.8895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR19MB0072
X-MC-Unique: A6Tm5rQGPXioipkWOwwtQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are seeing an issue where git clone in Linux Ubuntu 14.04.5 LTS fails wi=
th the following error using the HTTP protocol.

The error on the client is:
   fatal: the remote end hung up unexpectedly
   fatal: early EOF
   fatal: index-pack failed

The client is writing to an NFS volume.

The HTTP POST error on the server is:
   c.a.s.i.w.filters.StreamGuardFilter The remote client has aborted the co=
nnection
   c.a.s.i.w.filters.StreamGuardFilter Failed to flush buffer; the remote c=
lient aborted the connection

Our git repositories are managed by Atlassian's bitbucket server v5.5.1.

We see this with the Linux git client SW v1.9.1 and v2.19.2 (doesn't seem t=
o matter the client SW version).

The Linux git server is SW v2.9.5.

Per discussions about this we've tried the following:
1. We increased the GIT_HTTP_MAX_REQUEST_BUFFER setting on the server to 10=
0MBs.
2. We set the http.postBuffer client value to 100MBs.
Neither of these helped.

Any thoughts about this please?

Note:=20
For reasons I will not enter into, we cannot use SSH for this.

Thank you.

end

Regards,
Owen Ofiesh, SCM, Software Test and Development Manager
MaxLinear, Inc.=A0=A0|=A0 www.maxlinear.com=20
5966 La Place Court Suite 100 Carlsbad, CA 92008
Phone: 760-517-1109
Cell: 858-335-1690
oofiesh@maxlinear.com=20


