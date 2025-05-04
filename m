Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F21A2622
	for <git@vger.kernel.org>; Sun,  4 May 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746367118; cv=fail; b=r4ljr+gLSVmnLIl4xzeFuoBFGI+Cnx7NvB2kuL9C0S4zcbFV58Et6bLWJMHfwr8M6F6YBt92pzxrKcA6EkKLk1AZWkMURSf0aOHMfrmTGl+QJPIJ0ULs/NFaV7MZXlQaBROAu8bYsBKw8I/cdaIkDQhQirFZr5KfPWojpkC1Wx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746367118; c=relaxed/simple;
	bh=KJhhmPYVRdz59Bt84l1MoLVdt8Keyxd+nCinpRBVO7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwjrrqlTOidWuAltW3MoUzQD1f5+aCXx/JaM33gdhFZClmmc2gEI7nW3q3zFQ5gT33z3rMdNYcPwgIrhm+aOa/HSXsF1XIJdkViUBi+WK8fduXpTl+lDySUUKm7rQ8S1/Nnf2wtBDfepd+rwqzLqzjeH6FeWfuT2q6iR5WBv0sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=iGkOZw8Q; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="iGkOZw8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krkvs2nhizYxK05cDmiwqQxiSu/73TZCOYelrUdE+4TK8WHdwJx75fjlnX7W05I7PKcXn+iQzcef5BnwtADJhnyjbU5wBvAohCujP+gS6krTRiLebpsfNI4u2hJLbiM5pi0DuiH2GMyiP5YfDvK0fC03qwYNHKoFUYNrY2/D0DE67zxND5I5Pcj0V+RoYIdCho3Y6SY+0Bcl79cY4wpl5wc8dIGftyJUHI1YakzDwjo80SdXVgbWybnR502AIuizQN1w2sktFiAOh4X1WgG38OgCVR2LnF5KNLY/0a7eLZUcN9vafI0fwYwgWrZWEnWsn5IpJxUMTVG5dCKRA4S6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKhFV19FvJ3O25+UnUg8wNIBqvrrST2WfPB/STYBR4o=;
 b=JEKtK4JzC38biTb/isJWmPkUEjpMsxWKf3eICauux6xaaIp8lEBY1xV6ewLb5hbl2sCNVzEW2Cr+OPUO4ViVkvhNTyk3cGE3ibW9mUWon5ZTHMVJ1TtGDDGgzAp31CORDiiV0304puhb0bX9SHqGqwdkWavYXrWc0etpAFE9UXUdj4s0cxkxx6BNvP4ezpyErHoRcfFEWTvJcI2lL4jsbGcvrmCrUyN9RPDC2k+liSuCIPlmNJTlyiojtIGwemLPfb1CMjQScL3jrGKS3TNUXPBlu2CZQ8bc0MCKmJxTjbX9J02wFDZnNgnTuWaax8R5Drdqqocb9r1g8pRR7/svLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKhFV19FvJ3O25+UnUg8wNIBqvrrST2WfPB/STYBR4o=;
 b=iGkOZw8QVBsNJUFOzzRxmKeY+MJlqIDM35/NZVYQkOhEmRcOEap0Z/yZqe6RkFC7rJrflcDC/3Us5RanCfAqoYVjaicFBmzFEW88zqak/GXaZlqhyFwwdT/FMBtnyrulY8WWJUS8QVhwVpeR67XywZBLv4PaanR+oKupJbxRFQUtZmQOP78U9d1vdXMc9lhHA5TcViSpZCjorwwQBulbNcXV+EybQJ427eUlVx9iuoq/hBznNmhGlRh2D2TN8IROKSBZDTzRowjVO0T8YgTyP2PTz+Hr4xYMTL/IT80yP+U53ozJ+U0oohpMyuO0Vrb9dpJYdKlpjXWrbsjd3w3Bdg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB8169.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Sun, 4 May
 2025 13:58:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Sun, 4 May 2025
 13:58:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>
