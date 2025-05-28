Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D928C2A9
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452709; cv=fail; b=Z/kbYooxvf7BUlcPvuJNgZ/gScLCQ+3eo0LfNZ3Rm1yAd/J5XUCZcTxSO2pLYrGGKZGqEQWghfOMaxyJtq2t9ZJGvhTlF4ZTOvKwZy9gxtuL3rnhGDVnAc3k6ofGu6utGqRfhWoXXaZd9aTLuzloHTPqzwKDWZnJK0e/7E8juec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452709; c=relaxed/simple;
	bh=vbScbAVy4P92yht1kfvSc2VUghUio357qE5P5wmNVgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBHfxr1mNTvrZNc13usS0PCr0N+BwWfX+leqtC8DSw9vSwjkiDsj9KJH0lBKE2PaLi6u+3sYtuu/5fcdedc8bRqNb9XpPUm/B3SkJLlELZkbviN7Q7e4LHJnWiwMRe5QABIuyGh8CObjfF7uB5Ioelm0WBH7cITG9S7YI4AWWWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UL2g2Bdl; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UL2g2Bdl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKTw2jPljY+vWJ0XXWcB95yQkEOCJDT+szYf9BEwzl6/SAkhB6i5F65qDbBAn9VqETiqLtMS6P3V8l/cep7cf1UkDRFQRYqK3hGFsB62bU+kkkqxJeOnrZAjz6vS/DP7WSKM4CzfN1k0+etOoqZ/A8Dblv7OCy6yah24NgxDSs+DNu7kfOxyxaztksutEL1Aga77W4m8R5DmlQBRJ2NLwmdjD9kj6fY2UnajF8f3mCI3tBTsWz2f/uwrFOGos/SpSrNhnwlYzB6g4mhexwyq9Wt5NN4Pc0rHGuy8KpdsiXcVI7ylEr9jLYCAhaf3wt8xzjniJ+tTaQ6T00b2Zrd+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL4Tan9JC5wDBxDcHyDZ8sDFO6DcIO+rjruX3i+Js0I=;
 b=vDSFiLXOXp25Nv4og66krA2Rv7G+8zA88jusCZzN61a7piY43VMHkL+F5+pfEM9DB+CEU3U/hv9mW0OhrO6efNDYGw3Cp+WQPo98ARlWJnanNeL+OnqGpMcomchGtDvlxQyyP+R5lZR921EHEMkepWf+4zsF1YiHjTJaLAloMhZbXpUf84JIkRnCiELRmw6sEXQXAL3zkBJYpqiOtGusY4wfHxALJbZsxiTfn6vqs7WgH29I78sNYbXDB5yDRxomOySPxI74utaDlvCN9DVWYldLIJKXOX5ytiY7nGZKS3ap9kqP6dRDLNOCNAPru8fqnVlnNWIq6RvRuB5VPjHpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL4Tan9JC5wDBxDcHyDZ8sDFO6DcIO+rjruX3i+Js0I=;
 b=UL2g2BdlDU8etOWcDzR1Ir8dEp7X4Aq9ZomZVnVqw9Hdo1g5gIkkeMhs17xJGBoUDnJuy02NqJvkEdyIYqFwOyvQSdS5VSzdn/eB1rsDVnjsNI3rdxs3BQwTteU/oieSfWTSnnAqbZqwclyGfMklzB5H0Q6jtnNQa+StfAH4Z9DYjn2swFFJtrGjDh4y/jDDUTs/daAoMshAj/egWEoisCrYwhm7kYMNFD7mysKFFX7QdNzma5jiN18CF/4D3HJITYFbB3WgYMTofymwxmFQMD2sHjsXeSCFcJyHlbjDLO11dXg7Io7UlYnYhtM9roIxQL3Us6iJ8sCQivJLGXgLfg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:21 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:21 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 0/9] imap-send: make it usable again and add OAuth2.0 support
