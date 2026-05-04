Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BA3A6B6A
	for <git@vger.kernel.org>; Mon,  4 May 2026 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894615; cv=fail; b=NguQJmxDevW+6QKJbCZSmqv2zYPaJRM1iDlayD9MtBvKFHkoXAKACt5sdJAaghed3+Ce5jfWCo5gBl1HKjftcYmPq2yQR5FVC7DLchm9/adYG6IXsVzKV5ZJ2ti1OFhHVJq52DHqrBCM+v2ZyVwaWajh6SBxC5HgumHnchgrNeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894615; c=relaxed/simple;
	bh=Z4PiVrzaGFNDnmzSMoYzDLGvvLG8jdo55il7wqit0qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=k9b2TfcfexiBme5i/RTsZK8WdDS61OWljS5OXvqYqNUfUyQpVRwNtgXA0dWsCD+rT/q2PTTgYg8RvL2ChFnMjh1zaiKVBFa4o5NLdiyRk39oQMMnnub2ZqEw43XdrS4iOkodzKpu4zOKVAu170o04KqHm8tUmwQDVR8escpZWhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=DAZQVEGl; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="DAZQVEGl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC7rUh4G5KsBxYd3M5e1VeX/n7cLRiBu3uYOVXQRXvhR5yUPbBnjITmH9iopohiUJuEfi9LGFAPngYa8GxI1Q5NI9PHfedUlbKattiOdHngop+aGDyZQHvQO9pROkGwc2d6wvFBN5Y9xsqenJP5rXBnHuUtgGhDa2GyS5/iBs7Pn8fGxTpwYKS9C/iwl8Ha8LW/JRk/H8TIOnW48sZpeyaG69CDD6e0aPjHRGUFb/q4zswoNvQ/O5K1L8tLGO/xyllFMfgaUhtULXsDDoZ5CSnpOXbpY/0Kf1FQ2mMcwLlEtoSa547bhHkkEXWNNUzToDjUba0tpbAYSk/mEKaNOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVXZyfZ47a7bPWOXzPCGW7UwroJpSZJKXcPP8m8v5W0=;
 b=W16bLBTMV93Z11xEXTpwmtq/Ln30pnmjAYu7uc8N5stxlEoy580aGeOdgjBnPLfa0LWRIFXe/W2m5JuDrteQLz42tAafh2n8GcpG2LErjMm5R+MDbS5hucb79N+jNwY1uW7RtKh+UyYF0SosoV32ZyEwXop5KI9q6kFjCADUCsA+EKIjsswS5xFX2vko89SZDm75xfHxz+YlwUDcQ3effYseCY3Rq+G0Ds9dLOseBCsxK5hKSWRCK/nLTlr7DNmfJIO0NYtxH2F8fHvfSWGUbPlxZHB2kA371nk8EW/+7YivHXGq9T05SS6JNyz8dYHMBDG/0mnM4BlPtKV2Yz+yKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVXZyfZ47a7bPWOXzPCGW7UwroJpSZJKXcPP8m8v5W0=;
 b=DAZQVEGlz5IRKKK2yy+inK+I3sjfNowzytTrJ96ox5kOVUcmMJjbB3NTabyNyWvmqFWN3M8/RnSNW3nZbkOOV0ZvwxKlb9OH/4AbgKYmkXj7h98P7JCO/svDSN02x6gLKqR2AC9E5IyMNBhieHyeK1OTkXPQXU+W+w7U8P5LXIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by FRWPR10MB9461.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 11:36:47 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 11:36:47 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  emkan@prevas.dk
Subject: Re: git clone with --dissociate sometimes fails to check out target
 commit
In-Reply-To: <20260504095110.GA599780@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 4 May 2026 05:51:10 -0400")
References: <87h5onsi0f.fsf@prevas.dk>
	<20260504095110.GA599780@coredump.intra.peff.net>
