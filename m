Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5901320248
	for <e@80x24.org>; Tue, 19 Mar 2019 12:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCSMQN (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 08:16:13 -0400
Received: from au-smtp-delivery-112.mimecast.com ([180.189.28.112]:57073 "EHLO
        au-smtp-delivery-112.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726731AbfCSMQN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Mar 2019 08:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=griffithuni.edu.au; s=mimecast20181013; t=1552997769; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding:in-reply-to: references:references; bh=ySiq9ZfIBQDpSRKgRSFzjqsOruBpCEnUHrb6frXfU4c=; b=IvLdUdQEdcbdUTC1DKKgDb1httO7xt4lPTwy7ZNHouqkeBx6qWoKxtHB5FJRRpnQYqwkhb6QCKTN+x+gIRzrhdu9vT1IcCnBlAChZLHf81s40XRGMSNqn2j7YlRAAgPifr2kzdavOS+cVVH9SD2Qvav7+YdkdnXwROhlI2S0LOM=
Received: from AUS01-ME1-obe.outbound.protection.outlook.com
 (mail-me1aus01lp2051.outbound.protection.outlook.com [104.47.116.51])
 (Using TLS) by relay.mimecast.com with ESMTP id
 au-mta-49-d274EFpEOfK9fYN38De2hA-1; Tue, 19 Mar 2019 23:16:08 +1100
Received: from SYXPR01MB0957.ausprd01.prod.outlook.com (10.169.178.15) by
 SYXPR01MB1119.ausprd01.prod.outlook.com (10.169.177.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 12:16:07 +0000
Received: from SYXPR01MB0957.ausprd01.prod.outlook.com
 ([fe80::30f5:512e:dcf1:8e67]) by SYXPR01MB0957.ausprd01.prod.outlook.com
 ([fe80::30f5:512e:dcf1:8e67%5]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 12:16:07 +0000
From:   Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git server side "pre-receive" hook to create new repositories
Thread-Topic: Git server side "pre-receive" hook to create new repositories
Thread-Index: AQHU1mVOopyT6Ka+F0WRjDANg3ryOQ==
Date:   Tue, 19 Mar 2019 12:16:07 +0000
Message-ID: <SYXPR01MB09570A4CBFC30A36150C90BCDD400@SYXPR01MB0957.ausprd01.prod.outlook.com>
References: <SYXPR01MB095712C6765970605923A2FDDD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
 <20190319070629.GE31801@sigill.intra.peff.net>
 <87d0mndxop.fsf@evledraar.gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.191.7.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b632f1-71be-424a-a450-08d6ac64aa9c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SYXPR01MB1119;
x-ms-traffictypediagnostic: SYXPR01MB1119:
x-microsoft-antispam-prvs: <SYXPR01MB1119285E25DFC03841DA8A37DD400@SYXPR01MB1119.ausprd01.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(51914003)(33656002)(86362001)(446003)(71200400001)(9686003)(486006)(97736004)(66574012)(6246003)(53936002)(5660300002)(71190400001)(229853002)(44832011)(6436002)(55016002)(99286004)(74482002)(66066001)(476003)(316002)(7696005)(6506007)(53546011)(6116002)(102836004)(8676002)(76176011)(81156014)(2906002)(68736007)(786003)(110136005)(26005)(106356001)(256004)(14444005)(105586002)(25786009)(186003)(74316002)(305945005)(4326008)(52536014)(8936002)(478600001)(7736002)(14454004)(88552002)(81166006)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SYXPR01MB1119;H:SYXPR01MB0957.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1YV7FUYcOKIDkkI9i8VefrSlgnIz6y4r1XhYFhPCMhGmZUEWC1dLahq/YCn3EP4qsyH+sf+8eRbx6ropvIySUPyRaG/W/8/F/Z1HwvGKaScdhalRuqgKTshVIkYdsUvozcm+stleKzjdNSkc0uLqrdld+aKc1WOs2cZWJPapNjHfWRdHXmkxyrR7gwRPjie3ZF6BubGncySMuLy6ufR+A36HfcX8CJDvqGGij+/pKrWyoNWIC26j3VJo3ufIp2YnxHWgs+73geUwDfZQ0W8GSZGFSJvMZQANOjyIZ2pg4zvnmkCwIdysNUvFZDIZKxZCKvApRsTB+Z5urwFElf89c0A+Td23cKZwbWzL4YfWP/pe2sMagX4vkhB9BupBOaHxBgXWcH/0TzpN18yQG7fOhKS1VHTD9/R+OItXSqaVyQs=
MIME-Version: 1.0
X-OriginatorOrg: griffithuni.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b632f1-71be-424a-a450-08d6ac64aa9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 12:16:07.7792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a7cc8ab-a4dc-4f9b-bf60-66714049ad62
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB1119
X-MC-Unique: d274EFpEOfK9fYN38De2hA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback.=0A=0AWhilst I understand the options that you've b=
oth proposed, the intent=0Awas to enable the Swift Package Manager to mirro=
r repositories in a=0Atransparent way.  I'll look into whether these option=
s can be=0Aimplemented inside the SPM.=0A=0ACheers,=0ADimitri.=0A=0A=0AOn 1=
9/3/19 7:24 pm, =C6var Arnfj=F6r=F0 Bjarmason wrote:=0A> On Tue, Mar 19 201=
9, Jeff King wrote:=0A>=0A>> On Sat, Mar 09, 2019 at 10:46:09AM +0000, Dimi=
tri Joukoff wrote:=0A>>=0A>>> Thus, this feature request is asking that the=
 'pre-receive' hook=0A>>> triggers when someone tries to push to a reposito=
ry regardless of=0A>>> whether the repository exists.  This would allow aut=
omatic creation of=0A>>> new repositories and smooth the work-flow describe=
d above.  If the=0A>>> semantics of the existing 'pre-receive' hook are suc=
h that it would not=0A>>> be suitable for such a purpose, then an alternati=
ve way of providing the=0A>>> call-back ability would be implemented.=0A>> =
The pre-receive hook is a bit too late for this. It runs after the=0A>> ser=
ver has told the client what it has in the repo, the client decides=0A>> wh=
at to push, and the server has received the pack. So receive-pack=0A>> woul=
d have to know about this and fake having an empty repository. And=0A>> the=
n figure out where to store the incoming packfile, since we have no=0A>> re=
po.=0A>>=0A>> So I think it would have to be another hook that runs before =
the rest of=0A>> receive-pack. I.e., a system-level config option that says=
 "if you are=0A>> asked to accept a push for a repo and it doesn't exist, r=
un this instead=0A>> and then run as usual".=0A>>=0A>> It does feel a littl=
e error-prone, though, if the client does not=0A>> positively say "I want y=
ou to create this if it doesn't exist".=0A>> Otherwise if I do "git push se=
rver:my-misspelled-repo.git", the result=0A>> is going to be rather confusi=
ng. And retro-fitting that into the=0A>> receive-pack protocol is going to =
be tricky.=0A>>=0A>> It would be much easier to have a separate endpoint fo=
r the client to=0A>> say "please make this repo if it doesn't exist". And t=
hen just run that=0A>> before doing the push.=0A>>=0A>> For an unrestricted=
 client connecting over ssh, we already have that:=0A>> you can just run "s=
sh $host git init /path/to/repo". There isn't a=0A>> similar thing that can=
 be done over HTTP, though.=0A> Sounds simpler to just change the user's lo=
gin shell to a wrapper that=0A> checks if the repo exists, and if not creat=
e it before proceeding.=0A>=0A> The same with http(s). I.e. in whatever web=
server that's now pointing to=0A> git-http-backend as a script point to the=
 same wrapper script.=0A>=0A>=0A=0A

