Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CD1B593
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919123; cv=fail; b=odH07Jufi346xzRzvoDqt6zbx8APdebLK6D3aFF1rf55IPNrsvXdzFbVy5BTeB6DTD+gyYXqu8YhO/EFuYPAx96hRQYJRZI5cquKH4Rj+BzZTpdI58Vpc+7ugsaaqy3dmK4Ink8qGsw0qBlcz1qEGmf9d4BZZZ0T/RXKlN3soeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919123; c=relaxed/simple;
	bh=en7Zp5+sQEluJd6j+Cqj4yDr8F7SZzkRvuaIcfjAbq8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HPdlIgxeyz/8X2n+fw3ROIqMokhowdwAq8DS1tT2r5h/Dp+zGFpa7OOQYhUOZwD1cJXOcPrunr8eb/aAdzR75FTg65O4j/rGnFDIqsQsLfrj7qW66Q+WqVrlZfv9DgCvykvo21zbB8yzsjQ9ZFY2mP99Cg5B5AieQvL2NNbDJaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Se2e38fA; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Se2e38fA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU40jpuY4iqu1Im6x0lKEZc0ubCroqHi0cx7A3rZNBhRHRtyJuSeV1ZvFYD1CElm3wTlM+HYCaNHXoIzV3pZ4BZCHkb7rSCuUYkwp4IISOtpJXJ4UuYLF4ELFwBH8Vh8WGzmWM6pNHimtRUbCfs64i2fd1OwaIPXd4T0a370UX+sAMguhahxtZ4KX/CxOtrc0ZO5TrLu60hQ6VPeKZ9MLBJLJ2wCDFINcwrA6PAcINhgpOVJsZCcHL/lwTNYDvfJfZA1jrbgM3Da3nRNhCSYgDid1HNwztg8yRHWU5hfzRFeizD2YcTG/GIcKcCLsoTdyVDnkM66WDovnZaF9CS+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en7Zp5+sQEluJd6j+Cqj4yDr8F7SZzkRvuaIcfjAbq8=;
 b=cVpdxIzKJVWIGbok0W5Ee/pkgpMkZ6bOKOWa4JRSYBXSWt7S4fviYvEF3A9Y3qpYTIm29neh4FaZPqbDMcWL5WoGC31ps/HCLsv52phcxs6pNk7HnuO54+B34cYEitMm8VjetQabnY4Q7K/j488CZUdXcdrz+VF+FIXVJBgPf6eJvjwv9FXsHjb6g9rdAHxBJNtBr/JLpeWT3V9LkcVAg5ZHyYJkmqjh+EmQwRLsSYNxL/LhdPVAYaJyuvR5mRsM4almdZ6xJ1nJ62RThfwDqtmtpOThF5XFYSYqSGC7vEBkXZ+tB14hMsvgUuIApvpiRvh9u40kRvI5/jJF518ujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en7Zp5+sQEluJd6j+Cqj4yDr8F7SZzkRvuaIcfjAbq8=;
 b=Se2e38fAalxuqiISaMqL3EggTD8pJCNFk5ENd+NcTills9Qw5jEzl36w07Fx7tEZcsZAxnvviB03+Il5SMaZPJH8MiwykqNzqwSJyASm02s+s+dC9gOgPuTn9y9U0+WJoVGMtNyYryLAJBt7SmLr6tjgXDa1qqckeXn9+KhMYJ4=
