Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A587120970
	for <e@80x24.org>; Tue, 11 Apr 2017 15:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbdDKPZN (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 11:25:13 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:49734 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752133AbdDKPZM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Apr 2017 11:25:12 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Apr 2017 11:25:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1491924311; x=1523460311;
  h=from:cc:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=aoFTz8loQew0g/NmS2xgkQB0MRMBD3djHe0/V+PBdrA=;
  b=rg84nlmuYd9HAui5huY8Io0kYPNAJkUh4yqt3cn9AtS4L2f9Qd4wfuX3
   yt6EqempE2POPTDKO9+w5s8/PJ0y0tTbka+qwLTTz/dYesV4LPC/ov5kb
   lW9KdluQgQkPBuqXWWzCuUlfs3dgUbfgi49ud4LG6REJKrC/nMyWNhbo0
   o=;
Received: from esa3.dell-outbound2.iphmx.com ([68.232.154.63])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2017 10:15:23 -0500
From:   "taylor, david" <David.Taylor@dell.com>
Cc:     "taylor, david" <David.Taylor@dell.com>
Received: from mailuogwdur.emc.com ([128.221.224.79])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2017 21:05:03 +0600
Received: from maildlpprd52.lss.emc.com (maildlpprd52.lss.emc.com [10.106.48.156])
        by mailuogwprd51.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v3BFFJjO022573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 11:15:20 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd51.lss.emc.com v3BFFJjO022573
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
        t=1491923720; bh=Of9gFoZ6VE9OK7V41i5UmzM1qiw=;
        h=From:To:CC:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=nxWAmeXQwfYOH/nKhkWXXkLkPIGOJrIxHdmlCNbJwrI2ifX/YuYMJxwGqYZQGJDGu
         B4eS5QAwo+Ijtz7upxCxTUkfbaVo8TBMnyV7VmJRo3AvpBO9MWdu+Ppt6FzCHuX6jL
         cRinMpr0Df52rOav6pFjXv0X5XKlNhiyBfiRwM+w=
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd51.lss.emc.com v3BFFJjO022573
Received: from mailusrhubprd53.lss.emc.com (mailusrhubprd53.lss.emc.com [10.106.48.18]) by maildlpprd52.lss.emc.com (RSA Interceptor) for <git@vger.kernel.org>; Tue, 11 Apr 2017 11:13:28 -0400
Received: from MXHUB102.corp.emc.com (MXHUB102.corp.emc.com [10.253.58.15])
        by mailusrhubprd53.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v3BFF1UA014989
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 11:15:01 -0400
Received: from MX203CL03.corp.emc.com ([fe80::4dee:b763:b476:8fbc]) by
 MXHUB102.corp.emc.com ([::1]) with mapi id 14.03.0266.001; Tue, 11 Apr 2017
 11:15:00 -0400
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git work trees
Thread-Topic: git work trees
Thread-Index: AdKyynQzsywY23NTQ0yWVLQHo4XSCA==
Date:   Tue, 11 Apr 2017 15:14:57 +0000
Message-ID: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.238.48.71]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd53.lss.emc.com
X-RSA-Classifications: public
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are using Git in a distributed environment.

In the United States, we have the master repository in one state and a buil=
d cluster in a different state.
In addition to people in the US doing builds, we have people in other count=
ries (Ireland, India, Israel,
Russia, possibly others) doing builds -- using the build cluster.

The local mirror of the repository is NFS accessible.  The plan is to make =
builds faster through the use
of work trees.  The build cluster nodes involved in the build will have a w=
orktree in RAM -- checked out
for the duration of the build.  Since the worktree is in RAM, it will not b=
e NFS accessible.

[Cloning takes 20+ minutes when the network is unloaded.  Building, with so=
urces NFS mounted, takes
5-10 minutes.]

This presents a few problems.

When we are done with a work tree, we want to clean up -- think: prune.  Bu=
t, you cannot prune just
one worktree; you have to prune the set.  And no machine has access to all =
the worktrees.  So, no
machine knows which ones are prunable.

There is no 'lock' option to 'add'.  If someone does a 'prune' after you do=
 an 'add' and before you do a
'lock', then your 'add' is undone.

Are there any plans to add a '[--lock]' option to 'add' to create the workt=
ree in the locked state?  And/or
plans to add a [<path>...] option to prune to say 'prune only this path / t=
hese paths'?

If there are no plans, is the above an acceptable interface?  And if we imp=
lemented it, would it be looked
upon favorably?

Thanks.
