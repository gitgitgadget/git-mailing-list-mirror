Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764DF1F42D
	for <e@80x24.org>; Tue, 17 Apr 2018 21:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeDQVSq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:18:46 -0400
Received: from mail-co1nam03on0118.outbound.protection.outlook.com ([104.47.40.118]:43088
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752766AbeDQVSp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3YXdTuJDPgc02QXn5y+BMlQFK+MxZvDUcZ3m0Fb0YRs=;
 b=ZzkuVKLZ5ks6j/6LCQLBFI5TSqBxLkynfAJFqcUtuOM/KJ/hx9YqvYNM+PpCVqFC581wfNer6G36TYxxJGCHefDGhoDcDFasBy4MxF/zzCbON1YOLQyTkbpQ8Rcq/97/0jGUh02jSzI5NjeXG229guufTWFxQxjYGz3MfRjDn3g=
Received: from BYAPR08MB3845.namprd08.prod.outlook.com (52.135.193.27) by
 BYAPR08MB4375.namprd08.prod.outlook.com (52.135.211.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.696.12; Tue, 17 Apr 2018 21:18:39 +0000
Received: from BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62]) by BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62%13]) with mapi id 15.20.0675.015; Tue, 17 Apr
 2018 21:18:39 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     Luke Diamand <luke@diamand.org>
CC:     George Vanburgh <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "thanvk@gmail.com" <thanvk@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] git-p4: fix `sync --verbose` traceback due to
 'fileSize'
Thread-Topic: [PATCH 1/1] git-p4: fix `sync --verbose` traceback due to
 'fileSize'
Thread-Index: AQHT1mhSkMWRON2QrUWk6Q3es/p1xaQFYKgAgAASF/k=
Date:   Tue, 17 Apr 2018 21:18:39 +0000
Message-ID: <BYAPR08MB3845FEE1844EF613C739CB66DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com>
 <2e2b2add4e4fffa4228b8ab9f6cd47fa9bf25207.1523981210.git.amazo@checkvideo.com>,<CAE5ih7-iQsBxM3Gn4B1Q9WZ2A0=eTHn9nt3a0LVURppOCQsAWA@mail.gmail.com>
