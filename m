Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0AD35893
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304945; cv=fail; b=kcBVC42Lt7dSi+9wy+4V/nQsZ3e9PiRxxOGV409IkmIrC8in8U1/yfj03n/ikau5ESwrqkoBOTap4rsZMwZCRqvqYVxUIre+ocBMPONBdGgDIPwUIIsCYzu970iUfmZfqxwnZBpDpD3jLIMg2TXkCSH4CyQKmVgzlZkUVwRpzXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304945; c=relaxed/simple;
	bh=4/NlECvRMjSB2e7VTMpwg9G5HGNbdE1ooU/BdSdiwMg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nz29aZrdyIAg82Kwe3w2JcChhE6fUk44pRPoAOyyQJtGAom1XWX4pRKWdgh5OALbEQhhC3VmeJx5Djd3KfGgHg8/xmBJF+XxrSG5PzGzsSIlj6ZW1yiFb0JVvHw5h/3DsvJJkPxPXd6wfuUoe0VOXaKFGrSaPSzRgcl/odaHMk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=lSOf5Ava; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="lSOf5Ava"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0nr/2O3EN49LLQlskU5n0eNiijXI6YkcEzWJ0G/2Hkfhj0wuKkzcvKBGAlfu6ynaCyEPL3Yj82S7DimVCJGfT3u+MnTr/UEmJ4AeWe4fw/+4IeBuXhChiSrSzj655LOnzOf/1QrfjLESxyCpV7O0vWTXOt3sKdZLeV8pk6bibvIYOviS1sCvc3pNZNiMKRpZlX3T0GBbvZ/wDJMiGL8nxyPKggpkDCKBpZfjjwEPZWFpsr91fMtjxxk8uve9HVQyx1Fee+TZZ44wdIUYMQUzksVf9URgBZKaMvTylLfQBz7EEEDVkGQlcVzC4bN6odgKTggamRvRlAU7eXpNsgTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVf4zudmj2vBvQRdVbbekYiZbx0Wjpp0I8IfO35Z4tA=;
 b=rxL7CL/oC2IMx0gRRJ7Q6nJI3V0Af48q4tqAjho86QmxPvoMhELAbev2ukcjfPh67z9mwtHH6q1YuYsScQvcD40AJAw6Wh2D8ZOOUxcPRCvJktBp7mk+03Q0xGCpeQ2EGe6II64UOGloyIpK39MweUeke7d8vBAbfvkAwfCvjnHsdNYGX+uqSMuKtfL8tj93wJ0jfq3Ef+ApzAeKwTbWEMxFCXGMb+Ae5Qdkv1lPVPkakD9vyMolgEIiExKuU0NplYGeZ4iP8GTc6m8krq/UbMYnhHTno5zJXTiMx00agkS6Teq202pbjLR+eQKs9v0rAXxp8O8322dT3Y+K3dm9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVf4zudmj2vBvQRdVbbekYiZbx0Wjpp0I8IfO35Z4tA=;
 b=lSOf5AvagAxxGh8giZCerx54EYeTnfw6RopvA9N3Svz/rTLqEtSKYqap5YwZVzs86GfiRzE8Iq/96GuaImYhoto2CEa+PIzuqUOkOWTBmSx2jrbTOLcjDggkQoMYh0RUEF4bt54D8Ou8nwCvTu0h2PFQ/6NwM3Sz2otpwFsarvShuCEqCwdPij4V2JpmIwRR1T/dQnfIOR4ITl6BQL+LxAC2kmPSqWTlMZpvwjB0znzlC96XsxcFfZ63xIC0yhk+9ZQvZtAl/7mnNJqVCfd9itIt/cLOtz6FaGwZ1jbJ8F9sV0ejLVMFwlFw/inx38NnrpIxvoUwRD+BpTo/En6Z7Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8199.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 06:55:39 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 06:55:39 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Shengyu Qu <wiagn233@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Aditya Garg <gargaditya08@live.com>
