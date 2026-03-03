Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010023.outbound.protection.outlook.com [52.103.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A8367F50
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546500; cv=fail; b=uN5HnI3kaJj1q3tLlFTngzMdl7bhTUJO1uwtLX+H/gtsNTObbYfNJzc1ZtXSjBUV2JC1UdCitvtePBf6W+fmTyELYTZs3Bb6vR6UGmG8WBlWnO37mzlrlaxKyXaPJCrqomYHAbG3OOVj4moPqBFIV2jNUtQTTUWLX9Bl+ob7lxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546500; c=relaxed/simple;
	bh=5HzC/dQuRzWFYIQNqblqIhBJy05YMcy6k8jVAQD9BHQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HXX33gYc2rV6mvbmeZJKMwkP7XCcpRHLCy8g65SHyZyEVbHJ1DIuO/9tfANh2y8PwuIWHLjJCsTgnw+kwaV18Xf1NwsxAaQgFaYK3aIbYB2XLn6fZLeWIk181v7d8X7+rCR6oMARFpF7Y2Jp9tjXPpiwkTKmQ1XCdeHaFHMyfB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=JOVyt060; arc=fail smtp.client-ip=52.103.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="JOVyt060"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prkn/qwuuYMpGlT1MiT2a7FyFfZDowH16YeFYGNkuVZjz+EU8SbWzlzYFGyWAqXf1qTVh6cwD/kqqk37wYDMSSxIcYWvV7M8KOmWNnwMnZ7UcYu9TORCenJctUJfzLDYeAu4yL8zoy8hQwh7aa5qo4X/lsd/GyzC9eHfQW7cJZCcIWvJ+jTukKYBdHEspkmMNM1tH7tl9jjdGr3EiRYVZvXMdE/pcfNQySOlERKl6gEhL9N4QaH6XC1eMrvCKzF2rqZn1oQtcqMlfy2hCfsAKxdjjnC1Ml86RNudNJPKJ80lubs7riHfXqUebkqkuPTy7UbI5Y0MFdJd5aUqJ4wHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HzC/dQuRzWFYIQNqblqIhBJy05YMcy6k8jVAQD9BHQ=;
 b=L4VA3yEIqVKdAkCAKkr0gSKdaiX/BFKQ4m+j1s7QdTCZL4WXzFhUZRAuB8XPlOsrE5G4sHsrMcUG5N/oZ72CHBx1jsWnShpQpOWdHbmCO4rIzjCqDxVnzt54CHlIsbyArtzVehkeGs5W6mwZbNZ+G7lJ9TctGu1uQMceWhfUJUC3JE0/YQql09E/+zr4y7MxrU1f4qQBe95xVWYud7ICedxj3yOBh/MvUPKG1L4eyzDl1KFwpIB7uLFvV+ckOSXaYFQL2rL/yLwvurSygdh8Wsq6KWFM/O8VKRhljzyrfAyzP/+eV40GrRWBYPdWiLhkmlgylc8u0AGIDfC5yuX5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HzC/dQuRzWFYIQNqblqIhBJy05YMcy6k8jVAQD9BHQ=;
 b=JOVyt060HwuBSBppTo4X6Ma3edZ8xcn1PygUZxzO/LXYPOe50gyS15eUJ86y8Qb04ICOZyhqkistm2vZ+wfJRnlVScYGB+HCDkWX+jjXN1de5dGmxPP0qx3GYJJaZ1Upa7DmdQWUgyW3YHFY5Zsa+h9pul3ia3lp9eVFqV0ovoOS3YgXDSAsWHGEvhaD/GUjQMVrATQYB17rYlSPt428NrddiFJ9GJcIgsicGlyC5Ed6jo/6ibj+qclPi/VV5wwiAs7ZMq+6HgHgcMN9rk/Bm4bCQJQ3hB7YoST3BHKoOb8CGF2NaP7Ra/ISiQhKobeygJqUd1GT04bsd7Bqu+zVUg==
Received: from TYCPR01MB8293.jpnprd01.prod.outlook.com (2603:1096:400:159::8)
 by OS9PR01MB17027.jpnprd01.prod.outlook.com (2603:1096:604:407::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:01:37 +0000
Received: from TYCPR01MB8293.jpnprd01.prod.outlook.com
 ([fe80::3fd2:f9d:7cd1:c80b]) by TYCPR01MB8293.jpnprd01.prod.outlook.com
 ([fe80::3fd2:f9d:7cd1:c80b%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:01:36 +0000
From: Klaus Ma <klaus1982.cn@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: How to parallel coding/reviewing the same repo in shared dir
Thread-Topic: How to parallel coding/reviewing the same repo in shared dir
Thread-Index: AQHcqxX7R29PT8Eq7UmRZYW4GEMr4A==
Date: Tue, 3 Mar 2026 14:01:36 +0000
Message-ID:
 <TYCPR01MB8293D4E9A416FEA864C9906EB67FA@TYCPR01MB8293.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8293:EE_|OS9PR01MB17027:EE_
x-ms-office365-filtering-correlation-id: 05874e6a-c635-48a4-df8e-08de792d622f
x-ms-exchange-slblob-mailprops:
 9qw5+ftluCCm9yoJ9fgtGwzhjjsJDn+qPqcmYeIILvYFaoJp0qYEuuPJuDEvmHk5R+fLlVW6TLU0Xk4MZtCvAzmY592VTY8Fmhuvk/luUlLkXPNjlG/ZFhrHL6TL1+7zCmFMNPCwWUtM4wHSGBd4CpltyL1LKyyRvOdzjy/K9bdneKtCPiubToaNM8kOsQcN9pA5dtpMIDMpeJq5YEmeza9H76nvBWYWa1lFFZdcCWt7THM2jNtuV4xGNDSFWGE690kRwk6SXaEZRZ6lTs2byk1cfe/NyceESYnKp32y43AsPkr4TOAlkEjGVtLkLftbgCfxTb8fXkyL6BE5ZNQQRYlmPne+WsfyIxieC7A7DGQxrKX3oOzsnKDs1VSuxLS/2VsRgOOK90Uc5CerenZUZXY9MTVpOkQm54KultVkl5H04VfhhCib5/8MHZPwkfF/jkCNR6O0AbUYphKiJB57goA5dv+s1YqTTIh6Woqq8lVIf9tj68VwSmtpwCxW5BG8OrL8hwA3YLRfn7aGN4l8lLcQbrkxHCglwtXFRfyPd6VeFT8ELrQ8QNTzeWHtfbX4o23ALwlig+Vxy1sckOVzhoMScUM6Udw0LSYpFP9ySUR/62TViI1jErbosrFXuZT1H4FS/Q7MpZ6ePJuOZn7tSauzqp2YdwUssPo1R3bGN0SoT6AsTh7r4x2Q45QANb4vLw3nPK9PFCM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|15080799012|8062599012|8060799015|15030799006|31061999003|461199028|19110799012|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 8RzVZmNvDxuAo+b6BxDldGb3BxqlcPFgqTi1d1TZ/BX2Ok1DLpxWSjZvxq7IGg/uVsCda3NHbZ6S66Q04etolAStXX8PlhKhAtZOvQB3OU1MTTKyyiB/+ey1kfZa6UKk3QRoooWf9UU/NScDmA01G8+x12kCk9m26GHYukwlH9o0Nywit6ndDn1mNJYgQR04fZOyAbM40ngp8VfKHQcIsDl/hKQeLLjYaGyizUP9iUAAfaEbDpEy0qVbiscIZDGI6mCvplOOdepIEH3u3xm4P3tQ6aUloDAKReWd/MKq2aEw1dF0nu7xmlx+18uJLsvinSDH2w/Xml1hDMStzFBY/R06aI3q0n9hc6Um0WzF6e3xaneK/5nJQfHG25UMl9fmAEHDEfNy2oviuIeNoBmFYtT+xyQ+PDsrmZYiWpUtnbRlMT32OjoBYooz0Xlw1ryHI4nux49N1/tkbUPIbppu7LpomM3HNiP6E7KFm4Rwo60g+BM34o5Ga+bSWcFQKUm1oP0sENAWWJ4Mzzds2fu3+sMNsz96oSndeuF+pB3rTCr7QetbpzS+DNhckaE+LGxGocaVBs2rBXfVlJdKFEXwjnR62MCNe7sTh5dzR81R6lE7C/8Bg1nC4faTs4X/ZxcaJWQOfer5fNJIGZqqGQ32smRAc/jeheUlj1HELX4t53i/Jj03s8PlFt6fyK1yzWwG78kR8CkUVqWQ/5lOgcFwsZBkYNAbYdDf0dkJwpSIcHoI1mKM+QBuaQ336njMqjxhIr0JOTulN1zXuiNVagJ8jAzkeGZ6A8igX/Ghv8JkCX2yDzkDZL66X5tW93z8Y/o8ox5VBaUSoTa2CwLAKF++xwnPVkYc3Ik0bThgqOIG3o2281bzGoBDUOxcdv64Gswy9jkMaE0m2DDeFLIfpdWylgGKQ0Lm7c+OEndJubLN6nZ02aKJuy+Ucj4/eCoaizGb
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q3hzODBWT3pUWnluY2FTSzc0RmZzRU5hQkRxQnRyT0FtZVFTc2c1NFNCdmho?=
 =?gb2312?B?TFZTOVdIVDFvb01DSEZldkFCY1pPK001NGpEeENLSHJQdHRhYWkwQnpYZVU4?=
 =?gb2312?B?QVEzdDM5NVUrL0xkRG1BOG9iS3Fxa1BUMUlTaDJsbUpucFVDaDV2V0ZrUG94?=
 =?gb2312?B?S0FpVytzZjE4MjhwajlpcFFyZlA0elhSZlZMWGhlSjB6WkxUcmNiVTdkWlF5?=
 =?gb2312?B?ZDErTWNsN0xwUWFrWnBkRVQ1QW5OM3ExeVdxVFhMWWNFeU1mRElTLy9Da0dE?=
 =?gb2312?B?bW9XT0V0SUNsS2RvWnZSeFlJd2pxdk5XSTlJdGNQNXdVWGRTSzBKOU4vWFEz?=
 =?gb2312?B?WG9HQ1cxNTRsbHdjNncvUlNzK1l1dW45R1VqRVY4SXBkWkJtbSs5bno0RnpC?=
 =?gb2312?B?WW15NytTb2d2d2xJaUZkQzEvQWZqcllZbEczYVB3Q2J2ZUZIcnlLaWptaFdm?=
 =?gb2312?B?VW81R2pxWld4SnZEYjhGQ2ZRVFRlM2ZyQks4ODBDbE55SkExdHVkanNhYmlO?=
 =?gb2312?B?ZjF1Z2lJOUlBeFg1RUQ0bGUyU3I2OGdYYmtVMHNNTlh1dVZIV1BtZkVlRnVJ?=
 =?gb2312?B?YlF2Rktld3pxWU93Qy9WaGQ2d0M0b0RkS0R1amZFZy9tRTQ5L3d3ZFM2M0x4?=
 =?gb2312?B?aDlXQXRudGRNUjhkcktjUjB3NTRkc3U2ckNISTQrN3RnSmE3eC9qNWZYVXEw?=
 =?gb2312?B?YXR4WGo2QmoyMThVNGQ0RTNpcnd1VEU5MzdXcWhSOWprOHdaQWM1WUtpRFJ0?=
 =?gb2312?B?YWpFZkROWWU1dDlkdWplblp0THA5blJOVG5EVkRpSDlpQkQ4UUlQUW8xbW9h?=
 =?gb2312?B?dExqMUh1c0FaUlE3c2lURThwa1ljaE5sWjVWK2gxaU1HZDRkN1ZXZkd1d0R4?=
 =?gb2312?B?by9CVTFQWlQ3eE03dmQ3SU5nWGRpL1RTQXJac0RLWUN0WXF6K1dWdnJ3aEdF?=
 =?gb2312?B?aHNSc2hoTHM4OVNPZThzelp4YU1scmdGV2NrWUE1R2JDdFB4VS9MRWdKY2Vj?=
 =?gb2312?B?L2JtNnBJVERIUEYrMFBzaXpnWGRzUnpvMEhZZXNhSGxjdTNsZWhkbTEwcjB0?=
 =?gb2312?B?NngwNGxneEF2aDdKSTBBNEtuNWxmb3JsRW9mSkoybDFGZ3ZJWE9HSFVZY0d6?=
 =?gb2312?B?V3Vtb245V3JLT2U0cFBxTTdwODc3OUxRcng3NlN0dkQvdjc5MEw5ckFDckhP?=
 =?gb2312?B?ZU5NZC9VRFB2a3dnVnNXUTV3QWxXWWdhSXY0MEVUOEpJQXI1c0IwWlFWbXp5?=
 =?gb2312?B?bFFYYUlQRUpJWmR3TlREd2pkbG82ckpoOG1LbzFlc0w1cjArT2NLeThVZ1ZB?=
 =?gb2312?B?WkRQSnVJRldkbkh3MkpZT1lIRWlUS0o1NmNZcVIyR3dpcVczdU5BSy9QclhW?=
 =?gb2312?B?NUlEamx0ZlI4bCttUXVTb1dXWTdYYmhjVXJ5OE0waFFmSE9MRVNlczI3aEg4?=
 =?gb2312?B?V1Q4QjBTMUdaaXZLQStSaVl5VHpHM3h0cEY1eWRjSXpia0FrK0ZPcFdIbFN0?=
 =?gb2312?B?cmRieXZqeFhoVWlhM0p3WTI2OFRMcHZvZm43ZzFleEtZUEhBSDZxUjlTcmNj?=
 =?gb2312?B?VTJSa3dlRlZuSlNOK0dFY1BiRWhhNGUwa0xaaHUvQ01pTkFWM2xQUjBDNXBM?=
 =?gb2312?B?QkNtZ2RCT2E5aXZrTWdDUy9RTk9nYjJQbXFhelgxd1N4TUVsOU81ejl3M1ox?=
 =?gb2312?B?cjRCOXRvZkJKSE92SU1iSmlGbUtKOU03SWxVZXhDTXlRWFNMK2w2bUtheDZP?=
 =?gb2312?B?TXZzUHdZNVpFTVB2Wm9tQ2RyUmxEZzlpamo3NzFkRDlsU1p0REh1bFkwM3Zo?=
 =?gb2312?B?L1JxYjhIV0Y1MUlDazBWN2ZkUEV1TXFwMkVrUXorTHdrSWVyTUdKbk5Dcm9o?=
 =?gb2312?B?MFBOSVh2WDY1eTc1YWVIblVubisyVzZsVVJoM3pZanpjTkE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8293.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 05874e6a-c635-48a4-df8e-08de792d622f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 14:01:36.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17027

SGkgdGVhbSwKCkknbSB0cnlpbmcgdG8gdXNlIG11bHRpIGFnZW50cyB0byByZXZpZXcgY29kZSBv
ciBjb2RpbmcgaW4gYSBkaXN0cmlidXRlZCBzeXN0ZW0uIElmIEkgY2xvbmUgdGhlIHJlcG8gdG8g
bG9jYWwgZm9yIGVhY2ggdGFzaywgaXQnbGwgdGFrZSBsb25nIHRpbWUgZm9yIGEgbGFyZ2UgcmVw
bzsgYnV0IGlmIEkgc2hhcmUgdGhlIHJlcG8gd2l0aCBzaGFyZWQgZmlsZXN5c3RlbSwgdGhlIHJl
dmlld2VyIGFuZCBjb2RlciBtYXkgdXNlIGRpZmZlcmVudCBicmFuY2guCgpTbyBhcmUgdGhlcmUg
YW55IHN1Z2dlc3Rpb25zIG9uIHRoYXQ/CgoKLS0tLQpEYSAoS2xhdXMpLCBNYSAowu207ykgfCBA
azgyY24gfCBCZWlqaW5nLCBDaGluYQpGb3VuZGVyIG9mIFZvbGNhbm8vRmxhbWUsIFByaW5jaXBh
bCBFbmcuIEAgTnZpZGlhCg==
