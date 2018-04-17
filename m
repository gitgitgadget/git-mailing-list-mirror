Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5641F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeDQSrs (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:47:48 -0400
Received: from mail-sn1nam02on0117.outbound.protection.outlook.com ([104.47.36.117]:40788
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751836AbeDQSrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rGzXuy3m13siFSpeMvgFjM3GF6CkrnR0SldJAyKYWDg=;
 b=OdfyJ+fOVHFCjv1RVtUQh43675kLBVctw32cHnWX7PMcu28AC5PSnfKx7xocf9nJaMcFv72BYkP5s2pTOo5SY9shHFuxkIDUKoFTDt1LkfICPMqZz+LQYoF2znURdBLvBZgSnSx1RWaB37oUqeUG8Kg4I6ZKjIuspudYvF7JFLY=
Received: from BYAPR08MB3845.namprd08.prod.outlook.com (52.135.193.27) by
 BYAPR08MB3896.namprd08.prod.outlook.com (52.135.194.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.675.14; Tue, 17 Apr 2018 18:47:45 +0000
Received: from BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62]) by BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62%13]) with mapi id 15.20.0675.015; Tue, 17 Apr
 2018 18:47:45 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     Thandesha VK <thanvk@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize'
 key
Thread-Topic: [BUG] git p4 clone fails when p4 sizes does not return
 'fileSize' key
Thread-Index: AQHT1du7X51QcloYSUG+Lp9Mls7MJ6QFJMMAgAAQcACAAAD9BoAACkmAgAAHyno=
Date:   Tue, 17 Apr 2018 18:47:45 +0000
Message-ID: <BYAPR08MB3845A66624486DD1D534050EDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com>
 <CAJJpmi9OQicqEonVwWMo+yimU5MBdJ9gwzbtY1GXSMB+E69AGA@mail.gmail.com>
 <BYAPR08MB384591845049E50D98A42303DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>,<CAJJpmi_Qk-Q3ndiOFiYy5fGsKsJ0mF=nKbSDkdY-NE0DRkZTEg@mail.gmail.com>