Subject: [PATCH 0/2] send-email: add oauth2 support and fix outlook breaking threads
Date: Tue, 22 Apr 2025 06:54:59 +0000
Message-ID:
 <PN3PR01MB95979D98917E3986E37267A5B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001A8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::e) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250422065518.96853-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: f44547f9-9e12-456a-fe94-08dd816ab093
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5062599005|8060799006|5072599009|15080799006|7092599003|461199028|10035399004|4302099013|440099028|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0cStUsmN+IhWSLQvmgzveVBPTBsTIszgJhFOwhJTtzplwZO2YqtXA+MoDJJB?=
 =?us-ascii?Q?hUgebxs8xI2PB3g52zoJKjHSTFNNGFEz/0W8MdgLtDKbzFyD7orj12UjE/yF?=
 =?us-ascii?Q?7HMiQ9QPdyBOiwX4YMLzX7zElbVlIat7Sa1Bv7kcV10ySmtFt9CsGr1B9Azj?=
 =?us-ascii?Q?Dwon8VoMzEzEB+EMrdnPwU5wTmV6qTisf0/EJmHKhA65VOev5rjX20DWNHSM?=
 =?us-ascii?Q?i6bo6nnYZQEuR+NFv+X3GmlblOGl0/PamMFHmoEgwoY97yc5A/9VHeDJDynX?=
 =?us-ascii?Q?1HhSN6wDxjHx+Pn31paw4zsTftaOhPXa2ZXluX/OJC45CbSRNfagCauT+2sC?=
 =?us-ascii?Q?kpFBMquD6QT0G2wj668fVQMtOFoEb3kwxJlEErvRKZh17pGJ60gE74WpG+uc?=
 =?us-ascii?Q?9/lgkAU3kYMuMbEeiOIvw0WUSAfWDhTjzOVC1RuIR+ReL65t7oVyiU+DuHzA?=
 =?us-ascii?Q?NzlHZETVOZxDwoswRpbGQa4boJwew5xw2dqzCcimE6OkggNMGx5J3PD1tOwa?=
 =?us-ascii?Q?rESXMBoqkcQP427//FTgeOsAd+w4Bd0QBMjPcDtTXKlc3eYrJjPPnAKD0WQN?=
 =?us-ascii?Q?pNY0EzIs37JDmkuEmDthpkHhSbRgDtzl9/1fwzS3+c1rHwVMow83lqGKJ0FW?=
 =?us-ascii?Q?uPEBxljGU2YhFB2t/04fKyWyZ/BkNJFlbm/mq55l+sHvEuSxG+k8/UgahoR+?=
 =?us-ascii?Q?U8OFCtWGi3E+Jce+SgBUuxOjSm83lZsE2KqQ5wY39giBK+v21n1qS3KzZwmp?=
 =?us-ascii?Q?VnFHYJ9zx7ReUMrQAZwNPVWURu+XE519ge/uHqC3KVfMpvVjEPtmbyGpT9XX?=
 =?us-ascii?Q?FE8xC27+2NJ5Qg0IXY25kvBgQeksLH44SiS3RJIjTEx5IzA/Fzr31YcctDHu?=
 =?us-ascii?Q?0XSSgoastazq+bd7TwTrV6ekxWJ27UNvSvIF0jRYqGcfgcZPSvw3rO77XNhq?=
 =?us-ascii?Q?pJD2a+WJ2uhYuwvShF0L8iA+AY6X8yxxE6n+mtaKQh6nfGaNK1YHBVL3QO7D?=
 =?us-ascii?Q?6da41Z5wqZIsMJ1HLNaWhKlM/vOJAreu19jFg+Pu5wiyI4C4mNolQSGeSi8a?=
 =?us-ascii?Q?HGkDr0Bta6sSBqhavLjcvb1R3pzkNi6j7cu357w5FEzW6+49oHNlJKYRRTZs?=
 =?us-ascii?Q?zPZ1IFjcaWFy0N7ASnV3VX38aVqpYl7jHCjc9/RipCpo0eA8IPLiAbcmgpcB?=
 =?us-ascii?Q?Gl+V2bskIV19am+xyqJDTIiBwCMkKp5iExmZFW8SWabPMNUbTYPQxwWDB55M?=
 =?us-ascii?Q?/ZGdK3pczO+FbaD3H8WovMOGfAqLO1yhijV8HHWg2zWF8MsaGSwMRTB8ORSj?=
 =?us-ascii?Q?Ly4/qYrZvtHnV7l1B5goQ0GBJ5XofQudjnH8BbW/6T3Pnw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6C+DUNjJcArSPfk/ewC78w0aat6jTjJqgL7L8a+APNgcE0HH9tFPfiKuwXFx?=
 =?us-ascii?Q?pES82iygW4LpdFfp0aI537Q17vC4sIhYh2+4RwOL7y25ancFmjBFa1MnBQ8I?=
 =?us-ascii?Q?39ZT17w1u8/2rYWyGQNZ+t2g/tBMEH3D1e+3ODjNdP9amXxHW07S9lojYydZ?=
 =?us-ascii?Q?JXfPrbQ2lQOSbnBi+PlwZgcxRpSuxfaU0XpB03C/JyCg/nbXapKf9r1N+cLV?=
 =?us-ascii?Q?GRzed8/scv5btjeMz2frjBCVlReDCGI7XCf2+VXNJZfIF8oZlDiGe73YMe7f?=
 =?us-ascii?Q?kfuTpHr7QJtyoiUiFRdh3O4rSQ4WVIuMRxmgRniioc/s5taVmeeN+ZxdrBDQ?=
 =?us-ascii?Q?Yz5b2hSMKbJFFYBwMNZq6NlLfKTKLW0qt+qARIxPK0AMSPqwbw6bOd1lwUvm?=
 =?us-ascii?Q?21BUJPUGpePE05kSlHyeORMI3LKyWce56lpFA/Z3dTI6/Ev3O2A446vfqLWr?=
 =?us-ascii?Q?nrQereSHfjG3EMoI/QYKzEUEIO7EDpG01S6zC9t9MlT6TUEfgBB4o4qmhkgE?=
 =?us-ascii?Q?3x56/0+9YjfnnScwbjfbfkNs1vzRQ3i/2Ktg3IEm7bAjkt89ZFy1ssM4fKyT?=
 =?us-ascii?Q?9GFg/oV4AUKYK9rUtu6iAUOMKQKZo3xSNuuVgW6F2Cvnltja7cfEAkoB076c?=
 =?us-ascii?Q?aBDGAUh8P2NY4BBqnrmRhaVeky1L2XE+D7QEcFgNe1QjspYgk81/xTDHGpMt?=
 =?us-ascii?Q?SrZG/MwFvZ+ZyXEXFR2vrNW5YOKU0VZ2yvlVzbrJkfRqwDGHMJToEaKJd+Ap?=
 =?us-ascii?Q?b8sPUGSQE5YlDUPZWJRw/Vf+ONcOIMsp4sCQf9QMM36h0TrEYXthwVJUBGX6?=
 =?us-ascii?Q?GxWETSC3pSz8KpUZzEbP9nHDjsZF3zi2vlY3OUnuzgGq+P9LsvhInvmOhkpQ?=
 =?us-ascii?Q?/KIQ3qkAyY87Vo7env/GGco0uNNC/DiQCI5jI3t/ojvpHB34YAutjO7U5WQ4?=
 =?us-ascii?Q?YF0VPe+BnfeTaU22gDnKeTgr7+MHLqjtusdeAF3KIeaF9L9nTpoGQlmXCvO4?=
 =?us-ascii?Q?0RltpLApqrF5rLn3uz85TuFDbT6apFfKdov+0MuYu7hVzkcQJIhSofqFSxhL?=
 =?us-ascii?Q?65A2SESrZ2fywyTV1/NSPj7piTnl1vxw9pqDZQiNbgdmbJ1I7mGSvWDOFW3E?=
 =?us-ascii?Q?a0GomqCQ9+3yvR1l662zkXqVa5MMUAWjXA6O+WV8tR7vhcw05e6VpPg9DLrN?=
 =?us-ascii?Q?P0YrQhr/VY6pNJJr5/Nky6LwPSBiuiKP68j5tV7GWVEKbf2ba+VhAM0JCSI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f44547f9-9e12-456a-fe94-08dd816ab093
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:55:38.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8199

Hi all!

This patch series includes two changes:

1. It adds support for Oauth2 authentication, which is now compulsory by Microsoft.
   This patch has been rebased to the latest version from the original version
   at https://lore.kernel.org/git/20250125190131.48717-1-julian@swagemakers.org/

2. The second patch makes the script reply to the message id set by the outlook,
   since outlook has its own proprietary way to handle message ids,
   and does not allow user to set their own. As a result, threads were breaking.

Detailed description of each patch has been done in the respective patches

BTW, I am sending this series using the patched send-email by these patches from
Outlook!

Aditya Garg (1):
  send-email: retrieve Message-ID from outlook SMTP server

Julian Swagemakers (1):
  send-email: implement SMTP bearer authentication

 Documentation/git-send-email.adoc |  5 ++-
 git-send-email.perl               | 75 ++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

-- 
2.49.0

