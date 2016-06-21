Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D991FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbcFUQa4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:30:56 -0400
Received: from mail-bl2on0097.outbound.protection.outlook.com ([65.55.169.97]:47776
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752010AbcFUQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:30:54 -0400
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.onmicrosoft.com;
 s=selector1-roku-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=op/qyzbLuuYAfeg6HCYekBVgP0Zwuyv+j8agvBZ+zKc=;
 b=fCI1tTEN2Ur7Xrb0OOiaKFvbcY9kes1HCwlMGOuPOoZc8z/iRQJ2T23Dn8EqrYIkECNyE97K/x2LeO4UIktsKG70NXgY8i4vrLAXYYclRW9ssKIfCTEsve6GLlB/4RUaGvhwFxWG6HSB27krXqVkFY1mNKmu0gZhHUflajvtEeA=
Authentication-Results:	spf=none (sender IP is )
 smtp.mailfrom=aoakley@roku.com; 
Received: from aoakley-t5810.corp.roku (81.145.207.254) by
 CO2PR01MB2071.prod.exchangelabs.com (10.166.91.14) with Microsoft SMTP Server
 (TLS) id 15.1.523.12; Tue, 21 Jun 2016 13:55:33 +0000
From:	Andrew Oakley <aoakley@roku.com>
To:	<git@vger.kernel.org>
CC:	<luke@diamand.org>, Andrew Oakley <aoakley@roku.com>
Subject: [PATCH 1/1] git-p4: correct hasBranchPrefix verbose output
Date:	Tue, 21 Jun 2016 14:53:42 +0100
Message-ID: <1466517222-12600-1-git-send-email-aoakley@roku.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [81.145.207.254]
X-ClientProxiedBy: DB5PR09CA0057.eurprd09.prod.outlook.com (10.162.34.25) To
 CO2PR01MB2071.prod.exchangelabs.com (10.166.91.14)
X-MS-Office365-Filtering-Correlation-Id: 88a85ffe-0e32-4c03-dbb2-08d399dbb799
X-Microsoft-Exchange-Diagnostics: 1;CO2PR01MB2071;2:l6YPXVoGVWRTnv7E4pXdV0hQL4gCPSbX87xoDv76i3qxmVMetOb78AzxrIXH6QoW0PaLC9Qg30K0JkcZEu4vPsuph8coTD0Cw7ArCyE9wJl/xL5/qoUuJfK7FqFDHhjxeMSNCqMDnsJPE1w1uNyQCveV0Dw5mOoY6tVdsH0T0SS26FwFgG9kz/6oZsj16Hey;3:lGbLBg2RefUbRDzsqgBGCWJieVbC8Qd0++TYW1YRRHJGiUk+Y/E/8OAh8OEdeGMtUXxMqXEdl8BW3pC2e5WYG2r2p5QOcbycxAmvsOydhSTT75Bu4/r43wz/39bGFjSg
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CO2PR01MB2071;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR01MB2071;25:MWh7OxKS68OB3Wk7TAX76v/V5sPxeGHkWzsNg4v0aGHNuBz41BQpQr7zjGvZAyoUhIam7shsF7Xr25I6UJI7GXguGEE/crwtQPSiMKaaQgEeh+OZ7Q4QKd7vklY70ZoCUeDDe7NMBxTL+pWU86qPdFC74aTH2NvxZ8Mr4UEekm7oadHqsRty1C4kz/BI2nLnbmfK73We4TobrHyXaKqncbY2G9+9tPPGyCrmeoIg1K4Q0TGAAQTlm6MMwOie30jM4NvzJHzN5QQ0GmnUJ5UmE5UfA2oiSezHPX9HrkJTwb3oJ7pJSydI8sAlw46dFMl4B5c1u1qB6+hWkdDRfOp0HDUFxFDDBPmTvgfY1SXYUov3RNdfCB63EzWChZ99bIhHbs8/YOHv5K19YSxDB/Xa87yeyH5rpMfXhATcUNVYGMxkOalYSBXB604sqPb4fzef+QW3J5PoDDJn04goXwWfQPB9rhbeAm1jTWZcfDh10oXwYfEmmYUrCrVGXzTJbJBS8zJyRGI25nfBmz5VgoYMp4IWNqLhyiNTWNgcplEAtqfI032cCNdLcGrJtlbNF1jOVOvv/PpJej9DDddtL5LwjmaztgYkPHek9M79Ukvu1QzsJWK7SmDOG6QPZtHE2nCYDUrR6jnBuO5PJmcp28A5m89yiwkRzle4HJY0ABJDOsJkg2McpuM66ir1k3wpMazVxe/zhG7GpNNNbF5smt0OjIzAMAzHtkTICo3/YI5aHkM=
X-Microsoft-Antispam-PRVS: <CO2PR01MB2071183A7A8CE8CB8B035378C22B0@CO2PR01MB2071.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:CO2PR01MB2071;BCL:0;PCL:0;RULEID:;SRVR:CO2PR01MB2071;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR01MB2071;4:oCWKfFfiFLN1E3wkyPKoxqNdpCDnGJZjSNuW43YaFJS4/BtzS/hGaQr8rVJ3SqObLZmqLdzaEGFrfvWirzNVka3/rdtg4sndiperwTlOMz77B3wfguzX1Q5OWBucyWyoWSzcT4fjlQ5h9M0UBq30vzVYR606oFUSxdkeA5Zx3Dk2fF8iEk+XLvGyANLsLCX/2JKOfd33y3veBSWe/kxa+czuiVbTPcY09wozfmV8X+18pOQxTQXlCKcmOv7jTk1tm8ETu00jjuzntyXWlIIs0+erP2pLZCelycIBdGtU2/lc7IIAp+sHv6FuL4p6lJv7As5vgPLt/peaHhOvO8/wQTD6a2bu7LylrJJs0H9XbVA=
X-Forefront-PRVS: 098076C36C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(81156014)(47776003)(7846002)(5003940100001)(189998001)(66066001)(8676002)(53416004)(6116002)(4001430100002)(81166006)(50226002)(3846002)(2906002)(50986999)(68736007)(4326007)(42186005)(107886002)(110136002)(92566002)(2351001)(77096005)(36756003)(97736004)(19580395003)(229853001)(106356001)(105586002)(86362001)(586003)(48376002)(101416001)(50466002)(7736002)(33646002)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR01MB2071;H:aoakley-t5810.corp.roku;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: roku.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR01MB2071;23:hC2j8hetbWA3wq2yMSLxQ7SHjG8oj/Te4hwiEPJG3?=
 =?us-ascii?Q?Ko/9qGGeqomETnfHo8589wucgItnJ+YatQtwDBt5OVN5/ntUtyCuAZBCBfQL?=
 =?us-ascii?Q?xcZwah6qk+rpbumGlzofWUh8wBz+JmTztTkpa5SBiSkGqprj3edIPxnc5OF8?=
 =?us-ascii?Q?8imyowpVeavevJVuq867RKHztP7zvsqTwmTGzmdRPe6jiwTf01fzRAUWUNWj?=
 =?us-ascii?Q?nFEnT4QEFc9WkWy9tNEAJ9H5I3OAr2KM1lJ+t4EMHKpLuyYdqXpWLss8sqty?=
 =?us-ascii?Q?eP/1suTlpazAf/siEkyGAbyNALHxLQRlHI4BuHcuS1zHxBZmSAumRTuyf/Ar?=
 =?us-ascii?Q?sGvRDRivgCwWSfacJ0g8dgBXLebdk93E4SmcKXIaSTl7KjW0Y/lKhMNfGWs7?=
 =?us-ascii?Q?XFylYcGnkoBwb3YrbVbJDdZgnSUVC67V/DygCmgiO18W59jsCJLe28aEAhJE?=
 =?us-ascii?Q?OkI41VibArHkJXOB7xMZB4VJ5vD0QwWDMCya8SiByunMCuNTxpKOQCjXrND7?=
 =?us-ascii?Q?N2v1fxSame2EtX0KODvAD347sk7ElgxsO4E6J4FqH3tsopjMYpk/Uz2aFJjR?=
 =?us-ascii?Q?TR62N38qKJFThXBvxXR+72gPtcs8RVsT6K4xZFdyg6de+O9xvRko6g+P2lqf?=
 =?us-ascii?Q?dvneCuZEXb1IKR0ezYDhdxj+HDP2emUAcqjUFCZ1p2Lv1BNLNzvxe9562Gub?=
 =?us-ascii?Q?dwFM1g0TxkVc75d2qcUulLwJPE9kFfgpkuNH1PWccDcFRXI6NUfE+GpVAJzH?=
 =?us-ascii?Q?wVNK2Ca2EzinkmFXU+gEN29HWdlICZdOUKPfONiO3GRrgEAFR7PkETTVIF6y?=
 =?us-ascii?Q?Q9pAKRMWwwZ7adoWsM5EIRNeW/Omh+wQb0RvFzbCDtwaIHv4GC6ZwEYwRxGc?=
 =?us-ascii?Q?IehMUDumvp/0PSjHt5d7g3ejpZC/QDksZ0FfCMHGjK7cmPi9aCycfV7/spfO?=
 =?us-ascii?Q?fC4ql9OFBBYpmvOQiHQXeYl8ng78g9s3J9+Z9YOqZMQ0ajYCpsaYzmcoQpux?=
 =?us-ascii?Q?thRZg+SoUI1mz8OM7pQ1RAT0rFFw8zC5hLNhwDMaEAwRwu6Cq0w+pLrH4Zn6?=
 =?us-ascii?Q?eORyu/4zTLxb8muS+iS6wIFJhVG?=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR01MB2071;6:wnIOmt81y8w8X8tLcLedL4TO93pLPnGEYS7CIpqxMimmPfEfnZJ8v0kqqW3JNBFi96fQZ40j8cccsnrHd/Q15pct57gGLXlrf5Q960ikHxnBKWc/KvrGJEws5XyDMOyey8KmeQ2ZbhVqlLXLRjGU9tVFzCverJlUc0r69xYaff7b9zApm1GvA+aRgjIZ/2NBP0WbwYEvi+T+gUQIUf2hSOkwD92fycghS6RhWfVG/3rNh1Lxr8A9sCfypGtU6JikCwaHonbheSiq7oofP2PxXXMBwTArokr9VsC3nTLX2fU=;5:wPBNHfnC+x9VmktfjpMrXr/1m4/BErEFL18D+wJqBA/YY0sVluVbgk6Mj+zeuarcnHyo8SNQq9joZ+3upjz3LJDcjnvM2bVY52BJtW+x+VcN8akUh80+hvCeuq/Ia5wngKPXB8SejFxokQZj1ePv4w==;24:ERbfoefjkAyhgzuCBlCSrlUPYq5VKgYtkyKAo5zIeUKB49xtwrjuCEcz/7DkRZ8AT3Oxk80cNcnQipVE9dgiDISzLWjKvgkFoVJuVOSZXio=;7:3WgYzMWyxsLjc/9NPvcIgRNrHVdDZ20Bu6a6VI8iKZu4pcr58pUTR57sfwd0li1UkAWo33m+0ItETKnZHjmKGhgUQN+cp/CbsYk+J6fOKnfLAY/LwXWZD47QOffXYaaPoe7ksq2BE3afi73OkcS1C8zPkamrjqYqYCWPPCMsMx8OBOjlGw5JbGF76Mm0BX3dMVg1s2UldORmpPVIPg3hf41AIBw6AI7p+4feJ18AGpd/OJqdKDljXCouqAc9wjYJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata:	NSPM
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2016 13:55:33.8706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2071
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The logic here was inverted, you got a message saying the file is
ignored for each file that is not ignored.
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index b6593cf..b123aa2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2674,7 +2674,7 @@ class P4Sync(Command, P4UserMap):
             return True
         hasPrefix = [p for p in self.branchPrefixes
                         if p4PathStartsWith(path, p)]
-        if hasPrefix and self.verbose:
+        if not hasPrefix and self.verbose:
             print('Ignoring file outside of prefix: {0}'.format(path))
         return hasPrefix
 
-- 
2.7.3

