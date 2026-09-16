Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013041.outbound.protection.outlook.com [52.103.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2885368D51
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538486; cv=fail; b=IEYsqBIt/GXEoCRhM8dRtG71TX3V0gruqR3w9vE8FrMZ+eAK8TKUHVNyGRWvttOxXbu1i9W2fWoBr41TR7lsY+iU7lQ+AgXY0VOFL0b7jTh1uXZdzV3H9hfS9nAstp2v7YAzXWpD3hhPx05Ld7ZkehrKq+Zko4QrpUPMUqSjmH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538486; c=relaxed/simple;
	bh=lA9+RV6drqeWlFUQKKSBybG/xbfFsguaUdc90iTQNyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQvSqqGpYAAm33JDnf9bFTRDb+4JCHFpxa+fam8WVMZ5yN0w2juW/GO+ud5vowANB8mGEbl5tvGcgBW0FxyZI+SPBXfbRLLVi/uyXjlbRGUfw7H0O/AqTvhD7kdC7R8LmVYiy4WBRPedynnPzDogPxSBLEFHu/WNS1fRWkMjddI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=JtNgev1C; arc=fail smtp.client-ip=52.103.14.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="JtNgev1C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFMqcbx4ujTSoY9UyCjnz6UsboCGTiF3dWakrP4T2Q6P6y0AXyAwzdSTizRBxjUMbek0Y5lJKVfgLD96bZaa4ww51rDqDDUHr1VACISEBUxPlU9YYRklCRWso2xcNTZFtEFGp+mV6OHRFDDd/fUjb/P1n8Z9J6JY+P8bVyoWR5MxUgPlHuyN+KbWCyExL2CMGRAy0FXB5Lz9JJJ5gH/802asq79SOW71Z2aPAY1qD+k/1skBve4BEXj6mvhbn3Sn+hb4a4yCsIiMP/VA1ypJ8p3Po3cIwNlhIUcKKnfnExcc7V+WmMqMO/Nvg+QitDYxQUSilCkiDVPZ8DwpjG0NBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA9+RV6drqeWlFUQKKSBybG/xbfFsguaUdc90iTQNyc=;
 b=jyzmdhcjtlcIqrilh2NX/z8L7CvpYZDpTXX33M6+v9KObcVcDEB79vQvfr7DBvBlBaHXEgiug1QPufkBng+Iyr5+WMi+ALKwX7JFQq++uQQRLTA9boE0wKFeMLyK740JW8lSlAkzMmAuicCp5Ni47vwewTvVjLC/y4Ww+O9k5tEheMq0tkRxivUCaXmt442CzKHNXP7xu8ky+RIrj0xreLJ9J2jnaWf43TfGZR093YqtB3nGHNt1KRDDgotieUzzKhP2Tc3RLiXn66ECTli+UnPJBBl2/8cHZJzaP78C4AAXv4GFKv5M7DahnB4rjlBMNUF3lfR5YfuAnHzVnm5tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA9+RV6drqeWlFUQKKSBybG/xbfFsguaUdc90iTQNyc=;
 b=JtNgev1CGtJJHEYrZmaTc5wT03hSyAgs4lmdG33fVbYM+l8aDhHJPkg+jTrKM3AnHtqZraQDkQu1pEhUB+Z26LcyCH1fSE1J1kMkHq7YJOFZbElBl7JHCLk09xGfGXBPxD19b5D6IfKCTAPfkhqBRZi84k+Mp51XzL///udekMxXPGo/Qa61QTQ64mGT8LoQ8/APHHNcjIiyBhDZs6RmRmQvL6I/bqS3Jet/g34RR+Wkmk2Xv9u8FYARo6FwHSClCLNbtcgRKtSZyWoZXR8XQXSQ/BA+rXH8FeKdwKnLSIWoKN0VQHIK2u5PuMemsom9WrD82tduAl3JFrzyWU9gZg==
Received: from PH0PR84MB2999.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:165::22)
 by SJ0PR84MB3221.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:449::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 06:01:21 +0000
Received: from PH0PR84MB2999.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c62e:27b1:edb8:1a2a]) by PH0PR84MB2999.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c62e:27b1:edb8:1a2a%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 06:01:21 +0000
From: Qin ShiCheng <qeesung@live.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <ttaylorr@openai.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] odb: don't remove a ".keep" we never installed
Date: Wed, 16 Sep 2026 14:01:14 +0800
Message-ID:
 <PH0PR84MB2999B0A3F2D64F46FC62E659DDB92@PH0PR84MB2999.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.5.22.ge710c7d180.bgit.1.11.0
In-Reply-To: <aql8Wt2q9RnQpjEC@jtobler--20250820-SHC54>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com> <932e8e425aecfbd33c1e5caf66c80a0226abacba.1789385483.git.gitgitgadget@gmail.com> <aql8Wt2q9RnQpjEC@jtobler--20250820-SHC54>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0026.apcprd04.prod.outlook.com
 (2603:1096:d10:25::17) To PH0PR84MB2999.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:165::22)