Date: Mon, 04 May 2026 13:36:46 +0200
Message-ID: <874ikns8xd.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CPBP307CA0021.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|FRWPR10MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f31a87-15cf-4521-9939-08dea9d16ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NgF8wDYRumX0h8TDGUtjY60txOMyHL5rJOzB2KCpu7VNUJ6zwtDDyrW+v7cCU7u2dkScELLi5TjKDAjLhXK5O9/6Oy9iNq15obhcOUOjS8KnubVssVAm3l74RPaxf90vWPDLte+QSCL1JiuQhwfAgHksXOri91j6mbEB9HsYDZdR9qL3c+dpGbZ3VOIrO+AoBrlTPSjKROV3Fwt9B7Ql7NfnPw2zGxTbsJbiW1IAeX3Up7kXFj60x6Z3eMoExpOsWf/X69PfIu04LlYoo1l+PM9UGSVqh/Lp2oeEi0/Rbn93vZeg1LeBiaDNFfV7pQ/IKG1WBGdj4ysZZokt6iFMrmLsyC+6TZ1tid9Y66DIOnrENe8Fc1fSsohLD2OhVbtphJbZx2h0+MiThksoc5Aye+lnokkY1Kati9V1p4T7jd9GzCaWSEbSETJC29DphCMBp9V/VVrZoDPbfkqDXQmSaTgW0K+Mue3XHZ+l5SADmPWfJGR+GOUG0teJwJRm9uBw1aRMUtAU0unsRyWo4UmokIRr8A8BLbAC1VnQQ607BfYBHXUi/TgmCrPdKn0jDEzlY3QpyckqaXV/te2YDoISq/TYqKB/4RCO6+TqyUcCMBr7UzMlakR8jC6cM6l/qDLKJvOG7kyLeinugtt60w/WYOjC2IUGW5+Pd7M3zRgtF1KPY/i0a0vp7gDTs1+TmdWH2PMGBaE4AKNaosz/YyFT7pipTbGjX2xeq1jCN+YKlq5cBH/v7yrGnbZv8LzZ/Nub
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFBSR1pDV0pqd2s5ZGZVYjJlRkN6VmoxRjFjMVhhb3VUancwL3NSUzJQb2hn?=
 =?utf-8?B?bTBWQ0ZyN25yVXBrU3dsamFLSzJOWFdOK3hXb0ltbTJJclIrSGp0UHBFb1pD?=
 =?utf-8?B?aVBDMWk0T0t1aG9DdmU1N2YvWXl4NFhXRmFiOEtjZmt0WW12KzlYZFZSZS9z?=
 =?utf-8?B?MkZxWTcwWDhGVGJqUHpTckNIRitzTTdQRmluK2o2NXNBdnVxWUJUVnE2eHEy?=
 =?utf-8?B?MW51NXVsUUw1QUlHWGtKcHhWUVovcXJ0K0R5bm81cWYzeHFyYUYxRTJHVTJx?=
 =?utf-8?B?WU1tTkhyalRHMnczOW1qV01SOFlMSW9VOGttUHJWU05UUmMyeDkyQnBwYW9h?=
 =?utf-8?B?dWZ0RXF5NFhOTGVTNzRBWVdLYXp2SmkwenN5eWxWdTlZejJDQVRTemJkNFh6?=
 =?utf-8?B?a24vTW9vYS91VWpsbmsvdEd1V3ZBSktPMUJnYXVYeWxYWG01ZGJVVzBZN0Mw?=
 =?utf-8?B?c0lwVzhoVlovZFZuR0lmYUlVN3p4QWloMmJRVTRydEdLWDkveEsybGk5eHgy?=
 =?utf-8?B?eFlDbUEzWFA0QlA4NHBtbmFVOU16RWo2UWNaODF4QkppMnZJMXN6MGdyd0Fw?=
 =?utf-8?B?YVhxNEZrQzhyM1ppSCt2bGhuZEgyTXZqZjA4eXlNRDVZdFNDd2pWcVMxWjlh?=
 =?utf-8?B?U016dDJ1RG5SMVBCbFVoeTZOSDVma016MlZEOTRsNUNvZEVqakUyWmtRQ0p0?=
 =?utf-8?B?Rm1uekVoYjl6WHlOM29aSXNDakdoN251ZUtNcS8vcEZyeldZS2NnVitEaHNQ?=
 =?utf-8?B?TkVGdmVWQXFONkVqb0JWMTROUTZ2VE16VW4zTjgxZkNZTG1FSlRNbm5Idmh2?=
 =?utf-8?B?QTZYU2xTYXNkSzdqcFp0R29kcCt1VE1jSlpOYTF3M3VoS0cvd3AzUUtVc0E0?=
 =?utf-8?B?SlBQNXJ2TzRrbXZISCsrKzNmSFk5R3pOTXcycWZvMzc3YzM1Qjk4bTFsR01l?=
 =?utf-8?B?dnZZT2JWU2FYNkxWSlZ2ajJYNzRITSt0OWo0VXpBSm1ITU04YVdsb3ZRbmh2?=
 =?utf-8?B?UDVYYkZmS1E5U2MySHdqZ1JmUktpSUQyMnl0SlVscWJoOC85K1Y4cmxzUW0v?=
 =?utf-8?B?MVNUVTZlOVVlY0JNcnlZQ1pEUm9RZ3ZHY2oyRFFsQ0pDdnpzMTdTZ0x2TS9D?=
 =?utf-8?B?aHNvUnRrOWlnMWV3RmZHRmlEdWtWZGRmTVQrSFpuYi9hMlFhWnBpVytJOThJ?=
 =?utf-8?B?M1VnMlZxQXpFcncwRDU0SkN6dGtGdjVQY1F3T0pvWHlidk5paXBmZTVFQmpR?=
 =?utf-8?B?aW9CdVpQY2xFVHJyMnQxdmZpZDRVVHNGK3NDUkNNbEluT2RQOXVuQi8wbkQy?=
 =?utf-8?B?Q2FQUFV1UXZraVYydHB2NFRSVUZnTCtqNldlc0VBUHBscWl5MCt0a3lIWm1t?=
 =?utf-8?B?T3hvelFCWG1hbGFaSDI1cGVWK2NDMGtNakNXREgzWC9TR0Q3dnhPd2V2Zjhq?=
 =?utf-8?B?bXd4UVRJcXBvOVVRWk0zWEpoeDF0alhYTW12NWpFM0JDWExKc3hwK2RCZnJz?=
 =?utf-8?B?TzdNZWk0b0VNOS9iVVRsSTVNbEkrSXhPanBiZUVzLzVibVZIQ2RXWk5VbGlm?=
 =?utf-8?B?MG9rMUcyK0ZZaXZXZTRUNlM0bWk2R3AwL0ZZUDRkL0NmS3JDUHFwTjV6QTI0?=
 =?utf-8?B?M0lmKyszV2hYVWZ5dVhCZHhOdmo3VSs5K3BrS3ZoOUJoNXk1Q1BVMWtKNUN4?=
 =?utf-8?B?SWRlNmVxTXp4S2FwdW55RDMxYklHNUtCYTBIeWI3YkxHT2NwdDFESlB3dWhj?=
 =?utf-8?B?UlBsU0Q5dlBOeDE3T2ZxdjkzcWVKbEcyYjFpZ0VwM3Y4cU9TU2NPVlQ5RmVZ?=
 =?utf-8?B?OEZQT3RpOFRMTUtVejg4RDhJL09MdnlPK3E2SzFISHpKS1EybFd1aG1tZ0lO?=
 =?utf-8?B?bGJhVnMxa1RyUFI0VE0xbVlvU3hmanh1ZkFFT0xLTUl6MkJLRDhEczlpSzRq?=
 =?utf-8?B?UDVQQ0JnaTNmZnNIblp3WFJIc2txRW9SOG1xVklUaUViRzBTcit6blk0SXcx?=
 =?utf-8?B?WGxuYnZUV1ZoZmpHQ3ZlTzhFVGhLTzk3TEpCaHdpS1A5ejJmdmJpeExYcFhw?=
 =?utf-8?B?MWhlZmx2eGZEa0w4K2F2aVA5RDBqYktUbVVpMXZvdUhyNTVHU0c5d2xMa0FX?=
 =?utf-8?B?MFlJYWRhT3ZPdWllSUV5QVgvMkpYdlRSamlZMXRxb2tNcGJHNzFoNW5QWE05?=
 =?utf-8?B?QUVkKzFZMEwzbzBnVklmTnVKeUhDVFhIbmRLRS9XMTFUZjMwVzVhZUExc2I5?=
 =?utf-8?B?UmZmR1JFc3pJWHZEdHFreVJwdS8xcUpKV2txeFBsdFRQWHlTVllpRm85TFlY?=
 =?utf-8?B?S210aC8wOE4wTUh0VC92S2pvZXBDSFgxU2VpVGlkamY2VEFCdkY4WEZCd1JW?=
 =?utf-8?Q?YRukdfp2pNkaREuM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f31a87-15cf-4521-9939-08dea9d16ce3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 11:36:47.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFXhrxwPFcCUQA3QgyyxdG6JM65v4Ir4JcJSKiu1xr0vC3X+N1J2RZSjS2TWM38uvXsEcn4qgroXAHQ32Y6Xh6/T5FgJA1nU0sVOmh6Hk+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9461

