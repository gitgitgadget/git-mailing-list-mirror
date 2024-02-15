Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2114.outbound.protection.outlook.com [40.107.237.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8686A349
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033253; cv=fail; b=RKDqLMmVd6oFrnxRUfYLnU/FoZYmrlO80a9QlUz3x4OU0CBQLATJtnDiqyblsuEUBbfAlKJx1iwUvQIwk3pEKExVnkL51KwOAY92SuxSy7e8/qdxaCZewZiBPoumuN13aRvTknHlT0SPd6d3UXEb2yfQ6qRlhEgjgbDb1dtbZfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033253; c=relaxed/simple;
	bh=WyKWKIZjldp66KaLYXufjbEbQWuGdr6fN2Rs9PyiaT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MqGQF7MaOr1ZDJyOfo6h9n5Kpgkc6/JU5/K5A7+UtLPK0Vk4/ibtmK0QRRb7mR6PeVWsN2/6yraJyd5E3IGudC2/Fh6OAyJSMb5Q40pTVHBdo5u5FfinGyP0/SvFHeok7yupKj84QLBERzaGSbR5skEzNn6MsNpkrwGqgc/HcL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dlhcorp.com; spf=pass smtp.mailfrom=dlhcorp.com; arc=fail smtp.client-ip=40.107.237.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dlhcorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dlhcorp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJxLyrAGNuRGsxO/QqTKq57eZnQ8S1M27ouJ8hjSTUPKjlQXduDa5iTqOjp1m0tyyIBDLi4qay5qKIwmg4KTuAIQnYTBX6eCgxacFo33Um44z3sWpi6NcrUnkuo1VMB9P/0jrLjmBxX1PWm3ekm7HGbDLlpYQAOOuxlZ7EpeC1Oz/qmSbHmYYFmqK3vM8E9FyaqeUUjCdfx5jWc085WW+qzeXHwR7nuxs89USm/SFwLoZ8AdqJ/PmkekGX9agn92yd3z9EWG+rBTzdlBy2oVY2ka+Nyxw5Iz5hHy1wUBu/qSt5m6037/6l0GQYEh9Pn4I4u/wO6sbZ5s8k+WmqKfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5cr6sHj+CaNC50GqejZE0Brz1015pu4YK8Nh9XmfG8=;
 b=JkqJ2zC5qEzIOnBSU6iMV+u1OmOfHgtyWsjmGImfWG/WnoqX1FOAHruxRrED729lo/C4GLGfFaotltllIIBghDu01FX7Uo0artR4KS+pAP1Gk8z3qsoWI3oL4ME60rPao0AI+/xyYW4ztTyf63/Ken2/WoG5DlzrlCgRvjvGofPcZbkGzUFiO9E95PzIlHx2iFu6/LawUXYulNZv8bv2YK/g7CRqQzlSY0f6ytcWmmyni9cJgLURXG8NR/6JUi3x4A6f5DvAJ+7J2h4DOvyskTEY33XqUSxpWecdWOr13X1o8Hqe3DouQNF7SHQZZ/BVH/P73jdjakq1Yz5Y7VchGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dlhcorp.com; dmarc=pass action=none header.from=dlhcorp.com;
 dkim=pass header.d=dlhcorp.com; arc=none
Received: from LV8PR13MB6560.namprd13.prod.outlook.com (2603:10b6:408:22a::12)
 by PH0PR13MB4940.namprd13.prod.outlook.com (2603:10b6:510:a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 21:40:47 +0000
Received: from LV8PR13MB6560.namprd13.prod.outlook.com
 ([fe80::738c:4313:3c3f:7aea]) by LV8PR13MB6560.namprd13.prod.outlook.com
 ([fe80::738c:4313:3c3f:7aea%5]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 21:40:47 +0000
From: Christian Castro <christian.castro@dlhcorp.com>
To: =?iso-8859-1?Q?Matthias_A=DFhauer?= <mha1993@live.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag
 for this title
Thread-Topic: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag
 for this title
Thread-Index: AdpWBxy+1+dpg/5hSeqyrICsnZ7mywF7UPCAARh0jaA=
Date: Thu, 15 Feb 2024 21:40:47 +0000
Message-ID:
 <LV8PR13MB65609D60ACB8A6EADFBFE3459C4D2@LV8PR13MB6560.namprd13.prod.outlook.com>
References:
 <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com>
 <DB9P250MB06926B4A6997EF6F866296ADA54A2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
In-Reply-To:
 <DB9P250MB06926B4A6997EF6F866296ADA54A2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dlhcorp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR13MB6560:EE_|PH0PR13MB4940:EE_
x-ms-office365-filtering-correlation-id: 434d4da4-6350-470c-e07c-08dc2e6ec55f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eL9b4ZsbKiIx3LERGpWN2tkL81De5pKDkstAFtart9DW7Nf9T9dAPcopS15P/d3NeYDfN/zWqJ7GUZ/UsVq+7lQZUFRCFbldcRpxCcKLV9N0QYULNHXyYbAqKyqIiPf3vz5MfAVEZDLQbYTcX4Q7dNeqpeYw7Suz2a7NnaJnHoepj23QIkwVxpaBDmEz2CqXZc8HDRGcZmmnuEPAtNO/IayrtF+HR9/ZnHzsiGIyWDYjWMVGUf3OByidO2TebNv6pxqO40sYAMowNdURFwLESyjw6rKHTP8hosNXBBmb+eDzNx9sDEzDTBCbWqfrckR4trhfXLh/22tYVNqzoaB1q3wxrNiqFC+pjY6ZDIK3ZnyiTX+cfL5fCVg5N/mX8dr18Cey8dMkv4MBZQ8NCiAxxZUa9SJmD6g+wOTilB3HM2A9sC699Kf1RupGB+BUaqcmwyGskKxt9T7SgAXKMRixkzQRGyYPQHqPLM/m9QZ8MEZKeYxZMvVhtJSUu83UT5tVLsJxn4IEoxtMWoFv0G25aSX8Hb6FqhDZbvxVC1/W0UPo0CbHqj4GRuWs0mkeDsznMQNCTBVce4nrSmWR34wM8lyS8DsbEicb+RGBOFUfKCYC0zashr6gppXkg14kYA8S
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR13MB6560.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(230273577357003)(230473577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(122000001)(33656002)(9686003)(52536014)(71200400001)(6916009)(2906002)(86362001)(53546011)(478600001)(7696005)(38100700002)(966005)(5660300002)(6506007)(4326008)(8936002)(8676002)(66446008)(66946007)(45080400002)(64756008)(41300700001)(83380400001)(66574015)(26005)(316002)(44832011)(76116006)(66476007)(66556008)(38070700009)(40140700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1JlojJneoGXzqoxSfNKxyKsh/6FEP7UxC1XvQvpf+4sN84zXH5dehkWoRi?=
 =?iso-8859-1?Q?JroWjVc2IuxGCsP86DmTmBCRkDMv4Pn8PJsTLZTHFccBD4X2pivRXAXq42?=
 =?iso-8859-1?Q?HjIpbpBJiBJkuNTh7CTC+5s4JmcYrH9F+FRtLIuoHAOxPbwDlKPFEuD5Q2?=
 =?iso-8859-1?Q?knLQXYsRTotomfkcCvHBdPp8GBKFeNshiOYzKWMz9PitXTGpK3JYQvIDtb?=
 =?iso-8859-1?Q?gWGOW5G4rhQ+RQwuUq5/hSvWe8R3prsmR8yZ8Bv0gRONU0OTayXQcsp1hu?=
 =?iso-8859-1?Q?NkB1O5n96pn3Zbb+Rms3PLpwtm00GyXvA0tGxuqIagMqDAZjVw3mOP2vkJ?=
 =?iso-8859-1?Q?jdBLU4L3iZL5HrNENi6LVdGEwuZofCGoKKbCjn6nW2Gkid+VO58Zjuubom?=
 =?iso-8859-1?Q?zV1BPFIc0IMhFSDJFxR1EeIEsmTgmbKChjM3n/eGn9oW1KwykY7tpIRqI1?=
 =?iso-8859-1?Q?xneqWyGNJvSgw0cFVzz/LL77F3DnHX1fBDwqGJ8fWaBiY4F/t5qe52wqac?=
 =?iso-8859-1?Q?Scg5ii3m9hiRvL6aJ+fPO4p8b12c6rbFxf1xJMfnYmd1K6jp7WHp77Uhtf?=
 =?iso-8859-1?Q?YKrqKYnQf1J6kWnsQrL7/NC0zyEPka2mJrlwExEnwrdqeHTt6YCHgHgrpV?=
 =?iso-8859-1?Q?C9ItikbbszJwkyiCqb5ZQdp8+vReUmDydnYsB72+DHIHYz858ogEw+A5wo?=
 =?iso-8859-1?Q?vTs7Cv8c7msmUCBOs0il9xqYDC1Makx3tkun6wL2cJAlml1cjdb1KwAhVM?=
 =?iso-8859-1?Q?9MWmN7IAToXmGk3LOswouIEmmWTeQQ7z2rdOqUa7BH7uhcGceGkovpJmFK?=
 =?iso-8859-1?Q?pUdTz3EfMONssu+rbbTm1d0rpJkeNh9xlVQTGk8FxeJJkeEKe6CRQU3MVi?=
 =?iso-8859-1?Q?DuHY32y5AfSmCl109d/hQRSbrbEF4Hc5g9NrPFRWJve2i5bBTZbIgZyoZK?=
 =?iso-8859-1?Q?ASE7qLqfeEMSu19C0lnq4OKvPPNBgX8ksoyHhXVcK8LtQ5K2USv9pL9NAv?=
 =?iso-8859-1?Q?DHYcXkEwG0QM0iDPh3O+2BK+fix2CF8uPWMBItgPp0E+X+bERvJX5abX31?=
 =?iso-8859-1?Q?ZMm6otDECTxywqssT6Dw588YLQGl8k0oafnylblsGuoeqBwCLpGUP2WWJy?=
 =?iso-8859-1?Q?70cYtvDFlBjAdByLnO2gU7/4ZUXvPQLQlnAPDx+YlzLIiW4TkNI8ioUoha?=
 =?iso-8859-1?Q?LXqdFPnLD9w/x3QfUcSC30DqTHHq4mtHMKTk5qj0rGdysUHJzuJPBqbutM?=
 =?iso-8859-1?Q?y4mAOT1kaQbNfMBfL4CwkKgcSny6mBprUO53rhvS0+6Jv5bUuACM0kZ0IF?=
 =?iso-8859-1?Q?0fFq9D0qftHXEf1/8J1RsZMOGWWwzBl8nfS6ib4R/Mw4YiVck76IDJ37Bz?=
 =?iso-8859-1?Q?OQ6B1SvrXZuwRcyjQPb0yPR5uycebGFJnrWjX22olbIW8eSUp7XkPhTfQ0?=
 =?iso-8859-1?Q?b1jsTuBNQM7V7hLC15xKQ2UFqjnmsTlsi6ABf3+dQBj02iR3ZEqwN+SmNS?=
 =?iso-8859-1?Q?aG3jYrI2A0duCau5RXjLn/pBwUiMvaUvjqKmjO96c8XHWo4Vu1KL+kiYEm?=
 =?iso-8859-1?Q?2pftqJ/L24oHNecyoohQf+I+uRvaz1XEzLUm+f1sgmpicrRQc4t3EJHqL3?=
 =?iso-8859-1?Q?5JCDwE/5vC+FZG27+PW0WfEmXZd1SH0Y359Du5MUrwD1DZGfrakoBwFw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dlhcorp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR13MB6560.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434d4da4-6350-470c-e07c-08dc2e6ec55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 21:40:47.0865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6b3df673-4d3c-4327-9918-0c35b6a50da3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GF2VRtWRNWHQNTLVtywLLNVqZGjGkGU3uE/jP9nxP5ehZzmBak8YvW0qFbmEG37G2eG0LVHavKkwa2N0ZXExabgqS8zTRbVEEnzy0sKVmKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4940

Hello Matthias,


Thank you for your reply.

Question: Are you a Git for Windows developer, open-source contributor or ?=
 I ask because I will contact the manufacturer of our inventory product and=
 provide them your feedback. But I'd like to know what your role is with Gi=
t for Windows for as of now I just have a reply from someone named Matthias=
 from a live.de email domain. I hope you understand. Truly no offense meant=
 on my part.

Therefore, please let me know what your role is with Git for Windows so I c=
an send this feedback accordingly and continue working on with our software=
 inventory vendor on the issue.


Best regards,

Christian


-----Original Message-----
From: Matthias A=DFhauer <mha1993@live.de>
Sent: Saturday, February 10, 2024 2:40 AM
To: Christian Castro <christian.castro@dlhcorp.com>
Cc: git@vger.kernel.org
Subject: Re: Hello question on Git for Windows 2.43.0 - GUID and/or SWID ta=
g for this title

[You don't often get email from mha1993@live.de. Learn why this is importan=
t at https://aka.ms/LearnAboutSenderIdentification ]

On Fri, 2 Feb 2024, Christian Castro wrote:

> Hello Git for Windows,
>
>
> I have a question on the GUID and/or SWID tag for Git for Windows 2.43.0.
>
> Can you tell me where in the product the GUID and/or SWID tag would be st=
ored in Windows for Git for Windows 2.43.0?
> Our scanning software has detected both 2.39.2 and 2.43.0 on the same Win=
dows but this is not so, only 2.43.0 is installed.
> This was an upgrade from 2.39.2 though so not sure if that is messed up t=
he results somehow.
>
> I've looked in C:\ProgramData and there are no regid folders not regid.xy=
z files exist for this product (for the SWID tag).
>
> The Windows registry also does not have a GUID information for this produ=
ct located under:
> HKLM\Software\GitForWindows
> HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1
>
>
> If you've included a GUID and/or SWID tag for your product somewhere in t=
he installation process, can you please tell me where these are stored unde=
r Windows so I can fix? I'd appreciate it.
>

Neither of those things really exist in Git for Windows. Well there are GUI=
Ds, but no GUID that is used in the way you'd expect from an MSI installer.

The Git for Windows installer is an innosetup based EXE installer.
Innosetup doesn't have these concepts. There have been efforts to introduce=
 an MSI installer over the years, but they've all fizzled out.

As for SWID tags, you're the first person to mention them in almost 15 year=
s of ISO/IEC 19770-2 existing.

>
> Thank you,
>
> Christian Castro
> Sr. Systems Administrator
> Office:  301-628-3551
> DLHcorp.com
>
>
>
> ****WARNING**** This email message (including any attachments) are to be =
treated as confidential/proprietary and may contain copyrighted or other le=
gally protected information. It is intended only for the addressee(s) ident=
ified above. If you are not the addressee(s), or an employee or agent of th=
e addressee(s), please note that any dissemination, distribution, or copyin=
g of this communication is strictly prohibited. If you have received this i=
nformation in error, please destroy the information and notify the sender o=
f the error. Thank you.
>

****WARNING**** This email message (including any attachments) are to be tr=
eated as confidential/proprietary and may contain copyrighted or other lega=
lly protected information. It is intended only for the addressee(s) identif=
ied above. If you are not the addressee(s), or an employee or agent of the =
addressee(s), please note that any dissemination, distribution, or copying =
of this communication is strictly prohibited. If you have received this inf=
ormation in error, please destroy the information and notify the sender of =
the error. Thank you.