X-Microsoft-Original-Message-ID: <20260916060114.1225-1-qeesung@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB2999:EE_|SJ0PR84MB3221:EE_
X-MS-Office365-Filtering-Correlation-Id: a7463ebf-c97e-4af6-721b-08df13b7ee65
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|39105399006|4140399003|24021099003|22141099003|15080799012|23021999003|8060799015|5072599009|19110799012|12121999013|40105399003|12091999003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G+JfdD8IW0jG2T/15ToeB33acOG73N6oS09IwHn9Tiv1AjSh68WFr+zEaFld?=
 =?us-ascii?Q?SUw5HKQcKq79wxM2f6I+eAIqEOMuyaLZaIe4QxeTUD2Ivr5FQ1digAEPLsw+?=
 =?us-ascii?Q?70QJ5g2aO2sQ7uoVzcHlKUIGcCI0m77vhwGXsNhQRbNqp2VI0aAJN3UGhCVx?=
 =?us-ascii?Q?MxvxcVknkIE6uspKMKzumDBLUr/Qxftgr3NJpVoibREguo0WyRSb9ED8vExS?=
 =?us-ascii?Q?QNkLwrT98Z6xw+7sVYNNpUSaWfYzfgDdP+hLa4/t2aA8DWQRpe2wLThKzQ+K?=
 =?us-ascii?Q?i6nOzwiZTaaLyXLBTFJTv9L1VcoZlHzDvUu6e8ArIgOBv5kp7rTqqHZ4d2jg?=
 =?us-ascii?Q?01zLWk5ptbzV0Jxu8ualLoSs1KdVFNEnKu4GYMVvNdBDRvl9OLQaXgMF3Ff1?=
 =?us-ascii?Q?VttyZGmeDtqd95kDR+E5bsHxn1nEeUqtLZVgSB4Fm15mtb2TVJWlHID5wPhr?=
 =?us-ascii?Q?u9TrBkM57ZLAQ5rgDcw2IY448cVUv/4ZorhMy2yN4jwqU/R1IJr0L8io4+3+?=
 =?us-ascii?Q?vTLD3V+QhcQCGmi5WzI5QKtbcjENwI8WL3ZNZ7heVtKPYevbKZ7Lu00MdQyX?=
 =?us-ascii?Q?het9biNgTYO5T4eFCU6Nz7tESfu/nDTXLot6CVEpq0YmrD1gRry99aEZq2l5?=
 =?us-ascii?Q?o1RK9JSEvYUubnCKiwbw7RzEpUdiLangwjAOqWGvGDNiRhLRk9LY/XDqhYsF?=
 =?us-ascii?Q?vuO0/dXbxus3jeIFKoS+GlFpSUNNfjk7Zw5g/dWtEGkE/Zc/3KV8LEtFFCdZ?=
 =?us-ascii?Q?x2E2XxKkpS1fJ3k1XKhq1cUBBPeQQJ+BRPDgEZQqSKenq0gLxfGyKRjGXfGA?=
 =?us-ascii?Q?nL/u/LzW644DDGyyiIBsd/EbxXspkP4BH326RMO8Dgpluus/u8PL5dvzjs3I?=
 =?us-ascii?Q?RLghI+I07yolg76l1dK8wDa00CgHL0OzkdK3mMUAquToTIzm0sJu9ZEq78rL?=
 =?us-ascii?Q?WzS25aRNrbc7BUdWPox68Fks46LNhwjymkD5HcfC40JfLZhKfR2ylw+5RvUd?=
 =?us-ascii?Q?3Ad96hMjwZda5DQVZDHvr+4GLmMU6qlpQQKnEzjjO68r0Jk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6nRPgcm5+GU4fhvK4SypY3Q88xj8n/lxd9BUhmfREnGOCZUMCmvNYpDEEMVX?=
 =?us-ascii?Q?bXXtqyt/w3uK2nJodaKkKyRdnM/fKGqEdpWUxf/DPKr1wI5aKgYEYq70sY9N?=
 =?us-ascii?Q?4NU1pdi2AIKdCsOP7nvKfwvWIpC4PIW4U0ycuV3Ari1iwnanOIigMimjz/F+?=
 =?us-ascii?Q?iIoP47MGhtEgzmaXNykqN07Ywata5CnIizzl0vvAXJu0Yxh3zPWAYeczVVA0?=
 =?us-ascii?Q?GS1qaLuRLKQRrFda1kqC6PaMdofnD8eAPdpbGCkGu3Ku4H5d3sxcCEYWNcvV?=
 =?us-ascii?Q?+BPvMQ5AoI/J6RkfKNHA5zvhT2jtj0dx1P5Abd65HuyW6lwVHwiPNknXxM3F?=
 =?us-ascii?Q?FqMUZM7/YwLRbeZNeF00zQYiWaiJE7Q+31UHg+fTO3SF/QAT36SRyOyIh9R3?=
 =?us-ascii?Q?VA1Hs2zTleHd3j9418O/tX/c/xxWrS8+OX+Yo339sGbPLX79fkmnHEUatMej?=
 =?us-ascii?Q?1IVtKvb3uwkUtB7OuA+gPI0iBPcxAQk1W8VaAP0Ce7ZogBRgTYR0I5ffjUrX?=
 =?us-ascii?Q?qlq9Qf7kSol6Hc2Euumsetq+PC0q2N/xA6qpjPIwzND4ZEWbdFmbQB0iLfqt?=
 =?us-ascii?Q?t3OEVoZYG3bJbIQDcRLaLV7iFGEdAxTb6DJsGBBA2aXyIDqVHwoenhAHJMqA?=
 =?us-ascii?Q?8phXMPfs8SVXajxO7iJWnHQxOATea/A1lJN9/qaYz7m5rShzTf8Qwz7WVFmY?=
 =?us-ascii?Q?oTbppEHTww0dZSj+c75FPtL3hMsrsfx9SGU/Y/VPZ0kQlbeSGyzHV5Gv/qfO?=
 =?us-ascii?Q?GiGv7F14ymMwVt5qOPGxI/uBWiby8EwtpyIL9YVw0luv0Pbksi53hIRAhQfQ?=
 =?us-ascii?Q?DMCHSxV8slVEcyy7+E1yTWXy8+tyXMCuAmF440OdhK6ve+tdPZUKqHlkEt78?=
 =?us-ascii?Q?vliWzZjldiL7Uhp95oF+2EQkt9RBeTyzJKx6C1Cgk9eLKGTcdhSP7ZUqGg+y?=
 =?us-ascii?Q?kDone9xFvUNjajtvJUtFJmzHWh57CtPFp5zHMrTs4Z2O3QtgsS63fDOWqDKn?=
 =?us-ascii?Q?967z80IjDSN9pf0IkuQHEMjs8mldZLpbSm8wBokK23Iysgq8C4cZrVEzZRff?=
 =?us-ascii?Q?MLF+8Oh9E2rv2V/zlgO2u2SheAriwZRWR2CS6datnc8QF7wvH7rwTBnX+tFL?=
 =?us-ascii?Q?I3i0Zxxbp3EXBDBm9MGQpsxivJnCtmsW2E50WERPWs4I9lMenc4b2C69GX4z?=
 =?us-ascii?Q?5o1gaSlj/bqBNiKaEnoZSSnAOpRAK0NJOuM1YIUN7vSa6VFTy8YJRovPVxWj?=
 =?us-ascii?Q?tSjHitT49i22eeU80TsAk9R6JHNiuVxnviJMhw3BaFv1hMlRy1VF5/ivvdkQ?=
 =?us-ascii?Q?olA+OlwUe6t+ZyzsEIH/V8jgGzUZYQjVxjPaiwgN19pgpJDh2uIh5xvcAyIS?=
 =?us-ascii?Q?kOzM/kRwzs7XQJKUGFRhRiQQrRWq?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-4a72f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a7463ebf-c97e-4af6-721b-08df13b7ee65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB2999.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 06:01:21.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB3221

