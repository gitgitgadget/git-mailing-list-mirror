Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668771F935
	for <e@80x24.org>; Wed, 21 Sep 2016 14:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934257AbcIUOZM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 10:25:12 -0400
Received: from mail-db5eur01on0081.outbound.protection.outlook.com ([104.47.2.81]:54400
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932822AbcIUOZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 10:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sociomanticlabsgmbh.onmicrosoft.com; s=selector1-sociomantic-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mv8fX1uZRFToGaiqawCbIqbulur/tftstDtFDnPWyuk=;
 b=ZM3iccZOwcYeKraS2/7UA0MQeXgKcnmZWRPghWOOBGmnZCw0DvTW3Ufl/Jd+O22RPo33m9PVfsWufrIzbkcW/3ZJz6IIG2YUjmHhutmT7/rxmqo/57mj9Ervg8BfiLXywHajnvwuhCeaKGwV4B+Rlat1Xd3brAd+e9xZVcHyKUI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leandro.lucarella@sociomantic.com; 
Received: from labs-064.localdomain (87.149.183.221) by
 VI1PR0101MB2144.eurprd01.prod.exchangelabs.com (10.169.130.9) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.629.8; Wed, 21 Sep
 2016 13:53:04 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=labs-064.localdomain)
        by labs-064.localdomain with esmtp (Exim 4.82)
        (envelope-from <leandro.lucarella@sociomantic.com>)
        id 1bmhxM-0003ad-GF; Wed, 21 Sep 2016 15:53:00 +0200
Date:   Wed, 21 Sep 2016 15:53:00 +0200
From:   Leandro Lucarella <leandro.lucarella@sociomantic.com>
To:     Jeff King <peff@peff.net>
CC:     Mehul Jain <mehul.jain2029@gmail.com>, <git@vger.kernel.org>
Subject: Re: 2.10.0: git log --oneline prints gpg signatures in 4 lines
Message-ID: <20160921155300.79252e68@labs-064.localdomain>
In-Reply-To: <20160920231533.fxcdjgphz25hnbxt@sigill.intra.peff.net>
References: <20160920170954.38b24284@labs-064.localdomain>
        <20160920231533.fxcdjgphz25hnbxt@sigill.intra.peff.net>
Organization: Sociomantic Labs GmbH
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.149.183.221]
X-ClientProxiedBy: VI1PR02CA0018.eurprd02.prod.outlook.com (10.162.7.156) To
 VI1PR0101MB2144.eurprd01.prod.exchangelabs.com (10.169.130.9)
