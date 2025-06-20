Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122FE30E844
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401655; cv=fail; b=CtO//1MGqae8SS+f9oL6p6b7j1NMmYAJWL4vRAScTxSggkBmsmEi9myEvpVee+MQnC4/A849E4uJVGeHj7J//w/7HuYTNn7k4ysRrO9PssEBRjIeLWYINdrhaN9mrXd8Dvxn4f66abkLJfSpVtKN+trtGsf7eJVZOS+PBwXqtow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401655; c=relaxed/simple;
	bh=frCInIQSntYaYJqCmqLUpB1ykDfMnKcNgCD+bjWGnh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yu+zN4tH/YEHoWf3ptLVaR6EsV7SGNV1089VIoS5vLp4g1VKCt80fuy3gV383oIyIakj7QZz8ftAWghH5X3zALji0IC5Am5VT8Cv46ZgRVE9jX1eqoTZLXmLoXwEsZteG7c9ykUVCW9zpc3INCSlDWg7eMVMh4678ibunGBqSCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fPFsz1Lm; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fPFsz1Lm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZM46dKW7iClq5j3wGr8sgGNRuIZYcYGRFp3kCCeIVytSJmgVGJc6OYaY79jgQNhYYhvn1MkpFbjYMq86QqPAPaidTCzl1GIIP1AlvAD6JDkgDZwY/raaGC4v/g9gw+LRi9nA/xhdbkF/7EFQBi0NLfFjdhjqKq4jylXrajFLoCW4PaFZ1PdbHOeCLxpMtjQTELS7E3FMQbvLKaGd/xyfwU72DFnyptOjLn4ysH/JwAWvd1HEgrjR4q/bUiiSTmEBZTuj0ncTVMOtCc+IgJzhxIN3WxeANMru8rMfO5BDEVHsQcgqAnbPXHyzlHtv7K7pGPNYYGzrddt7sJ8vKpORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsceX+sdJvfhXd1MYdj42uMjmQ7CmB5q+n28ejcQuDQ=;
 b=oPtrVO1YatKHv3CbQXaHBMb9IgzYirPRngJXt4VX7ofYFce7NNydUH4qQWCXJnFFD5Qo0SxGz70TdPL3U7X2mcIO8oYWsuwQr91nXa6AA+5YDQYnMCVovgcLajXRMWtEI0ysFbImjT44T/Qo19Eu7OcbqC5WHYzBsy43/KtrAOxTaAZz+O2FEXtS3mvdxsK5P4P/kxLySNksZi+Va5wlWB1iTUuJ7mBXbVJnkkkALgDuY7yRPQx2nxFacroU7dA28XJLBzxrCrmvhREfT0HfivncY6ySSt0XKrK3Hu4hmC7AVCAqLR4bZ6sE5ph+TWQ/ZbEZNaO9lndZaPg6B2KDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsceX+sdJvfhXd1MYdj42uMjmQ7CmB5q+n28ejcQuDQ=;
 b=fPFsz1LmyJXilViufrnMU2Dorg+CKi9X9L4Q9Czxq9MXIJn4WmAwQLpgTJoCz8svLVL32+3D7V7BDukmQsoVD73hy04xJIUb8BqVNwvmiU29sn4qnOcWGNHzXMizGRxkXAAIUSUI8zDa2PlUbsI2mljoRB4nCDNTA1DJv4yVvq6I2GqvTtsUby5q0MInvTOL/lCISPfNsamcMYfbBVcuRzqVpKmXS2gnTQJIoDPCWMj7lwmsoiJwcnw0I/dgtvTDC8deUmYZeatN0QHYCkroufrDBpuo8uD6Y/eGaeKXdUzvFNQssgQ5Mogem1D66g2tMZtHG8nh2CXxP0luBYRHtw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 00/10] imap-send: make it usable again and add OAuth2.0 support
