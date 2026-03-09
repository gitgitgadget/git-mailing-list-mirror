Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010015.outbound.protection.outlook.com [52.103.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624519309C
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773021417; cv=fail; b=PAknG/1fL9GC7RCXAT2z1pOWTtNEPsq0oq1MpJwDHIlIXv8s4hrbf0Mo0j6KiFw5gYtWxz3u6OYvQ3C8NOw2+tsivJb2gVwLri0x7mFVm/ScPpf+1SVv9aOIKGEJk3Beewt8BuzuBvL+mabJ+Mn4WE4+9MlGbDMF1hyWLFgNJWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773021417; c=relaxed/simple;
	bh=RQwdNiWGxuL5VUnv67iIOyPHXR9HP49Dn7OYWCxChHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B5PMF0Ce6aWfCsH0x01AU8NZO66acE+2TwA19eiV3aFPVLx9A7Mm9yU2uyGTmkrsbYzdjjlo1Rk69KMYOkkEh9gciMXbijgDmzQBC3pIr5u8A520G55OaOkrH4Zl+lpQw3K1MZG4trRII2I4kJdVQ+LcBQWOtEfzUZ07S6J+Ak4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P7JhYVaa; arc=fail smtp.client-ip=52.103.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P7JhYVaa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCPU2Tm7ppz6QbROwVQmy2qnsI3lpSZJVI4TerVJ48pdR6FipR7KOeGwjpSFbYCL5d4rxe318hr0mOtxgUvSND7pfffkEVKcac0v9Ej67n4+lMqTKeC789wADlS2byAw0jeLUlXt6A2yj3oOa5hEeVr7DeWb1VPCLfUBsI+/g20a2MZlSBCGeygpy+OvenIiBDl2EDRXXo41BN5B8c6MAY9cUG2u+pUF0tZ7tI/s43I+HuzG0O/UInekQCCPJyFU4tw8JQbp8eYQD5tEZ5CtgQCeuRCPTwLKXHA0s2CIswNwz7glzfRKkTLwKBNQT41zKyH89+vfKuZMUeskTSNUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGEZjTfqkMDeZfBnDTrEK2sge+cJt30gs2sj2zHndbk=;
 b=zP9EqK3bhYE4hNPxrxEspQbWvpz8IfxcVi1WwFBjzetcUOcn5xRqbAbtZ1vbcnxDWDkb5r7h2idK286RLPDjJnNxBOYLlvLsw5tNrXHWQ8usLv44fZJYd2ZKyfm9Z1qWO+bJ5jJgC87rJTPl+aCSfwOPJXdBiuvUwdigrLAuFh5cWGW/RPYKUWjHWe4nRBVnJV/ivLtVQ+Xugagdiz2OtVcf2ZmF1Th4mSgs/DRirjcmYWRmXl89El1yDV7KiNTgd0nsxN/8wA2AC4ra+USRaDjxH4+Jwt5FwaLKLNO/gWy9Wa45WZRpf2npRYM8JpA22xfiXa58tBrP8Dd2ksOsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGEZjTfqkMDeZfBnDTrEK2sge+cJt30gs2sj2zHndbk=;
 b=P7JhYVaaaiwTc5iYnesyPFQJ4CSFPLSS64kvva8uRGQOuWcHa2GHhe/mW299ftKcIWiiUe3OADxxEtTN9PVAFtL3/ilaHE585qKy9gJOSjQyKQnr/N8FoYNAhZ22OXlfQxD+J5INufpDnECHWKShaVYM6YUnMAKtaNdGcGWRNFi+1gxukpMqzwG7u2p03bv3cke1OzfLCQ/vWgXXgSni1obE7brM8e99fbQgarh4tfhCCFtanbM32APRQoUjXAqsPgba/23/dN5K3MSMfxa37zuebrJv0ejizUfuwBGDDPUa1Hz5bgFwp0z73nhyC912YqlYr6NHuO1TDfc5RlDhjw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY3PPFD0A9997BF.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::4ae) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 01:56:51 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 01:56:51 +0000
Date: Mon, 9 Mar 2026 10:56:48 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] parseopt: extract subcommand handling from
 parse_options_step()
Message-ID:
 <SY0P300MB0801019DB36BC682AFDBF2C9CE79A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801422323C4C4185B9617A1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqq1phtao03.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1phtao03.fsf@gitster.g>