Date: Wed, 28 May 2025 22:47:46 +0530
Message-ID:
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdaee5b-5b7a-4b23-f04e-08dd9e0ba4ed
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReFQO+5d6ofa7WPjBVpSbrYurJFyfEXIzTOYhAWLLX8FqUc6QTxvsxxL/ThNGrupkynfYZWMYlBTgV4JIMv4WUkoXayrHcoj8Te7TVoWtptTJ3Sb1C7PUzJ7KAFWTOWK+mP4zFqVbYTDyBzr94ZwF8sb+1TGAnMw8ZG3NbajAZhz6ABhPYehm2SSqK6JiKj1h9HRwY2vr7vZyJ/0PBGzJU8y+J/7EZKvz/pAX+LbUADLXIKhScBi0WrZBZU/KgztqoA2X2N1ouselbOAIZ0ksTth6in6WqJjKu5/k6cbqVAdm6FZVIQMCHZdrpjH19e1lpg+RBsj5f2hE8DXttb+2W2vGj2e64nTV3+coGOzw6k8FTBszg5yRMIFrdmnh1+MwfYQ/lSugEgpG7LQgRDmNhFOyR6SaFRYTclkJ/eCtmB84l6kDd6osRwWCCewSkfbTPCYEaXxY2WCSdn4C4VT1gdueVSI00m6WcEec5MXwJsznO1im6FpA9Gcm1TlDRt3/lAzSgQmpZHFrNR6oMoge3pX+eOVExwfjNkuhD/VSPg890hwlKAqA8tZ0i3RMhhRkxX2OXp7ccc27kJJmZPJkTxIoA0yr8pQBmGwQiqXNPCiEeKYWOnfge89miZCnraHHw77uSmcu2gHuT5SafQZ6c8I7ruGg2SquuQcmWacm9Ks7YsLaLt8zOHS8RdGDma8YU83ObyjQ2lq6CbLc0WxoyJjj3GNCA+HeM97r95NQ5fZv3wjcbdm+QLyZsskUVdyQzFk6W4lYpbcoY92+Vkp2VP3DOkaejYU6Fl2nFZUB7ACxw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|12121999007|41001999006|5072599009|461199028|3412199025|440099028|12091999003|19111999003|4302099013|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQV+em/e59gak2bX5dMAUiBCyd/TWQ/Vfb2+xMXQR6QEnbn2q5OyUj1ch7n5?=
 =?us-ascii?Q?AH4n6MYI04N/FKzJX1eG3YBbRVLOGk9RdlQKsaiieJkajhATRLvFmLiSefY3?=
 =?us-ascii?Q?QOeQLjFylHRMiFYYwNJiUFcsrVCt+ajhs7PlaXVH6HxjxlpqQolcfbdx8NLm?=
 =?us-ascii?Q?JiAtsigZdULO1X655S+52W24JeNHB7XYR7+rowgVikJDozKRg8w8jbiFNSnf?=
 =?us-ascii?Q?NKoEe2aQeRqiw7amgXTY/gfcSojmAjdUcwpSwr6mXzl9cEIcoojG1UaLAwCe?=
 =?us-ascii?Q?tP5ZaAzIXd2Ap8TWOnFtpnoZbeaxtzh+XxcX0nXEYYXTunNA848vcUBtzBCx?=
 =?us-ascii?Q?H6+VacmfMGQKaAJE+t7Y8Qqq7XN2L69JHOJGWX/NOpxMoE0Q/+AhcU1vRwRI?=
 =?us-ascii?Q?LdVt6XqDCmEqoazcD2VOdVsngfm2JWfF2A696lDjfP0219iu+ad94IK4Y8vf?=
 =?us-ascii?Q?9Hl/90VMqbo0ptVLvmn8iomfl1Q+aPHQjYUb23KoHvHc99D6HNzHNovlN+SO?=
 =?us-ascii?Q?GG27Iex8gKVCrX4I4r13/gm3kMDvipx62qZIPN8vWrpY7CClXpIlm337CSwg?=
 =?us-ascii?Q?f/4xGMw1YzpT9i0dXEqDUw5r4xmMaoexj9gVbHuRqBSsklBNGujdNHPgMX8G?=
 =?us-ascii?Q?xEF6i7lSA6eQMUOmLPX1TuR6qDXmiNpprN1+QwXWm5jeFjMk90MUWsgu6Q5S?=
 =?us-ascii?Q?13Y4fldHe836hsUE68Oi9n7Tq00Aw2mrT92q2OaQmbUqlRLohcw6ndUj6rzT?=
 =?us-ascii?Q?mRuoDLZhTkWdb1z1UM6ee/H9YJXBYPfASd7LTgksYTjqlUnyzJYCT4B9S8o9?=
 =?us-ascii?Q?GESJgJiNxQAE0exxVwSFcEYgrpLqejbzy7/Dn/s2sn9vS6JSfC67/gMBGJ0q?=
 =?us-ascii?Q?CdoGHvPy/lCMN9RmGJEosqQrnniSk24fLmdgUBRlY9EwvD+P40RCPxY2adCz?=
 =?us-ascii?Q?/GiZahuWzIRJjRFZPSxmmb+pN6IM7G6CH5ySnxTT1WS+tTZsyW8gEubtQ3bT?=
 =?us-ascii?Q?die6YjlP66h5JVA+FmgEWgPZL8GDC3omN7ekjvnHNTK/BtL2Cj9renBfHpG8?=
 =?us-ascii?Q?RI/ptb7xrB45+rk07cGw49+Oy/V/RGT06o1bZ47C88WMh2UnG/rYDWGKWNRR?=
 =?us-ascii?Q?mBEoqASCfEcm9jFDzIIz83H72tP3Z03rJKSRumn7DqKncKU94FqbZyaZVFjg?=
 =?us-ascii?Q?S59PgS0SZNJYuO/nKoKWVv7mA6PRoNFM0E9f46XhaDzaoNGrCfCb7SydxYnN?=
 =?us-ascii?Q?H5R7uawsLu7H2ErOMkOKZuM6CFwfp1rJiQdcbxb4FawszQ/9gQK3hmmXQLc4?=
 =?us-ascii?Q?EGLa2MjNPw/7BITelfL2gBm5pZ563TL/aMJi2d2YnxyxWel4UIPwg2uJFaz3?=
 =?us-ascii?Q?7LtgTvWgQyI2q9mSX91SmHw3E5stTbAatFthV8jpMOs1AZjjBQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWbWcvqKX2xfMC0f3MUSVFoB0eqBMlHAQ5PfpONvwwtIDjRCrR0WfveFvmry?=
 =?us-ascii?Q?20RwmfBF9N3Tv3282qyktn07Es30ayCQIRazLXcHZkXvMXwzm3Co9IqErHJp?=
 =?us-ascii?Q?G3pumow1UFhN58W1YgBM7KNUq6G5fi4apxTA7mOznL8CuCceSdbegj44VdNc?=
 =?us-ascii?Q?m7TqqzUDZxh5vfHS+SN8RhMFU2KnZyaMCHOCsbW3Innu+c6exe+rzQ5HSJ64?=
 =?us-ascii?Q?1AFmD3DIsgfhqAEhb13dct+NAUzC4i32+UuM4TMCpr3x02kHZGSAXzvSpWAW?=
 =?us-ascii?Q?Kh8SlUJy6t30JDs9jrj8u91aNr65iaWAGgVmfAuvCFZpeyq8sbZGtnkRqtEz?=
 =?us-ascii?Q?D27Dq4BOMPEXCHM8R7P5w7yOJY+vzORTmhsO4z7O55Zdf/KWeB32L0uNOVfA?=
 =?us-ascii?Q?0XAjnqsAaZ+HIf3qEh/dPO12Lvf+UlPETz3188PhDH0xrk7mbRhPoVIUlzwj?=
 =?us-ascii?Q?cnAmzIO0dGmSOBbIxVFsqeUQOcSDkXikMBBmvTFXZ4YFudVZ5tsZRPxhL8Iy?=
 =?us-ascii?Q?r/BrsXYXq1duTjEHSsWSULIzg135ovpc1xG786yNUpl9Pzh0gkjhnzTxxeIc?=
 =?us-ascii?Q?V5jYloWIu9blZx1GPS4qNcv0zY00GFcyb3BA6k7i4ds3CRLoNCGO35cHfFHe?=
 =?us-ascii?Q?uSoGCKO3lnpHeWG70/nAM6PjwSlPQwPWL6oKeLVl9DXzDyVH0zesUMzwFS2p?=
 =?us-ascii?Q?QES0m+mSVRSAZZAwXi1Gr6yLOWY9ZOUJdYkhB+RUMd5f1L3dozx/1+mGHZSd?=
 =?us-ascii?Q?pqH8lyb+k/c5JrsFIUz28JiSnLWj8n1gTPPKoOi79lm5pMLIJjmT5YHhp9jW?=
 =?us-ascii?Q?bDjAbVZp4IkXPLDXMALfSlxXk95R2TKKppxvJ2W8w0QPBl+z5iYPkCouvkJQ?=
 =?us-ascii?Q?v9UrZNf+E6s/nlCK8CDZMc/+0Vi2hpHznKMdhgaTyE8QkYY08riGI5G+0Az/?=
 =?us-ascii?Q?zbEzTJ0RAjKUXtjUdPxKYkG+EhSa5Yunv8108xCccXEnI4snBph6e/nl798L?=
 =?us-ascii?Q?LOsnoifUCtt87LaHWQvoHeni4GgFQlH+M0SGoyC1NrGIbIziSEWVTLz5na+H?=
 =?us-ascii?Q?p0gCitbhGiSuH+2BaIX20O0cFJirstNy3sZdmYQ8I/rqTqWqLS3m8xdJA+gA?=
 =?us-ascii?Q?IxNIAOPi3zpAv7WVr7cJzNnGBTen4xvu6Y3OQiup2UMnhFctoXbikFyPLBc8?=
 =?us-ascii?Q?mlqPmMp75rodM/qVaXiKHEe6g0iq95phz4XTOp3ahGGZPD8Nptv290PYz3Sq?=
 =?us-ascii?Q?dp44lyAs7RSQKPxfm397KwabODfb2EI44FDiw47mZvZ4HQ8XDMGgaPHmOxfl?=
 =?us-ascii?Q?sFFNoqZH3Ff1b9zDekAwNx6t?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdaee5b-5b7a-4b23-f04e-08dd9e0ba4ed
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:21.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Last, it does some minor improvements including adding the ability to
specify the folder using the command line and set a default between
curl and openssl using the config.

