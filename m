Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E352820989
	for <e@80x24.org>; Mon, 10 Oct 2016 16:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbcJJQxz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 12:53:55 -0400
Received: from mail-db5eur01on0117.outbound.protection.outlook.com ([104.47.2.117]:29380
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753055AbcJJQxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 12:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icl-services.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qa1U0Y4osVxDkRJgDM1qBmv5LzCChX1ITSD8C16OZ7o=;
 b=g/vZjfy+fEGc6jjesSIBEu/iLVN3JDUlbrIPHnqdopO+OXN+4af6/bG2LZzQwMNrt15Q2KPHaUdnrb0Y4LOv/p9pgssWiT9LRmuiWQzzgEa7C/XmTVgqmXE0z7GDkr8Bt2JxTd9xGIHcHHD310VMF2f2VYlCB42kwkXopiERCWQ=
Received: from AM4PR03MB1636.eurprd03.prod.outlook.com (10.165.243.150) by
 AM4PR03MB1633.eurprd03.prod.outlook.com (10.165.243.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.659.11; Mon, 10 Oct 2016 10:19:47 +0000
Received: from AM4PR03MB1636.eurprd03.prod.outlook.com ([10.165.243.150]) by
 AM4PR03MB1636.eurprd03.prod.outlook.com ([10.165.243.150]) with mapi id
 15.01.0659.020; Mon, 10 Oct 2016 10:19:47 +0000
From:   Eduard Egorov <Eduard.Egorov@icl-services.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: RE: git merge deletes my changes
Thread-Topic: git merge deletes my changes
Thread-Index: AdIi2gGxW96gMpbvRJCzILaaCvDyAAAA3wWA
Date:   Mon, 10 Oct 2016 10:19:47 +0000
Message-ID: <AM4PR03MB1636EA0DEB4C8095F04AB92ADBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
References: <AM4PR03MB1636BE3423E2BC4F0E998159DBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
In-Reply-To: <AM4PR03MB1636BE3423E2BC4F0E998159DBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eduard.Egorov@icl-services.com; 
x-originating-ip: [91.217.156.154]
x-ms-office365-filtering-correlation-id: 95e7bb4e-4214-4dc8-2726-08d3f0f6f643
x-microsoft-exchange-diagnostics: 1;AM4PR03MB1633;6:+wzRaLODRooBHqjrLNqOn6lOSXMcVj3WwoB0fQy/mkA9wSfzxEA9Tzi3BsYApi1swVSAQbFQgu6aAOz+bw/wB2JnWEfbGo0V/gcvhEfYlMZenUbM2ezt8w+PEU1gHSE0DXPF0K/zyVMP1lQRst1g7lKrwNLndNX1yL2bJutpQGAoJ1os/Dy/fgFm9djfTnmrLoJ2ZotTEGrG0nrQPYM7207zqsda7GWwrthvL2XbqkFNQAChB+JoFqxNDiYH2tMDu61S+qJsL8FyYJMAa4ezMsXDdbmDVORhs97BGctBzU4R8dlWtJJipazEkKT7YHVd;5:JSzL2Jw/GQ2F71+8HNsb0zvLAR62owD6Fc1lS1NkLzhSjR0l0Hvj/BrT8Ri+sdFKPS5bnadFPH3PTXU+HhGrSEdZjaBNr6rMryW6jxwcqA5sY4CxfeO7qD/OYyXx9c3eCrtPH3pbkAT+yEQcry1oRQ==;24:ij8JMr0qClK2Es+oy3TeZVQM41dVxavNd1UFq+Q3CPuYg9QyCYYklPaNf6Cgkwr1uoDKJ/p90L2EzumzaviggGoj2EnmedlnSI4Pv2cpamE=;7:+g4A1C1WcE1amhQC2XTjWZ6EPJQpfVJcHcDN9yFFb582rSTpg60/0zc9k+Mu7EFo5LtHBWcfX+D0y1Wn6ik8c5MNnjkFMgomgFBZ00YgfdpyMGolV26BgNjx1PT8vAIkTK0J6KzEucdo/N21JpMegxpp5oNvKOv17D4YZCsG7exDaTRM/nHQqmIOw95Ro4xDHJOOdK4Qlu8i+CqwddU1I0hoBkB83wnLLbCb8s9eCIJct1EidfS6IMgyWH/T6M+hB+MPhIK7BrjewGAOH9W/HKZtAafKSGbCjXD7JKwg2Wf8wszwI2lkzJfgKAHCRhIYp0a9husMI7/FlwUwm34oTwvHE+PDQnzmPpyXj5RZGsU=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM4PR03MB1633;
x-microsoft-antispam-prvs: <AM4PR03MB1633DEFE1EFCA14BE3A9BF63DBDB0@AM4PR03MB1633.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185212123834332);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:AM4PR03MB1633;BCL:0;PCL:0;RULEID:;SRVR:AM4PR03MB1633;
x-forefront-prvs: 0091C8F1EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(189002)(13464003)(199003)(377454003)(6916009)(2950100002)(15975445007)(2906002)(77096005)(2900100001)(5660300001)(7696004)(5002640100001)(110136003)(92566002)(76176999)(54356999)(66066001)(1720100001)(8936002)(105586002)(106356001)(101416001)(450100001)(50986999)(33656002)(7846002)(305945005)(15395725005)(7736002)(74316002)(81166006)(81156014)(76576001)(19580395003)(189998001)(19580405001)(122556002)(10400500002)(86362001)(3660700001)(586003)(97736004)(107886002)(3280700002)(3846002)(6116002)(11100500001)(102836003)(68736007)(3900700001)(87936001)(9686002)(8676002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR03MB1633;H:AM4PR03MB1636.eurprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: icl-services.com does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: icl-services.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2016 10:19:47.1817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c6039a2-9be8-4677-87ed-cd9c68a6779e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR03MB1633
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

I've noticed that my git is quite old (1.8.3) and built it from source tarb=
all (2.10.1). Now the output is:

# ~/gitbuild/git-2.10.1/git merge -s subtree --squash ceph_ansible
fatal: refusing to merge unrelated histories

I've checked my command history again:
  738  git rm -rf ceph-ansible/
  739  ll
  740  ll ceph-ansible/
  741  rm ceph-ansible/purge_ceph_cluster.yml=20
  742  git read-tree --prefix=3Dceph-ansible/ -u ceph_ansible
  743  gs
  744  gc "ceph-ansible: reset repo state"

A quick googling showed (http://stackoverflow.com/questions/37937984/git-re=
fusing-to-merge-unrelated-histories ) that the default behavior is changed.=
 Adding ' --allow-unrelated-histories' clears the error message but the mer=
ge itself is still wrong (my changes are lost).=20

This error message might explain why git can't merge it correctly (since th=
ese repos doesn't has any relations, right). Can somebody confirm this plea=
se? Doesn't "merge -s subtree" really merges branches?

With best regards
Eduard Egorov

-----Original Message-----
From: Eduard Egorov=20
Sent: Monday, October 10, 2016 12:39 PM
To: 'git@vger.kernel.org' <git@vger.kernel.org>
Subject: git merge deletes my changes

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