X-ClientProxiedBy: TY4P301CA0096.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::19) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <aa4o4DV494elvzjQ@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY3PPFD0A9997BF:EE_
X-MS-Office365-Filtering-Correlation-Id: b47d5dfe-b1ab-41ee-b50e-08de7d7f21d1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|51005399006|12121999013|23021999003|25031999004|8060799015|15080799012|6090799003|5072599009|461199028|19110799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z1U7MMmGHtWAAlypKEb+HUbYiZwDyo6/WLYc6lHkYe1eibmPEtuti/D2zwH5?=
 =?us-ascii?Q?lMD6x9NTSMm+lI2aCFecQZ3Xydsg8ULzsuH6IvT8zaTxl5MLCCx8vTKfDym+?=
 =?us-ascii?Q?dWyeodN1EVzyAeTkvSZ7bJg/pMnFOTLKdspp0XrxQ1MBrnxNcnXji7a5nomu?=
 =?us-ascii?Q?TkkOiBqHNvwWfBac1u9k1uaMuWu0qXgealQ9qjerdKKGxwcYozjNTps7nBfF?=
 =?us-ascii?Q?GJtICrzx8F0qlKlvdcN+wk8bezsn9nEtnTBSNRdlrUunAGK/+D3+U8v/mwC0?=
 =?us-ascii?Q?oxhdM7uU7npHh+kv7W3XljThFa7t+GMgVgiGBEGRXZR/6R/EXITc5XsrCaef?=
 =?us-ascii?Q?vDogF6CQkXgY96J9tP2GTu+8ACZpU3+w/RQyZYzliMQIWnmygyjvbPZKsp3Z?=
 =?us-ascii?Q?ijUtNdh3CLWQ+wlA0hbMV1wjRzE4cDjOwIxGlohf4FijnBM6IDg+5gT30SCH?=
 =?us-ascii?Q?kolwZGFtOHWB/Dx4M9dgkmDvp3jmVbKMKyxjdWTuJmK/VtTTJy7OR5z/8sgz?=
 =?us-ascii?Q?2tcjD4W76+XJvLLD+jhNF43HVlYmWY7YyMEjJlZdbVqCFQtFnwOE7/EL/EHe?=
 =?us-ascii?Q?EyRMQUPJjB3xBWUj/ws4He0BPw4f9/iRk27FRMVlyoijiF7Qqvku7RZNvsCX?=
 =?us-ascii?Q?Imf7sXyf2GTwshWTE2UgE1aB8GIEC0Q3eAvQsECjD+vmgPsi1vzz1msRyPfH?=
 =?us-ascii?Q?fxs71roZ+TLIA/3Ay9p0/D9p33m18NQW75E0hxxEdKOdEaKRF2+5nkLhTMtv?=
 =?us-ascii?Q?x+p5dtLhM6gI/9PTVuRjhMEtL49DCr2K+Gv8BEkRaTwZ71wby9xgYvBGdPaw?=
 =?us-ascii?Q?TcGWyajP020FYo4s6g2aqkE+h68xk/qd5732YFRUvxpXrEedfin3rVvo/J2q?=
 =?us-ascii?Q?gjxrOLt9/VQEYryL9l74raA9QYEsD3kpfHnJhJMYhn2UZ7ZqLKHIM2XBXA6C?=
 =?us-ascii?Q?6O0pMwYn7rZTeUX5mqvc8+PjyDzSmmV/at10cORlUBZaBR2DQH6KN/HWqsZP?=
 =?us-ascii?Q?xDKk/ufujN5k6pqsJ9jYVGQnE65X6ZT1YwYr82VXufdiCKc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XlQU92QbA379N4kHXQKhC1j2ZtqbImQ94DaCql8Dv79+K87Nk23WQyeZvb4K?=
 =?us-ascii?Q?C+u+J0KNHTqMsq6nULeeGWkMqAzoPSj5kpLG0Qdrr44hPOfvLIxXJAkwUROe?=
 =?us-ascii?Q?XrZi5kE2HxhhfO3biK5AfA0lEePfUR9j1nCtclezK2bw615qjCKWGDnsywUo?=
 =?us-ascii?Q?SbiY9srmCp8SmbGYhAToyIomfmOzkWFjI/Sqafz/7xQID7S8oFheHQHaYFp3?=
 =?us-ascii?Q?0SLr89eMAu4EqvNWuaJ60ecyBw0tvjhaK6bsNBb3/V9jqDALq8U4W+GUqlRH?=
 =?us-ascii?Q?dbPVVPqaOYG1a8KEO3Jau3HnSK0/R6tPgp2BXOnohmJPpYqzXVTvj0AfpO5L?=
 =?us-ascii?Q?dCw5G1Q7YdHduv39PFRJSIBoyA1Ls33tsotmPPZZ+u5mSAjumkQhQJdErV13?=
 =?us-ascii?Q?fnSccQITimCybT6bBa3m1way3waaYEdRY756axJK7UTdStOMSaV8fwtGAt8+?=
 =?us-ascii?Q?wLDhdvzAM6BqEOeDvjYPIW1a70CTFR1PshlNVgLysxUw9q0AFBWxTdmYUR5w?=
 =?us-ascii?Q?ZT9xsu+q4FKf4raEN++NOrbC78nhTUE4zzQLiKRLXptM5FpFZgkYyunkJXVV?=
 =?us-ascii?Q?TI8MeVAxz/SNsG5u25LkpdxyOEBLUTWPBKBZHOKP/4n/k5xSbbyHFGZu178l?=
 =?us-ascii?Q?VZ2S9wQqus5iIScEJjPwSmnM7GEoHM3vpkTEq0Nh/q2IsccngMOgXmoolGWo?=
 =?us-ascii?Q?2JU1Mv/SWpxpY83lQSnp7F3XMJy6QaxGjoMpNXvjUW/63uK7vnomYGybozGr?=
 =?us-ascii?Q?O2uV/oEa/shKnzWFhg/1Lm70WNlq4+UmwtH3Z5BSLRtf8xuFVYpV9tgj0YaT?=
 =?us-ascii?Q?TQRFePgfxZsKPswe3hNZZpY3Hp5wcDSj6L26OfKGMqdEKrZt4YQ4m6IkUrmX?=
 =?us-ascii?Q?MhhBbuWVIUjClh0M1VIRMZsGz36jAad7qMB1mPqUIK5iVhtsyhGPb4ykZLRu?=
 =?us-ascii?Q?2SfpzIGBwZJisPpAfzTpqLIQJTzqcPS9Y8hGrjpYv7+r3fjSilaqq58JOItE?=
 =?us-ascii?Q?ba4Bw11LPd/ti0TkKZRKrsSrBWu5quwazh5+fvNgYDBMd5oieAD+/7KHT5IH?=
 =?us-ascii?Q?7jitUhX/FSGp6ghr8HFDL3HFzTipIbpMXJ+h0ufBDjxAkYqAokeZXXDAvD85?=
 =?us-ascii?Q?JWms7MprsfD0diIzC5k5VVhoxI8rPNGOr4zT7x/qeTWzoo4K9/Jjl55l8dyQ?=
 =?us-ascii?Q?qtylBPAdEYGnxgLBwSvz7DTOt9EjaYHBysE/VHtF2HGbolQsITnqdu1SvGNi?=
 =?us-ascii?Q?p1nlbJX9lvKfpQntVE9ZGZpp1z1sco4UOpSF6ixFKCOt7Ub9JTPTMM9Udvol?=
 =?us-ascii?Q?W3RC8NCurmVuNl0J7OuvC13DPO9wdn748I47WeS1p/ajHTytwtOqUOSWc9Or?=
 =?us-ascii?Q?6lKEI3jY9NX695ZyL4LKDuG288E0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47d5dfe-b1ab-41ee-b50e-08de7d7f21d1
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 01:56:51.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPFD0A9997BF

