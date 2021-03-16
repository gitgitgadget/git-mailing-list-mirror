Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E08C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE8765140
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 18:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbhCPSx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 14:53:58 -0400
Received: from proofpoint8.lanl.gov ([204.121.3.47]:38562 "EHLO
        proofpoint8.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCPSxa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 14:53:30 -0400
Received: from pps.filterd (proofpoint8.lanl.gov [127.0.0.1])
        by proofpoint8.lanl.gov (8.16.0.22/8.16.0.22) with SMTP id 12GIqAL3132303
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:53:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lanl.gov; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=lanl; bh=3EtIQ+a3+osYNXD4TMK+aCn6FbpKOaVtYFS99WR7s8k=;
 b=KJ897SQC3p3KaZYiabDgbRQo5S4dB/2F6zDeFgTVmh9Tab3YNoz+4YdyUnv/eoxhTIR7
 yrYupzRCE/byR3IaKUVTjHWiZWq0O8fAtZf0Dlzvf4QsbMIaGgfL/lkgbQKl+26dGMWi
 4Q74OaA2BtzFlZdd9/C3h+2oLwvrySDc4HxtpcP4blpmJDDY1j+xJiN36K0p6gQEF7OZ
 tOGR50rBNtESMFyr8ItJEZ5NTPlgh38OMkdGeXsWNMBF8fzrnznIbqjWXt5D9JP7WPah
 SDMRoOUvePH5MtBv1cLTuhDXGg6F/AxaLuTskzfpN/QeR4uGt7xww3CsGe7y0CNSjKH/ nw== 
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
        by proofpoint8.lanl.gov with ESMTP id 37aj3n2bt5-1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:53:24 -0600
Received: from localhost (localhost [127.0.0.1])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 989B91009B17
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:53:24 -0600 (MDT)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from EXG16-P-MBX15.win.lanl.gov (exg16-p-mbx15.win.lanl.gov [128.165.106.225])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 86F7E1009B15
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:53:24 -0600 (MDT)
Received: from EXG16-P-MBX15.win.lanl.gov (128.165.106.225) by
 EXG16-P-MBX15.win.lanl.gov (128.165.106.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 12:53:24 -0600
Received: from EXG16-P-MBX15.win.lanl.gov ([::1]) by
 EXG16-P-MBX15.win.lanl.gov ([fe80::619e:23ca:ccea:f767%4]) with mapi id
 15.01.2106.013; Tue, 16 Mar 2021 12:53:24 -0600
From:   "Lamborn, Peter Craig" <plamborn@lanl.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Nielsen, Johnathan Patrick" <jnielsen@lanl.gov>,
        "Herrera, Thomas Anthony" <taherrera@lanl.gov>
Subject: GIT_SSH and mirror not working with git 2.30.1 
Thread-Topic: GIT_SSH and mirror not working with git 2.30.1 
Thread-Index: AQHXGpVWttDVu/7isEqFzJLw1g41sw==
Date:   Tue, 16 Mar 2021 18:53:24 +0000
Message-ID: <e39d23615e084671965fc96174ac881e@lanl.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.165.106.210]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_06:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


We have some machines behind firewalls and gateways that cannot access git =
repos directly.  We have been using GIT_SSH and mirror to push and pull git=
 request through a less restricted machine.  This has been working for a wh=
ile, specifically both git 2.24.1 and git 2.28 can handle the method we hav=
e been doing.=20


When you try the same thing with git 2.30.1, the "git push" commands still =
succeed.  But "git pull" returns this:


$ git pull <mirror name>
hint: Pulling without specifying how to reconcile divergent branches is
hint: discouraged. You can squelch this message by running one of the follo=
wing
hint: commands sometime before your next pull:
hint:
hint:   git config pull.rebase false  # merge (the default strategy)
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint:
hint: You can replace "git config" with "git config --global" to set a defa=
ult
hint: preference for all repositories. You can also pass --rebase, --no-reb=
ase,
hint: or --ff-only on the command line to override the configured default p=
er
hint: invocation.


ssh: connect to host <destination machine> port 22: Operation timed out
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
$

Does git 2.30.1 change something about mirrors and/or GIT_SSH that would ca=
use git pulls to fail?  Do we need to adjust our current process?

Our method:

destination_machine$ mkdir <DZPATH>
destination_machine$ cd <DZPATH>
destination_machine$ git --bare init

...

workstation$ cat ssh-hop.sh
#!/bin/bash
 =20
MACHINE_REGEXP=3D"<...>"
 =20
if [[ $1 =3D~ $MACHINE_REGEXP ]]; then
 =20
  exec ssh <gateway> ssh "$@"
 =20
else
  exec ssh "$@"
fi

workstation$ chmod u+x ssh-hop.sh
workstation$ export GIT_SSH=3D<path to>/ssh-hop.sh
workstation$ cd <git repo>
workstation$ git remote add --mirror <mirror name> <destination_machine>:<D=
ZPATH>
workstation$ git push <mirror name>
workstation$ git pull <mirror name>



Thank you,

Peter=