Subject: [PATCH 1/3] send-mail: improve checks for valid_fqdn
Date: Sun,  4 May 2025 13:54:56 +0000
Message-ID:
 <PN3PR01MB95975D45B072101812714C72B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::20) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250504135816.6575-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNZPR01MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbf4a91-3713-4edf-22f4-08dd8b13bebc
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnKVp96vSozUuPaQRa9CUe6v0qJNA+HB2SafDKK4KhBawqAJgdrqY5jO9H+m1tctfoRgZ+Adn1yiLz03mCRCxwvi0jWCJpWU4M2VuEP0mSS/PyD0FiNKJrwpF8yi3700/D7rdoXVTqmC1gVbUShoVamD+mGx1ABWjFjbkDh9M0XlTu46HGi8A9HPWIOOUU2J9dezUIQvu4HVbTBudq02nSHYrhDTAI3S3PCObEaLsS1RIiI18sB63ns9bN+QK2m+uiF1u5RvJR7bQ7RfWeredea5H0zfCOpG9pONQ4ShxaHH5aQH64mEWLlH33Wp0PfBgfH96StXEmkrab7UawTv48/4EMA0GGdIALzeGIndrrNwzApeSSJLc9G2Afs3VYi3ugQ7rtWZDbbglO8fQyI4x9vWW1+DLVnHW0IdTDDL764fxBPFiW3YQJxDoMl0FK8lJvXqLF9/SmprgTSy+GNy3SjvktZEsu0pdoBTfGjjfKR5vKUy5hBn3bPcE6FQsZY+eevJLBm+WSa5UKi3L/eVAj/yOhVg/8xWrx5BKO0xaZk9zgJ0J5+0PtlfQH74hqzcSTCOLeF31sA4M5yML7Bq+kFz4l+cDxTTSfpDOnDe996of/qhuRjg4tVMrAKhPZ7UTBBc5m8/k0/zo7do0T1Z6FmFWtXrU8Jl3B8wuXHSMEVX50fLw73CPFX9hvfxC0bl7SuboTDAZFBTOyNyziSrvVx+OKFJhaazXHIt4XMvnRo8Y=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|15080799006|7092599003|461199028|10035399004|4302099013|3412199025|440099028|41001999003|19111999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lLu/P+M8mdz9mJ+ImQRg+aLyXt+hSBViLn76xFmKInnp59cU8AAMdyUVfm04?=
 =?us-ascii?Q?tXCMAkRa+Lzqi6iYw8/iDE9J+OcC5NNmz53tQmWPK+i5KgCdvw2bDU2aFhxm?=
 =?us-ascii?Q?UbVHD1XTmQqurn2FpcwTmgXJplsnB8OtAYOKR6Zn7GcDRZ0RjK+K5KBstwMF?=
 =?us-ascii?Q?uuqtw1CqZmcT0Egm8TOY4MTbFtgn/L8kqHry59EtLlnT1OoxxLlVRZmKPVAl?=
 =?us-ascii?Q?ZS97xumPE65u2FMGxvQCMQ0SbPkZV1rszQQ6n9OhWX/LocdKCcQu9Di+Dia+?=
 =?us-ascii?Q?BnDucB1aNmoXDJx6Xljj+bdAUsDmEX7pJWHwueTBnYhZPQ6KR5VT3sSx7P5S?=
 =?us-ascii?Q?VEZjIruH18A8axn1zRGYIKuEtifOGN0YMmiYWnrNuGDFGoVIpGhfDDYU6ZuU?=
 =?us-ascii?Q?0gn4gytnvYH6S0IMDzMmaicWfCaZZBdoaqxJpBX+XK2a36GJ4J06rBBn+ej4?=
 =?us-ascii?Q?fqPX0DcjJK+kC56xlqanOcvoiRZ5VbzmkeD0oGEjnsYEpuUsljxlOkzuFUm0?=
 =?us-ascii?Q?V05sVYUnGc+Uk+npjtpkUiNaiQQKtI6at7XZpLcIIQK96rJcUGCD5pUDDez4?=
 =?us-ascii?Q?Sr0ynr6sU0oMRstrQuQsv2ZhJN89CWzvC2qS6D9JLqt7p1jJezye5zCR0BAc?=
 =?us-ascii?Q?8VM2BtYYInJ+PSaky+rBSNqLJPBxcbkSDGem4oyiZnMrypm+HnXoV98Ped8l?=
 =?us-ascii?Q?S4csV9TUX3YwwjsxkG7q/yHVbu15AXgxLRtI7dSVbt461hrWdOVGKw8IBceV?=
 =?us-ascii?Q?JZGa5im4TT4Chh9jS/TYxLzPvOFrFflNglOXzpJ9P5s8BhwLKDnxyylGe717?=
 =?us-ascii?Q?i6tmqRROARMhIld4uLnXbxRNi+EruGpV32APdGzIxS59bY04TuvSuH58boSM?=
 =?us-ascii?Q?DC10spRU6lom3GSRF5uS6c0RI9+eBnXb/uKCp2fXaNXhFA8NOlShXWkyuxvj?=
 =?us-ascii?Q?bqLaL/2f/EscylTf4CbUYWLIaOuvdJ+G7quKdMP3SAeGysawzJcR7YH5a3gO?=
 =?us-ascii?Q?3m9GEEWwGLX8NABoBTnDNMs0PcRNNYvHI7ijkyFUgkD0+I3f/3Dbkx40W/aG?=
 =?us-ascii?Q?miA6qQpEiOGt6+cXfS4+3D8o9ylVsOTxUFeERn5VEyvEk+BYkwfkHjOGRIcq?=
 =?us-ascii?Q?xgTPST2kUAVrNTTeILDeBQYKNuhgEwnHXWiwzDPhw0wMYUp54qijNgiZlI52?=
 =?us-ascii?Q?CL8BotizBRGCu5pavscv90a5HcqM+yQgugkcs1nRkiXLordJOMW5vlcdWoVp?=
 =?us-ascii?Q?tD2By5wDzLDaRTlZudKkC+4v4Z6C1t+CvA0ZYx+g2Uld2LK24pYW2ZKS+q2k?=
 =?us-ascii?Q?zaT3bPrl1FcJMua/B7nfMVhPZy++X56B/eB+JyKYf2OMlQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?calFLeYmHgufBinop0rWrao2KLkWsRSzERu3b7GtVG4LS04Jg2bWW4TbdM8W?=
 =?us-ascii?Q?LUU+gVXKhCWFRST73VKFRwFfenWEuNjvIvUv+eajxWtmIF6aG55T36QgLiPC?=
 =?us-ascii?Q?vTCGgQnOaFiJVtg6XhvPnYTCkz6bpHMkARczqS3ygc1d5+kI5qNoW8YDgxC5?=
 =?us-ascii?Q?PVZvq/3jS7FWKBO/7vjtH08a43MRDCzfE5sBAFILsL7E6hPHfhFKpVQhxr17?=
 =?us-ascii?Q?paFcfeEAQHTKnNrxOVibipzxbdCO3C+T+p/n0oQ4lncdJ8qQzd7SJxXZq5VG?=
 =?us-ascii?Q?RnDCJwi2v6rRbW0Hq5P/7yYdqCd9ZytxtMjsF+1kiZ2QPIdNsurtq9eaTpAU?=
 =?us-ascii?Q?1CYSExhAw2OCQD4NwNrw4Gxrd8RhFGrDRw2NiLbogvuw9HdM33Rdy57jbdJZ?=
 =?us-ascii?Q?ebme2ytxenoGszC+vE12VXDFdntEaUtmff0dxYBD6yfYZg7M4Wof6WogtN4J?=
 =?us-ascii?Q?AGlFAJmReBu/T0RwSpq9mC2pwkssAqUeO988RFUii8jZG4zuiulAuOufEtHn?=
 =?us-ascii?Q?bi/oOQ5GsgwEe5PzmrFbMnUjkl1YXn/uzDDtzK6Nor5gzENmh++pHmJ1Eho+?=
 =?us-ascii?Q?AUsej50rsafR81H/KKW3ZVB1xJVmi6vWyxKpgF9vRucnsk3kDC+D/2iLU+3Y?=
 =?us-ascii?Q?ZEYGrwUXogLgnsqBjKi9qqvMff/fdIB4pPllkviMQu12DfPQRlddkJgXwUJu?=
 =?us-ascii?Q?Sy2ZsgA1zpxFe0lon/TX50t3/UFLzRow7pWK2S7Q6vyAae32nVh8bIq1X4gU?=
 =?us-ascii?Q?xAFs6tEh+XS+mFhbjHsHmH/FRZ2yzCI9U1Inkri2qvcV7jMPH3+bFAljlR0f?=
 =?us-ascii?Q?m59qv1JBheYNOkFrjA2RsezJh99C+FY5BscbwEuI7vRYZWSBCxPHwL6bO3Ac?=
 =?us-ascii?Q?8n/tVCzEu+zoB2STMApn/X6leFP+Xi06rSzHQVOFZJaHXmQwXKUFKlwipz0W?=
 =?us-ascii?Q?47zvk6vSDO+qD2r1r/QDIjR6RPBao/4EkAyZIrBVb46+t+ymEExbGwU+aAa+?=
 =?us-ascii?Q?ASW49u8/5x4ZlRifASiBJLGeNQ1ooNdiBNVh/y+S5xGwrhT4ZuTGcPWJb5Zb?=
 =?us-ascii?Q?L2hZFhr0T+L7FJo4nZoHGY2HAaBomcQZoaP7bfmWohg5ODp2DyUzoz7bMbJg?=
 =?us-ascii?Q?EDbSWM/r/1CtsnVJBOzAHT9AXixDiftHBoxpxI6Vn2Ob6qZzChEJIycziePR?=
 =?us-ascii?Q?o4CB6mbzXszeKWkiXkhn6uFsbOJxEcd2s8tdctIcPS5GVa5fsPkG8r+WhsE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbf4a91-3713-4edf-22f4-08dd8b13bebc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 13:58:27.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB8169

