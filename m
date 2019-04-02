Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C89F20248
	for <e@80x24.org>; Tue,  2 Apr 2019 17:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfDBRNj (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 13:13:39 -0400
Received: from mail-eopbgr790111.outbound.protection.outlook.com ([40.107.79.111]:17232
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728658AbfDBRNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 13:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d22vD2UrxWlg5Q2SHk4QxqdigfKJNlJJnrLUwrPi11c=;
 b=xSz2y+eSxzbgtoaPwPtNFGUpuQby3LwB64bcZgYqLAWTQ7ooDV3dElEaJ1HCyiSDbtyLyrGGi5zdQgkBa/72W8fuw4wEcd/r86vXKX/kH/t9351wsOr3h6ajBdTqtDrvvn01ZEm2OfTaGyWeNasRLZA0cVsP5whDS3TX8SQ6srM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4041.namprd08.prod.outlook.com (20.176.69.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 2 Apr 2019 17:13:33 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Tue, 2 Apr 2019
 17:13:33 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "szeder.dev@gmail.com" <szeder.dev@gmail.com>
CC:     "ahippo@yandex.com" <ahippo@yandex.com>,
        "Mazo, Andrey" <amazo@checkvideo.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>
Subject: Re: [PATCH v3 2/8] git-p4: add failing test for "git-p4: match
 branches case insensitively if configured"
Thread-Topic: [PATCH v3 2/8] git-p4: add failing test for "git-p4: match
 branches case insensitively if configured"
Thread-Index: AQHU6LUNbC8yZm9uaEqFmDinXPwhyKYox1mAgABV9oA=
Date:   Tue, 2 Apr 2019 17:13:33 +0000
Message-ID: <20190402171317.1364-1-amazo@checkvideo.com>
References: <20190402120537.GK32732@szeder.dev>
In-Reply-To: <20190402120537.GK32732@szeder.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d591fad-5c6f-42d0-b62c-08d6b78e88f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB4041;
x-ms-traffictypediagnostic: DM6PR08MB4041:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR08MB4041D8B36F250909810E1AD9DA560@DM6PR08MB4041.namprd08.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39850400004)(189003)(199004)(476003)(66066001)(2616005)(2501003)(102836004)(6916009)(4326008)(68736007)(6436002)(26005)(256004)(7416002)(71200400001)(3846002)(81156014)(71190400001)(14454004)(6116002)(446003)(966005)(2906002)(7736002)(478600001)(8936002)(186003)(25786009)(6306002)(8676002)(106356001)(11346002)(386003)(99286004)(81166006)(6506007)(6512007)(14444005)(6246003)(76176011)(1076003)(53936002)(486006)(2351001)(5660300002)(305945005)(97736004)(229853002)(36756003)(50226002)(1361003)(86362001)(52116002)(105586002)(316002)(6486002)(54906003)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4041;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NIDpQRqS+PV2+YU9FqYy2j55WrzMf/9YwEPyo2ESPEkDfKYSocLs7j5DOOgX2DoK8oi4po04bC01J1MHnHREPaph3eHq+ak3oXV0zbzda0AiTbkaBWkrZq2f/WwuiCByTlAIA0av5avOvXMn9e+QHprFr4k3Pz7hECvGY9m8PxGNVZwK1GlFIZ60uT52JfQdOzsJyeHJIcoxCMktY2AsQjYbwX+6nA7Y1rE0IsKa9nyy4aKJUOeTxB+NrDw6/ep0XwNaFtox8Xzz0e0HhClv8EZYY74PQ5AU98gvZzMY8n/cnOKtSgbN3hwflVqvJ8VQkuhQ6NGnNgLYmzeOA+Uupp4OHi1nAt6OXPgPtHpVBWUGObak8f8mLQQ/3UaFnczhAtpbFr39nLQcrmSuFUwLOzA4xMcw68dQDE6ZrbuWx58=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d591fad-5c6f-42d0-b62c-08d6b78e88f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 17:13:33.5687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4041
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Apr 01, 2019 at 06:02:21PM +0000, Mazo, Andrey wrote:
>> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
>> index 6a86d6996b..c48532e12b 100755
>> --- a/t/t9801-git-p4-branch.sh
>> +++ b/t/t9801-git-p4-branch.sh
>> @@ -608,10 +608,102 @@ test_expect_success 'Update a file in git side an=
d submit to P4 using client vie
>>  		cd branch1 &&
>>  		grep "client spec" file1
>>  	)
>>  '
>>
>> +test_expect_success 'restart p4d (case folding enabled)' '
>> +	kill_p4d &&
>> +	start_p4d -C1
>> +'
>=20
> There is a semantic conflict between this patch and commit 07353d9042
> (git p4 test: clean up the p4d cleanup functions, 2019-03-13) in
> 'sg/test-atexit' currently cooking in 'pu': this patch adds a new
> callsite of 'kill_p4d', but that commit renamed that function to
> 'stop_and_cleanup_p4d'.  Consequently, t9801 on 'pu' now fails with:
>=20
>   +kill_p4d
>   t9801-git-p4-branch.sh: 4: eval: kill_p4d: not found
>   error: last command exited with $?=3D127
>   not ok 28 - restart p4d (case folding enabled)
>=20
> https://travis-ci.org/git/git/jobs/514513463#L5827
>=20
> I wonder whether it would be worth amending 07353d9042 to keep
> 'kill_p4d' around as a wrapper around 'stop_and_cleanup_p4d' for the
> time being.
>=20
>=20
> https://public-inbox.org/git/20190313122419.2210-9-szeder.dev@gmail.com/

Good catch!

Don't know what's the proper workflow here, but I see 2 more options:
 * Resolve the conflict in t/t9801-git-p4-branch.sh while merging am/p4-bra=
nches-excludes
   commit d15068a650 ("git-p4: respect excluded paths when detecting branch=
es", 2019-04-01)
 * I can rebase my git-p4 changes on top of sg/test-atexit branch
   commit 74ec8cf674 ("t9811-git-p4-label-import: fix pipeline negation", 2=
019-03-13)

In case this might be helpful,
I did a conflict resolution locally,
(by doing `git checkout d15068a650; git merge 74ec8cf674`)
and here's the patch of the merge.

Basically,
 * a newly added "kill_p4d" is replaced with "stop_and_cleanup_p4d"; and
 * "kill_p4d" in the end of the script is removed.

diff --cc t/t9801-git-p4-branch.sh
index 38d6b9043b,9654362052..67ff2711f5
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@@ -610,4 -650,100 +650,96 @@@ test_expect_success 'Update a file in g
  	)
  '
 =20
+ test_expect_success 'restart p4d (case folding enabled)' '
 -	kill_p4d &&
++	stop_and_cleanup_p4d &&
+ 	start_p4d -C1
+ '
+=20
+ #
+ # 1: //depot/main/mf1
+ # 2: integrate //depot/main/... -> //depot/branch1/...
+ # 3: //depot/main/mf2
+ # 4: //depot/BRANCH1/B1f3
+ # 5: //depot/branch1/b1f4
+ #
+ test_expect_success !CASE_INSENSITIVE_FS 'basic p4 branches for case fold=
ing' '
+ 	(
+ 		cd "$cli" &&
+ 		mkdir -p main &&
+=20
+ 		echo mf1 >main/mf1 &&
+ 		p4 add main/mf1 &&
+ 		p4 submit -d "main/mf1" &&
+=20
+ 		p4 integrate //depot/main/... //depot/branch1/... &&
+ 		p4 submit -d "integrate main to branch1" &&
+=20
+ 		echo mf2 >main/mf2 &&
+ 		p4 add main/mf2 &&
+ 		p4 submit -d "main/mf2" &&
+=20
+ 		mkdir BRANCH1 &&
+ 		echo B1f3 >BRANCH1/B1f3 &&
+ 		p4 add BRANCH1/B1f3 &&
+ 		p4 submit -d "BRANCH1/B1f3" &&
+=20
+ 		echo b1f4 >branch1/b1f4 &&
+ 		p4 add branch1/b1f4 &&
+ 		p4 submit -d "branch1/b1f4"
+ 	)
+ '
+=20
+ # Check that files are properly split across branches when ignorecase is =
set
+ test_expect_success !CASE_INSENSITIVE_FS 'git p4 clone, branchList branch=
 definition, ignorecase' '
+ 	test_when_finished cleanup_git &&
+ 	test_create_repo "$git" &&
+ 	(
+ 		cd "$git" &&
+ 		git config git-p4.branchList main:branch1 &&
+ 		git config --type=3Dbool core.ignoreCase true &&
+ 		git p4 clone --dest=3D. --detect-branches //depot@all &&
+=20
+ 		git log --all --graph --decorate --stat &&
+=20
+ 		git reset --hard p4/master &&
+ 		test_path_is_file mf1 &&
+ 		test_path_is_file mf2 &&
+ 		test_path_is_missing B1f3 &&
+ 		test_path_is_missing b1f4 &&
+=20
+ 		git reset --hard p4/depot/branch1 &&
+ 		test_path_is_file mf1 &&
+ 		test_path_is_missing mf2 &&
+ 		test_path_is_file B1f3 &&
+ 		test_path_is_file b1f4
+ 	)
+ '
+=20
+ # Check that files are properly split across branches when ignorecase is =
set, use-client-spec case
+ test_expect_success !CASE_INSENSITIVE_FS 'git p4 clone with client-spec, =
branchList branch definition, ignorecase' '
+ 	client_view "//depot/... //client/..." &&
+ 	test_when_finished cleanup_git &&
+ 	test_create_repo "$git" &&
+ 	(
+ 		cd "$git" &&
+ 		git config git-p4.branchList main:branch1 &&
+ 		git config --type=3Dbool core.ignoreCase true &&
+ 		git p4 clone --dest=3D. --use-client-spec --detect-branches //depot@all=
 &&
+=20
+ 		git log --all --graph --decorate --stat &&
+=20
+ 		git reset --hard p4/master &&
+ 		test_path_is_file mf1 &&
+ 		test_path_is_file mf2 &&
+ 		test_path_is_missing B1f3 &&
+ 		test_path_is_missing b1f4 &&
+=20
+ 		git reset --hard p4/depot/branch1 &&
+ 		test_path_is_file mf1 &&
+ 		test_path_is_missing mf2 &&
+ 		test_path_is_file B1f3 &&
+ 		test_path_is_file b1f4
+ 	)
+ '
+=20
 -test_expect_success 'kill p4d' '
 -	kill_p4d
 -'
 -
  test_done


