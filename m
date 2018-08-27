Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17EAF1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 15:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeH0TGr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 15:06:47 -0400
Received: from mail-sn1nam02on0080.outbound.protection.outlook.com ([104.47.36.80]:11232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbeH0TGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 15:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firemon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZQW5P7ao9DgUAwahlGd+mQopweyGZK3nRjHDH3BQn4=;
 b=MNBZq3pWPLm5yzrqZtZuelkWK5sjbfKii8bS9aZ9AQ7MgoL9kOlgN4f9AqWs9SXWouj7Nob2FXG52nWf8NRLSrlr2N84E5pudbv50WMNiSvlPXbQC+IuLRhyK4khPFzRzbbdW7+V9UYhOehiI/ISRW6qPhuxdrGB/z79227vv5U=
Received: from MWHPR10MB1517.namprd10.prod.outlook.com (10.169.233.150) by
 MWHPR10MB1773.namprd10.prod.outlook.com (10.172.53.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 15:19:40 +0000
Received: from MWHPR10MB1517.namprd10.prod.outlook.com
 ([fe80::6142:aa0f:d578:65f]) by MWHPR10MB1517.namprd10.prod.outlook.com
 ([fe80::6142:aa0f:d578:65f%9]) with mapi id 15.20.1080.015; Mon, 27 Aug 2018
 15:19:39 +0000
From:   Bentzy Sagiv <bentzy.sagiv@firemon.com>
To:     Bryan Turner <bturner@atlassian.com>
CC:     Git Users <git@vger.kernel.org>
Subject: Re: Get "Your branch is ahead of 'origin/master'" message when
 explicitly passing origin url at push command
Thread-Topic: Get "Your branch is ahead of 'origin/master'" message when
 explicitly passing origin url at push command
Thread-Index: AQHUPTBFQMkaI6MdA0+jaK8pPNuw1aTSWRcAgAFexpM=
Date:   Mon, 27 Aug 2018 15:19:39 +0000
Message-ID: <MWHPR10MB1517F19A71CFC59A66530DFE9B0B0@MWHPR10MB1517.namprd10.prod.outlook.com>
References: <MWHPR10MB1517982C582BEFB7D9171EFD9B340@MWHPR10MB1517.namprd10.prod.outlook.com>,<CAGyf7-H+YoeO5bOvTkLtViMWv85cpQsxL=gxmA592WJ8=rd8hA@mail.gmail.com>
In-Reply-To: <CAGyf7-H+YoeO5bOvTkLtViMWv85cpQsxL=gxmA592WJ8=rd8hA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bentzy.sagiv@firemon.com; 
x-originating-ip: [83.130.65.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR10MB1773;6:1w7td2uG88qDCZ5fOxdk0NRKsWMXAfLYqNmwWvIjJoUzeSEnA+oWr0a+6v9/RJfnl3rbS4cJ+Rt8go7Asr6tGMMmklD2b0b3MhFW2fEdYGeoHd5T+6wy+rEkaifDs5Sy0Q2FTMe/nXHtokzIjLHIfd2QDWZas4OF3g5fAWf488TnaJLvs/PdO136Rj41Aqs96u3uVTTW/fbxIPT9/at+4NgljvrDHhJ01+urCPjUS1lyDNW4RZgco8KBQElWvZQM8OWMKWIsptUWRLU6GyDQeI2AxtaN4Us/uZ1y8ycD6Us7X2/7hyFdb+o0fEnoRPKv0zNqjwlcc7gOB3zRqWeS20Blr99RE7Hn9Qu9KZdGpt288jewfFcAKFW9Ihhwx1OO5v5Y0kX2D3siyJMegNP+njv9FDGPLa1gZ7FlrjxiAfyfjSCxvm0wxITyiKS9QVd0jLC2rCHZElrPfq82m0wYBg==;5:Pl6s4KI/zoq8pmvScF2DTVRlOMrOT4+OFtEQg7SGwXzS2GuWy76FLowWdWhu9Pk/HBDmnl8DoHy3BGoPeepJrJ8dWOWpXZMLP5v9RYfbR8oDYvhh36tz/82W9GtbCxzOsoKOrsSfrBJ/G8cn0pDx1rRuWQHib93VgGt7JlGaPRg=;7:Omheq9as/MzFURdYIwex4JbtlmmL5QE5kTRBlNTEwpiFy1m4sM+3sIsqasIjk09LeltbP5p7MzlInuqFK2/sMVI6JPUkt6+1aEYgPTirNdVXJUKY4Ty1sXAyIJYDQV3EEwTKubwERLm54Lb+gv9cI9nrYs9uSjoKW3tjbhoxiD9uYbiKYCHNRCsYaXIp6XOBt38xUasoKGevNQimQ5GtJAGwE6BLU4/gMZsWOf+0FpryrraoSW+sPFyAqAmDlORu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4610fe72-254c-4712-820b-08d60c30820e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR10MB1773;
x-ms-traffictypediagnostic: MWHPR10MB1773:
x-microsoft-antispam-prvs: <MWHPR10MB1773C39F5F6DCBB9B29AEBC19B0B0@MWHPR10MB1773.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(253373257661254)(63843785518722);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR10MB1773;BCL:0;PCL:0;RULEID:;SRVR:MWHPR10MB1773;
x-forefront-prvs: 07778E4001
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39840400004)(376002)(136003)(346002)(129404003)(189003)(199004)(51874003)(6436002)(186003)(229853002)(99286004)(7696005)(6246003)(76176011)(6506007)(2906002)(53546011)(68736007)(5250100002)(26005)(2900100001)(446003)(55016002)(11346002)(316002)(102836004)(97736004)(256004)(14444005)(53936002)(9686003)(6306002)(478600001)(7736002)(305945005)(966005)(74316002)(86362001)(8676002)(14454004)(105586002)(486006)(44832011)(81166006)(6116002)(81156014)(3846002)(25786009)(106356001)(6916009)(15650500001)(33656002)(476003)(66066001)(5660300001)(551544002)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR10MB1773;H:MWHPR10MB1517.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: firemon.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0PxLpwD7jxfiXMK0k71yu9J9fveuHh5AigEOQ9AMxTYLVXF2H5amMxeYZX9+3YUuzfQ09yfjGt0FlU/SiYsIswknF9yrSClxaOPP4OZTSLjk4aJ9489P9WFvUxY95fXHddmADgpwDdvOIvO4aPRTIvLwwsmTZxX7h3ugseRQZvwZ7Ef7N6lUubqz41swpr2sCYiDcoDV2EOASQGJ2sThPWiHaRihbol+Np2iEk3XiYxczMSTlZAApg11ukypXG6+5eqVW7gFnu9cTkOlPFSqjyHZ6OqQh/Z+w/4N0/xgevcIq/8AFtZbEM8xak4LPIR9q9AnV38FuUANIqMKsErNfYQVZZBSAgZUgOb1EI/mWuU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: firemon.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4610fe72-254c-4712-820b-08d60c30820e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 15:19:39.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: acd234ad-0e86-43b0-a357-9dce4d20f5c4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1773
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, it really helped to understand.
Since what I want to do is to run git pull/push from within a script in a J=
enkins job and Jenkins already has the git user&password stored, I thougth =
is odd to store them at a git credential helper.
My solution is running (before git pull/push):
    git config remote.origin.url https://$GIT_USER:$GIT_PASSWORD@bitbucket.=
org/...
while at the start of the script trapping EXIT signal and resetting origin =
as following:
    trap "sudo git config remote.origin.url https://$GIT_USER@bitbucket.org=
/..." EXIT
Make sense or am I missing something?

Thanks in advance,
Bentzy Sagiv
=A0 =20
   =20
=20
   =20



From: Bryan Turner <bturner@atlassian.com>
Sent: Sunday, August 26, 2018 9:22 PM
To: Bentzy Sagiv
Cc: Git Users
Subject: Re: Get "Your branch is ahead of 'origin/master'" message when exp=
licitly passing origin url at push command
=A0=20

On Sun, Aug 26, 2018 at 4:39 AM Bentzy Sagiv <bentzy.sagiv@firemon.com> wro=
te:
>
> git version 2.7.4
> _________________________________________________________________________=
_____________________________
>
> First try: NOT passing origin url explicitly
>
> ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git push

Since you didn't specify a remote here, Git assumes origin. It uses
your configured "push.default" behavior ("simple" by default) to
determine which refs to push and pushes your master branch to the
origin's master branch. Since it _knows_ it pushed to origin, it
updates your local "refs/remotes/origin/master" ref with the same
commit it just pushed, resulting in an "up-to-date" message.

>
> ubuntu@ci-bentzy:/var/lib/jenkins$ git status
> On branch master
> Your branch is up-to-date with 'origin/master'.
> nothing to commit, working directory clean
> ubuntu@ci-bentzy:/var/lib/jenkins$
>
> _________________________________________________________________________=
_____________________________
>
> Second try: passing origin url explicitily
>
> ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git push  https://bitbucket.org/O=
WNER/jenkinsconf-repo.git

This, on the other hand, _is not pushing to a configured remote_. It's
pushing to an explicit URL, which happens to match the URL of a
configured remote. But it's still not a configured remote. It's using
origin's URL, but you didn't push to origin. As a result,
"refs/remotes/origin/master" is not updated, and you get an "ahead"
message.

>
> ubuntu@ci-bentzy:/var/lib/jenkins$ git status
> On branch master
> Your branch is ahead of 'origin/master' by 1 commit.
>=A0=A0 (use "git push" to publish your local commits)
> nothing to commit, working directory clean
>
> _________________________________________________________________________=
_____________________________
>
> An additional " sudo git push" (without explicit origin) solves the issue

Everything here is working as intended. If you want to push to a
_remote_, you either need to:
- Name the remote ("git push origin"), or
- Leave it off, so Git will assume origin ("git push")

Pushing to a URL that matches a remote's URL is _not_ pushing to a
remote. It's pushing to an explicit URL.

Hope this helps,
Bryan Turner
>
>
>
    =
