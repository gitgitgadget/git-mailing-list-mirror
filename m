Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB6C1F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 11:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbcIUL6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:58:49 -0400
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:47264
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751736AbcIUL6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sociomanticlabsgmbh.onmicrosoft.com; s=selector1-sociomantic-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Hs/H4y0GQz14OWOEp1Ju2PlOqop9VnewHhAJFGZEMus=;
 b=e5Ux3yyf3OUvsi9DbpQpiIlsuDWo0Gj0oZ494P/wHz+5UG6RVGHEOWQiHuvImtpNfe/ltPkGe2zGEGWjX10oM/rYuqHdii1rMbv5UUuzQAYCmdomgE3rbZW4idkhAjzPXKdZUQ9NvwpkcZ0rwkoytcnxCf23pNzPUFonNw3bJfc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leandro.lucarella@sociomantic.com; 
Received: from labs-064.localdomain (87.149.183.221) by
 VI1PR0101MB2142.eurprd01.prod.exchangelabs.com (10.169.130.7) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.629.8; Wed, 21 Sep
 2016 10:24:57 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=labs-064.localdomain)
        by labs-064.localdomain with esmtp (Exim 4.82)
        (envelope-from <leandro.lucarella@sociomantic.com>)
        id 1bmehy-00027k-4y; Wed, 21 Sep 2016 12:24:54 +0200
Date:   Wed, 21 Sep 2016 12:24:54 +0200
From:   Leandro Lucarella <leandro.lucarella@sociomantic.com>
To:     Jeff King <peff@peff.net>
CC:     Mehul Jain <mehul.jain2029@gmail.com>, <git@vger.kernel.org>
Subject: Re: 2.10.0: git log --oneline prints gpg signatures in 4 lines
Message-ID: <20160921122454.2a736dea@labs-064.localdomain>
In-Reply-To: <20160920231533.fxcdjgphz25hnbxt@sigill.intra.peff.net>
References: <20160920170954.38b24284@labs-064.localdomain>
        <20160920231533.fxcdjgphz25hnbxt@sigill.intra.peff.net>
Organization: Sociomantic Labs GmbH
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [87.149.183.221]
X-ClientProxiedBy: DB5PR01CA0018.eurprd01.prod.exchangelabs.com
 (10.162.149.156) To VI1PR0101MB2142.eurprd01.prod.exchangelabs.com
 (10.169.130.7)
