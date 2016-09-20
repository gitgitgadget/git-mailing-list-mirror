Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4181F4FF
	for <e@80x24.org>; Tue, 20 Sep 2016 16:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbcITQmf (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 12:42:35 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:64224
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753964AbcITQmd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 12:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sociomanticlabsgmbh.onmicrosoft.com; s=selector1-sociomantic-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=skZt/qHaLnD1vCv1FzC9Sg4eOiM9f3A78P+Ud4GqsFw=;
 b=Ja3sxU/zur/fo3HBt3m+w6MDyrryP9u5WsL0yPQNvs3+dQfGgxEKvQIkcJ9fVSLSXtqTNOUP0uXVzXlw6rU7t80mFVAQLIuB3dXObkWIvJcRqUTCRkIslhYHFQ0ffZ0/LxMMtPFxCsEVZL+AnONr77uw2ol9LFPiPYYIxHaqOFA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leandro.lucarella@sociomantic.com; 
Received: from labs-064.localdomain (87.151.175.108) by
 AM4PR0101MB2131.eurprd01.prod.exchangelabs.com (10.165.23.8) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.629.8; Tue, 20 Sep
 2016 15:09:57 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=labs-064.localdomain)
        by labs-064.localdomain with esmtp (Exim 4.82)
        (envelope-from <leandro.lucarella@sociomantic.com>)
        id 1bmMgE-0008R2-OA
        for git@vger.kernel.org; Tue, 20 Sep 2016 17:09:54 +0200
Date:   Tue, 20 Sep 2016 17:09:54 +0200
From:   Leandro Lucarella <leandro.lucarella@sociomantic.com>
To:     <git@vger.kernel.org>
Subject: 2.10.0: git log --oneline prints gpg signatures in 4 lines
Message-ID: <20160920170954.38b24284@labs-064.localdomain>
Organization: Sociomantic Labs GmbH
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.151.175.108]
X-ClientProxiedBy: VI1PR03CA0014.eurprd03.prod.outlook.com (10.166.38.152) To
 AM4PR0101MB2131.eurprd01.prod.exchangelabs.com (10.165.23.8)