On Mon, May 04 2026, Jeff King <peff@peff.net> wrote:

> On Mon, May 04, 2026 at 10:20:32AM +0200, Rasmus Villemoes wrote:
>
>> Are we using --dissociate wrongly, or are we perhaps not maintaining
>> those local mirror repos properly? They are essentially just created
>> with 'git clone --mirror', with 'git remote update' run periodically.
>>=20
>> Naively, I'd expect the effects of --dissociate to only happen after
>> everything else the clone command does has been done, but it seems that
>> the ties to the reference repo are cut too soon.
>
> No, you're using it correctly. The dissociate step should copy all of
> the shared objects into the new repo, so it shouldn't matter whether we
> do it before or after checkout. The objects are there either way.
>
[snip]
>
> It's kind of ugly, but I think may be the least-bad solution. See that
> earlier thread for more discussion of alternatives.
>
> In the meantime, doing your dissociate clone with:
>
>   git -c core.commitGraph=3Dfalse clone ...
>
> should work around the problem.

Thanks for the extremely fast reply, analysis, patch and workaround!

I can confirm that the commit graph disabling workaround works on both
the Debian and Arch machines.

I can also confirm that the patch applied on top of v2.54.0 works,
although the build does throw this warning:

commit.c: In function =E2=80=98get_commit_tree_oid=E2=80=99:               =
                                                                           =
                                                                           =
    =20
commit.c:481:66: warning: passing argument 2 of =E2=80=98repo_get_commit_tr=
ee=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer target =
type [-Wdiscarded-qualifiers]                                              =
                    =20
  481 |         struct tree *tree =3D repo_get_commit_tree(the_repository, =
commit);                                                                   =
                                                                 =20
      |                                                                  ^~=
~~~~                                                                       =
                                                               =20
commit.c:459:50: note: expected =E2=80=98struct commit *=E2=80=99 but argum=
ent is of type =E2=80=98const struct commit *=E2=80=99                     =
                                                                           =
                    =20
  459 |                                   struct commit *commit)           =
                                                                           =
                                                               =20
      |                                   ~~~~~~~~~~~~~~~^~~~~~            =
                                             =20

Thanks again,
Rasmus