X-MS-Office365-Filtering-Correlation-Id: 1e165cf3-7100-4857-9284-08d3e2269c4c
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2144;2:iPPqBa85j3Nkf5ZLBeL0E10/lpwvrYX4PW4kYkJP+iNaLMQQBgdIEJOco7Om1pydBQMm469vfFfU59sOlRpzW1nUrLQ3nxMyn4AE3REeLjQiiMmKU8HXp36fcSMnnEEPJh7hsffKZcHzSEEJBts+ALX0x0fzm0CNFbrmDiD00kQKce4IQM97kLZV57itd9qe;3:XERd4sknDJyZ2hffIzFVsx5lNz1zxwT/PDpqdauvhUyWfHq3KFzhH7G2ZfORx8z/DyjSomcIyMRy9511yG+23jtML2gslFpXne85RUUWCgyuC/oPt6g682wvOy26Zjw1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0101MB2144;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2144;25:otI1ypYEgtCC57liRrkggwexD4dXtTsRLjkJm1PBMufTzNslRCD0qutuPoQdQSgoFOv7pnov7PepE3oqsirwIoUAxaMFCTJBcgUwI4KFZk8CUEm492aymQ4KIASjwrqX6f4AKfSlcl4k9U3/MNCh7xmD8xgLaijYIUNXFqavyA1YT6IC53yyUDht5Fh34VoGs8vuB17PzwBhbPbPTSV0REJBCyeETeMoeuZ9dPiqQn3A6g8tVpdxv5qGnUXzQeBbj+vwxwOrBkj8kQCAR1E1mVT5jsekffEJ9s/o5WKpvM6pRxvAd7uGsdbtSTzRlQRtaN/Ek7a59+bTX1FkihiK7Y5W1NwbUiCO5Ok+P9ywRsxqhmXzq0Zf8hz/NfZfLKdJp08onjrwodZvS19q8K6gqRhWDBavyklfKf4V7D2nF3PtCuOkFysOxuwtnCHQZTmHUNEntTuSeAwMjSD+3vRR0BYW4ZaPDKHTYyhB1eU0mZdfjDCTAvsAQuvxv+M/gg+Orjs9zs8CUwbOy5a+FV8eoLuvLEMiurwENUBYLQf9ctJyIRJ5gI5AN9uc7ex+uykUWMYyxvMP/OKXDOINRkn4dRy0aq5Bl3o9rTPoZ1ikEPV9jVSofbzY/yMe5LKWgJwGOQ5RbXM2oeDzUNWLCQGL25Dggb4J7UJ+/vg5mYvOLpu2MAvO/CuVc3NpMc7mAzFXEjDLwQKch9Dqu9zyb1o/oZR7a+ji0UnhlBjrYZurW6xHtA2TJljGaleMf3xgBzq5ukU3UR7WxEjXY8Z3QBHCh69HLvjYUkolX87b33ll21akc6qX/kJM5NEwfiDpqQ02
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2144;31:8EsdppPos0rj39xnJvqbq9TWf6kHSo2m+P/1lvP77osutC22woiHRc/8PO79sR7o6O5/GKdpCKXuPBbEPv18n++KEC2Yu3Zo1AB4ZnHFxk8aP4nZClGdBsrHOGXy8DZxZxTQb7VnMnri1CPiorl7VeluWsgy9WyOTCJ4DDFkS2zgT3GS/tNTlq+hrq0aYigEuph3RlmrMfcw84isU8fVfr5n0qnKsBanyRN3xoycono=;20:Lh+PWfUKk6CYMwL1IQWb5euxW452WXvCZwV6KJ/pUwu4R8s3pJaXMmAbdb3ilWImw0lVST7y9evIPp6d+2/zprdf02dikxwNYcO1htwlDsAdTo9+81w/WxweXLxcqMtuo/yHuUMzTDRgWz+m7bCDMpQAmayOUdZMGHpZ/zSAHfpbwqReWMLAOxLfzv3d49KDgJ+988+PQ1w9Gd9d1y/pKNJR/N6tOBqpVY4RDez5hoVdPMB+FQAJsNVE2kZ4JJHA;4:YQOgvNsZPeic+3C70k474xgeCF+xyMWznyr3YrF/1rVU6GJFwktyY2PwjT898qy6VSE35mCuzzcPs0MlOx0V4JWLVbopChYr0BT//+LmhJdf63g95P+04XG/I54HOggYs+5iNkRIvChAECf3FKmgQwYfgsgGOr7knh7BpxPuX/IBsH1wa/jx0VkXQTMqesIqmFPkgZ2S4LHJNekq/AQs3PI8fDG6vFTxlQNa5WO+3sfLaG0Up6237b6vjGJLEWdVNrLFmD175iAYfjwHfZpwjt+goAiaGBx02XVyhZ1c4EN8x5TlbRQBvuUfw2vvj7WJKBVzP5XVg1o0SaLtdZXIn4ORyYOBO9bIfuAnVt9YwymTYf4j0o1k4e+Xa8oH/ENSCU+sHgJXXfaPREeKNsf/qivp4R+JfXZXAU18TAUBmru8H8bG4VuKM1r815ABHhoPA/5bUDRpW8dzfj+We7Whpw==
X-Microsoft-Antispam-PRVS: <VI1PR0101MB21443436217E5299F83DEC15ECF60@VI1PR0101MB2144.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(7783539604369);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6042046)(6043046);SRVR:VI1PR0101MB2144;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0101MB2144;
X-Forefront-PRVS: 007271867D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(24454002)(189002)(1076002)(23726003)(46406003)(230700001)(6116002)(3846002)(33646002)(305945005)(586003)(7736002)(7846002)(50986999)(76176999)(19580395003)(106356001)(105586002)(19580405001)(101416001)(50466002)(9686002)(9786002)(2950100001)(68736007)(77096005)(8676002)(7126002)(47776003)(81166006)(66066001)(81156014)(122856001)(50226002)(189998001)(49486002)(4326007)(97736004)(6862003)(7696004)(2906002)(92566002)(110136003)(6916008)(5660300001)(86362001)(15975445007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0101MB2144;H:labs-064.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: sociomantic.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0101MB2144;23:C2DdgJj6RKXLYGvHevFCRy+qGJj3Nfk2czsthTe?=
 =?us-ascii?Q?Juyc3Kk7Y/JMIW6aX3vBbKttIge/sEfAHsUFUgkTHFhC7tYCFYK0y5QW3vgQ?=
 =?us-ascii?Q?wO4DSX1sR+awwrtSh7hPf0jsLW/KPmqwDQrorSpEyOCndRUjTvVDPGQpmRvd?=
 =?us-ascii?Q?0ZWWFmQ/5rXHtIBGUOc6sm+IN/NYq874Jcq3cJd6P24o595kFd8JSA/f1UAd?=
 =?us-ascii?Q?bLR7PJsTyC7a+tq8VLLUUP8y3apC3rWld/XRO2xml76EBI760rG6910+7ilc?=
 =?us-ascii?Q?AUytL3ZvnFawN1Qa829mfidPoYPMMp0BMP6NHo1bGA7HVuQHNaF/GAZ1h86u?=
 =?us-ascii?Q?lbMloc52V7WXm7QiuSInWCj5/MWx2FHlh3tTFRp3rUyI2vga6CDQFTsyB32e?=
 =?us-ascii?Q?G0HQFeVLnOS3KwRBRG0g55Qv17nXlJVbEHwPFLC7KxI+RfJ7wQp5E8Qv0aih?=
 =?us-ascii?Q?Bea9ejP2k1gQ7w7qVGIOLUyiq8uTOYRbQs2l0M56/bTcTVt2WeCiyc3Ls8I8?=
 =?us-ascii?Q?aZzTMwwJu+vMKUwnPZz3TVDNOFWDB6S1mJ88l/TfOh2har5nN2Vn+YV0C8f6?=
 =?us-ascii?Q?nL02+ivjNXbOYFvDbd74LUXWUtOVkBtOA9UVROPGcGiebejoWDyn6hSaBPL2?=
 =?us-ascii?Q?zm2G7+tg4JhdNA52hIQ9gsk/jewVw5oyd9LjQd43Ei5xTcLE7cYkZRtGxcm3?=
 =?us-ascii?Q?XTl8LiyCM8Jeq/GQ9mJBJt/HGXBCaH5X9JsOXgHxhXIRbOWMa464XlIZVNMX?=
 =?us-ascii?Q?bX9ioNC0uo2jTJCyyYwmgjSbfAVtZNnQP+rF7SsAjBrcY9fOhqHqlleIITIo?=
 =?us-ascii?Q?CdAc72gLCMNBxzA7/Cbi1JEcNuK6YLnTW1MoLJ5uTHBomNlpkwLt6nPZXAi7?=
 =?us-ascii?Q?VOmib0YX4zMO7Bb7NGsrmi+6kKbFL98Hf9mG2qcEqXCt1nUeZYIJGmyDEVpi?=
 =?us-ascii?Q?F0fPMWEvebTlpxXUbfG0GF1YMKADfsHbn7o95YZyJTpKL9991iZmqKFhDyif?=
 =?us-ascii?Q?xKu6oZ+QSb7hOP7wU36a9QdvpkYbJlf/i3iN3OSo3SqgEl0MY7OGz2mxmidB?=
 =?us-ascii?Q?Vb7wMZF4d2QhcfLPzKLvl6IJcUxyx96rFrWxb6DSsNWj6PAahYNDk4eWJZ/w?=
 =?us-ascii?Q?IUVI+/eHNhwjakcByHtqOn3DWKLZxILUNlmie4AI+Vw7S6LZMeIvQ7wvWfaD?=
 =?us-ascii?Q?onxPxuDAli5wyJcl/u/FtUutM281HlMZDbsjbfv2phwCv7ZNt/IvvZ+utFQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB2144;6:Uf+09Ac6XsvVq2mtR+bJymDgSLo5q/KfTtdjzq6on0uxoH6Nw0Rs2DwqGv/6jQ2BJvsbeDH0LS8toyjprFP7xEIRB1PPaKxu7YOBy1RVJYaHIHnRLE4YrRb0Qgmpw5oKheGi8wnNBZk4bCRLi6nToghFbiLei9jaqzC76LkI0HIkwoEWMHUGJzWRy1kkq6oQzRUD1BI0OlCROb9ezcgVP0pgn/o8uXRNxX0TrvqPZe0Vu8mXRvqwwZZI7Oyv8eqUxfcdSaOJO3/ahnZlROqpTgURz/Hnjg852dr+xLCME2nYQpUjsfVbt53HDQibGF3c;5:+tg2Cq2gAqsZTrptJVp6LsyMT4NbTlyubFKSbCc8AEX1sU8gGGolxtTmmuDyUYCcc5jhyDH7BVTeK85K8GyR4Tfre3d3uE31+jw6Wb9zN91RRfgXeDI/ogRrf9yWosE/ZC6ZcdcUJXTSoreLneGvnA==;24:sKBc95As3HJIBICk+m8vHfR10bJea8wn8N1FvN37cYHRDU/FrYbu4tpXSGx9GKBxIBYvfOpqbbxAeUzuFwEDdu9XxjQiOV5wHUqxTLB2OCs=;7:plHuktdFh/qwex1AmE846fs3D4Lbpqswf5CC9rN2MxV54C4F+rO9zJ2Nrceh6Cn/hXm2Vu0rbmdUARP5/mr/7ZW7ooeEyQw9b62inTkxQ5wgJfURTseZr3EzKpHTKGsqlpZ2YodU+8cUXqOeseCiyvDrePgtYewWa0jUdvuyKRGoZTlDu+wkJqXBfrAjslwPTW10qfgWJbSvvTvYr7yPze5iXgrzo1ZbUFOZRfVEr9fBTypIE7ejvtyFfQi4qhktkx9vTFnm2kIx7oEOWxkCyAdQiGNYrl+V2jYRkQKMKiHU+8tZ+NVZVPMyUqf05V5v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sociomantic.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2016 13:53:04.7349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0101MB2144
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Sep 2016 19:15:33 -0400
Jeff King <peff@peff.net> wrote:

> On Tue, Sep 20, 2016 at 05:09:54PM +0200, Leandro Lucarella wrote:
> 
> > Hi, starting from 2.10.0 I noticed that when using git log
> > --oneline, if commits are signed with GPG, now the signatures are
> > printed too, and it takes 3 lines for the signature information + 1
> > line for the title of the commit, so suddenly --oneline became
> > --fourline :)
> > 
> > Is this really intended?
> 
> I don't think anything has changed here in 2.10. Running "git log
> --oneline --show-signature" has _always_ been horribly ugly. However,
> 2.10 did introduce the "log.showsignature" config, which makes "git
> log --oneline" pretty unusable when it is enabled. Ditto for
> one-liner uses of "--format".
> 
> I think we should probably ignore the config entirely when using any
> of the one-liner formats (and I'd include --format, too, even though
> it can sometimes be multi-line; it already has %GG to include that
> information as appropriate).

Woops! Definitely it shouldn't be added when --format is used, this is
also breaking some scripts I have using git log --format to get some
information about commits, and GPG information is being output even
when there is anything about GPG requested in the chosen format.

I guess I will disable log.showsignatures for now... :(

-- 
Leandro Lucarella
Technical Development Lead
Sociomantic Labs GmbH <http://www.sociomantic.com>
