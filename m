Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977A43ABC
	for <git@vger.kernel.org>; Sun, 25 May 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171202; cv=fail; b=i9H1iqTTFmx1Wr3560aftT6GlUixS9Lp6DKU/VV+cEpngkiYXsyWehi1wUDweLQ44Glq3SQEYCS65X1cEbFjfznppob9DQimQtV9Fp9m6ZbR4Hirl2vUS/r6m0jomhySfY7WBfVPRePivxd20HIhNPDp7TJerV2I3bMh+eM3F6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171202; c=relaxed/simple;
	bh=EC3Qy5De3SqLL7ddzfLyKvMfSWQolpn30szFvMOgxr8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PpT9jxEsg2HzlYryHlZ66n0d1kLlResMkFbgm3WTw//7cHOehVuhLklfQK1THfn8VLF2Tf9SSIbujWUtheg5pCnpbDijbWJzJ+vculx/Es05hhV7tBtXwmrxYh9TWZlOCJZw7eobOgRCHCiQ6DEoUAO5VXUL0vrbXcbnrc5w76Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=J5uQ8AlL; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="J5uQ8AlL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hy8qJXirUSYLHFcuLmsDSc4EIhqBH77dEIHtPmItnvGKZvtFjxOogoQpvusLCGNTpn1TggUK76ApSi0oZv6eihAHrDyLggV63N0eRajBKNiR0zRcjbNuLDEHzYugCxTgYIP4UYPwMfhaq5KqNTvQl8MRaHs2TWFgBkowMLSz1qXALbIs9SbTpROl98f4PJaNx2Zcmw9MtLSnC2WMgopsSEGpMl3PM3FQ2JN5bVBrbg0wwAzQ+1Fi1a6ZgHgPsGoxJlnIecSzJZLp6pFSkA6AtvK2HNc+4zY8pLPkTHaG71D6qwefbpyuqNKq5TJcYLLG/h2cvX5R+n5JtfC23MzMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2O4Nf5OCpVAFcdCduDyK15Z3RxWYDc04Z5iyERqXQU=;
 b=wzFyAENhR6tD681mLJITpqv7BAOpBSoCV0roXwYPHiT5HaHmkyT0/CmQTjKBaVx051XE+lp7ZmQI+N7aJcK5HOa3ICoa8JLqA6KhOBOeWI+3NkxG4dNelHT+FSS+vIQ3ylj6whn4sqJhT1VSxcPWLVy8vDkxXYrwj8imVW6BfpwA57i+wLCKt0BRn7qcuzzXWQfBsk4CQwyggOcbm/lYygwrw3Cy/3/6XYGIN2J9PXI/YYA2tRTwR4dbnOAFTBFARm24bu/WgkkKMKnoAt60pHbV29pbcdjY7d8b8OBux5sDiZXBQg6UyqWq4kkNOuqJa+zEvi2BdPATIgHQiiDRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2O4Nf5OCpVAFcdCduDyK15Z3RxWYDc04Z5iyERqXQU=;
 b=J5uQ8AlLgyRY4f1G+buBgru8NoWndk/J8grUmX1oeqzGyIARGRScMacgO/xKA19oj//AEiETm/113kroL5nue1qd8W6p+ppzfrtW8+YRYgoRQFEF90FvbZW2WnOQewsOlJZdXUCm34hSN+p6/+oYCZh3VnjW0JvAnZiYO2uBN3NbpRuwCnvKfBOX0rDWrhzUfk9D4uiDKkf8bVn6vct4E4XtCo91GOmNeQVrKr2lPz3JOjy2SzDTNWfcxx7meIpQswZjt6d7Y0cG8gy0kt5dK1/RxhgLeRd3hOohjxh1K/f+kr5xJgyFJzE9Vst0fPbTVAhAIN9cNNj5nBs9g11OGA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPF1C007E3A1.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Sun, 25 May
 2025 11:06:33 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sun, 25 May 2025
 11:06:33 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Jeff King <peff@peff.net>, Zi Yao <ziyao@disroot.org>, Rens Oliemans
	<hallo@rensoliemans.nl>, Drew DeVault <drew@ddevault.org>
