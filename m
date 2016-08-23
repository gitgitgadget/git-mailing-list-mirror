Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C322B1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 23:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbcHWXOt (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 19:14:49 -0400
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:27328
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752154AbcHWXOr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 19:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sociomanticlabsgmbh.onmicrosoft.com; s=selector1-sociomantic-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dEPP/7EE8Q3PGnxKwE09z0sBOFd+8WKxa3wCOnaWgzs=;
 b=QtCspMpcIj6YGpzFGIxQN0P+7sRHjQ2K3//KjtHShnf0mS2Lz+P8UkIMbD9wAsmyAasHh3FPsn00/cTnb7CjECny6dj/TtK1269Xgx2JNi8zUPiI9k0i7zUmehaH0iNGv05TJ8VDpJN79+nhvaqr3yPCdmrEod4pK5KwvdH6Gr4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leandro.lucarella@sociomantic.com; 
Received: from labs-064.localdomain (87.149.174.153) by
 VI1PR0101MB2143.eurprd01.prod.exchangelabs.com (10.169.130.8) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.587.13; Tue, 23 Aug 2016 18:38:21 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=labs-064.localdomain)
        by labs-064.localdomain with esmtp (Exim 4.82)
        (envelope-from <leandro.lucarella@sociomantic.com>)
        id 1bcGaZ-0005GQ-5x
        for git@vger.kernel.org; Tue, 23 Aug 2016 20:38:19 +0200
Date:   Tue, 23 Aug 2016 20:38:19 +0200
From:   Leandro Lucarella <leandro.lucarella@sociomantic.com>
To:     <git@vger.kernel.org>
Subject: Re: Getting "The following submodule paths contain changes that can
 not be found on any remote" when they are in the remote
Message-ID: <20160823203819.2dfa513c@labs-064.localdomain>
In-Reply-To: <20160823203446.40abfd37@labs-064.localdomain>
References: <20160823203446.40abfd37@labs-064.localdomain>
Organization: Sociomantic Labs GmbH
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.149.174.153]
X-ClientProxiedBy: AM3PR04CA0116.eurprd04.prod.outlook.com (10.163.180.170) To
 VI1PR0101MB2143.eurprd01.prod.exchangelabs.com (10.169.130.8)