Date: Fri, 20 Jun 2025 12:10:23 +0530
Message-ID:
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250620064033.15814-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4fe19a-eb05-4341-bb4a-08ddafc563bd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|15080799009|8060799009|7092599006|5072599009|461199028|3412199025|440099028|4302099013|40105399003|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7TfRNC9esT0GaR4F+htju6oTpuHHqnoosbUbOrkbQESP1YLb8yeG6jKoae8?=
 =?us-ascii?Q?Y4DLeZgwXb1hNZVwcCEX/XdbqAPsXGIt7NFr8vwIoU9VsbvxEHSwcBHY3JUM?=
 =?us-ascii?Q?XiSBDOq25s0/6Fl86y0LyZRraRKZIr6upmEFJd9g/R1MJEUAABVusEKq9zD6?=
 =?us-ascii?Q?5Hl44qvQjuIcvzZa6bujEKgU9uuJ1fvw2aRJW6xiSaNkILoYhY8FFoLVRK38?=
 =?us-ascii?Q?eQNA9GH7RDI5MA0qVe20fIpdA1YX3BLj07xpTdaPTWuGtEvr6309BYHvQ7Bt?=
 =?us-ascii?Q?iRxW8l+MiMONwb2eqX7/HnaJzkdWeUs4LgxO34n/boDBy0VoNeST78jTzWDE?=
 =?us-ascii?Q?6qozJ3LPQV8+hFwJOZyYoyO+EPuBfxHuycsT1nqUQyS8CZ5pWLoyell0ffA1?=
 =?us-ascii?Q?sUZIiAWsjGOuh/2nucVqJWSmIAtEAvW6ZYIk7JA3bqm6sJOUxw8AzIFfSMzr?=
 =?us-ascii?Q?yuiAbZiurGhOXSUqXDqKsNmVJcUo6Tlqy7+VrMQAuqOzTzd4BLC/ObyZNYRI?=
 =?us-ascii?Q?FgO6xLPCvEpsdSzl6EMmKyqSPUy4O+EZHa0XGMNeGKgmjLeLpU4OvpZ6uDRf?=
 =?us-ascii?Q?jkC4cg6xCc3doK6Now6kfBeQbjQBJOOWbbEU19l7cefCoeO5nva72+/CLSjP?=
 =?us-ascii?Q?aIOjfPKaprpbOUeEkB/D+2eTMX5bvQwqEV5ip9g0/8s/zmTzNge9kYZqAXwu?=
 =?us-ascii?Q?HBDtyIclAloUK7uM6sV6IiA9PBiePwFUDy0W+aRLybYJnPgijHXJEDqbrgMk?=
 =?us-ascii?Q?16FSp98p2VDAahlUQH35mFEW8FEInKGm0TICbxR3lPeK4P4ysmSm3CCYAyni?=
 =?us-ascii?Q?rU3vRTVW/sCDbhN2U9egwKUH9uFi/eEy4wtz91e5kDI25PHrxwPa9uTFQiwc?=
 =?us-ascii?Q?2ytLLsfHOBlzKHZ+TB+QCv21ngyDioUAZQG83RSUojgvvP0IKGqfnu3eGMNg?=
 =?us-ascii?Q?BDezEvKQPV0zeHs1T+bsEbJxfOfYgIQpcVCRgUre6dyHck7cDDMRciorGfrw?=
 =?us-ascii?Q?JlQA02zwjzUh+JDIeYd6OLjw4q3+IpBXSZS6QwtRwGrYYAxsGkYX8oI+FIxV?=
 =?us-ascii?Q?AFoEmkf7uV7WzzKf4m3CacT8BGWaDgextv6rh1+Tb0tmUCHsDehgo35QSoiB?=
 =?us-ascii?Q?YHY6s4N2WtwWHahm4OI6DjiaqpswKN12bftcUkfeSHFMomnI3t9Fps2KjTcA?=
 =?us-ascii?Q?uxpks/1PSTSxx5PXPCoClaAaVTgxWpQgin01Hsfmbp27fYATV3cOHHBljbeP?=
 =?us-ascii?Q?RypBFuFmnYFOTdYyE6emDL0iiA6lSfX0Y3VPoaPf1sY1SmsxD1BIFvf6Otb4?=
 =?us-ascii?Q?/eyuOSmrjedXqZlZa6IJmbFpZCsv8/4dh6WC+aLhEm3qSQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Z41e+8IMpy+KOLDglymSoawJJk0W3cOvwDHOnTmjzmP550GOVHmb82u0BOW?=
 =?us-ascii?Q?H+0L5EsO/AdU+37QSTPvP+C2DpKV2dEOI5hpALkcjMl3lYEUDF4t8uzEiUig?=
 =?us-ascii?Q?a5LpNmCr7kFs1sFJZtj5FBL6Mi1GDAxJ1WGMOGaq4YNQz+8TPuzZeTOBa0kq?=
 =?us-ascii?Q?D4PaWUb29nDNdr8D673lPKM0ixtmW4Q/3XpyScBcODes3OIozzuUP7/bYec6?=
 =?us-ascii?Q?lCEUaX/TRX2Pl/5FVzmeJAZjHlRt3otCFFbhd7k81wNdJvYTbNCFfzgrBAkQ?=
 =?us-ascii?Q?Zx2WqCv6vQRMfng1+Jdk5Y20xysUCuAKCQqzr8+vtRmA+gwoxt+Bd2Cs2wdB?=
 =?us-ascii?Q?emb5FakCuNsbrrfxsohabvxJ0HHNqTtZofnQNk/dhsTCAWw3hv901hUi7tVp?=
 =?us-ascii?Q?WRKbpvjEQcJru+a3AlLOQm0KwEfo0MM4Rl+Ygn4tnxBMM5cWW3wzIzNGb471?=
 =?us-ascii?Q?gRtuwgVN4eb2ecxo+u/I5nr7q13I4pBCPWZKFRB65W/5wqO3HrFrvFN4gJr3?=
 =?us-ascii?Q?dbxQFQJ0WzopSMatvvNZJr0nIChJ8KZiM/7penF2sXcP473p/B35Qh7jctY0?=
 =?us-ascii?Q?17zoudme1/iCmam6+nqsKUDtBtKAg5f7b2Ro6eYWMRgqzROGjThDuoAVz1o7?=
 =?us-ascii?Q?Hj+KGowCMOsu0uR43s+uUy1nlG/o6q+8AlMgZP9XaNVla4Q29zatcUZcdaCo?=
 =?us-ascii?Q?bil8G1Z5JcwCht5XDOcdfMEIW8ulD6G/1AK8sN9tB26PVnWHjK+O/dVq1Bwp?=
 =?us-ascii?Q?LECYWxdYP5q0nqL5y5OWKcbcaWfRtmVXmnwa4o10IRTtAJSXXYIT0TKdvJgS?=
 =?us-ascii?Q?dDrUDjLoSfi3aWmlrVXBzs9gYaiwmap2XjZxFjViZAZPUiYIKz2GNBheQnSc?=
 =?us-ascii?Q?Q3oxbgy95V+3NhVWgWmL9/j6zw9+uhFL1Ls+TU6UhykEzUaFLepKTXnS+8ar?=
 =?us-ascii?Q?Urii1Jtl7/d+OGRCzw+9GhNoy9nQl13oOJLiwMth+g51h7xSoJNg+J8NQfAC?=
 =?us-ascii?Q?m9Ex4iUnVLFlCMWO/bN8mm6jRGaDJEmZUR5f6h/5PX+bBtnGUVnVECw+eQFz?=
 =?us-ascii?Q?5OTY1BwJeZJgVy5VmNw7kk2Cqar65e53WkigB20+YnmiEMWnvmCMGQsA3q5+?=
 =?us-ascii?Q?7PNsbeHPf0pTsEBPqu7WKT8j33ri/JcQ47Rrnwwo0mtNp660LDQfoN79oC1c?=
 =?us-ascii?Q?TFGPPztU420cphwI5kxRJ0rmWOfGWrb0tzbkLwBPASYedpX9IlF1ErFVMTF6?=
 =?us-ascii?Q?GmhCS2F51aYvco2RcQBZVt/JUWzfHlJ1u60ARo8V1u+9yAKUboHyvCp0K1tZ?=
 =?us-ascii?Q?Y1E=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4fe19a-eb05-4341-bb4a-08ddafc563bd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:47.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6023