Subject: [PATCH RFC] send-mail: add support for Microsoft Graph API
Thread-Topic: [PATCH RFC] send-mail: add support for Microsoft Graph API
Thread-Index: AQHbzWUSqVJsjYz9NU+BJwLg9+xtcg==
Date: Sun, 25 May 2025 11:06:32 +0000
Message-ID: <20250525110621.64308-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PPF1C007E3A1:EE_
x-ms-office365-filtering-correlation-id: b6e0d9a9-d2eb-488b-d122-08dd9b7c3557
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|8062599006|41001999006|19110799006|15080799009|461199028|5062599005|38102599003|440099028|3412199025|19111999003|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6JUQ45tO/n4HmJlpQwHMWavjZKdwULyyQlFJx5wX7+JTzvQlFwjSrzUJBF?=
 =?iso-8859-1?Q?3bu+hrlUZe6ZosTU/gWMTWU+V9V+8Xd3bAS+L8snM+GCO4UF9SEGlNktpQ?=
 =?iso-8859-1?Q?wf4ZoTSybfXk7+ezcAmANBsM540KHMAk1p8Am9eoB2kWUO14RvJrSjob/W?=
 =?iso-8859-1?Q?gnUksqJ+iE8/4BlwTRTrPiki0S3ma2OeVAat2fyh3q2T+zKasZWYCUzs3v?=
 =?iso-8859-1?Q?dYOmskT2KtDQXWwCh5sBaeWDAq2xDzE0Wth5PKw+5jM3c0HPWmIkusmUuR?=
 =?iso-8859-1?Q?YeO0i5E2QvpUkoN/uAXXZPA6x2iKV+qQ5aIZWUhyEnC1SfcOlV3hG5orQW?=
 =?iso-8859-1?Q?nJh2m6fbjY33NuNCSL2TDQmm94gBmt1glk7tKFDCR4Tyhp3L+Ac/UcscLO?=
 =?iso-8859-1?Q?RMJ4MENc9JEhYPBFxiIm6E0xULw8FWSS4prHmhYrvmUbD4psAs7tEUQk1d?=
 =?iso-8859-1?Q?2mw6VplFmYHQM8JipbYsLPQRNcVkvcx+yY4fREmsKp8En8xGecB+ODxFsa?=
 =?iso-8859-1?Q?wcRORixuspYY2qOGZICNTaOHk0Q/d2gc9vDJXo1g5ORlHEvv7Xgf2X2eUw?=
 =?iso-8859-1?Q?9HYsD5cveS5FNoVYx5VKIdgeYWoh0HC5sh3ndybMN7j4n1oNKd14vXAZI6?=
 =?iso-8859-1?Q?NDYXfpH6mr29Ygjy+geWTk3KSxpSnZDvMiZEOItXH2+kusQu/Wnep+TJdJ?=
 =?iso-8859-1?Q?495/U3bdDjj9aPnPvUiKPWEdog4nJnJM3sZdg1Q3LpTw8UoX56OvkBNE5+?=
 =?iso-8859-1?Q?k8amTebFgzmt4UUIsOSSzMOHuDHMuNZL/ZpRsrNMAXLgS8C9+x9RYw1OsH?=
 =?iso-8859-1?Q?4NRPddDqwfWlxTYqzWgP8LQpimuVS1eb2k512LHLPnC4rSl7/Tzfx93wmu?=
 =?iso-8859-1?Q?A1oj4Js21PobwLxZ9OmtuHJ1YRCQ9B3R1/hKJFYvxui3nY7+y4rtSEGONR?=
 =?iso-8859-1?Q?B24TEQd3P4nBtFsHN6iDL5M21NddKDRB8n/03y76mE0G2Nc/U/QOpJstr/?=
 =?iso-8859-1?Q?rLtFYjk44w+1TIcnR+H3ga2XlDAWhZKDYyUEQoxOgk+IW5DnY+iSZSauYS?=
 =?iso-8859-1?Q?hHEaCHi3z2HqKlq8lEuH+bn1yfBBf5ELhnWsIoH3ZLf4SwGRMO19dprGzM?=
 =?iso-8859-1?Q?NVDbpu4F6pDdRYZIsGkkgUiDBkthUnH2yF1tBBGeFUFj+XAAjrdXxsGhDt?=
 =?iso-8859-1?Q?71s0SvZ5Y/uvCTan8wEUznnXpuJxCX3CHJDBTEmrPu6u4dhyyuv9LSc84n?=
 =?iso-8859-1?Q?0B/M/TOXflHzNtCUTUPgzqR5VL6/Kt8sJhSeHhzmtU0COCsOhvPZtt/tXL?=
 =?iso-8859-1?Q?+ytzcxTWBAjSiNfgFl5gNaCV47seUWyFq4RkprSc/A/RKvZFzTpet14tQJ?=
 =?iso-8859-1?Q?w9PDqVfiO15B9lLgNKSx9LkvgU3SOsYA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+g2WsL0EkGU8825OsliOvdwaXRIKmjaoCqwAX0yj7PAK0BTXEb3QAjiPQB?=
 =?iso-8859-1?Q?tiX+xh/3/WkeHBe/0CYApNTx0eX9liiAgtkGmxpkqAJFTF8bBFX9kUA9ts?=
 =?iso-8859-1?Q?nVjuZMZ80Z1BvRX+UgezHBpIOvNaVcapnJmCN8uNl5lHpdQT/AqJxKhh2u?=
 =?iso-8859-1?Q?o6/M9QqaoLrZn/N1jQhY0T83XlKKTVFua54aSL49BogFl6ACH+RX5RWv6R?=
 =?iso-8859-1?Q?sBD3ttC80dIryLUnQw/0D82eWvLfZnwzbpAPJ/goCzjI+oc5ksBWUQFrkf?=
 =?iso-8859-1?Q?KixW4Oqkw+XW/uptNVeGzSV67jsiRlYG2UtSGItpeRvtoUJkhz+DMKrnkH?=
 =?iso-8859-1?Q?bUJSwZ08QkknfluXlyl9dqiKS401xCCWexyvlvAFqWGRrdGMrISIzNqwCj?=
 =?iso-8859-1?Q?sehhfhKwxMGZJJpp6SJPMYsxntP1qC3UDR3ZRdfvXzs2jb+1ueRcWYP1Wt?=
 =?iso-8859-1?Q?EAs3jeWD4N4UFaFbmI5tNOPjCNdHWyshR95b5ZbiXELdlMEkLaPU7OD+oC?=
 =?iso-8859-1?Q?JrkbLle/E7Nkh+zQFxU7UB3rO56ygAjc6Lvcy8Ue/G8G34RNGpC246urMC?=
 =?iso-8859-1?Q?n4tVm9/ypbTYzPvvs438B7eVrWvJbv6EA6E7439nyGtxI7IV5+U4P5dDgS?=
 =?iso-8859-1?Q?B3bXTNM/7vZHmcKLZynrkeM59nJN/zs5Yw+HewoqZQwtstQCMWpE8mrUSl?=
 =?iso-8859-1?Q?BWobmXhY1S+mKnEdy3JkPEqMMx593yN/99osbKRCMpMftGHRrIZ8q5DQFP?=
 =?iso-8859-1?Q?+5a3GTpqxUZTjfIZ/HvKBQuGKhqDHXrNHwcs8u4AWW09nk8mqFyJqMItCM?=
 =?iso-8859-1?Q?jqEmbOE9O2Bpl+R+LROeX6K2eyXu4gwudK8x1GUvDv0j0KI4nf6lwGkYT8?=
 =?iso-8859-1?Q?ZieujQOI5v6vwHU/Hs66hV++W5fdLvMzyEju6QM9iC8YHb9uRU9ase6Odr?=
 =?iso-8859-1?Q?lMbS1mKZIT0vANbQ9oiXmJXampTJOmKjfqEkSwoTu5MDx1FyEAG/7aKKsR?=
 =?iso-8859-1?Q?+4HQXsjO1eXCMoGJRUfM5RzNndi2uejahlODjX3DVkB66OGMWvzrA/45OP?=
 =?iso-8859-1?Q?NSPei4ywnCym7mRnhbKuL9190VHxVK0/5w/GEbWdgGyLy4/8tQScnmojgb?=
 =?iso-8859-1?Q?zFPYrmvQsf5t1T1Hp8cBeQTAAEhdiCVdQwX2HYJEcd1X+Cx/jutC4CjlnR?=
 =?iso-8859-1?Q?dYehie3G2+pkLEOGzh1Borvk+M0LVoN1wLxKFhDmIM1+CDRVHrARf7LN8B?=
 =?iso-8859-1?Q?j7NPLHgkle/Nl0/K662WLPC5BeWC0lqqrezIzQ+ts=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e0d9a9-d2eb-488b-d122-08dd9b7c3557
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 11:06:32.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPF1C007E3A1

