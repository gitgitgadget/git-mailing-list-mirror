Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AF21F597
	for <e@80x24.org>; Thu, 19 Jul 2018 09:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbeGSJzc (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 05:55:32 -0400
Received: from au-smtp-delivery-203.mimecast.com ([124.47.189.203]:48759 "EHLO
        au-smtp-delivery-203.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727075AbeGSJzc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Jul 2018 05:55:32 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2018 05:55:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unimelb.edu.au; s=mimecast20161020; t=1531991595; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=D9Nb2DnVslY6n+1cosg05suogIZKShOtiYBda/h1o6s=; b=ZJKwGwndavYZCE8EF4Xuiddnemuu4t/dJiCkb9rbnyhgTH5b8VvtTPTLRN12RayqJjESdYuMT7jpDYvSXbvPVnEbelSdCl43WBJVtW/UDrneJ25UGHDviEjRcMcvH7IfvpGqairMYnNoa/7SAcYRPp6VY1wQWXEOtVpavZL+wU4=
Received: from AUS01-SY3-obe.outbound.protection.outlook.com
 (mail-sy3aus01lp0176.outbound.protection.outlook.com [65.55.88.176]) (Using
 TLS) by au-smtp-1.mimecast.com with ESMTP id
 au-mta-39-K4f48pq_NLKBbSQdICUXVA-1; Thu, 19 Jul 2018 19:07:08 +1000
Received: from sleipnir (115.64.110.35) by
 SY2PR01MB2811.ausprd01.prod.outlook.com (2603:10c6:1:19::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 09:07:05 +0000
Date:   Thu, 19 Jul 2018 19:06:57 +1000
From:   Timothy Rice <timothy.rice@unimelb.edu.au>
To:     =?iso-8859-1?Q?3=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: Q: Ignore ./foo, but not script/foo
Message-ID: <20180719090656.GA18624@sleipnir>
References: <5B503FF0020000A10002C6B5@gwsmtp1.uni-regensburg.de>
 <8736wfd579.fsf@evledraar.gmail.com>
MIME-Version: 1.0
In-Reply-To: <8736wfd579.fsf@evledraar.gmail.com>
X-Originating-IP: [115.64.110.35]
X-ClientProxiedBy: ME1PR01CA0118.ausprd01.prod.outlook.com
 (2603:10c6:200:19::27) To SY2PR01MB2811.ausprd01.prod.outlook.com
 (2603:10c6:1:19::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3af2a599-4441-4ad1-eabb-08d5ed57000c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SY2PR01MB2811;
X-Microsoft-Exchange-Diagnostics: 1;SY2PR01MB2811;3:sXR9QNC+pjKqzPY7f2zO2E3EIn8a3O0sxK3steSB00j0MXuba5xjiQSYUpklxZluw0P8eRSXdMwh61A3tssksxO7vXH58ETZo4npWFFL16b9pa27aSTd6ARZp0GSwYtLGb0AdnLYykHqjVgCrWdA3psgriZOwXin/3m4LikcuJEP09kyjHd51SbvU+oXj9olee89Y+3YdR7zvilqVzytcVnMZPPghl8JWX7gMCZGK+R/NyUjrGw1mc2BDthtujIw;25:MRlA/1h1EWrPcf+nNxyLtdyr8V1UhJ32EdWwFsBWEGytvXxugKLbdojDjnFQqCQS+ifrtTkKjyUXc7xSd3v1ol76EC8SXJPM3/SYOArOFBi4GyOT/K5Iz2IFor/1Fv8YkrPWVJ1JkaeHiZz7rwtGeEHKuDkpsRrAHU5bNFKPAGfFuaRKA4skAjBPCm8Osshuig/dYhZGmNSS8HssXkOsYqPxW3q3xtOXjqB4QuUggmmvXgMffkDscm17/R3Y05WSpZWzNp5N+ukXTvnm4Zc7FlUYB7W0ps+gRDQy4p51hyXJDA0FQ4XRLWWqxm0FHz7AxmPMJzkVxIjhEPH5y/OS6g==;31:8g21MOlRgalP5qf616kVupmVf2UPDxfU8Qv9dGAJiysyI8lDCOpGz3uMjLh9G97ruAtgUtmYM4GAITNbB1FJczHFYiAP2kbOnPt1+b+SvlPh9V2uWlLlfk3uxq0/6KAitIZ9cH6jdJY3sAXD2dfT/rp5DO5qdIbRzo5F2fySzT3DLVZJNgdvmQjmgTBtbBmotC/fbz/GqkMcDIa7EkyxDtLOhh08vzOmxQ6b/+G/e4w=
X-MS-TrafficTypeDiagnostic: SY2PR01MB2811:
X-Microsoft-Exchange-Diagnostics: 1;SY2PR01MB2811;20:77G26OToWdXUVhdrWA/0tkwGubJiCD2K4z5WfZjFFOWDZ9/lm+gwx9HierOAb4SeBkkKDUg/+LPtYWaVLXEXynnGNzQ42ic4hpBl0NaFMeZdIlRIhVhPb0dwF0BXSkaF8FZAHp33U7cLpHiJnbWSLRpcxX1NObqQRsInPPLH6kv0e7yL4jRRErq6ZkV9dyoVGtWO2r4Z2c4ZSW5N3UJr09A9cVmvPUHxUUHC4NNfeT4rJQToCeBI6IPqThNpgta3rThlp5MsghdpNOBNyzfydiSGJIUnmv1Rfirj95ErLDbwKHsn/u2tuVXqQt6xqct2ihRFNoBtR9xZeDVuXAe7AvOUwnldUKYCDGIZhzjvb/zsYOj0mDhbgY7s2YydbE1aAE1hWQfdE5h/n6VY/7fDohJNHpRxXvN2KxwVy1FjTMoSkjl5qCgoSQYgo79LjX07gEhoyvO8+8yPOrHaT7BfF0Gj8aSJ08LhQ8jRHu7sP7TDyVPzXemWb+8k9JquLPOt;4:S7Hmgx42siTkCTKU8ZKZCPSlasuZfex/TiivljkFglr8wju563o492gGzhte3hWOHsESLVHO0nBvFXKDP4GLt6mGWDznnkNbFtYrIulPhbBAUVaTA8WCxv5MZxnkpowLRFvNcDMrME47NVYTYf6A3StKpdhyPH5YShbP+fyM5jrEupl+JeGte9POktTddTgTJuL5apmsyRPqLr+9s7KPQ4Nocx+4qx9twEbXw+Rw8QdItZ2mRr2zN7+QTD8AqCsCa/yOWVfE42mE2MRQ/ytQqQ==
X-Microsoft-Antispam-PRVS: <SY2PR01MB2811C4952F3BCF9CF0A80C7AA7520@SY2PR01MB2811.ausprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SY2PR01MB2811;BCL:0;PCL:0;RULEID:;SRVR:SY2PR01MB2811;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(7736002)(9686003)(8676002)(8936002)(229853002)(6916009)(81166006)(6306002)(26005)(81156014)(6666003)(66066001)(55016002)(316002)(68736007)(44832011)(76176011)(16586007)(47776003)(186003)(33716001)(33896004)(786003)(476003)(956004)(486006)(305945005)(5660300001)(386003)(11346002)(6496006)(52116002)(16526019)(446003)(966005)(53936002)(25786009)(1076002)(6246003)(33656002)(4326008)(2906002)(3846002)(50466002)(106356001)(39060400002)(105586002)(23726003)(74482002)(6116002)(1411001)(88552002)(97736004)(478600001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SY2PR01MB2811;H:sleipnir;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SY2PR01MB2811;23:2sI3rg1GhR0VtYMhvJLbiK5xn5EtLmCaSxbZ5TVlB?=
 =?us-ascii?Q?2CwJFs/MU3oEq65xrrn59cICpov9B3vSpHrqix6ep1A8di5XU9vYGOect7lO?=
 =?us-ascii?Q?l9hfGY1vvQTn52r6zclf56TRAcgg+orzC0JruLz4At+PSJFApEGnwT12/2uL?=
 =?us-ascii?Q?CXBj/W0O4eDmN5hXQNLGWPm8r5JCzEtRG8x/Nut2tjkgZ9I0XUKXuEJHfLnp?=
 =?us-ascii?Q?pNr8otr+45TzxTc9HYxu/j78UV/WjJ6GoD+IIQHei1jRzxD+r7rk9lX8IjoP?=
 =?us-ascii?Q?Ll8qOs80LbrInpLRjB1kWqgpLQ6+nEtF8DYpUOK8kqxdXSSbmY5pm5zzueCq?=
 =?us-ascii?Q?cMUSkrUscvIMy/Y9bFiz8tjk7jg6dhCZH0wOBvx6X51BgDykRFFPKPo/XVfy?=
 =?us-ascii?Q?IJU7D+v2Rny/w+4fiiMgoVCkQ8UL06Zr6LVwsDrmBGo6uFM4R+txqgmvD+zY?=
 =?us-ascii?Q?Uf+k/66BBL0rdBk7hKGI1liZWWQtHTb78lxQDe27AUBGsk9p4/0dWYyZJvp2?=
 =?us-ascii?Q?Wv2FmrQ+vpkfw4RPPU+geN6nkzhJvzF4M7STrCU/rAzn9qHEzG3TLJgjsFj3?=
 =?us-ascii?Q?h+tCNx75oXbTFGhBSa8SsjXuel6QpZxhGr9BI5Eky/33fgX6p1S1EsmizVjM?=
 =?us-ascii?Q?zev6v02FahvQpZpsOyBjirBm6yOXEWW3iyDwknpPp8ZZGbzUvDHlStLuov22?=
 =?us-ascii?Q?lm4LUvyv3httSzDNmpA/+u7qWntALgu3c7qOe5UqLqDPw837psyla03uxNzT?=
 =?us-ascii?Q?jkT1Tm/pnSgWzxgJA4zkkm0IdT6ebnD9kBf51CS5yGPB/gvH/j1RlXLVowrf?=
 =?us-ascii?Q?Ol65wkYJ9gsnpCqpJ+0G5WXt2q9tK7+s4adXKlVeOZnNwL4U9kWlBMMw77SQ?=
 =?us-ascii?Q?eJO+VhyX5Nhg5q2LfVB7OOF4dWwFaB9twQ8bsGVCcah4r4EnZiZj8c7Vh2M9?=
 =?us-ascii?Q?PhXJ/PCchi5wWzRloY5kY4zjcx+GWIXL2EdxrnY3vyE9PQeBc116ipgpkDS4?=
 =?us-ascii?Q?BF+ZwfOf2eE/sIVwiXLSiPAyrqvCEClcUMbXtZx8DyMgZ4dniH1G3n0EwOD5?=
 =?us-ascii?Q?M+1q2WgMCBpYIMjLVmpZZzt2mAXoGraNVox6j+mSWIcQ59aoY9m+zRuQk1La?=
 =?us-ascii?Q?h7kqvlKcLFX32lckyAK851WwmoGLaebx4W9wQ9S5GhKi/xAMSuRlhSH+Nfr/?=
 =?us-ascii?Q?z4KpfU5BwtkyqYxE1kITQYuugh3Q5w99iFgkJN48tLvBGWLP6Yp32iHvx9zz?=
 =?us-ascii?Q?wpPPKo9F/Nhj1f6OXSI85AmuCChdt/7QdygJfuszhTOrv9M0zaTWm0owPFet?=
 =?us-ascii?Q?xHdUoyo72ARDHmrMoE777KhjwsWApqUEtNKxqfktGr20eUxu/+IZfaJpJsW3?=
 =?us-ascii?Q?ebZXjWZVABaTv94b351209T9GU=3D?=
X-Microsoft-Antispam-Message-Info: 7TorcbDXjeP52tM6JGPENp9EXcB+k1D87ZK22iWoAjxyaFuPaVLzRyv2OFf+W3xgFBkXEHDqILnxLIrpn4N/CL20TqmWmZO75lYcWrW+Np7VWviVtrEYWXBhD6SV6bKgu3lMFVlDkoZPrFV+wqyzMcbecdFaI7ovLXi6IpghlXNRUA/NEU6rQxdEgFINXg12s9Nv3MzVmQ5EYipjs35UbyuxlOLx0vOFXX21h0JJtjU71WWkYYd8Vk1WMsfH3mIWK5ZJgT/FuQdPw/CW6VV8NCljndNBGjZtwWrKA1rv5QJDOpjjADQ7YbdA/gpM3Ei8zeDgXo3FAcmziAG1bTS0SIQpCkNal5BltrnVH9bI5TE=
X-Microsoft-Exchange-Diagnostics: 1;SY2PR01MB2811;6:KzbF07DOa0ZWEOkBQhCe3GxObg165zEHPDu0owDIOL4gzgHoM09JS1Xb8VmsqzOJV0GOKW83k6Y+PT26aArgwsMnZVJmTlW9S28LV8XJAEhI1LYJA4nt7J06gC8aso3+MELp+9TkxM3RgctWp3mR3B8CJWqqtGEc1of8Fm0arqsA7pOqIk5QkL9SS9hCykpQlncokccIKMoRsCAJYwcLqe+8dZIwJ8LTe+HPFeU4Mbc/bJmnKN0I0A6aR7LZOiw3DUkzcHYBW6JWHBSwRTZMVH5IMnpdEj1G+DBMc9iKqPD4GuE79j8yAcet0Dp/yK8oae8rMpd2HPvYNfPbiypwR6LnWPWv0ERrqLyqpVgQB+Wd/szRIKPVYr5wPd6YAPnzeHDVUrmryKLtKCK6PNwpTwH90UseNvbG/trvn/NcNRu+Lr8YWPu7kr0rn67su2X2p6af8l9IQ8tjC/Y2iGo9oA==;5:/oPOlbTUEuavr3uJp64llkF54XGwVfbXeC4Ypi4q4RGIqXU+A4H9Xs/HkT05I1FSg2fd9E38vJjHpSzNW1YaI9IMaCetrQGmqgnFVLyrPMLYNzSsK5IjJM2YRm6/URahzlkimnDpLm5AwG8YxLjwW1FfnZpCG5hwUIno8ln4W0E=;7:EnUsaqBp+6EQrNqKJM6T34gjbHf146OvWl4LcQcGdydUoV2+sGQhAnJcy8bgAiFf+5+UFDdJsGlzPBDQ7eOYI2gGxZIAUxFjpuB3svSwyfuIqtXJWzyayqVMCYh+E4xN9DylGwqzGhhCLrn6U8Uylwdjli3kLrTA8DW+yiElAaj1ffKea9P0L6pQdGxz3r9NoLTe/IRl3zlHNuFMktOoS9LzyD+eaNk+2LppLgEHS+CKJa+RNYN9Hm8/Wm/SMsfk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SY2PR01MB2811;20:FSEZj3gUIW+zm5tc3XdN9GP8BrkTuDxQCFwiCcVBo6AO11/JwEKLc+kMKpCL6EOq9bIHWZjP+y6WILmNcd42XQJX6wCP9ksjmUsjZY42WhvWokYFuTPg0eThCIh3XQYuno1sPUjBUf3BHO+ynuIVJ/M1czBRDwxHRSZO4Gx9JGg=
X-OriginatorOrg: unimelb.edu.au
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 09:07:05.9546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af2a599-4441-4ad1-eabb-08d5ed57000c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0e5bf3cf-1ff4-46b7-9176-52c538c22a4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PR01MB2811
X-MC-Unique: K4f48pq_NLKBbSQdICUXVA-1
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> How did you come up with this "./" syntax?

It is a Unix thing: "./" or just "." refers to the current directory.

When calling scripts or programs in the current directory from a Unix
command line, it is required to refer to them as, say, "./foo" (not just
"foo") -- unless "." is in your PATH.

Most people do put "." in their PATH for convenience but it is considered a
little unsafe [1].

Personally, I am surprised that gitignore does not understand this
notation. To me, OPs meaning was crystal clear: "./foo" should mean to only
ignore the foo in the repository's root directory.

[1] https://superuser.com/questions/156582/why-is-not-in-the-path-by-defaul=
t

~ Tim