v2:  - Added support for OAuth2.0 with curl.
     - Fixed the memory leak in case auth_cram_md5 fails.
v3:  - Improve wording in first patch
     - Change misleading message if OAuth2.0 is used without OpenSSL
v4:  - Add PLAIN authentication mechanism for OpenSSL
     - Improved wording in the first patch a bit more
v5:  - Add ability to specify destination folder using the command line
     - Add ability to set a default between curl and openssl using the config
v6:  - Fix minor mistakes in --folder documentation
v7:  - Fix spelling and grammar mistakes in logs shown to the user when running imap-send
     - Display port alongwith host when git credential is invoked and asks for a password
     - Display the destination mailbox when sending a message
v8:  - Drop the patch that enabled user to choose between libcurl and openssl using the config
     - Add ability to list the available folders by adding a `--list` option
v9:  - Encourage users to use OAuth2.0 for Gmail (similar change done for send-email docs).
v10: - Fix comment styles
     - Fix failing tests
v11: - Use lower case letters for the first word of a sendtence in an error message
       and avoid using full stops at the end of a sentence.
v12: - Gracefully exit PLAIN, CRAM-MD5, OAUTHBEARER and XOAUTH2 authentication methods
       if OpenSSL support is not compiled in, but is requested by the user.
     - Use backticks for string literals.
     - Wrap documentation text to 75 columns.
     - End the last member of enum CAPABILITY with a trailing comma.