On 26/09/15 01:25PM, Justin Tobler wrote:
> Something worth noting, if there are two concurrent identical pushes,
> both will generate the same ".keep", but the keep message contained will
> differ. In such cases, when the quarantined files are migrated to the
> ODB, the ".keep" file that gets migrated first "wins" and the other push
> will fail because the competing ".keep" fails the collision check and
> consequently the push fails. I mention this because the current behavior
> for how Git handles concurrent identical pushes is to reject one of
> them. So if a process encounters an already existing ".keep" file in the
> main ODB, it may be sufficient to abort early anyways.

Agreed, aborting is fine there. The two pushes that bit us were seconds
apart rather than concurrent: the first had already finished and removed
its ".keep", so the second found nothing at that path and linked its own
".keep" onto the first push's pack. What the patch is after is narrower
than handling the collision: whatever happens on the way out, we should
only remove a ".keep" we created ourselves. Today finalize unlinks the
path unconditionally, even when pre-receive rejected the push and
nothing was migrated at all, which is what the first t5547 test pins.

> Right, registering the temporary ".keep" files doesn't really need to
> happen prior to the ODB transaction commit anyways. In fact, we could go
> a step further and stop using git-index-pack(1) to prematurely create
> ".keep" files altogether in favor of letting the commit phase of the ODB
> transaction create it explicitly.
[...]
> Completely unrelated to this bug as part of another series I'm working
> on locally, I've already have some patches that start creating ".keep"
> files explicitly during the ODB commit phase in the "files" backend. I
> would be happy to pick these patches out and send them upstream with
> some small adjustments to also fix the issue here in your first patch.
> Just let me know what you would perfer. :)

That is the better shape for it, please do. Creating the file at commit
time and registering it right there gives the two guarantees this patch
gets by reading the files back: nothing foreign is removed, and a signal
after our ".keep" is in place still cleans it up. (v1 registers before
the migration for the latter: the ".keep" is migrated first, and for a
duplicate of a large pack the migration then spends a while in
check_collision().) One case worth keeping in mind is a migration that
fails partway with our ".keep" already installed, e.g. the ".idx"
colliding because pack.indexVersion changed between the two pushes; the
second t5547 test covers that.

I will drop 1/6 from v2 so the series is only the repack side; 2/6-6/6
do not depend on it. Feel free to take the two t5547 tests if they are
of use to your series.

Thanks,
Qin
