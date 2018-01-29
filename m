Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D23A1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeA2PgQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 10:36:16 -0500
Received: from mail-he1eur01on0063.outbound.protection.outlook.com ([104.47.0.63]:38084
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751256AbeA2PgP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 10:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PirumSystems.onmicrosoft.com; s=selector1-pirum-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=riV8uFaP7hXLY1sF2z5MCqLW+TesMAnbiTRufEJgPMk=;
 b=tMJaj7MIgCLkUyUwoZHrUFiGmzNWCr29soL1rVWKjWb0aEblYdILlPBZuW9o3E9Y/0F4sS7t3t6qtB4l70L8qeMDyrW4c5YZEvlli9IzEXD0YiTrppVgU6nBJlaqDh5higBHvD0Q1eRk3HJCuIi6WBKIHPC333vhuH/sBO/Ewv0=
Received: from HE1PR0602MB3355.eurprd06.prod.outlook.com (52.133.4.18) by
 HE1PR0602MB3626.eurprd06.prod.outlook.com (52.133.5.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.444.14; Mon, 29 Jan 2018 15:36:12 +0000
Received: from HE1PR0602MB3355.eurprd06.prod.outlook.com
 ([fe80::9000:7688:7d7b:ca33]) by HE1PR0602MB3355.eurprd06.prod.outlook.com
 ([fe80::9000:7688:7d7b:ca33%13]) with mapi id 15.20.0444.016; Mon, 29 Jan
 2018 15:36:12 +0000
From:   "Hugo van der Sanden, Pirum" <hugo.vandersanden@pirum.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Hugo Van Der Sanden <hv@crypt.org>
Subject: rebase oddity
Thread-Topic: rebase oddity
Thread-Index: AdOZEqtm7ftFK5ofR3G8BDWWetsIFg==
Date:   Mon, 29 Jan 2018 15:36:11 +0000
Message-ID: <HE1PR0602MB33559DA1B3A84C68A70F1F1DE4E50@HE1PR0602MB3355.eurprd06.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [5.148.138.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0602MB3626;7:S0axEqRymNuL+5NAUBa5cjB8X24lxTtL2uZ3svs6GaSk0f/mLklO1HlQ1ckGX7YuSy5kwB09v3tXSKxzRvs5cecDck9F+zGtvRZPpabGtkIryAPJ6ddvf0u/phvT63uje7a1wJZuFGkiEQJ2F3JXkwR+jMxzctAd5ON8G+Ho4OnI9Ag67Yz/6BsjbGFfXMOHgFjISfSgIZgFuOdTWJSXEwvymMn3nvR5ffaPfxx3Tm1X0j3pkj/Zvl/Ouyhx5DHO
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: ac4642d4-be72-4167-c241-08d5672e06a4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:HE1PR0602MB3626;
x-ms-traffictypediagnostic: HE1PR0602MB3626:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hugo.vandersanden@pirum.com; 
x-microsoft-antispam-prvs: <HE1PR0602MB3626DBD70D1F4CD1CE4C0FC9E4E50@HE1PR0602MB3626.eurprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6041288)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0602MB3626;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0602MB3626;
x-forefront-prvs: 0567A15835
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(366004)(376002)(39840400004)(199004)(189003)(59450400001)(33656002)(2906002)(6916009)(478600001)(86362001)(68736007)(55016002)(3480700004)(9686003)(53936002)(99286004)(71446004)(6436002)(8936002)(8676002)(6506007)(102836004)(7696005)(3846002)(14454004)(105586002)(5660300001)(81156014)(1730700003)(81166006)(5640700003)(6116002)(316002)(106356001)(3280700002)(2351001)(26005)(7736002)(7116003)(3660700001)(5250100002)(66066001)(25786009)(2501003)(74316002)(305945005)(2900100001)(97736004)(186003)(4326008)(221733001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0602MB3626;H:HE1PR0602MB3355.eurprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:0;MX:1;LANG:en;
received-spf: None (protection.outlook.com: pirum.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zoNOUs/iuT15UowPyx3jpb6KFRg7mlrc2Wc8mhI9aYuQItfJvc9oftv4BD1GEqbwxbbjqrDxxwCrvco+zZfR3Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pirum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4642d4-be72-4167-c241-08d5672e06a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2018 15:36:11.8691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99a0b81b-68df-4a75-8fca-954de34c6a14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3626
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I'm encountering a rebase oddity, and would welcome advice on how I cou=
ld debug it far enough to characterize it so I can (one or both of) report =
it as a bug, or detect and avoid the situation.

I can reproduce this on my primary development host, running git-2.11.0 on =
a debian (jessie) VM hosted on a Windows-10 machine via VirtualBox 5.2.2, o=
n a filesystem native to a real debian machine mounted over Samba and impor=
ted by VirtualBox into the VM. I have not been able to reproduce it on simi=
lar checkouts on the real debian machine, nor in a Cygwin shell over a nati=
ve Windows partition (running git-2.11.0 in each case). I have not yet atte=
mpted to update git version (which would involve getting permission to do s=
o).

In short: rebase stops on the second commit with the claim "Your local chan=
ges to the following files would be overwritten by merge: lib/NL/Control/En=
rich.pm"; this file did not have local changes, and was not modified by any=
 commit other than this one beyond the merge-base in either branch. I would=
 expect it to apply cleanly during rebase, and indeed cherry-picking it at =
the same point manages to apply it with no problem. GIT_TRACE=3D1 does not =
show enough detail for me to guess what's going wrong, are there other diag=
nostic options that would show more detail, short of strace(1)?

I've done numerous similar rebases in this environment, and not had anythin=
g like this happen before.

The long version follows, any clues gratefully received.

Hugo van der Sanden

<<END

The setup is a parent branch with a fresh merge of a single commit, and a c=
hild branch that needs updating:

merge-base A=3D823cbe6f1fdb9b3b5aed43de84380e8beb220ec1
parent (at C):
  commit B=3D097d2c7e648c87a927a77d0f39ed0e53149320ef (parent A)
  merge commit C=3D94ba94817003f2ca72301882b6be5744b3919d06 (Merge A B, was=
 fast-forwardable)
child (at G):
  commit D=3D1d98a92010c2a2929c178340683d890cab8e056a (parent A) commit-mes=
sage mD
  commit E=3D0960ab2979c74f10cd0b39c6893b69adac79d8cd (parent D) commit-mes=
sage mE
  commit F=3D2abf3b4ffdea7de86c4e7e5109fb6e974a9e9c67 (parent E) commit-mes=
sage mF
  commit G=3D2ec06a698ac5c6eb927e1849e5536f1f0ed36895 (parent F) commit-mes=
sage mG

When from a clean state I invoke 'git checkout child; git rebase HEAD~4 --o=
nto parent', I get this:

% git status
On branch child
nothing to commit, working tree clean
% git rebase HEAD~4 --onto parent
First, rewinding head to replay your work on top of it...
Applying: mD
Applying: mE
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by me=
rge:
        lib/NL/Control/Enrich.pm
Please commit your changes or stash them before you merge.
Aborting
error: Failed to merge in the changes.
Patch failed at 0002 mE
The copy of the patch that failed is found in: .git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort=
".

% git status
rebase in progress; onto 94ba948
You are currently rebasing branch 'child' on '94ba948'.
  (all conflicts fixed: run "git rebase --continue")

nothing to commit, working tree clean
% git diff HEAD
%=20

Commit D changes 10 files, including 3 renames; commit E changes 3 files (i=
ncluding " lib/NL/Control/Enrich.pm"), none of which is touched by D.

If I reorder the commits in child using interactive rebase to be (D, F, G, =
E), the rebase still fails exactly the same way at E. If I then skip that c=
ommit to complete the rebase, I can successfully cherry-pick E to get exact=
ly the result I expected of the rebase.

The original rebase with GIT_TRACE=3D1 yields:
15:01:52.522578 git.c:600               trace: exec: 'git-rebase' 'HEAD~4' =
'--onto' 'parent'
15:01:52.522730 run-command.c:350       trace: run_command: 'git-rebase' 'H=
EAD~4' '--onto' 'parent'
15:01:52.524820 git.c:371               trace: built-in: git 'rev-parse' '-=
-parseopt' '--stuck-long' '--' 'HEAD~4' '--onto' 'parent'
15:01:52.526160 git.c:371               trace: built-in: git 'rev-parse' '-=
-git-dir'
15:01:52.529971 git.c:371               trace: built-in: git 'rev-parse' '-=
-git-path' 'objects'
15:01:52.533615 git.c:371               trace: built-in: git 'rev-parse' '-=
-is-bare-repository'
15:01:52.537067 git.c:371               trace: built-in: git 'rev-parse' '-=
-show-toplevel'
15:01:52.543825 git.c:371               trace: built-in: git 'config' '--bo=
ol' 'rebase.stat'
15:01:52.548413 git.c:371               trace: built-in: git 'config' '--bo=
ol' 'rebase.autostash'
15:01:52.554723 git.c:371               trace: built-in: git 'config' '--bo=
ol' 'rebase.autosquash'
15:01:52.559588 git.c:371               trace: built-in: git 'config' '--bo=
ol' 'commit.gpgsign'
15:01:52.561834 git.c:371               trace: built-in: git 'rev-parse' '-=
-verify' 'HEAD~4^0'
15:01:52.573794 git.c:371               trace: built-in: git 'rev-parse' '-=
-verify' 'parent^0'
15:01:52.588723 git.c:371               trace: built-in: git 'symbolic-ref'=
 '-q' 'HEAD'
15:01:52.591557 git.c:371               trace: built-in: git 'rev-parse' '-=
-verify' 'HEAD'
15:01:52.598194 git.c:371               trace: built-in: git 'rev-parse' '-=
-verify' 'HEAD'
15:01:52.609517 git.c:371               trace: built-in: git 'update-index'=
 '-q' '--ignore-submodules' '--refresh'
15:01:52.741980 git.c:371               trace: built-in: git 'diff-files' '=
--quiet' '--ignore-submodules'
15:01:52.868020 git.c:371               trace: built-in: git 'diff-index' '=
--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
15:01:52.880407 git.c:371               trace: built-in: git 'merge-base' '=
94ba94817003f2ca72301882b6be5744b3919d06' '2ec06a698ac5c6eb927e1849e5536f1f=
0ed36895'
15:01:52.894183 git.c:371               trace: built-in: git 'rev-parse' '-=
-git-path' 'hooks/pre-rebase'
First, rewinding head to replay your work on top of it...
15:01:52.902352 git.c:371               trace: built-in: git 'checkout' '-q=
' '94ba94817003f2ca72301882b6be5744b3919d06^0'
15:01:53.082451 git.c:371               trace: built-in: git 'update-ref' '=
ORIG_HEAD' '2ec06a698ac5c6eb927e1849e5536f1f0ed36895'
15:01:53.092045 git.c:371               trace: built-in: git 'format-patch'=
 '-k' '--stdout' '--full-index' '--cherry-pick' '--right-only' '--src-prefi=
x=3Da/' '--dst-prefix=3Db/' '--no-renames' '--no-cover-letter' '823cbe6f1fd=
b9b3b5aed43de84380e8beb220ec1...2ec06a698ac5c6eb927e1849e5536f1f0ed36895'
15:01:53.120678 git.c:371               trace: built-in: git 'am' '--rebasi=
ng' '--resolvemsg=3D
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort=
".
'
15:01:53.123889 run-command.c:350       trace: run_command: 'mailsplit' '-d=
4' '-o.git/rebase-apply' '-b' '--'
15:01:53.124187 exec_cmd.c:116          trace: exec: 'git' 'mailsplit' '-d4=
' '-o.git/rebase-apply' '-b' '--'
15:01:53.124668 git.c:371               trace: built-in: git 'mailsplit' '-=
d4' '-o.git/rebase-apply' '-b' '--'
Applying: mD
Applying: mE
15:01:53.350845 run-command.c:350       trace: run_command: 'apply' '--buil=
d-fake-ancestor=3D.git/rebase-apply/patch-merge-index' '.git/rebase-apply/p=
atch'
15:01:53.351119 exec_cmd.c:116          trace: exec: 'git' 'apply' '--build=
-fake-ancestor=3D.git/rebase-apply/patch-merge-index' '.git/rebase-apply/pa=
tch'
15:01:53.354153 git.c:371               trace: built-in: git 'apply' '--bui=
ld-fake-ancestor=3D.git/rebase-apply/patch-merge-index' '.git/rebase-apply/=
patch'
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by me=
rge:
        lib/NL/Control/Enrich.pm
Please commit your changes or stash them before you merge.
Aborting
error: Failed to merge in the changes.
Patch failed at 0002 mE
The copy of the patch that failed is found in: .git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort=
".

%=20

END
