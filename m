Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C337B1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 15:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeIGUAW (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 16:00:22 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com ([40.107.8.108]:3960
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727692AbeIGUAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 16:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qtcompany.onmicrosoft.com; s=selector1-qt-io;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cih+y5VdWU3VqZm4J/OygtKPX4LOi00tyylTsntHGE=;
 b=p3qqEWJS7nUt5EM5JYWGh133nVCiPyvysjSlbWD5pP728EiLcAlxV7BE7QZOmTHRgwciylh+ab+kxvcOidwtnwEasCM9gi6GrRVF0aSFhgtDfG0gFs+UJ2Q1YLmJyL7ZE63S25WY+zNSOD4lyiilRTaCB5J/pZm5QAeBd9pJCcM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Allan.Jensen@qt.io; 
Received: from twilight.localnet (62.220.2.194) by
 DB3PR0202MB3387.eurprd02.prod.outlook.com (2603:10a6:8:6::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Fri, 7 Sep 2018 15:18:54 +0000
From:   Allan Sandfeld Jensen <allan.jensen@qt.io>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: Old submodules broken in 2.19rc1 and 2.19rc2
Date:   Fri, 07 Sep 2018 17:18:52 +0200
Message-ID: <1591523.hyI6sBWrkQ@twilight>
Organization: The Qt Company
In-Reply-To: <20180907150327.GB26719@sigill.intra.peff.net>
References: <2659750.rG6xLiZASK@twilight> <20180907150327.GB26719@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [62.220.2.194]
X-ClientProxiedBy: AM5P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::25) To DB3PR0202MB3387.eurprd02.prod.outlook.com
 (2603:10a6:8:6::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f451d705-00df-47e1-abcd-08d614d539cb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB3PR0202MB3387;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0202MB3387;3:IQIIZRlIa0hoA/JkvX6ViaVfdqVtb3lonTyamvVY1Loc2UaQtO0HwZb+DI79lho7erzaKw+/FofxnI1JdpF20Z8Lgojy5wOPnrSXSWsB3CYDpp3a9uqp03roj1GCk/Yj4PxFiU8bBBbnX1Aeqspm5RFZb+0MDaJk67NYKE0ezKift+nAZolGG7iwGPL+sIoBQ231IV8iqzti2bBBnOaGXj+BvEwJ8BNmBwdpYpmDRuvrfzXj94Boqm4852r7tVIA;25:9boYYh7KxDZIqXZm+8IoIS6ZPSOOpOPqHLan2CPVCP5EpJzqrBgXc9vAgpKkbw5aeSzkbkT+0FXAIXtMkOE52kYisdepEqtTZrLUGZfoY+cxPNIBo9l9WS0GOIdkT64GCDmJEb42V/1jqm3AP2QWN5BqFvPHfz6jzvw10GtH/Ankzljdtmzjbd8/DpoOLW9L/MSEGxWuiwtRBlLdU9aAr8xsJ32YIrXs9wk2BrqlBQiN0dZtbwND48Igkl21O2GVWpg/uwtLp1WiUU8y5HXqr65RlfvIe6OEpsJI5Dv5Cmv3Q56BzNo0V9orVOHo3kUop9lG2CxbAzL7bYGYhEtZVA==;31:1izpjSN3VGRq9Oarvgi/ugLN23O4gynudbGeRbuR46nWd6wwO4BFe04pASlZc7wlRi16Ka6uHtXHXc5dxDjtsiAgLsVVldbpR/W874coQ0X2yI/Chd5xcDVKSraA1/CggsIDHriG8ek4O8ocffvT57iWP0W4aMSj1OakGsMJhe7E1251BWb+QRlOQmn9HxMh7G/8hmFtCJw1ZxgFhsbRaTUBwjaLhKnge9qQB7DMOPU=
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3387:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0202MB3387;20:IlRxwKfLqJUnxk2wToSS4enjdLBTsQUk4TyFL5xE6HPNdEeX6uoNDmm3tK2bS3JhkiltnKczzrjFjKlULwAtmnTYEbIr73iBDo3JS4CruIorj0Q5Da+MVc48FggHPU3pVWIKToxBRh8elU1xpEvT37pFH1vrBRQ1ZVlMmhzeHzIPiy8LZ/M5DeM/ohlFsrucC0ctMEesS+rJbV/qzJm21bU7C4vk4EQZKaL5HPLj/DxzN+3lz6BOdnRPtJcIFM/twCkJtZfGxNeSEAYlYqtSV1572p9qw06EYorUJZgRm4NH90t5yUmhqRNsQDHOdfjMPc2c+g5oP+SFVPX9lPF9LHk4rJQsrrlng3w+JhPynwd+LfhKvteAYGf6GXsSqxahtgCt+fHkDwmBryBZBrpZeFS1wuU4seshUs8b5bH2EIUl++Hh8uLzffdhMmwo20RYGsd8mPkz6x7IG5dxhuaCG9ZxOYqBkJ63qOhR2iAhrod/aERPiIiceXigO1kdwhbf;4:ejzvgN9AbRtuyW8Jx3tLSucbPh2uuQEWR2gVQL6i+6E4C1N4+jaFZgXphZ/Z5OWYru35UmYgU5Ma1YYkY2rFjmfAsVJN8hXX2r/JDJPEsr6g9mRfv4CmX4jHeDRbX5RXYcleh6L9p/cU9wUasmbe4A6T1BvBemOhIIP2mYkIz4AWiGJPnm+HwS966mUX7f9A+dfsZYcjNiQluz9ehOycaj2LKxkDo7w23W6BGGqyh65thdRRFuYng/FY10bmJLveG8qqJwkVpe3uTlGrElmjBD/cvBWoVdgUKXPnVlMsdMMHHOWcrsmnBpDcupRD6eec
X-Microsoft-Antispam-PRVS: <DB3PR0202MB3387E2AAD67D3CB38030AB6B8E000@DB3PR0202MB3387.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(244540007438412);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:DB3PR0202MB3387;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0202MB3387;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(136003)(39850400004)(199004)(189003)(316002)(50466002)(33896004)(53936002)(97736004)(2906002)(68736007)(478600001)(14444005)(186003)(16526019)(26005)(76176011)(6246003)(11346002)(52116002)(956004)(36916002)(446003)(74482002)(486006)(6486002)(6512007)(9686003)(229853002)(476003)(230700001)(66066001)(81166006)(47776003)(6916009)(8936002)(6506007)(33716001)(386003)(105586002)(106356001)(81156014)(4326008)(25786009)(86362001)(46406003)(8676002)(97756001)(3846002)(6116002)(7736002)(23726003)(305945005)(5660300001)(72206003)(39026011);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3387;H:twilight.localnet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: qt.io does not designate permitted
 sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0202MB3387;23:qg8y0mvp33SJnHaHljubmxllDYLJJhfbPD1uXao?=
 =?us-ascii?Q?BCso31UnrsO0XQwaYXIqXWRc4b0oP2FAmkUGn/ZEfkMu66nvHoKZpnCa9TY7?=
 =?us-ascii?Q?8i6yn3uEuMtdSjahGLOlXG5zSNqqJ40Klr6/ZSScfzd9u84aQhOEtuzgLbyT?=
 =?us-ascii?Q?bPhXRJCEB9qxV44O/oTVsFXOXq4xl8LGg9rMsXG86aevBW71Raoa49D/60gd?=
 =?us-ascii?Q?ZIErUuXfMEoBnRdmI5pswJ+wgMIdBNW/waNLV9BPfzKJiUk9R9PaRnclSX6i?=
 =?us-ascii?Q?9yFTwZsxeMBsiVOs94K1sacqBGZEDZlCcii8d/hMpG95TaEOo0k6Tm5lZHjB?=
 =?us-ascii?Q?E+L7l1E7738EF09rcB7TF7+Ip+QHFnbKGCbchyI4rdTxBULqsSbjFJ9GGNAi?=
 =?us-ascii?Q?4Z4JCqcKs3IY3ytJynddjn+uPY94jLMCAvgFBZQWD0/SiJT0QGSF5Si8jn89?=
 =?us-ascii?Q?SrnRM4WVDl75gINB30mFHO3OC53RBGbFDadvmRRdGkJNE/FlnsQZ+oGUILXI?=
 =?us-ascii?Q?anGV+4wMuciYz1qj5ioowAlJp6g+MrkVzp0vSgiLPuELbiMaVcGOKxxCG+yu?=
 =?us-ascii?Q?tEmC94YizZrKpeOmxmYPJSaKTxoUnHXqRfI9HRpxXTi8FSAXaV8eQRJxvi2e?=
 =?us-ascii?Q?EhvYnv+xrNlShIFXlbLxc6wPiBBMeRG5pnndE8xnuRiZtrx4ofGWk+P5Sh1a?=
 =?us-ascii?Q?yehiwZ3ijw7f0hjnrFcAPKC73nGuWlQiPJ3212zkJOOA4as02WlpgGxj1TkC?=
 =?us-ascii?Q?XqmNMCncNmaFsBoX5VUoLIYiUfOKcbG1c/3WSl8UIeVzqA+uM5ir3lJ6gMEl?=
 =?us-ascii?Q?T7SOJ+amlql1lnaX3n5SLJacEugiXyf6bvXuNo3wZAVx2L5c1SC2T1wOmOlq?=
 =?us-ascii?Q?r5vzgI5qZox7AtPmAwTj8XuphAvOOzGry1BCMa0n7C86CXRqH0OWXWaDidmg?=
 =?us-ascii?Q?ZyqN3BB0KJ8m0qX73QnxgI14wP/KsxotddwTif6WbZwULJ3NkFIvG1wEuxjW?=
 =?us-ascii?Q?h8UxBHiSmSZhwzNxp1AJtN8lnsuT4SjtrvwhLKHvMYuPMw1xPku9TbPyhEVj?=
 =?us-ascii?Q?0saAwXHxxD0Dw1Y5M5yUMNEiGnto4G2Krnp7aAojcrDIyknVR4j1bjy222pP?=
 =?us-ascii?Q?5YN1Y6loj7/4rMzCMba5MOZvVK8LugJh+RNwcHZt1+mYmdjehcZdsb7z6J5f?=
 =?us-ascii?Q?JDIEi2jYZ+RhoasYHXcl7u33kFYP5to0QsYfOD4XVDEaDZj7E5LfO+0xL7FU?=
 =?us-ascii?Q?mD2OmDQ3Y1epjs8sYqB3AGrnwSnNM4Hyn2kr8ZIriabfQ2IPvucC5NQsIesN?=
 =?us-ascii?Q?BmzRecb3s3fp61kv+oSIJQkU=3D?=
X-Microsoft-Antispam-Message-Info: C7sePPQh1EyN/nET1w8KAfgP8HD9Py9eJG9JHlD0p8Vy9tvZZoXRwZ9CvNFixUeUAta+C6536o5M3bzfxAv/so05Z+mQvnwdw49dQ1fLVC0wOItJT0znvg3StNXWKgIsAKvN3dJ4rx415X03KtAsfjxcUpwk3kU4JU2wYlwH6BCSvr8SibDO0bGjyR8xeu0WpOl9CSAtxBUY+gyj0U9MIXHeXVEpXan/v1/1ahiMSNMjoh8DTmnerZw+m9CdB6xCs41fPud4uudkSn/AkX9CZSmL6AuAF1BN+AAMNU0GmJ0u1Mu+6pJJbg8RNa62aOy301D+mev2n5JY1As8TgCi3NqBXd15xEFYD3XHPGH89ZI=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0202MB3387;6:DsXGMLzHY9HsgX7T0rhIX4+/5OvifezNK4iPn7UhN3jvpD83i44sAKyKPVnWmYyvkkfplAm6JL1h49kCBA/RHtf//fAQFs0KZ4gmHMd3AiydsJ62fFdrubUfLI+1T71aXVU7eXjcvw9E5IAXiiAcDj6WInEyfbB/h5BRZtZc2C+Ey2svAVdBliZ5Nn/Pmj16EFDAVDH+Z554KPe40zwKAhBigSBQc+WDCqgWjnFAUWp1rJjDNrnAGi1tkAIMmRvP7VslM0bpkIWActzHv0hk40xsCvI2QUquL8g45aLG3Q7yE9CrBxIEJLxGNC1zCsuXsAdygaCA3r/Ncm7vfqoxAdtb3jfYKLu7Xiq4K/lhvV7zxQ7hZDEoBDZtDxtyZfklMF+h22wkqSVaIorZZ/sv6jDdLUy/Wf9uMnKVA/QtntX3/EDMu3AZEo4hXfpwSVJ1gxPKvHBQomMSWnIB/c6IgA==;5:aykmXUhsza/iOExq0yDUPu3Wwfw3Z6zOkmJ0nI8c0C2BWq+PaMpgqp9mS5sMPSqSzOzzRwn70nyaqb7FAJglodZxix+f8epelX5hfIbS5aECkW055pv6qJIhLRF97pJGssVbtXFN1eWvL4Yyum+HZmKtu1FKhXfR2asC1RmFMu8=;7:lt3FzOgSdL1KOySywMiiEY9/GiZhQcVMVqw4C0J7/wCMadXw9xnBpVVwWaQdP2KzIcuc8sjctYEgU8+VWtA79zWTeCOvNOnvxNThS26I/tfhMKy4MRvsUccAL436DIngmOFNFJh5T42u8ljyuWZLTks/p89Id/OPyaZNM/mF+nL15Y4yr3ISCViwciqPd+RsrMIZOoxImd2Kaf4vccNNzodW22gKw862Vk8MU+3Uw5XXkLGz4iKQZdurU7+qEmrq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 15:18:54.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f451d705-00df-47e1-abcd-08d614d539cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3387
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Freitag, 7. September 2018 17:03:27 CEST Jeff King wrote:
> On Fri, Sep 07, 2018 at 11:52:58AM +0200, Allan Sandfeld Jensen wrote:
> > Submodules checked out with older versions of git not longer works in the
> > latest 2.19 releases. A "git submodule update --recursive" command wil
> > fail
> > for each submodule with a line saying "fatal: could not open
> > '<submodule>/.git' for writing> Is a directory.
> 
> I couldn't reproduce after cloning with v1.6.6.3 (which creates ".git"
> as a directory in the tree). Is it possible for you to bisect (or
> perhaps share with us the broken example)?
> 
I discovered it by using Debian testing, and it is shipping the 2.17rcs for 
some reason. The example is just an old checkout of qt5.git with submodules, 
it is rather large.

I could try bisecting, but I am not sure I have the time anytime soon, I just 
wanted to report it to you first incase you knew of a change that suddenly 
assumed the new structure.

'Allan



