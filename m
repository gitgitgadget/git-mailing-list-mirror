Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010008.outbound.protection.outlook.com [52.103.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B0B661
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754229562; cv=fail; b=oeWPoFqmtvki33HehI7ZYuAc5ut0X9yeSj9Ocw3NK+ImY70B3NJn6kVQ1DTJfjdwyy98PZZBg1SwwUIsbkDARfj2+Sww1BlXp8xd010TBk+BdWJ6R9tYOYRPV18yQK6WtC9Hsh79kBP+mxDk5+nFznp3hmVoKSca0QhvoC77XwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754229562; c=relaxed/simple;
	bh=UB6PvdmR8Tg8duI/1P2BsyScvL7rOoY7c4tb0jor5Yw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mEumUugU1ZVkXqLj5fgOcUVIz2+FCYDCjfSFgqulJLZ9Quw1k2idd07WIOasISE2vbKy619O/INEbWO/V3/S3IiWFYKYbUlGmLv9+0eVVEf5awJBNfbHXG0FCxfUSdeKUlgET7FUhuz81bmfxU4iyfgHM6shdOb42leg6ck+nww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=akQ37s4X; arc=fail smtp.client-ip=52.103.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="akQ37s4X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPyVHMq7mcttM49PQNKEFV1z8gRgpfJLBSKtWZElkgJ288zSXhieFmRPgn5bkt7OjKodlnH+XPoOWYyABW1aD5/KFXAOMgNTI0n4gHiY5hfRadMWSApz9+jSe3UeWNEvJbVcgHQ+NhCfhurMdQiUgOkHlJcQW6hCD2f4zUqVQaRxITk2J2k/GBJx4Di35TCR2tdGMBkUdHm7BHHxYaSOibqhdbCdYQ3mQ4jLet0befEV0vc/3OrOK48iW9dfLqsOn/Fi+HFngTZQ3aWvRCHVRtrZ6021UiicdKFepHkkhA4/HN0VAsXFy+JxJkil7rqlvSXtc4qqDoiOtqM+t7zFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3qV53fyaX6BxRuUZQMMJuKS41GrFEtkneohO4Kho6I=;
 b=rHhvjAEkCAner6U853r59dRpK3jb7exGXEKyPdjkN5/sWBzTanyNp8AMNNlH8zM+00tN9jffS0c888LZnirPAU/A8gJw8HThmUHmvNv+VTBOR5vIGBnzj5Dy+tE2G6/ZOEQ/PNy5OcIxClnWidbwjYEMpzEU04tPB2GkYqDMgggqbGCoWxvN59vsnPOyt1rfj62BiS3gwrjdKO/l3wd61iuZPUtpldfZ8HPpGdoM/HfcACw8LOKqCXWNAPUTIv0H7moKK5icUjZNOhvfK6G1wrjBdZC+y2MRC7nQsgAjHasZJh8wk6ABsOUFrYdvImpCstk4jOcZJdnfBROetjTADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3qV53fyaX6BxRuUZQMMJuKS41GrFEtkneohO4Kho6I=;
 b=akQ37s4XWBXTddJ/DNyjVexAc9h0W3xbdesHFusNLFymDhL+KQ9TM7UglcpMqEGlS64jWwVKPX/Cgm4+w0zWixB3CTJMd6QcSnDKkHKj85GreobpuRnJguemTvRarKH6jfk+7eis5QxiNGL67y1f1xYoatQ1t4R8XvvA/uN2/RVpIrbMyXfGb5MtVpMn5Fjgmsg0W9Zjq78FDZwKGjdX7x6TnMMHfB2ETb7VGda0NeVB72PNdCHaxf1YQ3hyrmHtRumf75bcwL+vT4SUvVMVsZIJGkJWd2GEwv9c70lqQsgMZ8CyFC8lGJ3j/PF8lklKT4C8uEoQcAn+Tr2XecpCmQ==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7628.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Sun, 3 Aug
 2025 13:59:15 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%3]) with mapi id 15.20.8989.018; Sun, 3 Aug 2025
 13:59:15 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add --get-smtp-server option to fetch SMTP
 settings
Thread-Topic: [PATCH v2] send-email: add --get-smtp-server option to fetch
 SMTP settings
Thread-Index: AQHcAWRimBaHkan2W0SdeBogO+mWgLRQ9IiAgAAGDwA=
Date: Sun, 3 Aug 2025 13:59:14 +0000
Message-ID: <1ABB6EBC-7CA0-4108-94AC-F38E96BC7673@live.com>
References: <20250730151227.12389-1-gargaditya08@live.com>
 <DBSU01804YQB.2JA3KHG5FDV55@swagemakers.org>