X-MS-Office365-Filtering-Correlation-Id: 677c4ee0-2b5a-4b22-03cb-08d3e1682f65
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0101MB2131;2:DmwG2JgskjxZ7cFxxyjtUG+/IS3Rw5B3Qgyodg1oxbLfSVvTi6kNoAhh6P1DHZthwrDu7Y4ts3zkD1KtcLMeCHdxxanvhIJKN3BTubvC44SttsSNJ58JFw28SQdQvFVBsG33ap2oK8P5G+BDLH8ljaKx9rs1x1z557BRvo9iVrgdeVc14LW8MaxNvld7nfsy;3:jN32oIzdXo73FnOQSzQyVCd0RRuvo15R2B1rppJrNGIx4DKp8mFT5XFx0C/DZwiH4qLfhSbzXvM1hp0tV/r2iQvx915+hq6sGyM+7TGse0aCsx1HL1mYoip+NjXPx0lK;25:TL2M9NlLjHWyMfaF0V3N2sYTeKy3AGLxSqWMUP8rz2ei3n/jNR8YyiYo9YUmwYg7kWH3r8Li+qa92wmLANHgtoMR9mvu7+vh+7BXvEbDhudDeR4QjTDE9lYTFcQAz35Dkga2UlcyR96wdx9bGwOlQR0AYBlBDIm3ss2fdo3Uu3BHzv5cLa6VLEPiWxDAEdTL9h0H77iKYw01Syy2LxuWgmqa+0QKU5MRbd3aSMcQ8+lbGKT7BuZzKP7sDohc/xfl6VtUfD15RwZj9N57pInp4ppwpEWeNHB/74MdAk11tsPWglM3UyQtDlsR3ZMq1ktZjCf9cIqXXasypSMA5lCZ79pYFtCqxqeETCMJwRBq0zmoeokE1wiUjZ9DnB1avh1koUuE/Vqtv0OKF8UlKE4B21OOdRbQMfQKT3Q56/QkYyQ=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0101MB2131;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0101MB2131;31:Yexpwmco9eaT87GnVzlJkMOrlDV0XBUfEKFckpoAnS/5CqINZDL/g3hV3MtToHbY+9hHRuKYHSnjgQivLSwVkZsF5O+3hNirJAzTRsxVVAS1ng/4GnzW48LkVRIEDPywnrQ8oUuniDqDZeFrMRTXCdcEIXqssCnPEN9Ilq4A03MxgD53dZgNC/c6YiZeWW4FbU0uJhVMIFNSKtJdAM976LMroQ+QyU7rfkWo9Y85uSo=;20:vsML0M7BluJbrWSWbaimOgEajWko+7jvbr8yK5gHw5FEHuBLiUrI3Zbf78izjE0GWSt7n+P/F9fLqkGtFnxT9zQLVugFFhlal/YcyCeMyq0xZHJjuIKNPOEZNxdEzGL7brPDHtooQgH4ufj3j+/Qcm/Pc15Ys/r8+zRgnmyjdeViVdJhdYQZ52E9/yz/PLNAn/ir8PErrajWWFhV1LdmSTpy8DLPsnR0AEkrD2zQIFBpKyBybxF4KI+uhy72Ve2w;4:1m60U/zzxFynzJEn51BglPHVNEXPBgrq4iLRfnpEMmETv0p2p3T0n7sVbveUuzlAzESFqVTfgLPQPzLzKjPPuXX0F4S+Z2G/f0LFg0OE7oEB7EDnOixG7qJaTCcD/FXjd4QDzj3hLxjHEx882CnG7gE4YYUwpcSRFr0BxwgRpEooaLi8Y64XIN7vqKrJ3wzWMC6+GzhNP1Bpj5rXDPccDWWYf7ejhrxnzQAT1XC5TNCC4+GMRQnalEDTuiX1PQphUiC8X6ARcMXRf8Z4DIJuQWpbfcEMcCrlDTQXDQPoRvk1pVknMVm7VrEUJPDTsF/Y9L2TUEcvqKP3acEoRkB09nax899WNVJf01NKp3gTwzNVs9u/3YXsmujeToYr2/gmtX6+yFenGDHk0VA/P0j2gHix+r8H+htbo26DlJ5NpPs9cQul/a1ug+re+mydDOY5iJyT1krERhDDtTLZsbVHIA==
X-Microsoft-Antispam-PRVS: <AM4PR0101MB2131B6ACC730A9048849ACBFECF70@AM4PR0101MB2131.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(7783539604369);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6043046)(6042046);SRVR:AM4PR0101MB2131;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0101MB2131;
X-Forefront-PRVS: 0071BFA85B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(229853001)(450100001)(19580395003)(92566002)(230700001)(106356001)(305945005)(66066001)(2351001)(47776003)(68736007)(110136003)(105586002)(7846002)(7126002)(7696004)(97736004)(107886002)(5660300001)(122856001)(15975445007)(2906002)(77096005)(189998001)(23726003)(33646002)(49486002)(6116002)(3846002)(86362001)(50986999)(1076002)(586003)(101416001)(9686002)(9786002)(8676002)(46406003)(50226002)(7736002)(81156014)(81166006)(50466002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0101MB2131;H:labs-064.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: sociomantic.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0101MB2131;23:yWs55TNl6eXXHNr+L8m+RFT0gR/XJHNN+67nm7U?=
 =?us-ascii?Q?vvzzGC8nO7Sm5h0UQ5fogwceHdhJOiCl2mBNJA+6NCdnfltHODDo0nJ31ylP?=
 =?us-ascii?Q?xyQjRVlI6EBG6EW8cRrEhHK/eAN01B8lEgGBtxscv50/Z/a20RiS6lKqPo2c?=
 =?us-ascii?Q?6gHkDht7U92QJ2u4Y2LQhnHroLcrAnK+9dAgONzzH7Th05DNx5xAABXZVUdU?=
 =?us-ascii?Q?PSrThBZ4RaDsrNSF3JZTeFj6JlY6/gKb0tvEeOTlvsqo4H7lkL5yPTOvmsrG?=
 =?us-ascii?Q?czsoOqM7Kl1e6Ru3zHPtipwJmKd1LvxDmnxmNHMekXurGEbS47BSlmeGndww?=
 =?us-ascii?Q?MGALEWSapLMtniMhRwhfdmfDG20UqTXcjOg65AX2lkm9G08ls1cguF9rUAzH?=
 =?us-ascii?Q?3P1hVY+Zjny84pnxZHRG3Gucry1VmXdfDbPDadQBRGV/TI2+H4qHf5tS4PC2?=
 =?us-ascii?Q?2lviR0LF4QO1K2mjKkUOulw9+tPett0MeAv2LWFRkaAFbrfWZNuR4RdwenVY?=
 =?us-ascii?Q?LDveDcs/mkHWTzkwpueHF1+sIYaIg7JCV+z+lX2uRgCfXFF4HEg07FtGmJ6Q?=
 =?us-ascii?Q?1ITDm5fZPH91y2bkyNhyiNJH+jQEP5vNnZWHDEXr9BilYRSkicppMyHHbpZf?=
 =?us-ascii?Q?6aTs3m0zmr06E23wlgioA1nKl0YDNA/vkLg5QCKumRP0qkAX9FbHBrNtVBq6?=
 =?us-ascii?Q?UmIQPHR0xbmGYpTTgP5SBo4omddBtP9R4SOnE4AXL4YOJ+ZJza8PtkjLaWFi?=
 =?us-ascii?Q?EdFlt5LjRyj6mT4QwLFgT3pd094zHJvwLviYBdYapJb7kN6g0DYpdUCX6NJA?=
 =?us-ascii?Q?b0tDvg68Lcp5zlnur61LJaAIzHi1VHgjvPltWHKIdkSa3HybU2VLviYbzdZ0?=
 =?us-ascii?Q?GMve7ODr6FOJCJ7PnEHuW/iw/DN2wfhEZlvtXjTEmHQIFJ2EpG66FHde4yA/?=
 =?us-ascii?Q?tDMehG9LOKH/Vak2EVG+rEei2/duU5MbbtudFBoVZTXNoob6dAUmwHTMLdjq?=
 =?us-ascii?Q?pm0Ip53zHllgbdt4z6S7m9L0TaGnKf7o1HYHW51elHVSUYcgmEtc+pPIzH3w?=
 =?us-ascii?Q?zyybDTtfp3rTSoA1i3A42ocEPI6uDofbiCBmFaRkz3R63nxeKRfr5ZXdN6qj?=
 =?us-ascii?Q?/rk3uIZiSqecnkbFHq9pUBjzNKskeu07ni6eB9R4vdqtIIeqnaE9g7Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0101MB2131;6:UDqnlDjqAXHX+dWSkFMJLNYYsV8AXPD9IUVA3lDrIxiaa1x+fqVIGmnm8HFKZZ1T9DTE5WauTEsqbK/RHjPHE7qBhgjAjC/4rL/LyaYPl7WgPL6rMRUixtU9gmJu6EczpdEWSQTTs2cP6/qNmAda4BRjHWX3wRHsVaOGOf3sfRWl+PhiuMIHmu2q0hCnGeFnULkLCzShUhZoaLmqrX979kfVSffqtG3HVnZgXH9XaTokZ6YFj9DeCLzKtwsNDQAc/cqs4KryzE/sic1HCtvnxLWOzECbW0PWRmQ5AbNGYqTJtHkavLOkVT7aoiTym8d6;5:rGyMqqlWsS/XkGK0VR/MOnk78UTVcuUgvO+cBgCXTHHgLxLLH+La9qSb++xuyaWkRgiHpBHMwexSYhcdksUQcmhhUpZUYd11ziRs8Q6+EAEX4X0fNRTYKsLyzd7D2IEcwsNWrYrd3sAvPp75qrHm+w==;24:1pULkROyLw8bex3d5t8L4+O/gjgKKbSTsfdG0li8cIORjlrhD6dnLqXdy2FFIaLewLMSDw52/i31R6OAPDruYqO6XT7PGrmtM0QQdweL2NE=;7:rC7u4sALRDo6OG87ihFEXbHeuUaZPJq8Xmten1luEU3KhFf7U/oqkH9ts3O/srC013tENHLNs77aYzg+pn5zrWAPFFtRbIcfAhETWyGA9kPJrT65L3I/xBHKd8OBsLHSWBwhknYXoJNRL9Z62qsJyhzEEAKkbD7T+MJdW+iCQe1R3ncGWRQ2oP6aRxIqvBk6McXwOeB5V/7Gf+aF6a6py6tjlQC3utxK9vasuTZK/fzL1sB0MORl3NfH4WvHmnL228MhKCKhNGR+dhIZhYmAjsgxjf/XkN7MxAhw8XsYGXdbq6LQ7ZXnKY4XwIZWF5IG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sociomantic.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2016 15:09:57.6708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0101MB2131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, starting from 2.10.0 I noticed that when using git log --oneline,
if commits are signed with GPG, now the signatures are printed too, and
it takes 3 lines for the signature information + 1 line for the title
of the commit, so suddenly --oneline became --fourline :)

Is this really intended?

-- 
Leandro Lucarella
Technical Development Lead
Sociomantic Labs GmbH <http://www.sociomantic.com>
