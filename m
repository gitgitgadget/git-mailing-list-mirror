Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3DC4201A7
	for <e@80x24.org>; Mon, 15 May 2017 13:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965136AbdEON6j (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 09:58:39 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:10266 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934374AbdEON6i (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 May 2017 09:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1494856718; x=1526392718;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ans24/I3JgiKSn46z69JiPTfCkK6Xhrmfzpik4e590Q=;
  b=TLjP/hl+nqWJb9eV4ukGmDdcGJy/Coe+cQPOqWnqUtT5axPS+8TcbomD
   LQCf8BIbeNo5MBS90LTUb7dKq36Df/RqOvbaTLrR5tqJLrjw39nFGRA2w
   BkCnxIoW8zHfz6zE2QrqdGirxXz1tUvIpvFPV3nILM7jCNGGZT9/B4A1y
   M=;
Received: from esa3.dell-outbound2.iphmx.com ([68.232.154.63])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2017 08:58:37 -0500
From:   "taylor, david" <David.Taylor@dell.com>
Received: from mailuogwdur.emc.com ([128.221.224.79])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2017 19:48:41 +0600
Received: from maildlpprd53.lss.emc.com (maildlpprd53.lss.emc.com [10.106.48.157])
        by mailuogwprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v4FDwacR025594
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 15 May 2017 09:58:36 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd52.lss.emc.com v4FDwacR025594
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
        t=1494856716; bh=tUVLkI4gs/EJzH2l5aQQZcpyvEg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=FyXPsn4dPAq2WoopcIlCiynjxuOHDubvqUC699zxyfm9tRYXV3Qb2UJRCx0MJbItJ
         oy4/23pJCxGa70Y3ARh8RqoeollRe00KIxea+IZSr0OAb3rmjTucFaF8GKgIubRa5J
         t1cDS9P3VFpFaS6C6hr0HyUm20hGMWeoG7neCb80=
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd52.lss.emc.com v4FDwacR025594
Received: from mailusrhubprd02.lss.emc.com (mailusrhubprd02.lss.emc.com [10.253.24.20]) by maildlpprd53.lss.emc.com (RSA Interceptor) for <git@vger.kernel.org>; Mon, 15 May 2017 09:58:14 -0400
Received: from MXHUB230.corp.emc.com (MXHUB230.corp.emc.com [10.253.68.100])
        by mailusrhubprd02.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v4FDwK9g019176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Mon, 15 May 2017 09:58:21 -0400
Received: from MX203CL03.corp.emc.com ([fe80::4dee:b763:b476:8fbc]) by
 MXHUB230.corp.emc.com ([10.253.68.100]) with mapi id 14.03.0266.001; Mon, 15
 May 2017 09:58:20 -0400
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git worktrees must exist even if locked
Thread-Topic: git worktrees must exist even if locked
Thread-Index: AdLJxLnaduSLoWUtQTOTfBkbFAeChADvWjcg
Date:   Mon, 15 May 2017 13:58:19 +0000
Message-ID: <63F1AEE13FAE864586D589C671A6E18B0D6B8C@MX203CL03.corp.emc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.238.48.71]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd02.lss.emc.com
X-RSA-Classifications: public
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The original report was against Git v2.12.2.  I have since tried v2.12.3, v=
2.13.0,
and the next branch.  All exhibit the same symptoms.

Even if you ignore the original scenario for creating the problem, if I do =
a 'rm -rf' or 'mv'
of a tree that contains within it worktrees, that should not break the use =
of Git with
worktrees that live elsewhere nor commands that don't require a repository.

> -----Original Message-----
> From: taylor, david
> Sent: Wednesday, May 10, 2017 4:25 PM
> To: git@vger.kernel.org
> Subject: git worktrees must exist even if locked
>=20
> The Git documentation in describing worktrees says that one reason
> why you might want to lock a worktree is to prevent it from being pruned
> if it is on a removable media that isn't currently mounted.
>=20
> So, my expectation was that if the worktree is inaccessible (and locked),=
 Git
> would pretend that there is no worktree by that name.
>=20
> In reality, if you have such a worktree, Git gets an error.
>=20
>  On local systems, /home is local to a machine; home directories are
> elsewhere.
> Home directories are NFS mounted; /home is not.
>=20
> . create a repository in /my/home/dir/my-repo.git with
>=20
>     git clone --bare <some arguments>
>=20
> . create an empty directory /home/somedir/worktree-tests
>=20
> . use 'git worktree add' to add /home/somedir/worktree-tests/<branch-
> name>
>   as a worktree on branch <branch-name>.  It gets populated with the corr=
ect
>   content.
>=20
> . lock it using'git worktree lock'
>=20
> So far, so good.  Now, go to a different computer -- one on which
> /home/somedir/worktree-tests does not exist (and therefore
> /home/somedir/worktree-tests/<branch-name> does not exist).
>=20
> . cd /my/home/dir/my-repo.git
>=20
> Now, try issuing Git commands.  Many will fail.
>=20
>   git fetch =3D=3D> fails:
>=20
>   fatal: Invalid path '/home/somedir/worktree-tests': No such file or dir=
ectory
>=20
>   git status =3D=3D> fails -- same error as above
>   git help worktree =3D=3D> fails -- same error as above