In-Reply-To: <CAE5ih7-iQsBxM3Gn4B1Q9WZ2A0=eTHn9nt3a0LVURppOCQsAWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bloomberg.net; dkim=none (message not signed)
 header.d=none;bloomberg.net; dmarc=none action=none
 header.from=checkvideo.com;
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4375;7:UaLMRk6Xbf0J/q4zeYQILmeg6BXndgAKk+gy3IBvoAXygvBHjCAO32QLeCRu4G+dnNFnRgNrOTc4rb1XPzwq3jtCRDR0qHTIEjGCYmzQ5bKB0MFwdyNmOwjC2LJwCvW2nD5iQ2wiFdi5JJiuu1pghzss+Y3U5/N8et2LA48XRpGnuwSvaXecXUe27kPZr+kkB2+3SB5JE9otpyDgNDWw5TC5Dr2OpTXO17nAekhs7FlUMjkyoD2yBXLpuHZ2vNi6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4375;
x-ms-traffictypediagnostic: BYAPR08MB4375:
x-microsoft-antispam-prvs: <BYAPR08MB43756CAB886C79BAAE059243DAB70@BYAPR08MB4375.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231232)(944501327)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR08MB4375;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4375;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(99286004)(33656002)(25786009)(476003)(305945005)(8676002)(74316002)(9686003)(345774005)(6306002)(66066001)(55016002)(6246003)(39060400002)(4326008)(11346002)(446003)(53936002)(8936002)(14454004)(7736002)(81166006)(3846002)(6116002)(6506007)(966005)(3280700002)(3660700001)(186003)(575784001)(86362001)(2900100001)(102836004)(478600001)(316002)(5250100002)(26005)(93886005)(5660300001)(76176011)(6916009)(7696005)(6436002)(2906002)(54906003)(229853002)(59450400001)(81973001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4375;H:BYAPR08MB3845.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: +Kt7Kd2WvmmRk0Fz9rA/JapNkjbSFp8t/ZNGX8mJauXW+1bBDbgKNc9vUT3rJ37yAclFXDKdnI49IEgOgca6CkuywD1b5F+B2AZ+fxoyLw2M/38Ngc4A1mHuXXqYh5UE6rGnGlmYitU+avJuLlKN9rHYoeyO8u1d6piNCn78R0zXnsSLtM5WyHdN6K8UbtAf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f08888ec-daec-455b-85e9-08d5a4a8ca2e
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08888ec-daec-455b-85e9-08d5a4a8ca2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 21:18:39.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4375
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke,

Thank you for reviewing and acking my patch!
By the way, did you see Thandesha's proposed patch [1] to print a warning i=
n case of the missing "fileSize" attribute?
Should we go that route instead?
Or should we try harder to get the size by running `p4 -G sizes`?

[1] https://public-inbox.org/git/CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9Y=
viobRpYGg@mail.gmail.com/t/#m6053d2031020e08edd24ada6c9eb49721ebc4e27

Thank you,
Andrey

From: Luke Diamand <luke@diamand.org>
> On Tue, 17 Apr 2018, 09:22 Andrey Mazo, <amazo@checkvideo.com> wrote:
>>  Perforce server 2007.2 (and maybe others) doesn't return "fileSize"
>> attribute in its reply to `p4 -G print` command.
>> This causes the following traceback when running `git p4 sync --verbose`=
:
>> """
>> =A0 =A0 Traceback (most recent call last):
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 3839, in <module>
>> =A0 =A0 =A0 =A0 main()
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 3833, in main
>> =A0 =A0 =A0 =A0 if not cmd.run(args):
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 3567, in run
>> =A0 =A0 =A0 =A0 self.importChanges(changes)
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 3233, in importCha=
nges
>> =A0 =A0 =A0 =A0 self.commit(description, filesForCommit, branch, parent)
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 2855, in commit
>> =A0 =A0 =A0 =A0 self.streamP4Files(files)
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 2747, in streamP4F=
iles
>> =A0 =A0 =A0 =A0 cb=3DstreamP4FilesCbSelf)
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 552, in p4CmdList
>> =A0 =A0 =A0 =A0 cb(entry)
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 2741, in streamP4F=
ilesCbSelf
>> =A0 =A0 =A0 =A0 self.streamP4FilesCb(entry)
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 2689, in streamP4F=
ilesCb
>> =A0 =A0 =A0 =A0 self.streamOneP4File(self.stream_file, self.stream_conte=
nts)
>> =A0 =A0 =A0 File "/usr/libexec/git-core/git-p4", line 2566, in streamOne=
P4File
>> =A0 =A0 =A0 =A0 size =3D int(self.stream_file['fileSize'])
>> =A0 =A0 KeyError: 'fileSize'
>> """
>>=20
>> Fix this by omitting the file size information from the verbose print ou=
t.
>> Also, don't use "self.stream_file" directly,
>> but rather use passed in "file" argument.
>> (which point to the same "self.stream_file" for all existing callers)
>>=20
>> Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
>> ---
>> =A0git -p4.py | 8 ++++++--
>> =A01 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index 7bb9cadc6..6f05f915a 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2566,8 +2566,12 @@ class P4Sync(Command, P4UserMap):
>> =A0 =A0 =A0 =A0 =A0relPath =3D self.stripRepoPath(file['depotFile'], sel=
f.branchPrefixes)
>> =A0 =A0 =A0 =A0 =A0relPath =3D self.encodeWithUTF8(relPath)
>> =A0 =A0 =A0 =A0 =A0if verbose:
>> -=A0 =A0 =A0 =A0 =A0 =A0 size =3D int(self.stream_file['fileSize'])
>> -=A0 =A0 =A0 =A0 =A0 =A0 sys.stdout.write('\r%s --> %s (%i MB)\n' % (fil=
e['depotFile'], relPath, size/1024/1024))
>> +=A0 =A0 =A0 =A0 =A0 =A0 size =3D file.get('fileSize', None)
>> +=A0 =A0 =A0 =A0 =A0 =A0 if size is None:
>> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeStr =3D ''
>> +=A0 =A0 =A0 =A0 =A0 =A0 else:
>> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeStr =3D ' (%i MB)' % (int(size)/102=
4/1024)
>> +=A0 =A0 =A0 =A0 =A0 =A0 sys.stdout.write('\r%s --> %s%s\n' % (file['dep=
otFile'], relPath, sizeStr))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0sys.stdout.flush()
>>=20
>> =A0 =A0 =A0 =A0 =A0(type_base, type_mods) =3D split_p4_type(file["type"]=
)
>> --=20
>> 2.16.1
>>
> Thanks, that looks like a good fix to me.=A0 Ack.=