X-MS-Office365-Filtering-Correlation-Id: 5ffd60f7-fde9-4179-0246-08d3e2098986
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2142;2:m03G8PAv/f515GaG7T+XzSSB797VyZOvn1VPJ3oG7tNbBILq5MCApHmfuQLs4FWtgtf65xX9HcqSYejhz5VFBUGQ/8Ya2STaLxGRtrY4Zv1U25HhWdCqSWqHjYCq+rkdar1JqxpQb0yKFuNvEH3JS74ZGZA8ypGbHQch5XQKDx1tJfk+e6NVCdXJDWI16/rI;3:tXmShby9DTs0Cd2AlYJHa0HdOU9JCYseqObFS1co7bm+p1PktcFXrWr4u1KOjPJZCxNPCPFHg+3niTyG6CI5vnQRWmd+MERJxbDSs3Eu55YjLPr8F9gcYGC981QIb5gU
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0101MB2142;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2142;25:3i0/mtY7uiTCVT/LcT2Y7Wz2dLiscWgRtHuwALFt18/XvCcMhRA2i+2lcLGsifY91/Qz8a0LRriP51/CZVMxtzR5FmbBEblv+Ocv9n+4GfRleBnOSxicCofk2XEroZKGk0/eOrA85KuDN/wD+TSwBqb2YefpB1AjkuONV8jwMII4D5X6pShpYAJqrwBZIDdxT9wNecuP9gRcs12RVTbX9CfhjpRxWv09sUF8E+BE/XctnsH2MEAD4U+FoX+GDKViAxiux7ZRIKKB57e6bwzcm89bqDlbHJxuQvN0RjZ3TpUMbVZvspDEhNNqFLpRsi9OaeVPBISLWBk7mx3H3YV1rBZr7aqxHgPSMkCs3vWCgC/P684r0VNCAKeCuLDTvxlARcgG2RdLr3sMaQQEs9cB2ofVGmr3sR7UgCFmo0n+KSOhJ9qnVWCjI263w6TCpiMt5qA/M+0M0bNB3IcZIJrtm/jsZF8JVdcDTXZPCBL8Xndu4ouMLSWCckUEGxN9YxNEioxaoTc6wGqtoDX/V0YFCIpLplHiMDxXGMdcU6OMSqHynttfJkHED2NV4Nx5oi36b9OkU3CpLTVlPY8nH78tbXy2MBLUzj5ziv6V9RPXCy3azZ4v/f1eVtyFSt7GG6W7GphXN0dualtXRmTpxQEaVaxVBbsiSeWT936+Hv36Wkg9HWyym8PP2mRLtxPHaeljir+YFet5qv4RkarC7TpZocsQRh7RiWlWGpditF4y3BojluS1MMNBhlY3WdmMj+whO7KXnaGWosEeSJ5AoK/e9ZYLnCV1MdHbHqBLAcl0OWwPxHx0cobkRXRkOPcvnB10QLiMxscdvY3L48q5F1B3eg==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2142;31:nQHIB8wdgZPht68Hb9Bk+mSpYg+6GyECFFSr93X2PwgahuEJft5r02XDNjiUtOb1PoNBbtAr+byUEcYiUfzk3SIx/UwcD9jt1R7jNm9/19ENw4GxIyH+hNmrnyXjEx/vg+mgueIiyWjHarbNJH9TI0vviWv0ZJXv3bumZuthB2Kas7qiFVP12NRZq8nPVmIp0hHYvKnIevAZEOOm+OEV1gNDEokZBqNYbBc4WxnWseA=;20:rIw1AZHuaaB7OLC+sGFrm4HzuFlnj9Jroyr9edP1JuEZGJN6IKd1iT5tOdatqrpPalyak0y+cXEtQz5O6cCfqiUsrL5ZtGjWq8q7yzTXU9pp9XJS/KsUWK2VRTWzAWz6cAtpaEEDQfiyJQZSpUqTvK32PbsayPENEX5DjhXA3lUMjacIEwOgkfn6uY1/Y+90KS2koJWWQbeJFSOxUYRIMU+pL4JFAnzReXhnKf2+ycAEtf1/6wzE2MNobRlDCkrn;4:Dxqqe+CQQc9kh8SYFBr/3SEmMUFXC9oacQdpNpL8K20gAtzwDkkE8aHoNYuLPkRlTRCYrZrAXxItHhHipy1RImNdbmYlIIKvNLjP+r0FAlvsxCEg2Ch9s6U04AfPfeqUCgEuEvHvXdDAOvUhixlZAnPbv8UMdeNcgTZJiwbLKkps6mzl0kfc+QJimxGh+99/xSdftozNPAb9rcQS2x7s8bJNqJIBU0Rblvc3LtloVZ371+RcUbKFX2eZBQegGMQ5elS5hEyczbM1F30q0oa1UWipZ6tTiRVnCivO1GI4+44ETIDX/QrQNr06RdkHdJ3pjZWvqOGoSQBtyYdcZfFHV44LqjpcXysp9YkdeBq7BlhSLFvoaWpyhX0OWKOclhWE8e39a5TT8jXpRi/FecIez1/nm53Kx24KnuHbtNaMvVhZhyODQ8Gi3q/mrTIz91L2kiZ7/LLBIF4pAqt9Cu62/Q==
X-Microsoft-Antispam-PRVS: <VI1PR0101MB2142151D3B8076F697C02B9DECF60@VI1PR0101MB2142.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(7783539604369);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6042046)(6043046);SRVR:VI1PR0101MB2142;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0101MB2142;
X-Forefront-PRVS: 007271867D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(24454002)(52314003)(189998001)(122856001)(8746002)(66066001)(33646002)(7846002)(305945005)(7736002)(97736004)(49486002)(5820100001)(68736007)(2906002)(50226002)(92566002)(23676002)(86362001)(81166006)(8676002)(81156014)(4326007)(9686002)(9786002)(586003)(5660300001)(7126002)(1076002)(101416001)(6116002)(3846002)(7696004)(50466002)(19580395003)(19580405001)(76176999)(106356001)(47776003)(50986999)(110136003)(2950100001)(77096005)(15975445007)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0101MB2142;H:labs-064.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: sociomantic.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAxMDFNQjIxNDI7MjM6cGloM0J6VFdSaDQ2NkhyMElQSnY0Tllw?=
 =?utf-8?B?MW9kaVRpdzJMeXF1M2t6WFBBcUZSWnlDN3lNWlZFZ04ybW9wL29zdTRHR3JW?=
 =?utf-8?B?SnZQU2VUaGl1b1pPZFdHa3o0SlBRSnUzTlhZWCtBTmtPM2VtcFZHeFp3YVBT?=
 =?utf-8?B?UUlFbEo5QmJsS2hCMWIwOGRrbmk3UFNsU3hPbVFZMFVSenJSdDNqKzVqVWhL?=
 =?utf-8?B?Y2dDeU5sQ1R2ZHVURE01aEJ4c3g4RUQ2byttVlRwSVovaUNGeXdpazNQRXVT?=
 =?utf-8?B?RzhxdE00Ull1TmJPcTdVY3pBNFUzb1c5ZlRqekJPcEZ2L2xhVkxzQmljdFZV?=
 =?utf-8?B?bTl6ZllBanN4YkpieUpqUEQ5S0QyUEkxTzJubVdMVXRaRkhGMG5JeTJBbVI1?=
 =?utf-8?B?SE9BRWo2cnFPY3o4eXBUMk5pcnZCTmUxVnZxT2dLQmw3K2FpRUpYak9ETXdG?=
 =?utf-8?B?cWJSa2d6OFZZekFIQVk0Zk5QV3Zja0ZqRWxObU13M2g2YThEdXV1STU2bXNk?=
 =?utf-8?B?eUFma1YrWDcrekZIdkE4dmkyMTNTd0VqeUg2NmgrRW5FMkdFZ3pNVEtOYk83?=
 =?utf-8?B?ZW9kdzRoUmFUOC92TFo0R1hsdjdzZ1lxazg3L1Q2UnVVdERGWG92UzN5eTF2?=
 =?utf-8?B?dVlhZngrZ1JLQTluZ2JMWmp4SUkyMHI4d1VEeS9lWHJtSTQ2V1JKbUdhVEFQ?=
 =?utf-8?B?K2Z1VHJ2bmtzM2dSTEo1b21SWEhYUXpnN3J5WjhWbkpyZitOSUs2QmYyOU9y?=
 =?utf-8?B?Y0pHbHlSbWx6akJzaStYNWNRV2lRY08zclpnRUZtejNnYnN1THY5Tnh4Um83?=
 =?utf-8?B?TndrK0hjZFpza3NoQVhkeFpJalkzTUZyNGZubmc5VUIzaGx4cmFTdXNXZnY3?=
 =?utf-8?B?MFduOS9EU1hDbVo4c29wWWNLK2N3SzBYVDFBM3pqSHh6bHdiTURRVUx6TXNH?=
 =?utf-8?B?cHNNTE5NNENBZHNhL0l5bllJTExybVZCajJwOUxDMWw5OXdZSDJUWHhBM3A4?=
 =?utf-8?B?Z0xZNnJRTzBmdmZYMTBIYTZDZHNTT1BUMHVvWVZwUVk2WjNoVGVja29VOXVj?=
 =?utf-8?B?SXBRMTZqTzdvem41SUZGVkhoWDRyV2paOXl2MUVTVDA0cnIvNUt6WGVSdEQ4?=
 =?utf-8?B?WGZkcEorYnhFbEZNRStmM2w3a21VSW9iZ2x6eGx2aldxY1c3OTBoa3hTV2FN?=
 =?utf-8?B?NDJEemZUSTB5cjZ4RVB2MWJMc3BPdnl0VVo0KzdHbXRmL0wrQVh4NkpidFdh?=
 =?utf-8?B?ODJ2c2VaMFplNTBSQTV5TTA1UFVYT2I2RlQ2dHZLL05kZDBQTVpWNlJpeGhV?=
 =?utf-8?B?MkxiWHpJV0NOS1RBaUJVY2RNZTV1ZkpUYnFsczU3ZE5ub24vd3RLZUJVZFdU?=
 =?utf-8?B?QzFNN2ZCcEhycmxFcXB3U25nSDVCWTNSc1lFSjdBVlhyQkhuMjBpaVdQTjhK?=
 =?utf-8?B?Sk1NczkzYmhoekQraC94QnQvT1BBNExIdVFVZysxb3RkWUZsRm1wOWtoUWI4?=
 =?utf-8?B?UkJrYWZzS1ZvTmhSSXArcmdnMEM5WXpxWk1DR2ZYdHg3MUJlTVJRb2ZYOFRX?=
 =?utf-8?B?U0ZMb0dpRDhmY0J5NXJ0cVVHS2ZyWXNvbHgvbktQV3RlZmJoSmFmVm4ySXd0?=
 =?utf-8?B?cWUzbHZxS29NMG9VWFRoOVZXRVF2RURTM2J5NnErVVN4c0FmUDluT1l4K3c9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2142;6:TZEB74xSSzEYxKwtWa3/0WIgm14BIbcOI4kgB9TWEk95AiMWnaDfRLCERzcIZcfQXLGeRsfekSc5D3GdMbLPeOMnHJ06T+fF8N6zSao8MIk2Ms6dRICDTMBsyzVTOIgqoIHZMWY9KeeQOPvZkYYbMaeYlQ98vpdyUxuB9FMeSArSwrcM/LGasnh+wWQEq6UibtU4mXKxbCOX0wz/JsfvDNY3eBMuhNkcIVo01olgpA8UcP2c0kd66zlKspCvXD+dcTJsGZ6x9+oIeaq6NowHt+NksIwAevLti027AIL+7lQ0suNVcd63XN6QLdVMULiN;5:6pYhv3L3JTMvcmJnO2rUVNAsN+ObJww3STJn49JdpVaxeVnz+fYpjRDTSv4Ze1XbllTU9/Fr8twf0W64F2pHt0fRlzYRGm7hpZbsxFbnRpegavZboWLMeqHiaYj8MbttfXiKWezMB3xt4G/Hc72VAA==;24:zrBdOMwrv4oN1lTBfBDle8iQnnDK9PnzXGvJL4dEIR/5U2xIyMRSFJBZ99I2dc2KdhPpDMyChfUbkmzKf1VoYKt9i5TImODXVsTh1X7bwmc=;7:EJQaoY/gdXy2J9n3LYsqRasrFut+V6RHw4BXy76i4JbvpPyTtOpDMe76gzaCMqloKjRi/irwb1+OY99V4pWBwOXFlLU3SpyEKcYf7BKI2dg3bxXPIYmLEQX6t9tq8cG/xm9iVR29pA+qCERVXx6zYoD7LK21KcXcVEvZGE9wAb16bMVJyiSXILH5P/LjK+AhqmZdXk8k7dAxXwiEJbjVMgphaExpUmtlaC1hIOgEioFDLTN/G2eDsERvbGd00jOxFzV0ByzZEkJWzUuFTZ8/qE6oRQh1mdO4kIDM89reVZywFAz059q6GdLZpDnXGuFW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sociomantic.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2016 10:24:57.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0101MB2142
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Sep 2016 19:15:33 -0400
Jeff King <peff@peff.net> wrote:

> On Tue, Sep 20, 2016 at 05:09:54PM +0200, Leandro Lucarella wrote:
>=20
> > Hi, starting from 2.10.0 I noticed that when using git log
> > --oneline, if commits are signed with GPG, now the signatures are
> > printed too, and it takes 3 lines for the signature information + 1
> > line for the title of the commit, so suddenly --oneline became
> > --fourline :)
> >=20
> > Is this really intended?
>=20
> I don't think anything has changed here in 2.10. Running "git log
> --oneline --show-signature" has _always_ been horribly ugly. However,
> 2.10 did introduce the "log.showsignature" config, which makes "git
> log --oneline" pretty unusable when it is enabled. Ditto for
> one-liner uses of "--format".

Right! Now I remember, I changed my configuration when I read the
release notes, before I upgraded. Now that I did upgrade I'm seeing the
results.

Anyway, yeah, using the new configuration makes --oneline pretty
unusable, so ignoring that option for --oneline seems like a good idea.

> I think we should probably ignore the config entirely when using any
> of the one-liner formats (and I'd include --format, too, even though
> it can sometimes be multi-line; it already has %GG to include that
> information as appropriate).
>=20
> Another option would be to somehow represent the signature information
> in the --oneline output, but I think I'd rather leave that for people
> to experiment with using "--format".

I think it might be nice to show the information in one line in a ver
succinct way, like just showing a green unicode check mark (=E2=9C=93) or a=
 red
cross mark (=E2=9D=8C) if it failed (or just colour the commit subject in
green/red if a signature is present and is passing/failing).

Thanks!

--=20
Leandro Lucarella
Technical Development Lead
Sociomantic Labs GmbH <http://www.sociomantic.com>