X-MS-Office365-Filtering-Correlation-Id: 7bbc75ae-d85f-4c08-0125-08d3cb84a892
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2143;2:P8flFP7tzUbaATeyB3Hpo5m++ndjEesLpHii0QAJLmUzJWY3vVp//HfGC82NMpHwdglxDLzYn9p6PQVRux8pwRZQl+P2b/TP2xAmtpbedwHeO1oruLbPnJjXVOfAM6ik+oF61SDTPWVWSCy9ulrtQII1AQbhVDGA2UfPEo0Ug2ygf+XLSq2S5NLE8P82dere;3:RTXuEvyh4yYKnrA0b7O8kD0cG+3hc/RFL0jPQ69hrf1UgPl/zx2TSA0acbfFiulfAnj1tCv4mFcSTIw+Ukq9rbE2Visk8agcvPkZWYPfaP6N++awf48sYiXYkDBflOdg;25:KkX/HFbIf5zG7lQsRXbVeZYgtP3UTCBh81ys2s918m8SGQWdzH8yjhzYojsj0scO2WkSVoT6LWEfsQQxlFYlM99/IgwTPhw1QaE84b2p6qnl1R+x6lW9923vkxcWNnGielcVAZ+Ctc4PdQDvfykTt8K4vYU+eP/2OZTR40eFV/ZXgQT+YoiUZJK1L6DNs4S/JLqGv53SGH8siwedF0QS2rNUDdsuncoXEJ3O1z2suqGiWa/9c1jXyHlHMJejax/s8NeQqqgDfzcb9vZqQ/yAuEGRsH4cd9AKVx+mKjhmbrYJhlDviCzGCcBgF/JCwkYKXjSvuqbQQhBWIDCPX/VwslocNZrA850Qv6edHLuvqaNCkIPwdZWmgo+LhF8qfolt3N1muMX6QXt3UFKPnFfDeRYjjR0llmlAl65pHgn1DYs=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0101MB2143;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2143;31:ea2H1YBEW9cI/Lbw0xjcXWEMyjfvRbzHxCaucGKNQL+tqPXBrykgDBO0SshljdbbP3P1KDPcHWjQjugE6ErOkNBwz9IX2RN2pvZm75DChLokzZXiJm0baKVJG6W1rJE8r0g2GNsEDZQW2ulMOnJ36mUhb1cczliuUBAncIonDEdsM0TCQRiWtd/kQgTcWmHHMcZ5+105uqPHHQ+lsrKPNxbj1DViPS74uKqWlrBmqw8=;20:6yoC8JiB+AW42YWfCoxWyfPkNBYX/6FHA58kNeGhrv6VZa32DHS06rY/L+90ZwUXbQQkGhhyI7MA9wOdQUC/Ot4RtCfN7cuOh2P1BPV/yrZbDtFk5wCTtVExZp4/vyQX3UN6J6VPXLgvLZYtGYwajju/Owz14a2EHBhC5j/sH5MlEE23fQv3KqGr1ydZdbbhDZBPMFqF/CptYNpYK8MhOM4oCk7KkwIelk1P1jIUYtl6jC2oxv1hRs0xC3r3Ya8a;4:4is4JVYEPg5IEfVeUGMApWw7iQoZ+vSqDjYYs6fAmVDQRrd2pJooLj2I5AAIh5XC1GiKdG6ZJwAkmmAhQsEJYZB317m7l/C4ROOpH/pW2J+xNiwNcVJlUzdM7BcFKo5rGnVDNn7ArZF4HiWrLQ84BpNAnXDTNUnfuO5ARJ68hzleJVBTaXZLOkMiuYRBJERi3r2NItJOMrbyHcvI4KvrexB4GMkdlwtt0f6So445eAEjIfWP36p5l7ducUn7Mq6VNxGlRCBtzx4I08YGWa1xcuRi2+sIBmqAroM2knhgAB0dsXKQwYX/4I7ZEu956+6oh5LoQ4KyzTm6gm+TDLMZxzZqYAAuCmIoXFzJoWUHHI8qgRCRFScJtptEZMwJmN8YueT1hPykvIVz8ZxuY7ihXmXk9tAqwuJSjEF9rWfn4LuERJYuRYl+lP99SJRJSO1MIQjDKUyhiTW7zV7hcBck+w==
X-Microsoft-Antispam-PRVS: <VI1PR0101MB2143ADF6C7973F63CCA76EB3ECEB0@VI1PR0101MB2143.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(7783539604369);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6043046)(6042046);SRVR:VI1PR0101MB2143;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0101MB2143;
X-Forefront-PRVS: 004395A01C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(24454002)(199003)(43784003)(189002)(81166006)(23726003)(2950100001)(49486002)(7126002)(2351001)(5660300001)(86362001)(76176999)(230700001)(586003)(77096005)(106356001)(105586002)(6116002)(101416001)(3846002)(50466002)(19580395003)(450100001)(15975445007)(33646002)(50986999)(122856001)(7846002)(7696003)(92566002)(46406003)(47776003)(305945005)(2906002)(7736002)(110136002)(1076002)(50226002)(107886002)(9786002)(189998001)(19580405001)(8676002)(66066001)(97736004)(81156014)(9686002)(68736007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0101MB2143;H:labs-064.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: sociomantic.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0101MB2143;23:fEEuVDZkLUQZEnCi6AQVbOzYU+8z0LLB2+ciG0k?=
 =?us-ascii?Q?oP5umvjRodbQoBlrUYLjOzLyEZmvv3Do0GBcObxuNuAnQblcrQYlxiv3dywD?=
 =?us-ascii?Q?7y4A8sMyIuB12KiiPUikGiwvPoMb80EOga3djwfk+hyRQuEBYYojsMKfuCps?=
 =?us-ascii?Q?Ca9h+V3z7mvrsjhSoYlQonv1jrMG0dP2NSd7zU60sRVAKA5FT/Bmc1fhg+NR?=
 =?us-ascii?Q?U2U0UXSDPZiacv1BcDWpt2WCxUQwMBtGPQo6hHetG8IOdPKUPtXfxQ+MAUnA?=
 =?us-ascii?Q?/fnCfjTFqU18npok12+91DlviBetj2uIU1g5lmCc23f994JRpR6EGRM7Wy4P?=
 =?us-ascii?Q?3C6UJePZpef2ov0Gp0NEFQrJCnj+IylG0yIvhiuMjmTNwGuYjqM0d3Spx1nc?=
 =?us-ascii?Q?q8yidMgoY6Xcb6RCSKQ3LipYg4kbacHEMKRjJjU9a0/UAxmiapF0lEDFRrmW?=
 =?us-ascii?Q?CWD/ZhAZbg0Frbq9OXTKmTOZzrH4Msr0mSn9ni1F9P/xfOd9AE7hJOtgka1i?=
 =?us-ascii?Q?Csfyg/LaA5QG7jhgUxlXPFY+UAPAt8nqJhmlqfxrfgOv61Xtd8ztIRzJ5DMn?=
 =?us-ascii?Q?aKhZWxrEzws8xUtp8i6UOIOAHzE8eJde94qHsg1nqU8TB4gdX9wugoFAJMLs?=
 =?us-ascii?Q?uuJ7xFNmWHjyU84NBN36gh1+OkH+s6HTRg43pZwkFeBEDps7XVCBl2IobQ7j?=
 =?us-ascii?Q?y2+9W9D5g5pxK0Qs5SQ3g+jjqWU296CUbBHTZlzkHgNmkLkYRDk9LMVchmiQ?=
 =?us-ascii?Q?e6TvMPFKsVDU5nEfhYfzGk7T+TIgKp9Ok9MtbTRfOPfagWJ3qd+2bW9IIsN8?=
 =?us-ascii?Q?Sy7qcTIDD/03SfrkOsTpSM6yQVC72nKIvS3czqOYL5hle/Q1efipcW5uXdW8?=
 =?us-ascii?Q?YU7KCm2I3WMFzMh3/lHNyIbBijYL7o2edjesL6C+XF9Z1O/R1ewJWfN79bnV?=
 =?us-ascii?Q?S3rIK+og53BnGAJi3B5umUpAXrzbjKolkqvMMNlBkwnWtmI04646qOflPSd8?=
 =?us-ascii?Q?s0/CknKc2kkbgDyhElVaK1lVFhXVDDIk3K12FIyohbH5VisSSZccaKoUSpXC?=
 =?us-ascii?Q?eFjYiuOOi/X/HWAPjvg1n9utQrMHIC+Pnbp6YJXcGYStCM1w8ytfq6qFje+y?=
 =?us-ascii?Q?szwfBTBAKRCSpn2lVDCy0QaWO/3OD+a17b6/pmt95QeVsmX2JKwd4wzMyALu?=
 =?us-ascii?Q?zoAG6r2qSePAwY8Z8r4AZnzUTlMwl/sspYFewkBCVR+BGtUFiLV1Xyj3PigJ?=
 =?us-ascii?Q?onUdukWD1DViouLj72U6hsq/z8neLH0kWisDcmbUk?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2143;6:tFM0OZI/2z27SZMO893qmCf1znrr5RIvQ931r2PPSn2qQa88HH3IN676dS4QZRnn89/Lsw5PQt0xJ4tfFCt6DjNXbSVfhqruSXxZFVDRr4JOGlMLBP6TRgf/trUtr9TDFvHrWMF6Wt6SvXKhl4FyQJNUfsaCHk2RCgcVSaQwUm2BDGvpcqcXeBkiWYySciyRfCPACVwj/iZMrU4zsoWNg5DInvjxonU2J4wxSnqYXv1Slg9QZacwmoLQpPCQjH9rj21wxMeat0ZV9VYvwuJZ7/Q5oGjg3DEENI2uFzj7iwugGoVfXV5zaszpevaYQlDz;5:J08UFBd7EHZ2wQpRSi4/6Dc4NA3AAZgJb/wgz8iXDHlF//dvuGG0gFRvRVP/nFSGCOuZNYnUDGLfENh/rFu7sB+u10o0sz3JnDqs1rYWS8s74pVi6cHog9N5jNpJUD2R3OVlzsRNIOMTqI673PXtbQ==;24:fPEgyTK/Buqzv5oEkZBRM8c+R46mQPT6LLAS2SBKI5JQrtfcTuM+n7Olhp/ZBuuD6yDO9nHgRBQOu3FdQvBfeZmQgqfitezVfetuLEeskfk=;7:3kh0gN41yZhs0rn8g/EKpQJFsrF+v6EUbj4+s6DIxymIw28U94io9mGew7y96V3ra5Fbvj4xzAz5ZN7CXKpafL//34eHsGIQqBP0Z2loBGDdqj74WUJwGKk1FrsBfW6dDB6Xli4kewby10bIjhi1dgrf97pR1rgCH79exmApeTVTdE/zEqMp9PsE2f5CZHjlqjbGc/4aE3KG0ChKESafPXjzNyvdW/+nscurwjYUfLm/YL2+K4gRR1zq56Ekm4LP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sociomantic.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2016 18:38:21.3043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0101MB2143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 23 Aug 2016 20:34:46 +0200
Leandro Lucarella <leandro.lucarella@sociomantic.com> wrote:
> This even happens after doing a:
> 
> git submodule deinit <module>
> rm -fr <module>
> rm -fr .git/modules/<module>
> git submodule update --init

One more thing, doing a clean new clone seems to work, but I have this
issue in many many repos, which are old clones, from before Git had the
ability to check for submodules. Could it be some incompatibility in
old clones with this? Is there anything I can look for in the .git/
directory or elsewhere to fix them?

Thanks again!

-- 
Leandro Lucarella
Technical Development Lead
Sociomantic Labs GmbH <http://www.sociomantic.com>