v13: - Fix logic error which was using || instead of && when checking if
       the authentication method is neither XOAUTH2 nor OAUTHBEARER.
v14: - Specify why we are not using CURLOPT_PASSWORD for OAuth2.0
       methods using a comment.
     - Add a function try_auth_method() to reduce code duplication
       when trying to authenticate using a specific method.
v15: - Simply rearrange the patches to make the cram md5 patches come
       before adding OAuth2.0 and PLAIN authentication methods. No 
       change has been done to the code itself.
v16: - Rearrage some more patches so that the two new features, i.e.,
       --folder and --list come just after the new authentication
       methods. Then the two patches with minor improvements of displaying
       the destination mailbox and displaying port alongwith host have
       been added. The patch fixing other minor mistakes in the logs has
       been moved to the end. Just like v15, no change has been done
       to the code itself.
v17: - Rebase on top of master where 30325e2 was causing a conflict.
       (Sorry for the bad range diff, but I think its easy to understand)
v18: - Avoid initialising variables with 0 or NULL. Let them remain
       uninitialised
     - Add a white at it note to the commit message of the patch that
       adds support to specify the folder.
     - Add another minor fix to the log that displays the unknown auth
       mechanism used. It was displaying the host rather than the mechanism.
     - Remove unecessary and pessimistic lines from the patch that enabled
       showing the host alongwith the port.
v19: - Use xstrfmt() for OAuth2 strings and strbuf for PLAIN.

Aditya Garg (10):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: gracefully fail if CRAM-MD5 authentication is requested
    without OpenSSL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: enable specifying the folder using the command line
  imap-send: add ability to list the available folders
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: fix minor mistakes in the logs

 Documentation/config/imap.adoc   |  11 +-
 Documentation/git-imap-send.adoc |  68 +++++-
 imap-send.c                      | 405 ++++++++++++++++++++++++++-----
 3 files changed, 407 insertions(+), 77 deletions(-)