In-Reply-To: <DBSU01804YQB.2JA3KHG5FDV55@swagemakers.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|MA0PR01MB7628:EE_
x-ms-office365-filtering-correlation-id: 0d214c59-5c19-4adb-0947-08ddd295ee6e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8022599003|31061999003|19110799012|41001999006|8060799015|8062599012|461199028|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JfSvr76A8atzUnpWQh43dpAQZ7hlfRKumXOBnv6nqACPqcAlENga14xyYeZX?=
 =?us-ascii?Q?X7mP/6pc6RnCRhJUCIj39LTQTAZZYIu44IVRsgHpV+MXgQuyFbX7LSFYwTkH?=
 =?us-ascii?Q?/CXlNktYojCHaCAzO/Dw8uRQZD+J4g0ctA1FVc2BD+xRnLMIRnHoCHiRtCun?=
 =?us-ascii?Q?ri/AaW7woodSU0kzXtc8oI7cBaLTTE/sU4CSzwhf5inM2bp1FF71ALjNLvsi?=
 =?us-ascii?Q?nCqdMDk1wkl0dH7yfKnVuHtn5X5p1Lo0dbNWTunHIB03+iSH56xC446GawJm?=
 =?us-ascii?Q?mA1FcOYjB3FAhX4jH72vFs+w77XE/ssmUXPoGoN1QgTNbDmAXCqMn4UuW33g?=
 =?us-ascii?Q?Zl/qVrOxLUgkFbQ9eL61WQuEIYPBUIIOlqY8apT7aFSR9ZLmXjfC9VE74TLo?=
 =?us-ascii?Q?9OhM4HLNIcRWOpfSal5/4oGhOwhlGgP00tERNkfbfc0K1WTSpaUHNR1NZCbW?=
 =?us-ascii?Q?U1dswJnJcgZ9Kju+YHYzXxlIxEkPLfdpzcGA3zdVAeIAOeXT5yrSvoR2BlG+?=
 =?us-ascii?Q?lrnq2YCpmcbKkXMAuRs1OFry7vPWbS8qJPrv7YRr2uL1IwVYDO9ILBnfVDiS?=
 =?us-ascii?Q?s0TSie2ZWSLiVh6l+tYl3NsydtZbizULULMNnc/upgcxSR70e9SGunxIK8Ck?=
 =?us-ascii?Q?7FTAD0fFgEtDudNm2U/F3YAef9FXJAcXvSc29XoZcqKxVIezQ/OdTpmwZw27?=
 =?us-ascii?Q?cxMuKoueSEKdeSne+7qbTMEBsBZxTQFw36K9ORWnGwnPYgHKOZrmkptoRSPY?=
 =?us-ascii?Q?qXJemuJpPWbTl1vAw6GhmxjDal1EgSoGRwLlglRp2c9LT5Okb/HDlhRiqYOR?=
 =?us-ascii?Q?OJ0kYxv7PGpFGfqLyqmMFE/F1LuJroOmBAZRMH6zeRMrddXIktGOz/WpfMSs?=
 =?us-ascii?Q?02FmuP2RysdCVrbIEJp3einsq7VFsXCmFKJLU6vO37JbvV+iXGMnVPDuazRp?=
 =?us-ascii?Q?n5YkkVt6a1p5CoPNL1UpN9R8RAdgvJ5kRFcmWGic3kAx9AXLcug5DTVTPGGc?=
 =?us-ascii?Q?XFb2iWObGYnZoftF3twkXYfE9sdRKiubt3SaUBsb+ZRdi4Op6AfGpezouFCY?=
 =?us-ascii?Q?/9PMQOq2h0VlvQ78twIDpgUuIqFBuMULjXMOFe+Sz63m3OQhfavERtrvSgzF?=
 =?us-ascii?Q?+/PwkR85uugsZjGH5gLRcskynuVkWyWM+v66is+dECaiC3mb5w7fKn2HqMpZ?=
 =?us-ascii?Q?o1s91ujKmX4tIgK/?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eciwflbHqo7YGnyqgByhTvD3Ww09zmGBJisOjy0nilgBWLM6Ov/Y9u5w8280?=
 =?us-ascii?Q?AcINLgoVv/eqhl+BMcO+Q8E0BtlGGwj1JFDYRbsxf5ZxQ4Z23++YcMl5s1Kx?=
 =?us-ascii?Q?a1CvQVnWcxk5cXz9Q+bnmTLWAPScimbCBNMt/2tRXtQTgRxYT1PCBf9VnZ6O?=
 =?us-ascii?Q?QVYncBKm/e8LbA/1Wp67AgYjNCrePOYAojxSpOFHcrsXvMgKj8WQeIFN7Chn?=
 =?us-ascii?Q?THI7Z/rAzRfE7bo9CwbPtayX9sVqfaVBT0V8YxdYWAiyO3V9Osk/MYUKPREY?=
 =?us-ascii?Q?naVZLrmyVMLYiTnPwnIjoiGV8k0ZoQyJyo05qMOeahzzT4c7wgKpQqBP5YOx?=
 =?us-ascii?Q?VOa4qb4BhS4TFZlQjrLjOVs1i+xk69f+2dzph+PCLeOj43DF92PbTL4EPNTz?=
 =?us-ascii?Q?5nJjdln3Db8rY/NpmKj3SPClqyvYdJ0k2VbyoVluD+M5G28aYbVMDjU+ipJh?=
 =?us-ascii?Q?UQ4S6XtdUqywkPJxCxpoeLIpUR3Ru1zE60LucKxZ2T5a9lFXLYXVkXpdl8kq?=
 =?us-ascii?Q?UKSypD/YMFBpRBzr6cBmqDM7IEaNA1ipnTYwTmwQqT2Feez+PTwF87k+2iPv?=
 =?us-ascii?Q?rpPN9D+HqqauOCYYnzqmF1TZQphPwTJCh7Ep/1woznRNRYVWzetddsEKc1YJ?=
 =?us-ascii?Q?CSUmBpLUxxmk4pIGKCZp35Drivty4X+RYmD5vczogVONjCGgOgo6QluihWoI?=
 =?us-ascii?Q?ooedSJijt5/pc52S5VD52sJx750W+8vDmefK/uxu4IX2tWB6af6D0IoDQQVy?=
 =?us-ascii?Q?W8PyI8RkkYvgn+roNz9Kd9xU/Ix0DN5bTbI4yfVRR2gV/hiXCR3PWMrnqrXU?=
 =?us-ascii?Q?VOkeAQ8m9rDKR9ll4l+4xl5OWNbecC/snFXC/5ex22wTM8XTOYuxfSXEjmEf?=
 =?us-ascii?Q?Okm0VhEz8wG6KaILqGALblIYBdrvhaxialp9md3kZpMzd3+P63IWfr0GlgRF?=
 =?us-ascii?Q?DFHnoDYbgCXhDzgWQIxMSiVzhpgE5d663B5V1qXHGAT7k3qQBlWr39p3BCOC?=
 =?us-ascii?Q?ZRVgucRxU9ROwHS0InYgssJOlelAgpoEXlz0YPyMmBdGA7Pk1KXUUfRyMV5N?=
 =?us-ascii?Q?UjTxLZD7+aBswLmuOes6auz2ftDnpMMhu2fyPTngmUEphnoh3HxO3/XNHqYJ?=
 =?us-ascii?Q?LqJVb6hJPU+cgIOH4zNFxpAwRXQvPlyGxmx+7JPH7GlYRn2cLSegEp4jnLao?=
 =?us-ascii?Q?LdljeyfY+4/4CekUttUcoRXwIlstcYoxa0DUNxlYLOt7H3GfpdlTbqnB5CR1?=
 =?us-ascii?Q?J9xuyNpmaiLAF/4e+KqVfGc2mjhSHjcBm/q8LkJ5SCk+HbLVBGvu9dub2dg9?=
 =?us-ascii?Q?GQHIOQpsdADuXBx2Q0LRWHka?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2216177545AEC346B5F68250A8A40C21@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d214c59-5c19-4adb-0947-08ddd295ee6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2025 13:59:14.8556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7628