In-Reply-To: <CAJJpmi_Qk-Q3ndiOFiYy5fGsKsJ0mF=nKbSDkdY-NE0DRkZTEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB3896;7:CxE/miV4dJiUwj63RnyN7HfVHTG5nrrXqP+NxU7oKwxSocO38s0OAOiIWlJObMtFYb9N8gkFY7C7I18G12cU/Al+vhwS36TL8RF9IaurfB4W/B3IpAxrfXBLO5TG4STEWJXNfPsYJsT4hLdjen9XEouyKnkCovMDmmoJ68yJ1m0+mM/3TMC0YEz8t4kopYaP6g6mrr0t1wIHnG4sXxWe82Etqufw9Y3KbnsqV1C1byCkEWtx5eeJeXxaUmNlNVsO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB3896;
x-ms-traffictypediagnostic: BYAPR08MB3896:
x-microsoft-antispam-prvs: <BYAPR08MB389625A48BD94FF6F9686CBCDAB70@BYAPR08MB3896.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BYAPR08MB3896;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB3896;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(39850400004)(346002)(396003)(199004)(189003)(6246003)(39060400002)(106356001)(99286004)(3660700001)(53936002)(6436002)(97736004)(3280700002)(5250100002)(229853002)(33656002)(9686003)(186003)(446003)(2906002)(2900100001)(11346002)(476003)(25786009)(26005)(68736007)(81156014)(93886005)(1411001)(81166006)(54906003)(55016002)(478600001)(486006)(8676002)(3846002)(6116002)(105586002)(6916009)(5660300001)(8936002)(7736002)(59450400001)(316002)(76176011)(6506007)(86362001)(4326008)(53546011)(102836004)(305945005)(74316002)(14454004)(66066001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB3896;H:BYAPR08MB3845.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vddu9nSGMQ8ugd69znJCFVxYABvPr/M4A0fbGU0fX8RMfg9vCzsEJZHleyFnBk18DMA+u0svS0WSmNY/nk5dvCpxtJxQvfE5STP3RMuUgVTludy/x78PT4mqJSXCYR3FhE1ZDhUuVb9j+cTB806lii50ZoRkpKTNm/fcjix8MQ8vBTYixkMDpYU+ZAJhzitV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: de10045d-1277-4190-bae7-08d5a493b5ac
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de10045d-1277-4190-bae7-08d5a493b5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:47:45.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB3896
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Does a missing "fileSize" actually mean that there is something wrong with =
the file?
Because, for me, `p4 -G print` doesn't print "fileSize" for _any_ file.
(which I attribute to our rather ancient (2007.2) Perforce server)
I'm not an expert in Perforce, so don't know for sure.

However, `p4 -G sizes` works fine even with our p4 server.
Should we then go one step further and use `p4 -G sizes` to obtain the "fil=
eSize" when it's not returned by `p4 -G print`?
Or is it an overkill for a simple verbose print out?

Also, please, find one comment inline below.

Thank you,
Andrey

From: Thandesha VK <thanvk@gmail.com>
> Sounds good. How about an enhanced version of fix from both of us.
> This will let us know that something is not right with the file but
> will not bark
>=20
> $ git diff
> diff --git a/git-p4.py b/git-p4.py
> index 7bb9cadc6..df901976f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2566,7 +2566,12 @@ class P4Sync(Command, P4UserMap):
> =A0=A0=A0=A0=A0=A0=A0=A0 relPath =3D self.stripRepoPath(file['depotFile']=
, self.branchPrefixes)
> =A0=A0=A0=A0=A0=A0=A0=A0 relPath =3D self.encodeWithUTF8(relPath)
> =A0=A0=A0=A0=A0=A0=A0=A0 if verbose:
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D int(self.stream_file['fileSiz=
e'])
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if 'fileSize' not in self.stream_file:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 print "WARN: File size from p=
erforce unknown. Please verify by p4 sizes %s" %(file['depotFile'])
For whatever reason, the code below uses sys.stdout.write() instead of prin=
t().
Should it be used here for consistency as well?

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D "-1"
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D self.stream_file['fi=
leSize']
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D int(size)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sys.stdout.write('\r%s --> %s (%i MB=
)\n' %
> (file['depotFile'], relPath, size/1024/1024))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sys.stdout.flush()
>=20
>=20
> On Tue, Apr 17, 2018 at 10:33 AM, Mazo, Andrey <amazo@checkvideo.com> wro=
te:
>> Sure, I totally agree.
>> Sorry, I just wasn't clear enough in my previous email.
>> I meant that your patch suppresses "%s --> %s (%i MB)" line in case "fil=
eSize" is not available,
>> while my patch suppresses just "(%i MB)" portion if the "fileSize" is no=
t known.
>> In other words,
>>=A0 * if "fileSize" is known:
>>=A0 ** both yours and mine patches don't change existing behavior;
>>=A0 * if "fileSize" is not known:
>>=A0 ** your patch makes streamOneP4File() not print anything;
>>=A0 ** my patch makes streamOneP4File() print "%s --> %s".
>>
>> Hope, I'm clearer this time.
>>
>> Thank you,
>> Andrey
>>
>> From: Thandesha VK <thanvk@gmail.com>
>>> *I* think keeping the filesize info is better with --verbose option as
>>> that gives some clue about the file we are working on. What do you
>>> think?
>>> Script has similar checks of key existence at other places where it is
>>> looking for fileSize.
>>>
>>> On Tue, Apr 17, 2018 at 9:22 AM, Andrey Mazo <amazo@checkvideo.com> wro=
te:
>>>> Huh, I actually have a slightly different fix for the same issue.
>>>> It doesn't suppress the corresponding verbose output completely, but j=
ust removes the size information from it.
>>>>
>>>> Also, I'd mention that the workaround is trivial -- simply omit the "-=
-verbose" option.
>>>>
>>>> Andrey Mazo (1):
>>>>=A0=A0 git-p4: fix `sync --verbose` traceback due to 'fileSize'
>>>>
>>>>=A0 git-p4.py | 8 ++++++--
>>>>=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>>
>>>> base-commit: 468165c1d8a442994a825f3684528361727cd8c0
>>>> --
>>>> 2.16.1
>>>>
>>>
>>> --
>>> Thanks & Regards
>>> Thandesha VK | Cellphone +1 (703) 459-5386
>
>
>
> --=20
> Thanks & Regards
> Thandesha VK | Cellphone +1 (703) 459-5386=