Range-diff against v18:
 -:  ---------- >  1:  4accbe6ecf imap-send: fix bug causing cfg->folder being set to NULL
 -:  ---------- >  2:  1cfd66ccea imap-send: fix memory leak in case auth_cram_md5 fails
 -:  ---------- >  3:  12ff5135be imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
 1:  43b18dbfb0 !  4:  6461607abc imap-send: add support for OAuth2.0 authentication
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
      
     +static char *oauthbearer_base64(const char *user, const char *access_token)
     +{
    -+	int raw_len, b64_len;
    ++	int b64_len;
     +	char *raw, *b64;
     +
     +	/*
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
     +	 * https://datatracker.ietf.org/doc/html/rfc5801
     +	 * https://datatracker.ietf.org/doc/html/rfc7628
     +	 */
    -+	raw_len = strlen(user) + strlen(access_token) + 20;
    -+	raw = xmallocz(raw_len + 1);
    -+	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
    ++	raw = xstrfmt("n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
     +
     +	/* Base64 encode */
     +	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
     +
     +static char *xoauth2_base64(const char *user, const char *access_token)
     +{
    -+	int raw_len, b64_len;
    ++	int b64_len;
     +	char *raw, *b64;
     +
     +	/*
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
     +	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
     +	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
     +	 */
    -+	raw_len = strlen(user) + strlen(access_token) + 20;
    -+	raw = xmallocz(raw_len + 1);
    -+	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
    ++	raw = xstrfmt("user=%s\001auth=Bearer %s\001\001", user, access_token);
     +
     +	/* Base64 encode */
     +	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
 2:  1ebf9f935f !  5:  76745861e8 imap-send: add PLAIN authentication method to OpenSSL
    @@ imap-send.c: static char hexchar(unsigned int b)
      #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
     +static char *plain_base64(const char *user, const char *pass)
     +{
    -+	int user_len = strlen(user);
    -+	int pass_len = strlen(pass);
    -+	int raw_len = 1 + user_len + 1 + pass_len;
    ++	struct strbuf raw = STRBUF_INIT;
     +	int b64_len;
    -+	char *raw, *b64;
    ++	char *b64;
     +
     +	/*
     +	 * Compose the PLAIN string
    @@ imap-send.c: static char hexchar(unsigned int b)
     +	 *
     +	 * https://datatracker.ietf.org/doc/html/rfc4616
     +	 */
    -+	raw = xmallocz(raw_len);
    -+	raw[0] = '\0';
    -+	memcpy(raw + 1, user, user_len);
    -+	raw[1 + user_len] = '\0';
    -+	memcpy(raw + 2 + user_len, pass, pass_len);
    ++	strbuf_addch(&raw, '\0');
    ++	strbuf_addstr(&raw, user);
    ++	strbuf_addch(&raw, '\0');
    ++	strbuf_addstr(&raw, pass);
     +
    -+	b64 = xmallocz(ENCODED_SIZE(raw_len));
    -+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, raw_len);
    -+	free(raw);
    ++	b64 = xmallocz(ENCODED_SIZE(raw.len));
    ++	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw.buf, raw.len);
    ++	strbuf_release(&raw);
     +
     +	if (b64_len < 0) {
     +		free(b64);
 3:  ce2cfa34cf =  6:  cb0857e36e imap-send: enable specifying the folder using the command line
 4:  5c36e68493 =  7:  360aa72808 imap-send: add ability to list the available folders
 5:  cc4f88791f =  8:  422db5f0f0 imap-send: display port alongwith host when git credential is invoked
 6:  82432c7b21 =  9:  eaef39e6f1 imap-send: display the destination mailbox when sending a message
 7:  d780afc026 = 10:  cc76007b2f imap-send: fix minor mistakes in the logs
-- 
2.49.0.824.gcc76007b2f