P.S.: I am surprised this thing even exists xD.

v2: - Added support for OAuth2.0 with curl.
    - Fixed the memory leak in case auth_cram_md5 fails.
v3: - Improve wording in first patch
    - Change misleading message if OAuth2.0 is used without OpenSSL
v4: - Add PLAIN authentication mechanism for OpenSSL
    - Improved wording in the first patch a bit more
v5: - Add ability to specify destination folder using the command line
    - Add ability to set a default between curl and openssl using the config
v6: - Fix minor mistakes in --folder documentation
v7: - Fix spelling and grammar mistakes in logs shown to the user when running imap-send
    - Display port alongwith host when git credential is invoked and asks for a password
    - Display the destination mailbox when sending a message

Aditya Garg (9):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: enable specifying the folder using the command line
  imap-send: enable user to choose between libcurl and openssl using the
    config
  imap-send: fix numerous spelling and grammar mistakes in logs
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message

 Documentation/config/imap.adoc   |  17 +-
 Documentation/git-imap-send.adoc |  65 +++++-
 imap-send.c                      | 327 +++++++++++++++++++++++++++----
 3 files changed, 358 insertions(+), 51 deletions(-)

Range-diff:
 -:  ---------- >  1:  4757d0305d imap-send: fix bug causing cfg->folder being set to NULL
 1:  f5ad01abc5 !  2:  c4e2a5659b imap-send: add support for OAuth2.0 authentication
    @@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
     +		  const char *access_token UNUSED)
     +{
     +	die("You are trying to use OAUTHBEARER authenticate method "
    -+	    "with OpenSSL library, but it's support has not been compiled in.");
    ++	    "with OpenSSL library, but its support has not been compiled in.");
     +}
     +
     +static char *xoauth2_base64(const char *user UNUSED,
     +		  const char *access_token UNUSED)
     +{
     +	die("You are trying to use XOAUTH2 authenticate method "
    -+	    "with OpenSSL library, but it's support has not been compiled in.");
    ++	    "with OpenSSL library, but its support has not been compiled in.");
     +}
     +
      #endif
 -:  ---------- >  3:  af9aa85cab imap-send: add PLAIN authentication method to OpenSSL
 3:  11f7ac1325 =  4:  2ca10774db imap-send: fix memory leak in case auth_cram_md5 fails
 4:  f6e7a5498e =  5:  190bed0bff imap-send: enable specifying the folder using the command line
 5:  4769924781 =  6:  469c05321b imap-send: enable user to choose between libcurl and openssl using the config
 2:  e3dc19dc49 !  7:  6a839e5f4d imap-send: add PLAIN authentication method to OpenSSL
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
     
      ## Commit message ##
    -    imap-send: add PLAIN authentication method to OpenSSL
    +    imap-send: fix numerous spelling and grammar mistakes in logs
     
    -    The current implementation for PLAIN in imap-send works just fine
    -    if using curl, but if attempted to use for OpenSSL, it is treated
    -    as an invalid mechanism. The default implementation for OpenSSL is
    -    IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
    -    still used today by many email providers in form of app passwords,
    -    lets add an implementation that can use AUTH PLAIN if specified.
    +    A lot of spelling and grammar mistakes were found in the logs shown to
    +    the user while using imap-send. Most of them are lack of a full stop at
    +    the end of a sentence and first word of a sentence not being capitalized.
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
    - ## Documentation/config/imap.adoc ##
    -@@ Documentation/config/imap.adoc: imap.authMethod::
    - 	Specify the authentication method for authenticating with the IMAP server.
    - 	If Git was built with the NO_CURL option, or if your curl version is older
    - 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
    --	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
    --	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
    -+	option, the only supported methods are 'PLAIN', 'CRAM-MD5', 'OAUTHBEARER'
    -+	and 'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
    - 	plaintext LOGIN command.
    -
      ## imap-send.c ##
    -@@ imap-send.c: enum CAPABILITY {
    - 	LITERALPLUS,
    - 	NAMESPACE,
    - 	STARTTLS,
    -+	AUTH_PLAIN,
    - 	AUTH_CRAM_MD5,
    - 	AUTH_OAUTHBEARER,
    - 	AUTH_XOAUTH2
    -@@ imap-send.c: static const char *cap_list[] = {
    - 	"LITERAL+",
    - 	"NAMESPACE",
    - 	"STARTTLS",
    -+	"AUTH=PLAIN",
    - 	"AUTH=CRAM-MD5",
    - 	"AUTH=OAUTHBEARER",
    - 	"AUTH=XOAUTH2",
    -@@ imap-send.c: static char hexchar(unsigned int b)
    +@@ imap-send.c: static int ssl_socket_connect(struct imap_socket *sock UNUSED,
    + 			      const struct imap_server_conf *cfg UNUSED,
    + 			      int use_tls_only UNUSED)
    + {
    +-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
    ++	fprintf(stderr, "SSL requested, but SSL support is not compiled in.\n");
    + 	return -1;
      }
      
    - #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
    -+static char *plain_base64(const char *user, const char *pass)
    -+{
    -+	int user_len = strlen(user);
    -+	int pass_len = strlen(pass);
    -+	int raw_len = 1 + user_len + 1 + pass_len;
    -+	int b64_len;
    -+	char *raw, *b64;
    -+
    -+	/* Compose the PLAIN string
    -+	 *
    -+	 * The username and password are combined to one string and base64 encoded.
    -+	 * "\0user\0pass"
    -+	 *
    -+	 * The method has been described in RFC4616.
    -+	 *
    -+	 * https://datatracker.ietf.org/doc/html/rfc4616
    -+	 */
    -+	raw = xmallocz(raw_len);
    -+	raw[0] = '\0';
    -+	memcpy(raw + 1, user, user_len);
    -+	raw[1 + user_len] = '\0';
    -+	memcpy(raw + 2 + user_len, pass, pass_len);
    -+
    -+	b64 = xmallocz(ENCODED_SIZE(raw_len));
    -+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, raw_len);
    -+	free(raw);
    -+
    -+	if (b64_len < 0) {
    -+		free(b64);
    -+		return NULL;
    -+	}
    -+	return b64;
    -+}
    -+
    - static char *cram(const char *challenge_64, const char *user, const char *pass)
    - {
    - 	int i, resp_len, encoded_len, decoded_len;
    -@@ imap-send.c: static char *xoauth2_base64(const char *user, const char *access_token)
    - 
    - #else
    - 
    -+static char *plain_base64(const char *user UNUSED,
    -+		  const char *access_token UNUSED)
    -+{
    -+	die("You are trying to use PLAIN authenticate method "
    -+	    "with OpenSSL library, but it's support has not been compiled in.");
    -+}
    -+
    - static char *cram(const char *challenge_64 UNUSED,
    - 		  const char *user UNUSED,
    - 		  const char *pass UNUSED)
    -@@ imap-send.c: static char *xoauth2_base64(const char *user UNUSED,
    +@@ imap-send.c: static int verify_hostname(X509 *cert, const char *hostname)
    + 
    + 	/* try the common name */
    + 	if (!(subj = X509_get_subject_name(cert)))
    +-		return error("cannot get certificate subject");
    ++		return error("Cannot get certificate subject");
    + 	if ((len = X509_NAME_get_text_by_NID(subj, NID_commonName, cname, sizeof(cname))) < 0)
    +-		return error("cannot get certificate common name");
    ++		return error("Cannot get certificate common name");
    + 	if (strlen(cname) == (size_t)len && host_matches(hostname, cname))
    + 		return 0;
    + 	return error("certificate owner '%s' does not match hostname '%s'",
    +@@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const char *pass)
    + 	decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
    + 				      (unsigned char *)challenge_64, encoded_len);
    + 	if (decoded_len < 0)
    +-		die("invalid challenge %s", challenge_64);
    ++		die("Invalid challenge %s", challenge_64);
    + 	if (!HMAC(EVP_md5(), pass, strlen(pass), (unsigned char *)challenge, decoded_len, hash, NULL))
    + 		die("HMAC error");
    + 
    +@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
    + 	if (ret != strlen(response)) {
    + 		free(response);
    +-		return error("IMAP error: sending response failed");
    ++		return error("IMAP error: sending CRAM-MD5 response failed");
    + 	}
    + 
    + 	free(response);
    +@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 		tunnel.in = -1;
    + 		tunnel.out = -1;
    + 		if (start_command(&tunnel))
    +-			die("cannot start proxy %s", srvc->tunnel);
    ++			die("Cannot start proxy %s", srvc->tunnel);
      
    + 		imap->buf.sock.fd[0] = tunnel.out;
    + 		imap->buf.sock.fd[1] = tunnel.in;
    + 
    +-		imap_info("ok\n");
    ++		imap_info("OK\n");
    + 	} else {
    + #ifndef NO_IPV6
    + 		struct addrinfo hints, *ai0, *ai;
    +@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
    + 			goto bail;
    + 		}
    +-		imap_info("ok\n");
    ++		imap_info("OK\n");
    + 
    + 		for (ai0 = ai; ai; ai = ai->ai_next) {
    + 			char addr[NI_MAXHOST];
    +@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 			perror("gethostbyname");
    + 			goto bail;
    + 		}
    +-		imap_info("ok\n");
    ++		imap_info("OK\n");
    + 
    + 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
    + 
    +@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 		}
      #endif
    + 		if (s < 0) {
    +-			fputs("Error: unable to connect to server.\n", stderr);
    ++			fputs("Error: unable to connect to server\n", stderr);
    + 			goto bail;
    + 		}
      
    -+static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
    -+{
    -+	int ret;
    -+	char *b64;
    -+
    -+	b64 = plain_base64(ctx->cfg->user, ctx->cfg->pass);
    -+	if (!b64)
    -+		return error("PLAIN: base64 encoding failed");
    -+
    -+	/* Send the base64-encoded response */
    -+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    -+	if (ret != (int)strlen(b64)) {
    -+		free(b64);
    -+		return error("IMAP error: sending PLAIN response failed");
    -+	}
    -+
    -+	free(b64);
    -+	return 0;
    -+}
    -+
    - static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    - {
    - 	int ret;
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    - 		if (srvc->auth_method) {
    - 			struct imap_cmd_cb cb;
    - 
    --			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
    -+			if (!strcmp(srvc->auth_method, "PLAIN")) {
    -+				if (!CAP(AUTH_PLAIN)) {
    -+					fprintf(stderr, "You specified "
    -+						"PLAIN as authentication method, "
    -+						"but %s doesn't support it.\n", srvc->host);
    -+					goto bail;
    -+				}
    -+				/* PLAIN */
    -+
    -+				memset(&cb, 0, sizeof(cb));
    -+				cb.cont = auth_plain;
    -+				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") != RESP_OK) {
    -+					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
    -+					goto bail;
    -+				}
    -+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
    - 				if (!CAP(AUTH_CRAM_MD5)) {
    - 					fprintf(stderr, "You specified "
    - 						"CRAM-MD5 as authentication method, "
    + 			close(s);
    + 			goto bail;
    + 		}
    +-		imap_info("ok\n");
    ++		imap_info("OK\n");
    + 	}
    + 
    + 	/* read the greeting string */
    +@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 			}
    + 		} else {
    + 			if (CAP(NOLOGIN)) {
    +-				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
    ++				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN.\n",
    + 					srvc->user, srvc->host);
    + 				goto bail;
    + 			}
    + 			if (!imap->buf.sock.ssl)
    + 				imap_warn("*** IMAP Warning *** Password is being "
    +-					  "sent in the clear\n");
    ++					  "sent in the clear.\n");
    + 			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
    + 				fprintf(stderr, "IMAP error: LOGIN failed\n");
    + 				goto bail;
    +@@ imap-send.c: static int append_msgs_to_imap(struct imap_server_conf *server,
    + 
    + 	ctx = imap_open_store(server, server->folder);
    + 	if (!ctx) {
    +-		fprintf(stderr, "failed to open store\n");
    ++		fprintf(stderr, "Failed to open store.\n");
    + 		return 1;
    + 	}
    + 	ctx->name = server->folder;
    + 
    +-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
    ++	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
    + 	while (1) {
    + 		unsigned percent = n * 100 / total;
    + 
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    + 
    + 	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
    + 	if (!uri_encoded_folder)
    +-		die("failed to encode server folder");
    ++		die("Failed to encode server folder.");
    + 	strbuf_addstr(&path, uri_encoded_folder);
    + 	curl_free(uri_encoded_folder);
    + 
    +@@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server_conf *server,
    + 	curl = setup_curl(server, &cred);
    + 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
    + 
    +-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
    ++	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
    + 	while (1) {
    + 		unsigned percent = n * 100 / total;
    + 		int prev_len;
    +@@ imap-send.c: int cmd_main(int argc, const char **argv)
    + 		server.port = server.use_ssl ? 993 : 143;
    + 
    + 	if (!server.folder) {
    +-		fprintf(stderr, "no imap store specified\n");
    ++		fprintf(stderr, "No IMAP store specified.\n");
    + 		ret = 1;
    + 		goto out;
    + 	}
    + 	if (!server.host) {
    + 		if (!server.tunnel) {
    +-			fprintf(stderr, "no imap host specified\n");
    ++			fprintf(stderr, "No IMAP host specified.\n");
    + 			ret = 1;
    + 			goto out;
    + 		}
    +@@ imap-send.c: int cmd_main(int argc, const char **argv)
    + 
    + 	/* read the messages */
    + 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
    +-		error_errno(_("could not read from stdin"));
    ++		error_errno(_("Could not read from stdin."));
    + 		ret = 1;
    + 		goto out;
    + 	}
    + 
    + 	if (all_msgs.len == 0) {
    +-		fprintf(stderr, "nothing to send\n");
    ++		fprintf(stderr, "Nothing to send.\n");
    + 		ret = 1;
    + 		goto out;
    + 	}
    + 
    + 	total = count_messages(&all_msgs);
    + 	if (!total) {
    +-		fprintf(stderr, "no messages to send\n");
    ++		fprintf(stderr, "No messages found to send.\n");
    + 		ret = 1;
    + 		goto out;
    + 	}
 -:  ---------- >  8:  a60d8f458f imap-send: display port alongwith host when git credential is invoked
 -:  ---------- >  9:  5db5b64a3b imap-send: display the destination mailbox when sending a message
-- 
2.49.0.638.g5db5b64a3b.dirty