On 03/08/25 7:06 pm, Julian Swagemakers wrote:
> Hi Aditya, really cool idea, here are some random thoughts:
>=20
> On Wed Jul 30, 2025 at 5:12 PM CEST, Aditya Garg wrote:
>> Autoconfiguring SMTP server settings is a common feature present in many
>> email clients. In order to get the correct SMTP server settings easily,
>> this commit adds a `--get-smtp-server` option to `git send-email`. This
>> option attempts to fetch the SMTP server settings for a given email addr=
ess
>> via the following steps:
>>=20
>> 1. It first tries to fetch the settings from Mozilla's ISPDB at
>>   `https://autoconfig.thunderbird.net/v1.1/[domain]`.
>=20
> We should first check autoconfig and then move to the 3rd party
> database, this is how thunderbird[0] and aerc[1] do it.

Ah, I thought Thunderbird did the opposite. Thanks for noticing that.
It does make more sense to use autoconfig first.

>=20
>>=20
>> 2. If that fails, it attempts to fetch the autoconfig file from the emai=
l
>>   provider's autoconfig URL, which is typically in the format
>>   `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[emai=
l]`.
>=20
> The documentation mentions using `DOMAIN/.well-known/autoconfig/mail/`
> as an alternative to the autoconfig subdomain, what do you think about
> supporting that?

