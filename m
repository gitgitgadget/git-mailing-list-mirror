From: Alexander Skrinnik <askrinnik@amtoss.com.ua>
Subject: CruiseControl.NET hangs on git-submodule bad file descriptor
Date: Thu, 17 Dec 2015 08:17:57 +0000
Message-ID: <HE1PR08MB089107ED02BEA428A6BB37A5F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 09:18:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9TlK-0001gV-QA
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 09:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbbLQISG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 03:18:06 -0500
Received: from mail-am1on0068.outbound.protection.outlook.com ([157.56.112.68]:21915
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752369AbbLQISF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 03:18:05 -0500
X-Greylist: delayed 59955 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Dec 2015 03:18:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amtoss.onmicrosoft.com; s=selector1-amtoss-com-ua;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sPKpPlqBp74ap0gXqVMr7DbG0t9pd1YNzufH4ctPEBA=;
 b=GsFNRHnFaWMCXbHmln/siNtGnG2FSp7JrkncdSvKG49s8HyYk+uUFtYrg42yYtFwjoKpxetAEQk4rdTST6unl1qs/voCCMHWts3ZBjQcbZDBDzi5kIk+xUdH6chQHKGlK7Xm+GSiPmr01o8tRhAmQpnyXzbFWg/ce3vjaUVb3mo=
Received: from HE1PR08MB0891.eurprd08.prod.outlook.com (10.164.53.29) by
 HE1PR08MB0890.eurprd08.prod.outlook.com (10.164.53.28) with Microsoft SMTP
 Server (TLS) id 15.1.355.16; Thu, 17 Dec 2015 08:17:57 +0000
Received: from HE1PR08MB0891.eurprd08.prod.outlook.com ([10.164.53.29]) by
 HE1PR08MB0891.eurprd08.prod.outlook.com ([10.164.53.29]) with mapi id
 15.01.0355.012; Thu, 17 Dec 2015 08:17:58 +0000
Thread-Topic: CruiseControl.NET hangs on git-submodule bad file descriptor
Thread-Index: AdE4o1uEu2TGfefDQfCy4zvcOMHAYQ==
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=askrinnik@amtoss.com.ua; 
x-originating-ip: [94.27.36.22]
x-microsoft-exchange-diagnostics: 1;HE1PR08MB0890;5:cP58tIEyHamsnuntPUjWznTCDosjIABW8J89zSl06My+0791IadLFQJedXRq/koUwNyCYclo5Vg0w9gQs5i8uCT6xBpMPY8oJwZN+ETUTEj4wN34wDC+0rv0pZPns7T5ZnhPvoHrOqHm/H1anDD5Jw==;24:WSAI8s8y1WIZ190tKgtF10b4NNXuyEfGbNdqGnChwN6ajEUzL7fhLPK5UDl7y5N0zx6jmxiX5uJ8q8PCmk7Ex5+Xpz7qtW0q8NMCSQSCgsw=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0890;
x-microsoft-antispam-prvs: <HE1PR08MB0890E9BC32EC1801A6762089F8E00@HE1PR08MB0890.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(5005006)(8121501046)(3002001)(10201501046);SRVR:HE1PR08MB0890;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0890;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(504964003)(199003)(189002)(40100003)(77096005)(122556002)(101416001)(2351001)(229853001)(76576001)(54356999)(74316001)(2501003)(50986999)(1096002)(5008740100001)(19580395003)(1220700001)(92566002)(106356001)(33656002)(66066001)(105586002)(450100001)(2900100001)(5001960100002)(107886002)(5004730100002)(10400500002)(189998001)(5002640100001)(5003600100002)(81156007)(3846002)(97736004)(86362001)(6116002)(102836003)(87936001)(110136002)(586003)(74482002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB0890;H:HE1PR08MB0891.eurprd08.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: amtoss.com.ua does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: amtoss.com.ua
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2015 08:17:57.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3a059e38-2ff1-46cc-b231-299d17307f39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB0890
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282640>

Hi guys,

I had installed CruiseControl.NET 1.8.5 and Git-1.9.5-preview20150319
CC.NET invokes bat-file which invokes 
git submodule foreach git checkout "myBranch"

It worked good.
Today I upgraded git to 2.6.4 and CC.NET fails on this command with error:
C:\Program Files (x86)\Git\mingw32/libexec/git-core\git-submodule: line 544: 0: Bad file descriptor

When I run the same command from cmd window all works without error
For now I have to return to 1.9.5 version.

Could you, please, help to fix the issue?

Thank you in advance
--
Alexander Skrinnik