On Sun, Mar 08, 2026 at 04:40:44PM -0700, Junio C Hamano wrote:
> ... here.  Move the variable definition up in the block introduced
> by the for(;;) statement, perhaps?
> 
> > +		*opt_val = options->subcommand_fn;
> > +
> > +		return 0;
> > +	}

Agree. Actually, I forgot to check the CodingGuidelines.  Will fix the
coding style issue in v3.

> Editing the hunk to only show the postimage shows us that the blank
> line at the end of the "if ()" block is funny.  Drop it.  Or even
> better, as the block either returns or continues anyway, lose the
> "else" block, perhaps?  Which will make the above read like so:
> 
> 			if (!ctx->has_subcommands) {
> 				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
>                                 	return PARSE_OPT_NON_OPTION;
> 				ctx->out[ctx->cpidx++] = ctx->argv[0];
> 				continue;
> 			}
> 
>                         return has_subcommands(ctx, arg, options, usagestr);
> 
> or swapping the logic the other way around, i.e.,
> 
> 			if (ctx->has_subcommands)
> 				return has_subcommands(ctx, arg,
> 						       options, usagestr);
> 
>                         if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
>                                 return PARSE_OPT_NON_OPTION;
> 
>                         ctx->out[ctx->cpidx++] = ctx->argv[0];
>                         continue;
> 
> may make the result even easier to read, perhaps?

Swapping the logic works better here. Returning early in the
ctx->has_subcommands path lets the rest of the block assume
!ctx->has_subcommands, so the extra check can go away. That makes
the code easier to read. Will do that.

-- 
Jiamu Sun <39@barroit.sh>
