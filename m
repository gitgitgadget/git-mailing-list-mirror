Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809C91F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeFFURD (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:17:03 -0400
Received: from au-smtp-delivery-203.mimecast.com ([124.47.189.203]:27491 "EHLO
        au-smtp-delivery-203.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752282AbeFFURC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jun 2018 16:17:02 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2018 16:17:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unimelb.edu.au; s=mimecast20161020; t=1528316220; h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references; bh=q4MSSlLP1XxwMJQDnwNIxWbRouA829LDsoQVFn9vHcI=; b=ceMDgUcAmMmb5eK0Rv01q+P3QQcV51ERGd9qP/KkyKE2Wxy4PJe2S43ErrtWo6ZBMlZAhnliiY91k+THWgYo3uCsoodFIUAIr7CTqI/eVbsPu1nypwHM6kapcC6hyR5lzav+5hLCo0kjTrym0IvzMW9c3jviFphLuQHqp72C/WQ=
Received: from AUS01-ME1-obe.outbound.protection.outlook.com
 (mail-me1aus01lp0149.outbound.protection.outlook.com [65.55.88.149]) (Using
 TLS) by au-smtp-1.mimecast.com with ESMTP id
 au-mta-49-ls3MJV1DMYeNK_C11z_IoA-1; Thu, 07 Jun 2018 06:10:23 +1000
Received: from sleipnir (115.64.110.35) by
 SYAPR01MB2815.ausprd01.prod.outlook.com (2603:10c6:1:f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Wed, 6 Jun 2018 20:10:19 +0000
Date:   Thu, 7 Jun 2018 06:10:13 +1000
From:   Timothy Rice <timothy.rice@unimelb.edu.au>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Thomas Fischer <thomasfischer@fastmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>, git@vger.kernel.org
Subject: Re: git rm bug
Message-ID: <20180606201012.GA2454@sleipnir>
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
 <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain>
 <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
 <20180606200137.GJ3094@zaya.teonanacatl.net>
MIME-Version: 1.0
In-Reply-To: <20180606200137.GJ3094@zaya.teonanacatl.net>
X-Originating-IP: [115.64.110.35]
X-ClientProxiedBy: ME1PR01CA0084.ausprd01.prod.outlook.com
 (2603:10c6:200:18::17) To SYAPR01MB2815.ausprd01.prod.outlook.com
 (2603:10c6:1:f::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:SYAPR01MB2815;
X-Microsoft-Exchange-Diagnostics: 1;SYAPR01MB2815;3:eqVVo+DnKKc1gdt6+29rFISoji+d6EBI9A1YcDXTbdZbeobfcBuOs85bn1UkYksRNLpN2Rs29D5sg5uAVkaa6yMERbsXYz7Sa8F66VYmoCGvMYvhw1YSjJ+7m5Es0b5GwnaJJc1mNu3hAWVhTl4AbHNyH5HcbLGKDEnoos08n0556aVc7QzRCS8R8ab0rjlv+VDvf5zsqSnfrh8XCIesevRaHvBmrhwjtL1bhweOAOFKXF5KasOwYegz2qkvDpCU;25:XFxHbEc+g/wqHtXr9E4MWzZURQWXQ6C/fXVkwKPrJaCh0oFPZ6GOvitoGprNB3y/jssacwv2ode2gxXwCuMc46Ene8Z5QhxrcWcBy1m/j0WeEtwprFiVzuMulJRFpZobD3k7zGTEoepDFpndDfuNNum7+APrzWXy7wO/Uvd/QkdKIPUpbk42T0tMiWGfvtqKL7cnUgKjj+u/gTaTygyKFZRye6wOocuxOw5YIsD94awh4A+S6kNzw0FHC16yqF4+Mb3hp/saaNviaM66mBcub9kbeHd5Do0Oc2agEOyoroQxnrINpTMB/IrcCZqXvNkKCtJHO0ZLzH030f4xSs75VA==;31:Mq/pMfuySxAIZgOKv5VpBrcJTSlkxjINNXgy5wAVysvfrpRhnOc+5HyyBnk+Waz6tYneBWpguEWX5+6IildTpx7KFS/OqRLVCMwpMz5wL/A1Lw6Ok/clDhr1zzY7UnYWNRkH71IWdflUyvsRw3FKd0Pcxo9QukqRpgc8HXwhKqsbPFuwV5RenXFl/CjwTsHTa/HQ4ke9ZqWTpiIOMX70rxPYlH+VtOlw3hCk+MtQP4Y=
X-MS-TrafficTypeDiagnostic: SYAPR01MB2815:
X-Microsoft-Exchange-Diagnostics: 1;SYAPR01MB2815;20:+626ghyIvgZSMfO9LMyx5zTBy51Cmx4fYFpWxI0guIZWYCnr8BTcdo1NJJF6zr3E8cJBuRbXsKspA8nQAtzT+7tna1PiLERmxUTDYxhh48N/MeOmfYGa1b7MUiZDtTG4+rJJQ7dHcgRXJCaXmJ4uIG08fY+YJQptycFowYyZcslB2kkY29UjCKPwMxOosgEwgHy1AA2WjQK1lkRrFGYDilX1zvX1T+HZpa064m3NnFQqw4HhMEfpxC5x9OAbSaDV7VFWl+kavPrm3Z1IShWIILjMtezvoa9g6FqWr4L2KO+b1yLFLps38XWH0nB6dNhusIfNzkdz0SsTEVq6zBsr0Id4aqQuJL8tJ2N4IZgUu8E0I5pbD6fCBm9Cw7h4UVgOB+3tkQHp2HT0ZTbiw5Ehal5boAqEInaFFa9x1KB94julZqnX0/8v47v5LbubX1ICPkp8zCKqy9EFcq88k02G1FyOILWM+YAsYdRpg+hSmSSwdedETlIFEA5/aB5Qg0ne;4:qN1H0Hj2wEGz7RSKXrDt+IIhLjYNUA8eC1SghJ3mXKR13ryxyOHrJ8w6zIUDOloPHYoK/Zg5DcLrf6g6gQGjBKEqfRj9+RMYBSFSR5c7+p4pkAKakSNn1m0N8ynE0qr3njnKuu3yQri/5r53fd2kHfAlelgJ8GiINPHVhFLAV6WaL5Lh13nhBjA7G0APxquJXGgB5DzDLzJz04OQykIUyke/0Q5FZBoOSOOOPSBQYdo/pVBci8/5QtfbmvkJ+mQfP1ep3nm/oU5pVgDrPeQpQw==
X-Microsoft-Antispam-PRVS: <SYAPR01MB2815F4C160DAD5590CADA0C4A7650@SYAPR01MB2815.ausprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SYAPR01MB2815;BCL:0;PCL:0;RULEID:;SRVR:SYAPR01MB2815;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(8676002)(74482002)(486006)(476003)(11346002)(956004)(446003)(786003)(186003)(316002)(16586007)(16526019)(54906003)(106356001)(105586002)(8656006)(93886005)(66066001)(386003)(33656002)(88552002)(50466002)(33896004)(47776003)(76176011)(52116002)(6496006)(26005)(68736007)(478600001)(2906002)(97736004)(6246003)(25786009)(4326008)(305945005)(7736002)(7116003)(8936002)(3480700004)(1076002)(5660300001)(81166006)(44832011)(81156014)(9686003)(3846002)(6116002)(33716001)(6916009)(23726003)(86362001)(6666003)(55016002)(53936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SYAPR01MB2815;H:sleipnir;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SYAPR01MB2815;23:2rHX4ZXWkpeTfxMhDQudJFvCpQMWthxFsQMYOT9hk?=
 =?us-ascii?Q?ux+zptL6iLNhckIJKGIa4xIAR9xE70EBTTylqpUwG2omy2buyuKSk5dK5AGL?=
 =?us-ascii?Q?PYVQta63y6v3SpMkUBTbUmdoxzGkTh5e5xDScGW8kdsJ4vaERHsBcgdbwPUo?=
 =?us-ascii?Q?MztNAPsLbNCCUHNOr4YR5TK/T9mbePRKk0ndNUVHp01pvhxNbp91vrBiaLcd?=
 =?us-ascii?Q?+WFcjHlbrBH6EnV0txNU2UFyx2K6xsl/D5os+tLyJMpH41xj+LC83s09a0ss?=
 =?us-ascii?Q?lIgPQn+sirrgvv0C6KS2YKxKzmc1xHjA8R5XMR/703U0AmGzjdy5p1LZD3an?=
 =?us-ascii?Q?qiD8dKn4FPQYWCN3dO7u2L8BBrLoFhd0tmZgaqZakyJhcKe9avBt3/aq7CaT?=
 =?us-ascii?Q?9qUo7a7roaqDF5uvDyiL7ynoTiQrI7QFsZ4aZ3Z43ASCUQuub4b7VJZ+TOgc?=
 =?us-ascii?Q?sdI/SzRhumLVxT0d25cHRVfztyYL8KYfC4u3o1l//UodVZimcdzMt4kLcK/X?=
 =?us-ascii?Q?cMs3eP+c1HKa9pPCOgD8kEDFjdz8SQVF6acEgCJpL3ydgP4+WSGF7Nx5TCWZ?=
 =?us-ascii?Q?GBX9LJLc4rTrOx8tbnozIiubF3eXwp0xEF5XfljmN/6VLy2FTRae+yIpYmWk?=
 =?us-ascii?Q?CyovzTT72zZxkyBoYkzwZwPO99K7r074FbiE9f8VaMaN3Q0qkqO72+O8q1l8?=
 =?us-ascii?Q?ODCx54YxiqKLVfFDKiAOg2jrCzltweW/oIlqY59plUsr+uFgARzZaUyyvFMc?=
 =?us-ascii?Q?T9eX9UltFJAOeWSNSFoK0/oZfJdD+s/ahL75FPImOgBcAtSzSifNOS76Z5Ip?=
 =?us-ascii?Q?ClXCNZIu1oOp03A3LEBFdJkHjtMnAs/FQyinxmrhcHYq2tj2A3fC3X/uPmYI?=
 =?us-ascii?Q?KLDDYrICVnnfiQfwDxzwGYd7ChqKhp+uijBpAe18ZYlOFumRUKaw28fsVYhn?=
 =?us-ascii?Q?NyZzlNyAmz5ELBlNkSfEwT8cWPFjseqGiVW+0O7eGyoENQ5jtl0EpGujFVlF?=
 =?us-ascii?Q?/KGgr+x61s5mCIa0EzlETgZCoEtW0E9MBP+YQjc0iHWxxo+kO1s9slYYQijo?=
 =?us-ascii?Q?jFdQdUdUFGf+LQZrNu71ERQjHzs/1pmelUBYYxj046xsdIukZtrRJ4cH0H8j?=
 =?us-ascii?Q?xeZJFMiv/PNR+LqJy3vYPOtqbrS5b7W4pwH73xcv/OBKvc7wDUt7VMy3a4eg?=
 =?us-ascii?Q?RD7yo3xqSqPLkKs7JkZPJu8gCs8ikIQNAdv7Ns1xEdqbQkrOERU1hoiIcPE9?=
 =?us-ascii?Q?8K1l0ZJB59yWYmnazoBHWXGwT/2NDJ1F5XdFDGOrjYtz1F4L9PH3JEDD9kL2?=
 =?us-ascii?Q?Hwo2YA2Ydm1p2xLsnfaxaCT18F4jFXo4UU8NzkSiD/A6Dayq3MnlOPtItL+F?=
 =?us-ascii?Q?WZxNHT4hkSydrKJcS37ThG+9C6RwOcoSk/FT9zOyejm809p?=
X-Microsoft-Antispam-Message-Info: bfAp/3zkmLdG1xCT0e9eSafwg12s72ZA+MvdynInwTSIzbyZpOXT+djJHn6vC9AbvGiOCBwh8UQL1chTetRhVgW/++8m8OGjUCIjYsvgq9fS9uB/iecolUpkbmO/TnvFIDEzzS/2wmSd3ORAKgfA0YkMrE8ty/nCN7uOh9u83ZQeKu9eKPOuPauuYvHhWfxE
X-Microsoft-Exchange-Diagnostics: 1;SYAPR01MB2815;6:V9siUNsYT3tpKIlORQoeDTX6uEjO38p03xvZRyKquL66p+aZGTX5aRmBsiUhMeVScCtYDQb6Y1fJfPk4VcqfRdPr0porw9Krp+8n0Tnn4iXTTaxoFf+KwjbvmNNrYnPRGSfGbNWkcfIUICRtjUGWhq4Bxm5SusUBAlHdgpcaRf/fMPkfoLxWgM8FzLCplr5JP8t1vfa6uvx6gvvQ8x7JfiqAnszsNm5m2GkzA5wZXHqRsJs7Vjwn+FAsYVuXBNEihzrifz5TeHSNGyb5QPcZBOYduAlLzIlBE9fnFW54PBC3QWgsKTVWmc92qATmGlrxM4HsXZjVIY/Aw2i6F7tv5eQxVhpq5KF+D751EsHHJOmjZdr4srUCITfMawQaPua4oLsuJj7HdnrXsYrHGD8t68xvYMzTsM2JnRtO2KiDHtRvQ7WuKtNOZF9HoAFyW6BVV2IaCLaJGNPC6bcOguu9wQ==;5:hFSyMnuXMOSx0ejEQ2QdldxKTXwaHLnQAl8N4zXPGoiciI4N5QPopMv0Ptyl21kTBqV1d8cPGwoDD8cjNozViOc3r3JKONM/fe0G/jjYiB10PWaBJs5P/v7oa5uP4ekeWwzCbRgq0wDjyt5Qc+4lFY3hh8TrDXAnnhOtELHn3Tk=;24:JA1urwEGGqU47RhvpHF7B3hVBXOYpuFzplHrgEbB9DDjJfaL3rBu82HdlL23VqgIsDjR6AlXRieDTGFUfDeTd/slEYxugQY+dCyBOS+GNUo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SYAPR01MB2815;7:c8ubM9r8XbILoSev/X5+gEBuk6J2qsCK0UGPD0V1/g9JhemCs3e00TLpUIhNFnhCt/7+aHtHmkPAE+QV00aZzNwjT0X2sZInALX/pKjzzcjK0rY+U7RHUfSBHFSq8PtOz2W+jKYDtTSOm4vpbMh28n53H/JCaWtEBRawfjNoycIPH6TUZ0Q5QQ/zNKA32XpTOdjawrwf5IpBWaU7DabiedBqHS/8+d9GusFJ7ZOinynBCNdwvTl1V3QVZ55oMpkl;20:xyzDZsw6z7RQ5DlnIffHNHN/azohizTaNFooZwalfvLLwLTh+UclFpRRkrn023t2MewJOnvxbphgvc0W2OQhi8NQtlVFo9m6VyGfSs9XqgAcWidzygl8JD/WoLA0hV/rOj/xYbemqeOIWYVEMqZ/bbeN1gbkC0zoxglNfOKuhI0=
X-MS-Office365-Filtering-Correlation-Id: 7e6a06a0-154d-44e5-372c-08d5cbe986da
X-OriginatorOrg: unimelb.edu.au
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 20:10:19.0715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6a06a0-154d-44e5-372c-08d5cbe986da
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0e5bf3cf-1ff4-46b7-9176-52c538c22a4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYAPR01MB2815
X-MC-Unique: ls3MJV1DMYeNK_C11z_IoA-1
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It does seem like something which could be noted in the git
> rm docs.  Perhaps you'd care to take a stab at a patch to
> add a note to Documentation/git-rm.txt Thomas?  Maybe a note
> at the end of the DISCUSSION section?

That same documentation could mention a common workaround for when someone
does really want to keep the empty directories:

$ touch ./path/to/empty/dir/.keep
$ git add ./path/to/empty/dir/.keep
$ git commit -m "Keep that empty directory because it is needed for <whatev=
er>"

This would obviate the need for a new flag to switch behaviours.

~ Tim

