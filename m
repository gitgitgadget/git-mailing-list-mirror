Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EBB41F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfGAU6G (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:58:06 -0400
Received: from mail-eopbgr640094.outbound.protection.outlook.com ([40.107.64.94]:6202
        "EHLO NAM06-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfGAU6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa6agzxqVAkDBhr6Z8889rptMGqEyHisX3Fqbptw8w5UpdkBZegWHOQY1U3f/5sTt+LmpYWQMOs/npoK8eDXkAwXfzYUWsLTeXr/00OW2E5EnVLYQF6Ywl0DVPyXnNyRyiw3vyMbXjAAVqTFbHDn5J3xF1/W6CndV3oS5Ffcxggmb2mVMOH55Vr3eC+04970cLXUZJrzefW/qTqUwTyWCoX5maSEchJFZPFvBse5exGXr5bU0IhZVt5/EnbttE8rmNpwNkjzzPKWyCCVahR3dbVpOSeLn2aBof6nhcZ4clnKLVQI+6bzd142nzRhu2myGyaqI6nMo+4tPLxWbR6i8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwqdffRIBahvIUbe/PcsLg6R/aYiP8boLPiwA+wYVFI=;
 b=LPc/gU4cIw5zw2b9ujCrpy7ykOhlXB5bTEIUZYiFVLiAx8tB3yMmpTYkMuQCLFpdd19wvODU0MrzTd5PUbVb59zRj3OBPVALasEvSI4m4qT/d5bDKInEdni1Y5z/PYHCs3tw7DpFmQq/u5F/B6aZM8MKfaAxans7riJH9le+hCIS2dPOlFbaKww1g95Fuy0HeUD0oo5lQiPfzeyX0nSMnXtZt4KCVwFVo4J0KIezJkJV5Wnto1Xaxt5O0/yVLczf5egPYSN5Xpk+cgnHOPIxxRqY6GiEi3+S8Kc9GiD6gvDA8QtfZpQJ9A7Vgy90g1ide23rSvnihmGGLyJliKG1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwqdffRIBahvIUbe/PcsLg6R/aYiP8boLPiwA+wYVFI=;
 b=OM3D00JZQIOtRPTxZrOe1k6NNlf8KrnnFwIlAyu/WlMfxbsRV7zZ/GVxDer1kn6brGJDXFPtqDUfwAPlOZSwMs2lSIGCWB3gICVKs/uZ4PRaDCrWNC8+WraN/AxfC5SlPEx6bQpQURqhQAyredqxBE369XBD7ywcl714PVv6/WE=
Received: from DM5PR00MB0408.namprd00.prod.outlook.com (52.132.129.32) by
 DM5PR00MB0392.namprd00.prod.outlook.com (52.132.129.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2083.0; Mon, 1 Jul 2019 20:58:02 +0000
Received: from DM5PR00MB0408.namprd00.prod.outlook.com
 ([fe80::9923:ae05:ac1a:e3e0]) by DM5PR00MB0408.namprd00.prod.outlook.com
 ([fe80::9923:ae05:ac1a:e3e0%5]) with mapi id 15.20.2080.000; Mon, 1 Jul 2019
 20:58:02 +0000
From:   Eric Kulcyk <Eric.kulcyk@microsoft.com>
To:     =?iso-8859-1?Q?Eckhard_Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Bryan Turner <bturner@atlassian.com>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Tracking parent branches in Git
Thread-Topic: Tracking parent branches in Git
Thread-Index: AQHVMD3i8/gIlx7oOE2G2ApKMwWLhKa2J7lzgAADpACAAA6JgIAAATQK
Date:   Mon, 1 Jul 2019 20:58:02 +0000
Message-ID: <DM5PR00MB040870EB598E4E7B0CC1765DF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
 <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
 <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>,<20190701204017.GA7537@esm>
In-Reply-To: <20190701204017.GA7537@esm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-01T20:58:01.164Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eric.kulcyk@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:e561:6c02:9616:a3c8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1616b0ae-805e-44f8-4a60-08d6fe66ce7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR00MB0392;
x-ms-traffictypediagnostic: DM5PR00MB0392:
x-ms-exchange-purlcount: 2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR00MB03920EAC0E0A6580A8F92374F1F90@DM5PR00MB0392.namprd00.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(51914003)(43544003)(189003)(199004)(7736002)(46003)(8676002)(305945005)(966005)(2906002)(81166006)(81156014)(186003)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(4326008)(478600001)(76116006)(10290500003)(14454004)(53546011)(6506007)(76176011)(72206003)(102836004)(7696005)(229853002)(25786009)(99286004)(6306002)(68736007)(9686003)(86362001)(53936002)(8990500004)(14444005)(55016002)(33656002)(52536014)(6436002)(11346002)(71200400001)(6116002)(71190400001)(446003)(486006)(476003)(110136005)(316002)(74316002)(8936002)(22452003)(10090500001)(256004)(54906003)(5660300002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR00MB0392;H:DM5PR00MB0408.namprd00.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x0wqBWDPacF5gP4UxjzSneROEOfIVklhCMunkN6+j05lfNRsnIAbQcGMbnGdqAl9bHoq5viadrVrNAZlPhR/iQUUEw12iTT9lFYUUYjLDjwwxOrw7DueWlN9jUzuqaGPV3DQCi5A1rccEF/8Lx2mRIAV/h8ic3RQV2QbJXDn1kZcNeLHRm+5+EGLGkmhALT042WX+Q0u1jzc7oZ3DCxyc6lQNgtx7hFN3jw5C9lPqCbqX0/T08f5ucCUnCJACd9IcuPu1yxt7zfGRw6s7cCeXAHRdLDBmtrJ7OwrOPI/fLrlLiF9HOlyj3zhR8w8KkPXUG6RsObYGxuDvPnefZDHaJa6U5TO0RZZfSYflI/QjSlQau4+Qm2ILFKhalwdsAGrAEcqKBKyFXCa0Y+QTEtQz6ye0jtf+O1haYTKGjdPtpY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1616b0ae-805e-44f8-4a60-08d6fe66ce7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 20:58:02.2782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erickul@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR00MB0392
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > [Overly long lines are not appreciated around here.]

Thanks for the feedback, is there an email client or tool
that can format the lines correctly?
> >
> > > We would like to track parent branches so that creating pull
> > > requests can automatically determine the correct branch to merge
> > > against.  I understand that this would require tracking more
> > > information than is currently available right now in git.  Also, it
> > > seems that if some cases, it is not possible to determine a parent
> > > branch, in which case it would just be empty/null.
> >
> > Do you mean by "parent branch" what people usually call "upstream
> > branch" (i.e. when that branch on the other side gains more commits
> > independent from what you have been working on, then you would want to
> > rebase your work on top of the updated state of that branch on the
> > other side) around here?
>
> I suspect the question is in regards to "What branch did I create my loca=
l branch from?", especially given the pull request reference.

Yes, this is what I meant.
>
> In other words, when I locally do:
> git checkout --no-track -b bturner-some-bugfix origin/release/5.16
>
> release/5.16 is the "parent branch" of my bugfix branch and, when I push =
my branch and try to open a pull request, release/5.16 is a _likely_ target=
 for where I'd want to merge it. There may be a remote in the name, a la "o=
rigin" in my example, or it might be created on top of some other local bra=
nch. It's a common feature request for Bitbucket Server[1], for example, to=
 automatically select the "right"
> target branch for a new pull request based on the ancestry of the branch =
in question--except branches have no ancestry. (This sort of metadata could=
 potentially offer some benefits for building commit graphs (referring to U=
I treatments for visualizing the DAG, rather than Git's "commit-graph" func=
tionality), depending on how it was implemented, since it would make branch=
 points more stable.)
>
> > Since branches are ephemeral names and have no intrinsic metadata of
> > their own (unlike, say, annotated tags or commits), I suspect
> > implementing something like this may be more complicated than it might
> > initially appear, especially if said metadata needs to be communicated
> > to remote repositories (which implies it might require changes to the
> > wire protocol as well).
>
> You can right now give meta data of your choice with --push-option to
> the push command. The Gerrit system makes use of that already. However,
> this would not be intrinsic to Git, but the serve needs to react on
> those options. And it should be in good company with suitable client
> tools.

@Eckhard, is that documented somewhere?  I don't see it on
https://git-scm.com/docs/git-push/1.6.4.1

>
> Take care,
> Eckhard
>
> Best regards,
> Bryan Turner
>
> [1] https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fj=
ira.atlassian.com%2Fbrowse%2FBSERV-7116&amp;data=3D02%7C01%7CEric.kulcyk%40=
microsoft.com%7Ca780a740f5894ba5ce6508d6fe607317%7C72f988bf86f141af91ab2d7c=
d011db47%7C1%7C0%7C636976088301830933&amp;sdata=3D1KrFM%2BLcKoa3FCc1F86jIVZ=
BrIUGi%2B6ad7CuA8ekAUY%3D&amp;reserved=3D0
>
> >
> > Perhaps "git help glossary", look
> > for "upstream branch" and start from there?  The entry mentions the
> > configuration variables used to keep track of that information, which
> > are described in "git help config", I think.
> >
> > > If I made a change to track the parent branch for each branch, would
> > > this feature be accepted/welcomed as part of git, even if it off by
> > > default?
> >
> > Regardless of what is being proposed, this is often not a very useful
> > question.  Something worth doing for yourself is worth doing whether
> > others also find it useful ;-)  And others usually do not have enough
> > information to judge if such a change is welcome until seeing it in a
> > bit more concrete form.

I wanted to get a some thoughts before I worked out the details.
The feature is of little use if no one is using the version of git with it
since most everyone uses standard distros of git.
>
> Was there not, at some point in recent history (2019), a discussion about=
 storing extra arbitrary data associated with a branch or other objects? My=
 thought for satisfying what Eric was originally proposing is to store the =
root commit associated with the original branch HEAD when checkout -b/branc=
h was done to create the branch. Presumably another datum could store the b=
ranch that the branch HEAD was on, but that may not be unique - which is a =
root part of the problem with this request, although it might be something =
that the user could select/specify - not sure how - at branch creation.
>
> But aside from that both of the above are transient relative to the new b=
ranch and by the time you wanted to create a Pull Request, the information =
you originally wanted could irrelevant - at least to git. If I was the prod=
uct manager on this, I would suggest going to GitLab, GitHub, or BitBucket =
and asking for some augmented capability of branch creation, that stores th=
e data for future Pull Request management - instead of doing this in core g=
it because of the transient nature of the relationship between a branch and=
 a commit.

Multiple branches can have the same commit, but only one branch can
be checked out at once, right?  Then the parent branch would be the
branch you were on when you ran checkout -b.  That branch might change
and no longer be of use, but it seems like in practice that is not the case=
.
New features are usually created off of a local branch and then PR'd
back to the upstream version of that branch.

Thanks!
Eric

________________________________________
From: Eckhard Maa=DF <eckhard.s.maass@googlemail.com>
Sent: Monday, July 1, 2019 1:40 PM
To: Bryan Turner
Cc: gitster@pobox.com; Eric Kulcyk; git@vger.kernel.org
Subject: Re: Tracking parent branches in Git

On Mon, Jul 01, 2019 at 12:48:16PM -0700, Bryan Turner wrote:
> Since branches are ephemeral names and have no intrinsic metadata of
> their own (unlike, say, annotated tags or commits), I suspect
> implementing something like this may be more complicated than it might
> initially appear, especially if said metadata needs to be communicated
> to remote repositories (which implies it might require changes to the
> wire protocol as well).

You can right now give meta data of your choice with --push-option to
the push command. The Gerrit system makes use of that already. However,
this would not be intrinsic to Git, but the serve needs to react on
those options. And it should be in good company with suitable client
tools.

Take care,
Eckhard