Can be supported, but I unfortunately didn't find any email provider having
that sort of server to test. Do you have any in mind? Nevertheless, and unt=
ested
implementation can be done.

>=20
>>=20
>> 3. If that also fails, it falls back to checking the MX records of the
>>   domain used in the email address to find the SMTP server. It can be
>>   useful in case of emails with custom domains. It attempts to guess
>>   the correct domain for the email from the MX records, and repeats the
>>   first 2 steps with the guessed domain.
>>=20
>> This feature is heavily inpired by the autoconfig feature in Mozilla
>=20
> s/inpired/inspired

Thanks for noticing that :)

>=20
>=20
>> +sub parse_config {
>> +	require XML::LibXML;
>> +	my ($xml, $email) =3D @_;
>> +	my $parser =3D XML::LibXML->new;
>> +	my $doc =3D eval { $parser->load_xml(string =3D> $xml) };
>> +	die "Failed to parse XML\n" unless $doc;
>> +	my $config_num =3D 0;
>> +	my $smtp_encryption_config;
>> +	my $smtp_user_config;
>> +
>> +	foreach my $outgoing ($doc->findnodes('//outgoingServer')) {
>> +		$config_num++;
>> +		if ($outgoing->findvalue('./socketType') eq 'SSL') {
>> +			$smtp_encryption_config =3D 'ssl';
>> +		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {
>> +			$smtp_encryption_config =3D 'tls';
>> +		} else {
>> +			$smtp_encryption_config =3D 'plain';
>=20
> 'plain' is unencrypted, I think this should be accompanied by a big
> warning.

Any ideas on how you want that to be displayed?

>=20
>> +		}
>> +
>> +		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {
>> +			$smtp_user_config =3D $email;
>> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') {
>> +			$smtp_user_config =3D (split /@/, $email)[0];
>> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {
>> +			$smtp_user_config =3D (split /@/, $email)[1];
>> +		} else {
>> +			$smtp_user_config =3D $outgoing->findvalue('./username');
>> +		}
>> +
>> +		print "\nConfiguration $config_num:\n";
>> +		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";
>> +		print "  Port: ", $outgoing->findvalue('./port'), "\n";
>> +		print "  Encryption: ", $smtp_encryption_config, "\n";
>> +		print "  Username: ", $smtp_user_config, "\n";
>=20
> The new option only gives you the needed SMTP configuration, as a
> user you still need to apply them and to do that you will need to
> look up how. We could help the user here and give them copy and
> paste commands similar to when trying to commit without having an
> identity set.

Git allows you to set it as global config or repo specific config.
I'm not sure how to give a copy/paste command for different needs.

>=20
> The XML file also contains authentication details, what do you think
> about processing those? That would also allow adding references to the
> documentation in case it is OAuth2.

Honestly, app passwords remain as a preferred way to use git send-email.
Outlook I guess is just an exception due to obvious reasons. Plus, OAuth2
does not tell if the Auth is XOAUTH2 or OAUTHBEARER. Not sure if its worth
adding here. I am open to ideas on use cases though, and may try to
implement.

>=20
>> +	}
>> +}
>> +
>> +if ($get_smtp_server) {
>> +	require URI::Escape;
>> +	print "Enter your email address: ";
>> +	chomp(my $email =3D <STDIN>);
>=20
> Someone sending out emails will most likely already have set up
> `user.email` in their gitconfig. We could just use that instead of
> prompting for user input, or at least suggest it as a default.

Suggesting as a default is better then not prompting. Although I think
it won't be easy to read the config since all this exits before the config
is parsed (I guess?).>
> If you don't have an SMTP server configured then `git send-email`
> will default to `localhost` and fail if you are not running a
> local SMTP server with: `Unable to initialize SMTP properly.
> Check config and use --smtp-debug.`. I would suggest altering the
> message pointing the user to the new option.

"Unable to initialize SMTP properly. Check config and use --smtp-debug. Use=
 --get-smtp-server to get the correct settings for you SMTP server if neede=
d."

What do you think about that?
