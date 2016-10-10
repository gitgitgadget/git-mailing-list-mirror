Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232381F4F8
	for <e@80x24.org>; Mon, 10 Oct 2016 09:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbcJJJz5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 05:55:57 -0400
Received: from mail-db5eur01on0095.outbound.protection.outlook.com ([104.47.2.95]:11040
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751056AbcJJJz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 05:55:56 -0400
X-Greylist: delayed 953 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Oct 2016 05:55:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icl-services.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7WR75xcykugkQTU5go/xfESQBHZKYyc3Sq+QvZW92mQ=;
 b=Z4s4SGw5XkrjYgTHxnDKqNfT4fZf25OE6Jx5Ou2nJvVdZKcpfxLgBhoV8wGkX/eONlvmhZm86hm88V46vI6E7m3r1ZMEcyIJeZd6Z7SS3Zbsg9hRC4VyLL4tI37XogTVOlS0zr9XuJ18SANcDWunq1OgKR/ZVHIBlWll9iBMeBc=
Received: from AM4PR03MB1636.eurprd03.prod.outlook.com (10.165.243.150) by
 AM4PR03MB1635.eurprd03.prod.outlook.com (10.165.243.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.659.11; Mon, 10 Oct 2016 09:39:13 +0000
Received: from AM4PR03MB1636.eurprd03.prod.outlook.com ([10.165.243.150]) by
 AM4PR03MB1636.eurprd03.prod.outlook.com ([10.165.243.150]) with mapi id
 15.01.0659.020; Mon, 10 Oct 2016 09:39:13 +0000
From:   Eduard Egorov <Eduard.Egorov@icl-services.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: git merge deletes my changes
Thread-Topic: git merge deletes my changes
Thread-Index: AdIi2gGxW96gMpbvRJCzILaaCvDyAA==
Date:   Mon, 10 Oct 2016 09:39:13 +0000
Message-ID: <AM4PR03MB1636D18D727968F332F16021DBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eduard.Egorov@icl-services.com; 
x-originating-ip: [91.217.156.154]
x-ms-office365-filtering-correlation-id: 3b1607ea-cf45-4f62-1a2f-08d3f0f14bd7
x-microsoft-exchange-diagnostics: 1;AM4PR03MB1635;6:2GMoh6AqMyrIjcJ1dvv+wrHWVwubh30+MZPmq9RYgP0FE65xzzBt1Sb9h8A2SIseFlWeattU0ZdN0p5dSpPdHEVhZzVL4IuvbXqW+RrW4m3xFoeqCU13vHsde8EnKLh/fujWbu41b/z2Xg74sTS9L751xDnNt07BGQE0hsA5kK1Xi4FNUjUpNLWEeJxNR2b262qKZiGEmXxZsWvi4z+LB0u2hVyzY5URC2u0F/0BOIMaM8H0kxjOb57V4OtLOVTJRetWS5Kz+lNzCFlmi/n6vejPw7S+l96ocPBSPdE7jqOS+TgN93BG4MGzucXvRzep;5:0UdufHMJ/pQnyRajUtu7+iXRJZjCxpoN/V/Y7ReQYfQ1hhUfTV7DpXoSHRFjK801Ay4BYUgXCo2HANvQwHrDnpuUW3mpCwN5A42YHzGm8YWOw/vsvs+Ua+pd4QFZlnwiOtVrBQVuBnTueb4mHlIKwtO7BXfx1pl4R65npQGzhk4=;24:/lKf+ADR7ELvEkmv35qNMW3KtulZ5ZmFNhHfs9/0viMrcoMvOSu2GIIYAPEs77pVLLz4TdSu6EKuWUyqgu3UGtcB4uAHXLMXHvsO59jHO2E=;7:PEz5gTuGUlXFwzSyR2lcJiuP8TnRMymLVQCZX0K30Li+eFupuTZFHMbBgMqMZ5r7gTC3opEb6xlTmLzwJxGe/NNXZc9fhB7P4i1yVAU9S9mZBS3yrqszUWAzMUnH20bsf8IdfcTSKAJoBQfWEIdWjIEc1VOrVeMkkxkzSYin3HWmc3UYMp2eECPCBvSfqYfBrcoE2onsqma5o5qze2J76IPl0HX1I3tlX1AGCL7075XaKT7E6+fmfx4B+bwu0JXEXofcFNUGvt9XvaxrOxYQHnmBb3O+35C16Hr3uLLPhlYTffaQqWxPhAEBrwzd/0jX/ZPCgc+1VReXZd4AZHOp+H3Eh6zQ75i/j4ov+kRxeBQ=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM4PR03MB1635;
x-microsoft-antispam-prvs: <AM4PR03MB16355948D6E89EE407FC6F78DBDB0@AM4PR03MB1635.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185212123834332);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:AM4PR03MB1635;BCL:0;PCL:0;RULEID:;SRVR:AM4PR03MB1635;
x-forefront-prvs: 0091C8F1EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(199003)(189002)(586003)(102836003)(3846002)(7696004)(5002640100001)(6116002)(19580395003)(122556002)(107886002)(189998001)(76576001)(450100001)(5660300001)(110136003)(2900100001)(92566002)(87936001)(6916009)(86362001)(15975445007)(77096005)(1720100001)(7736002)(305945005)(74316002)(54356999)(50986999)(10400500002)(97736004)(7846002)(81156014)(81166006)(229853001)(15395725005)(105586002)(106356001)(33656002)(8676002)(9686002)(101416001)(68736007)(3660700001)(2906002)(11100500001)(66066001)(8936002)(3280700002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR03MB1635;H:AM4PR03MB1636.eurprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: icl-services.com does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: icl-services.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2016 09:39:13.8063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c6039a2-9be8-4677-87ed-cd9c68a6779e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR03MB1635
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git experts,

A week ago, I've reset a state of 'ceph-ansible' folder in %current% branch=
 with code from corresponding branch (that tracks an upstream from github):

# git read-tree --prefix=3Dceph-ansible/ -u ceph_ansible

Then I've committed several changes, including:

1. Renamed file and commited:
# git mv site.yml.sample site.yml

2. Made some changes and committed

3. Pulled updates from original branch by:
# git merge -s subtree --squash ceph_ansible

It said:
    Auto-merging ceph-ansible/site.yml.sample
    blablabla
    Squash commit -- not updating HEAD
    Automatic merge went well; stopped before committing as requested

I can see that "my" ceph-ansible/site.yml is deleted (as well as few new fi=
les added by me), ceph-ansible/site.yml.sample is restored and doesn't cont=
ain my changes (it's just restored to the state before my changes).
`git log ceph_ansible site.yml.sample` shows the latest change on ceph_ansi=
ble branch done from 26th of August, 2016, my changes in %current% branch w=
as this October, so it shouldn't be any conflict either (even if it was).
I believe there is some obvious explanation for this behavior. Could you he=
lp me please? What information can  I provide in order to troubleshoot this=
 issue?=20

A post on SO: http://stackoverflow.com/questions/39954265/git-merge-deletes=
-my-changes

With best regards
Eduard Egorov


