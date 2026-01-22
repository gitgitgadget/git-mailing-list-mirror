Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazolkn19011026.outbound.protection.outlook.com [52.103.74.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B178322154B
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093150; cv=fail; b=U64xNB04+budm0hpYao8OuVdGv5OR+cc3mQYtHBO60TxjzM1soXO1NvpxpN4qwmbAfRr8jascWDWUTLA+gdfplgyjKwZcOZjPY4BYKVB9NYh8ZfH67X4wb3adwjS0+weopvci2PbWVwgDk9HZ0S5USFLvzXkU+0o+ewDf8CvOlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093150; c=relaxed/simple;
	bh=Bvgdvi4jeef43cSfJOaLUB8MROHHFCJHS79nJu1Hg2E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l4z3vxeaY2W3VkXz8taDguMz4MosCktsePlFMmXux5Ysf5zTMv8iWzqWJWuo2pa8aJUTNqPiwFAWFDwVO3bwN28RIYeLBQ0bustIcQQMcBHz5PdBX1IvUBqVAOe5IeQcGO5hqvF5QlPIqPKu0MdIMd0HTxZ+gbv7SAVkMGJgKks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Dli78Z+2; arc=fail smtp.client-ip=52.103.74.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Dli78Z+2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmfYCuDQWmGByPj96rUCtflGZvvwTGHqJoizOIlepCEwzKf7BRdsKa4nMVHodGyE/SXdDuaFLbJhpHvQEqqB5sYyZujt+U74/VGdgk1R7yhXNbBOuIF5m0VMyEsEZXr9bESjqIVuAkzeFRk+yWk6a6fUk/h5y4Ol+MBuMnXAuoIsg1ZyK/CLl26U+2cucYq9M+EU7kYsgjPUeLuXpUTfQ/9izbw4bmzSD64hX7yRCt5DPjqiGHRgU32bLO3PxUoJxec32IDUwxSFTeGtx4Tf2oCjrqG52LxxdXzAfx5d98YsdhLh0rGs6YMY9zgiFLlVP2qdtLwxIq73N7o7Cz6bxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvgdvi4jeef43cSfJOaLUB8MROHHFCJHS79nJu1Hg2E=;
 b=WnhyXE86UFupigqEVVGIG9Lgnk8rOkk+GCUSD6Li0BBRlP+vjLOZwMXX3UXE8N+Pb8zDKgAJQF+QlTzdoxl+ep6ojbfprzHzeJQ0lZKDCtq05/wD6CZqSIahBxsYnqhUCnD9Y04xSl2aUE7isJSp5Z8TIkM4bCCX5ZPRq3310uwudXBrWIOBJ2YYDOoSZx+ECZ2FSHW5xBj1BK/9EPMevk6LfM6ISU1ijNYY6HDq0o+E54ygGEMXjEbY7ISlAtmRmroNMDge9SJfKlOylq1tqiyb3TyflDgjU4yIlazR+fCmgRCpb77d14OrUfbZvpmy5KoroGKgGMOiu6cGvksQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvgdvi4jeef43cSfJOaLUB8MROHHFCJHS79nJu1Hg2E=;
 b=Dli78Z+285RkcbCuQ/CWAnDqr/wKCdY9jL0JWyAAxkSPBswphBqGGByWMrB8KDmygFT2MFtl3BfsxkScJWPYE+nQJyZYTLPT8WyCtSgSiJyIsDPoUFcPVmbYjyn0keFpQZabPsWiucaL4LD1W/fmn7TxdkIwyR2v1/UmLaK9F7vEzhH3zf5PUTV1rJPtH/JEqFmFGeBXKNZgH07RR0t4Kms/xOtzmARGNmjo5KocqomixONlWw4VLQ+fLZEoZnV8mayq6R0A/iQB/qeuOHxtR6mMF3Opg4mC9C12FaPEUROeTitfboKqu4heN7oDAv9+5F4T6EpEJiiTbtdvW/JT9A==
Received: from SE1P216MB1319.KORP216.PROD.OUTLOOK.COM (2603:1096:101:b::11) by
 SE2P216MB1859.KORP216.PROD.OUTLOOK.COM (2603:1096:101:fa::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Thu, 22 Jan 2026 14:45:46 +0000
Received: from SE1P216MB1319.KORP216.PROD.OUTLOOK.COM
 ([fe80::6717:af0e:30bd:11ee]) by SE1P216MB1319.KORP216.PROD.OUTLOOK.COM
 ([fe80::6717:af0e:30bd:11ee%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:45:46 +0000
From: Alexandra Deverick <Alexandra.Swapcard@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: HIMSS 2026 Leads list
Thread-Topic: HIMSS 2026 Leads list
Thread-Index:
 AdyKSvZm8hlJ2FUvSdW9DQBvkvFDZgBYrOFAAAAADRAAAAAUoAAAABkAAAAAGWAAAAAcwAAAABqwAAAAJOAAAAAVcAAAABfQAAAAFjAAAAAW8AAAABYgAAAAGCAAAAAYsAAAABrgAAAAF0AAAAAYMA==
Importance: high
X-Priority: 1
Date: Thu, 22 Jan 2026 14:45:46 +0000
Message-ID:
 <SE1P216MB131975C1C287B50A8D9DF0C99B97A@SE1P216MB1319.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1319:EE_|SE2P216MB1859:EE_
x-ms-office365-filtering-correlation-id: 74f4f682-0a01-4ac9-5cc8-08de59c4ed2d
x-ms-exchange-slblob-mailprops:
 zZTkHIKWWP8EXRfSHz/+bmvhnEayH3FsmlGegbV8D5CNUCdUaXhOgyCKPtWy3tOCja4qGHQndofBuUyIReM1Kek1xBnxT5ijAl37he8Az9hk3YvZDcSBhp6yZeCwXkMiOmR7PQs3RjUNPLC39VUSfGsDYurGpPOKIS4qTgsA7ntEwmZd9g8DKumvtPSWX8QeRfI/2/AKyYOYiF15b1aP8TPaV+jhEIclmBx+4G7ieWyARoTc3iruEeoPINFFwRMPKdixMA2tN5UCgEa0fIakDXlecCKI9Jq5salUSAiYxav3YDNrs2bZA2zeveFWb19OMwJuBpxSp6vB/f7X/n+55VTW/OX0K0G9b1/QzVxXIFNEiYV+CAciTc9NZvD70a8s2W/Ic85DWBv/0U25MM2RDn8jQfBiU4ldfY8qienQGwCDG33tBiRTFk7N53iVnkTRF5ApOtkxjMsLcP+4bu/f+s25rZjry6nMwksStUZFflUm7nEdmn/KVOSjg1mlvNPn9PqGLsFPq7nJY4M0QL0lApmXinu4//q4SE4VP6NJfhudCvV8H2wvKW+hwytRjbTyLK4+XCsg+NJ2rep0tj9A+v4pw6I+iYBjraXFJ4yH9kmd0NDeZJVZnJ99kHKeCMGYMAZo0gNsuBcfspnubVlZhGdZwwQ2/08zPn8Ikl5SYD//NIM752G0+g==
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|15080799012|39105399006|12121999013|13091999003|19110799012|8062599012|8060799015|20031999003|3412199025|440099028|40105399003|30101999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y4ULjr8BXdKWI4/ptoH7mITlZvye1VbrC+eRBKOSpDm4wwpSiHXieyDRcMlO?=
 =?us-ascii?Q?dVrxMz5A3jE1GJVBME9KzbWKC7rCvpm32uh7Lb+LSaQZTEzw1neQ7TBSqAS1?=
 =?us-ascii?Q?CWcnFL5U6fP1YhvsXzDUO6tBciedPOpszQKWtdI2IAx52gJuAYWabZpQUuvU?=
 =?us-ascii?Q?L4mz7Jt+zBLKZKJNu7UXbq4QcJ3sXqSmknnBPaLAeZtQBh3VH5eUJRuVD6i2?=
 =?us-ascii?Q?7A9zhYlbc5ourZ1OhaIMvMxqJ2+HQkPS8j1jJzdZ1CAGvq4O+0pBKVdHZ5HT?=
 =?us-ascii?Q?L06kvhm97FlbxNBUJyKHRSZF0BMvXRCx1pNKH7ce6ka1zREPu2ONyr4LPjFO?=
 =?us-ascii?Q?BfWyPUVy76cglIoTh+lJBhKDTBXG1IS0WzunHmsPeVR/BXQrAXEsbo7cwwor?=
 =?us-ascii?Q?CEorY0FRgLu5rpBv/hxoBDIa3PBWaPW/Tw1jVbxmM5Rds1CaCDECuxYtgAd8?=
 =?us-ascii?Q?Z4jrW1cFiTai/dNP8LBWt+du/FM2i5qwEuu8frl51PWbTTNlj2lr7gO6W8Re?=
 =?us-ascii?Q?D/aSRAo1ixHgf0ffLgU6RVlLryopGzvN7ppQagDvZtazSLrpcK8ZTEFm8I0O?=
 =?us-ascii?Q?T7kv09J5iUIekbS25rc0cqj6EAS0UfRvMX3WE4j9krj8mBn9uhoua/XqQ/kx?=
 =?us-ascii?Q?Of1H4YvrK1s7jwy8m78xpe7oeKVRONWPEMICu2qyXTmhFbhm9/ivEWqTSGeO?=
 =?us-ascii?Q?O/zMoQ3reb2E7rHDMFdGLo3hznemRrPtVmTq8SupDgGTRYfWsuiSWxRBy5DH?=
 =?us-ascii?Q?wH1dJB7aTTbfmolgum4cx25xe8dTufopm/spA3ZwcisRKLfmgR5S+g+3RcWz?=
 =?us-ascii?Q?Gbz5XO2GJQGGMcD+755cyfj/0d5UljxV+ydtwhso6b+L8jRFPIa78zh8bFsL?=
 =?us-ascii?Q?jPZAZVBhpt4qyjL6Ky+/XHRXrdyeA1acgOx5Oct+7NhLGQ1T4q46kkmyUnXj?=
 =?us-ascii?Q?Et0NTPeFpwmZqMnIXdCGLvWh7KsNoXvy8XuJnzOz2ctRfby8ZChRNtD6KxUH?=
 =?us-ascii?Q?AWZbT7zWotao0v3nWJ+/Z/90c3/W0Vam6/TdMcAN7wc8+mWyVUGCKF2sqMB1?=
 =?us-ascii?Q?wnKAvY7xuKypGqpXW2RsjFrnCYAx7qn0ufMGSJEeesipcHhPQ13lHCZryhCI?=
 =?us-ascii?Q?t+/Xph99l7kkmd3dI7zZ1q1ekn3dJvZqEHy5BI4Yk5+7Ls1UJdeTmbVZSbBK?=
 =?us-ascii?Q?zds16OQJfYI6FM7aeqZN2x1483PCXRbINAlvBYPsz380PT+Q64RVNAJaP+KE?=
 =?us-ascii?Q?ykMuAcOGLPjTKqXsKhXPUhw3r8pLk60TNgkn1BHdohe2pZu0XO3BFaJ4p1aH?=
 =?us-ascii?Q?HZh14zuP9MDVxEqA3NaK3E6v?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EkLnFbtEC5bylS7tnD5XoddFxyTMNRJ+v69RULw5LDe+tyZWKPBB4UiauiDx?=
 =?us-ascii?Q?HtmYYAq3Og7Xefx6fqOOmVkqRA6L55KojYyaE9Td6P7jJ/suHrPWi2zVJqVM?=
 =?us-ascii?Q?nyeccuHuAV8pTQZFbQjRBICBt+POIOobs9AW4YG63yGpQiYeVKmWGqgYUa+U?=
 =?us-ascii?Q?b334TCHSQrUgoXE9u95SRnDXGAhcHk7zIiy7EavM3oCyBQxXrjkTCqlhysUd?=
 =?us-ascii?Q?p5BR0V9u9htc01IHPeAll+x0/Qsg3uaA9Fc9BDZPrnuLHRC/2vyfZgdFCVh2?=
 =?us-ascii?Q?2yutX0qMJRJ5EA6ASt6cquAMqJ8IU79OxmCHHtUIKvEYt8g4q5lNCI9LK+XS?=
 =?us-ascii?Q?wASLUA4V0XUIjgHlni0Cutv7bJM4jfpYVnRhVGF3o2YYZmphBhA9nx0jkg8E?=
 =?us-ascii?Q?OnOzFv1GbSyejeHVIofoJsvVQ4r4GeblrrxcfaLJs/ikswkkAO5uOMYW8Nbl?=
 =?us-ascii?Q?8nb+lqTJeaG9mA+S3O70uXXnhfynRP2aaLGEEE3ug0di4PMmuRZwGSQ9r9/1?=
 =?us-ascii?Q?1omXjJpBmGzhriKhutgGvTEn6ZeMbBZrBYjOqRCQXD59kwelvYrN4UTtbk5z?=
 =?us-ascii?Q?DiHM0DL0D3j2pLLfarZ149qXYLq/JluRUl3I+SBydg8C6dd2mfTlvRLUdzqA?=
 =?us-ascii?Q?rSAdX3p352k1FPR9ucH5UoeOq2sqDFsTOvwm8OM5qDb4ysKIyqWMXGE9mif8?=
 =?us-ascii?Q?qn5AGDpH4ksj1Up+XePAzut0tnUQBh3J7blI04qEvxvi5CpW1zmzIIh3DXPU?=
 =?us-ascii?Q?vxs44xzOUuWaHbszHqKsVtU/7uM8YMWrXJQKifXQjgDtB7oEqpVX/FfLBp6d?=
 =?us-ascii?Q?9xNFx+W26fj72o6cNR9NDOsi1w+bitzkXQPRW39gHqMnto53SF9GHkhKypUQ?=
 =?us-ascii?Q?Vu9upNG4P9m1owmRcg4K8kHmbMPWe96vrwKt2yCVKOYp2VYMcZ/G+za+ZguU?=
 =?us-ascii?Q?m36EjucufKE0NjFbHxDGBw0Z2qnZTjFcuKwfdjQYu8dzg3N3eg9wy3PmVu9v?=
 =?us-ascii?Q?paRGHW95fKQ0dSfuWqVX9eRpPBsviSLDs4qZVfHUREzKQui/C6H9G8b4DMna?=
 =?us-ascii?Q?Cq/IJzMjfBgA5eH9MonSPcFHMLxfR0y+XwLNhvWQoC6Am02qBWkwG6IIXmRh?=
 =?us-ascii?Q?suCpTniAaVi391YXSXV+hcP/RqzIKxxhpMag3BVDWTnN5yJEc1ol2ACyauCk?=
 =?us-ascii?Q?j+235lCx0cIWvcJUbizExDFJ22hxzYnCt6el59dSpDJwZ+2qg0yDreZY+brE?=
 =?us-ascii?Q?KPlzxu5jB6wvB20I0CLsS41AMCvb1NJcJxX82lDJSgfh2B4SskSOzg/Qs5vu?=
 =?us-ascii?Q?9J1swI6i2NPN3/JGtsndXlZ1UsWdp4YiGo+NjOjuravRKtrdTJAglIvWbRiu?=
 =?us-ascii?Q?d7eBepk//kficZ2zVLG+kCIOeQQ6ZQ66G9KgjGvolqE9v2N6LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1319.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f4f682-0a01-4ac9-5cc8-08de59c4ed2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 14:45:46.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1859

Hi there,

I wanted to check in to see if you'd be interested in purchasing the email =
list of attendees for HIMSS 2026 (Healthcare Information & Management Syste=
ms Society) at a discounted rate.

The list includes verified contacts of key attendees such as healthcare IT =
professionals, hospital executives, technology vendors, clinicians, and oth=
er industry leaders.

If this is of interest, simply reply with "Send price", and I'll share the =
details with you.

Thank you,
Alexandra Deverick | Event Manager