Apart from SMTP, Microsoft also provides a REST API, branded as
Microsoft Graph for sending mails. Upon testing a bit, I have
found a few benefits over SMTP. Firstly, SMTP servers of Microsoft
are kinda slow. On an average, initialising the SMTP server even
on a fast internet connection takes around 8-10 seconds with
send-email. Once initialised, subsequent messages sometimes also
face delays, taking around 3-5 seconds per message, and other
times they are sent almost instantaneously. Secondly, their SMTP
server does not respect the Message-ID specified by the user and
replaces it with their own generated string.

Microsoft Graph API solves both these problems. It is extremely
fast, taking around 1 second to send a series of 5 patches, and
also respects the Message-ID specified by the user.

After this patch, users can use the graph API by having their
config as:

[sendemail]
	useMSGraph =3D true
	MSGraphUser =3D yourname@outlook.com

The API requires an OAuth2.0 access token for authentication, and
users can either generate them manually, or use a credential helper


TODO:
I still need to write the documentation for this feature, but I wanted to
get the code reviewed first.

PS: This patch is sent using MS Graph. Note the fixed Message-ID ;)

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 71 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b09251c4fc..edb96c7e1a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -73,7 +73,10 @@ sub usage {
     --no-smtp-auth                 * Disable SMTP authentication. Shorthan=
d for
                                      `--smtp-auth=3Dnone`
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
-
+    --[no-]use-msgraph      <str>  * Use Microsoft Graph API instead of SM=
TP.
+    --msgraph-user          <str>  * Username in case an email API is used=
.
+                                     If not specified, the from address is=
 used.
+    --msgraph-token         <str>  * OAuth2.0 access token for the email A=
PI.
     --batch-size            <int>  * send max <int> message per connection=
.
     --relogin-delay         <int>  * delay <int> seconds between two succe=
ssive login.
                                      This option can only be used with --b=
atch-size
@@ -201,7 +204,7 @@ sub format_2822_time {
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@xh,$envelope_sender,
 	$initial_in_reply_to,$reply_to,$initial_subject,@files,
-	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
+	$author,$sender,$smtp_authpass,$annotate,$compose,$time,$msgraph_token);
 # Things we either get from config, *or* are overridden on the
 # command-line.
 my ($no_cc, $no_to, $no_bcc, $no_identity, $no_header_cmd);
@@ -283,6 +286,7 @@ sub do_edit {
 my ($compose_encoding);
 my ($sendmail_cmd);
 my ($mailmap_file, $mailmap_blob);
+my ($msgraph_user);
 # Variables with corresponding config settings & hardcoded defaults
 my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
 my $thread =3D 1;
@@ -293,6 +297,7 @@ sub do_edit {
 my $target_xfer_encoding =3D 'auto';
 my $forbid_sendmail_variables =3D 1;
 my $outlook_id_fix =3D 'auto';
+my $use_msgraph =3D 0;
=20
 my %config_bool_settings =3D (
     "thread" =3D> \$thread,
@@ -309,6 +314,7 @@ sub do_edit {
     "forbidsendmailvariables" =3D> \$forbid_sendmail_variables,
     "mailmap" =3D> \$mailmap,
     "outlookidfix" =3D> \$outlook_id_fix,
+    "usemsgraph" =3D> \$use_msgraph,
 );
=20
 my %config_settings =3D (
@@ -337,6 +343,8 @@ sub do_edit {
     "composeencoding" =3D> \$compose_encoding,
     "transferencoding" =3D> \$target_xfer_encoding,
     "sendmailcmd" =3D> \$sendmail_cmd,
+    "msgraphuser" =3D> \$msgraph_user,
+    "msgraphtoken" =3D> \$msgraph_token,
 );
=20
 my %config_path_settings =3D (
@@ -556,6 +564,9 @@ sub config_regexp {
 		    "git-completion-helper" =3D> \$git_completion_helper,
 		    "v=3Ds" =3D> \$reroll_count,
 		    "outlook-id-fix!" =3D> \$outlook_id_fix,
+		    "use-msgraph!" =3D> \$use_msgraph,
+		    "msgraph-user=3Ds" =3D> \$msgraph_user,
+		    "msgraph-token:s" =3D> \$msgraph_token,
 );
 $rc =3D GetOptions(%options);
=20
@@ -1095,7 +1106,7 @@ sub expand_one_alias {
 	$reply_to =3D sanitize_address($reply_to);
 }
=20
-if (!defined $sendmail_cmd && !defined $smtp_server) {
+if (!defined $sendmail_cmd && !defined $smtp_server && !$use_msgraph) {
 	my @sendmail_paths =3D qw( /usr/sbin/sendmail /usr/lib/sendmail );
 	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};
 	foreach (@sendmail_paths) {
@@ -1603,6 +1614,7 @@ sub is_outlook {
 sub send_message {
 	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) =3D =
gen_header();
 	my @recipients =3D @$recipients_ref;
+	my $msgraph_response_code;
=20
 	my @sendmail_parameters =3D ('-i', @recipients);
 	my $raw_from =3D $sender;
@@ -1680,6 +1692,52 @@ sub send_message {
 		}
 		print $sm "$header\n$message";
 		close $sm or die $!;
+	} elsif ($use_msgraph) {
+		# Use Microsoft Graph API
+		# https://learn.microsoft.com/en-us/graph/api/user-sendmail
+		my $auth_api;
+		if (!defined $msgraph_user) {
+			$msgraph_user =3D (defined $smtp_authuser
+				? $smtp_authuser
+				: $raw_from
+			);
+		}
+		require MIME::Base64;
+		require HTTP::Tiny;
+		$auth_api =3D Git::credential({
+			'protocol' =3D> 'https',
+			'host' =3D> 'graph.microsoft.com',
+			'username' =3D> $msgraph_user,
+			'password' =3D> $msgraph_token,
+		}, sub {
+			my $cred =3D shift;
+			$msgraph_token =3D $cred->{'password'};
+		});
+		my $email_url =3D "https://graph.microsoft.com/v1.0/users/$msgraph_user/=
sendMail";
+		my $real_message =3D "$header\n$message\n";
+		# Convert LF to CRLF
+		unless ($real_message =3D~ /\r\n/) {
+			$real_message =3D~ s/\r?\n/\r\n/g;
+		}
+		# The API requires the message to be base64 encoded if sending in MIME f=
ormat.
+		my $encoded_message =3D MIME::Base64::encode_base64($real_message, "");
+		my $http =3D HTTP::Tiny->new(
+			default_headers =3D> {
+				'Authorization' =3D> "Bearer $msgraph_token",
+				'Content-Type'  =3D> 'text/plain',
+			},
+		);
+		my $response =3D $http->post($email_url, {
+			content =3D> $encoded_message,
+		});
+
+
+		if (!$response->{success}) {
+			die sprintf(__("Failed to send email: %s\nResponse: %s"),
+				$response->{status}, $response->{content});
+		} else {
+			$msgraph_response_code =3D $response->{status};
+		}
 	} else {
=20
 		if (!defined $smtp_server) {
@@ -1790,12 +1848,15 @@ sub send_message {
 	} else {
 		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
 		print "\n";
-		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) {
+		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)
+		   && !$use_msgraph) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
 			foreach my $entry (@recipients) {
 			    print "RCPT TO:<$entry>\n";
 			}
+		} elsif ($use_msgraph) {
+			print "Email API: Microsoft Graph API\n";
 		} else {
 			my $sm;
 			if (defined $sendmail_cmd) {
@@ -1810,6 +1871,8 @@ sub send_message {
 		if ($smtp) {
 			print __("Result: "), $smtp->code, ' ',
 				($smtp->message =3D~ /\n([^\n]+\n)$/s);
+		} elsif (defined $msgraph_response_code) {
+			print __("Result: "), $msgraph_response_code;
 		} else {
 			print __("Result: OK");
 		}
--=20
2.49.0