The current implementation of a valid Fully Qualified Domain Name
is not that strict. It just checks whether it has a dot (.) and
if using macOS, it should not end with .local. As per RFC1035[1],
from what I understood, the following checks need to be done:

- The domain must contain atleast one dot
- Each label (separated by dots) must be 1-63 characters long
- Labels must start and end with an alphanumeric character
- Labels can contain alphanumeric characters and hyphens

Here are some examples of valid and invalid labels:

'example.com',          # Valid
'sub.example.com',      # Valid
'my-domain.org',        # Valid
'localhost',            # Invalid (no dot)
'MacBook..',            # Invalid (double dots)
'-example.com',         # Invalid (starts with a hyphen)
'example-.com',         # Invalid (ends with a hyphen)
'example..com',         # Invalid (double dots)
'example',              # Invalid (no TLD)
'example.local',        # Invalid on macOS
'valid-domain.co.uk',   # Valid
'123.example.com',      # Valid
'example.com.',         # Invalid (trailing dot)
'toolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabel.com', # Invalid (label > 63 chars)

Due to current implementation, I was not able to send emails from
Ubuntu. Upon debugging, I found that the SMTP domain was coming out
to be "MacBook.." and was being considered as valid. As a result
the script was failing. The debug logs with the failed script are
below:

Net::SMTP>>> Net::SMTP(3.15)
Net::SMTP>>>   Net::Cmd(3.15)
Net::SMTP>>>     Exporter(5.77)
Net::SMTP>>>   IO::Socket::IP(0.4101)
Net::SMTP>>>     IO::Socket(1.52)
Net::SMTP>>>       IO::Handle(1.52)
Net::SMTP=GLOB(0x5db4351225f8)<<< 220 BMXPR01CA0083.outlook.office365.com Microsoft ESMTP MAIL Service ready at Sat, 26 Apr 2025 18:06:30 +0000 [08DD842467C8274D]
Net::SMTP=GLOB(0x5db4351225f8)>>> EHLO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name [BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM 2025-04-26T18:06:35.781Z 08DD842467C8274D]
Net::SMTP=GLOB(0x5db4351225f8)>>> HELO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name [BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM 2025-04-26T18:06:40.828Z 08DD842467C8274D]
Unable to initialize SMTP properly. Check config and use --smtp-debug. VALUES: server=smtp.office365.com encryption=tls hello=MacBook.. port=587 at ../git-send-email.perl line 1727.

With this patch, it was fixed and was being considered as an invalid
domain. Logs after this patch:

Net::SMTP>>> Net::SMTP(3.15)
Net::SMTP>>>   Net::Cmd(3.15)
Net::SMTP>>>     Exporter(5.77)
Net::SMTP>>>   IO::Socket::IP(0.4101)
Net::SMTP>>>     IO::Socket(1.52)
Net::SMTP>>>       IO::Handle(1.52)
Net::SMTP=GLOB(0x58c8af71e930)<<< 220 PN4P287CA0064.outlook.office365.com Microsoft ESMTP MAIL Service ready at Sat, 26 Apr 2025 18:08:13 +0000 [08DD84B323498C1A]
Net::SMTP=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-STARTTLS
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP=GLOB(0x58c8af71e930)>>> STARTTLS
Net::SMTP=GLOB(0x58c8af71e930)<<< 220 2.0.0 SMTP server ready
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-AUTH LOGIN XOAUTH2
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-AUTH LOGIN XOAUTH2
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> AUTH XOAUTH2 (OAuth2 access token removed for security)
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 235 2.7.0 Authentication successful

[1]: https://datatracker.ietf.org/doc/html/rfc1035
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4215f8f7e9..4c143e24bf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1359,7 +1359,8 @@ sub process_address_list {
 
 sub valid_fqdn {
 	my $domain = shift;
-	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/)
+		&& $domain  =~ /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.[A-Za-z0-9-]{1,63})+$/;
 }
 
 sub maildomain_net {
-- 
2.49.0