Received: from IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 03:45:18 +0000
Received: from IA0PR12MB8227.namprd12.prod.outlook.com
 ([fe80::53e9:9935:5c47:fa2]) by IA0PR12MB8227.namprd12.prod.outlook.com
 ([fe80::53e9:9935:5c47:fa2%2]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 03:45:18 +0000
From: "Chen, Boyang" <Boyang.Chen@amd.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "Wilson, Mark" <Mark.Wilson@amd.com>
Subject: Recall: CR position changed in exported patch file subject section 
Thread-Topic: CR position changed in exported patch file subject section 
Thread-Index: AQHaaGY3qgZrOAO9ikm6gKxCApvUOA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date: Mon, 26 Feb 2024 03:45:18 +0000
Message-ID:
 <IA0PR12MB82274DF9DFE60A8F9365777AEF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8227:EE_|IA1PR12MB7687:EE_
x-ms-office365-filtering-correlation-id: d17de00a-9fa5-4332-0426-08dc367d59d2
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Vni0GTvG1ogkZV5XbDisjLKx6PdV7DfW+dUhG/11N92fywOq5DzLiGMjy63ywLk86X3yFW6Bh41Do6dNSktEyQSHaO/PjLFsxaPBGgnzBzN0YEcbOY3m5HCQpinymSoJAbC1si8GpbMnbggB+dLL8vPQVRBpChAat3+1zBAd+y1ttUY+Pab/Aj5btLYgJ/SAon/rjKN4WmZTR5d5n6bJl8Quq44Z/meyCkTtTwcWwkKxOsiLU4+5YGwEmsExEfNYZKtXm9QCw162YHROU82Vl9DK5i7H3LK3gHeN7cv1tuz0nc7NzldME1CcyI0AtGzxLplj/BKF6h7fHf7fLIwA+ZKVbs9xfHUwgyGfGPjhwmLZIdp2JZRxKShgE/DanpQfrRbKQZEjVzfoliSkN6P/cYPAcv1E96JKLyou26qfEwBrpyP6T7RCP9Hc4ow+HCNlhn7OC/ipbHi7ezG+gqdGCP69/zU0BaZaUtNd/zvDGocjP4Tb/UunxjFY6CnfhpgfQiu7DdBRwPX+fHhVVE1znM0Ak3EaQjO3YfDOWBk77cP5eyWVokzHJfKh67dJPf2TAQcJCdynUeCiuBhopiz4qtIEX68io4yr48wRVXwc15B8g1awuI1JqkoHvqNigfonMW5yRmdJq30g4v6U68Wvsor9kx/rUf4BFjElj31m7A6dShiKE1zXFoEtrDVbBnOyRMoRimzx+qZa+PLMgBn21NJb8oDAqYHjtP2eWRc+De4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8227.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MDeN256g7rt2IBVCEPTSyGrD4dtzsN/CDDhJJ+j7b6Z3miJtvfChx3+LkEn3?=
 =?us-ascii?Q?HgSp52IUI0nz1XTNNpe81raHWMtCKMKJv8mPWhfCkAKpVF0IT7HYPCt6+QWH?=
 =?us-ascii?Q?YYv7SREizs50QodobB8AkU2IYcOXZrvXbF83cVgYAlO/MkYsatss5DSwySeT?=
 =?us-ascii?Q?/64NbqksLR3liA82wts4ZXJr0PzxaCBoZtud7k+1O0IRj4a48YcVdNPuu0BW?=
 =?us-ascii?Q?HG9oR0glUB8EY8sjgSwEJZSCQIhqbf/DWKb4ZTyxdrGVz/oKA2P/xb3cnJ4h?=
 =?us-ascii?Q?HjA5REf78FXpvfYPD0THmiams4ebMjJCc31eKMrUP6sVm0vxbuUXSzzq5gfD?=
 =?us-ascii?Q?9y6ObbJ4hGWqDmn1itXMb8bJKcN/09wk1oRePAiSRmi4BX7yCMYmf2gJICsy?=
 =?us-ascii?Q?MxyXaknhFygxIk5fpXJfFw0OuVVdT6JIGUDWk257fUpLg4pEVuN1S2hbNqy3?=
 =?us-ascii?Q?EShqr4fk6nkGD4nQeSisTtWJkwKYPAdWKDOd3Vqq/oPfSIGgCZxjatiI+IX4?=
 =?us-ascii?Q?VSYXQUSWVAZIxI54Kg/C+fsld4tq3UdBnOo9boyi1EdU99c21VB7GSwtbTJZ?=
 =?us-ascii?Q?67gxd5CnpyQY1+A9jZ6VdwJIFPX0m9GhTLcJe1qB+XEuTRDn4cXl8zwBg2Lp?=
 =?us-ascii?Q?loO/j5w8lMoHNQsdulUvCRR/EgxzZEP97palYiR4f3SHsadSoHE44B+7+RgW?=
 =?us-ascii?Q?UVVpmAWmCQVg8BllHJyKOK9jCfRiJOvtZL0t33bl9MzPM+ERE9zCsUjsHWWH?=
 =?us-ascii?Q?hfGKIR80VGUfay8OMP3hi3xPGykSwNgWOFlYLuBKfRoHhSRGVB6Kh60I9ssi?=
 =?us-ascii?Q?b4y5Bz5yX2nqXPBYTbAnTjSc8WzGxUZXM+lJBuxVa+6sly0Ij2Ewd013vtDi?=
 =?us-ascii?Q?Jl5oDto79gmmKEFEXYRKoS1uHEsPXyM2AlcgAnkw7y/kqSVHWtYUwBi2MVy8?=
 =?us-ascii?Q?iuqk2QZKEbocp7RIwpQCS34IvuRXqkGrKf45T+XUeF1SuG944CL0x6Wh9Z+y?=
 =?us-ascii?Q?JID09bN41jFqtl6+otjwk9u48RD8lg9p+Jdx6rhYyUG2g4PRIFa/5/AuBWFk?=
 =?us-ascii?Q?MLmQPzZm4MhQb8c0OoVstcwqYBcJ8rWLrAGmEj+D1hXqlF/bZ7jl6RTEMegV?=
 =?us-ascii?Q?9sQIZyB3Kyi6/nerWWuMbtJPHaeBkhQycbGoSIGLu5P1HnB8Lp0JZpIDbqe3?=
 =?us-ascii?Q?Fc47MC+XqrIMWXYpep/u6kMjrS/fDZpRGAMVfau6TNMbMre96q0pqm5+Uc8c?=
 =?us-ascii?Q?h9sb4+mc8Psk7FzKIZLt0hMsog2wruMOX6i28kfhc/W/RgwCLLpcyLPm3Ip8?=
 =?us-ascii?Q?HxhbQOB4HpNbBCHLPQLhsL04qv9o+lehu3UQG8tC26nN/BVmWefk0zjebkXT?=
 =?us-ascii?Q?pM52ljjaSkJmsvajRX7xJ1uMIpPvwOYr8EzoiYzOvcMCy+SotqArGNrpxnXs?=
 =?us-ascii?Q?5w8iAQeOcxqalfd5G0zYTPSdB+rub9l318N5J+Kz/0xixTZwOHiHiakNkR63?=
 =?us-ascii?Q?xyNa4+SSke666xf5xrrTsMbGhe7T4Wr+2SCNY+JJ5+qzuAZeKcFRIOplW1zG?=
 =?us-ascii?Q?JO0QhEav1MXBtj5a0FM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8227.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17de00a-9fa5-4332-0426-08dc367d59d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 03:45:18.5218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJS/b+EQcVycOnElPNpBeVYf2Tk2M6AcQW5P9bTNXjpXzGSscWYylNmWwFnDbBemyROCXo9z9xlY088YWWGFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

Chen, Boyang would like to recall the message, "CR position changed in expo=
rted patch file subject section ".=
