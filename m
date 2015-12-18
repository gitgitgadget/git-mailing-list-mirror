From: Cameron Esfahani <dirty@apple.com>
Subject: -C option with pull doesn't seem to be respected in aliases in git 2.6.4.
Date: Thu, 17 Dec 2015 17:35:37 -0800
Message-ID: <96FA4EE3-B68F-49B9-896F-38F37E12676D@apple.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 02:50:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9kBz-0005hi-7Z
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 02:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbbLRBun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 20:50:43 -0500
Received: from mail-out5.apple.com ([17.151.62.27]:60137 "EHLO
	mail-in5.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964859AbbLRBum convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 20:50:42 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Dec 2015 20:50:42 EST
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
	q=dns/txt; i=@apple.com; t=1450402537; x=2314316137;
	h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S3JploqdWGFK1+i5RVgEzUSCEijvrRHEzUXUnKwDM3g=;
	b=HFVHpKk+00G939gZIV/O72oxtHi0RN+FFgzyN4YpXEu6F30rf+n/OMZGXfKCPaqT
	o4L3xzcKEsgER/OYVL6aLIO7MFfki5xJ5FSSMHGZdJb6dT5DERDU6uhQrQRLhPch
	ul9CYLO/lFP7oTWapPXzLfyJ82iMCtCEQxFBmwhiqC2fY9aoApodMkMxtSmvg1Ds
	laz68usNY+fpemEj4Qx3xmYvepLeKz8KgRrrBW8Svzw8uj6vMQ7rnIMjdoNC7aVS
	EzMnqG0nXCRSQZdURbHvM64iiVrZNN3L610kCXPcUnjiTvC4qZ3J/hmRmBb4eoXe
	BMwzzxrzHWi24EPu6xkRlA==;
Received: from relay3.apple.com (relay3.apple.com [17.128.113.83])
	by mail-in5.apple.com (Apple Secure Mail Relay) with SMTP id 11.95.13397.9E263765; Thu, 17 Dec 2015 17:35:37 -0800 (PST)
X-AuditID: 11973e13-f798b6d000003455-7d-567362e93582
Received: from da1203a-dhcp206.apple.com (da1203a-dhcp206.apple.com [17.208.31.206])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by relay3.apple.com (Apple SCV relay) with SMTP id 33.E7.05180.9E263765; Thu, 17 Dec 2015 17:35:37 -0800 (PST)
X-Mailer: Apple Mail (2.2104)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42IRbCgM1n2ZVBxm8PengEXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDK+vlrLWnCmj7Hi1r29LA2MfQVdjJwcEgImEqe2nWCFsMUkLtxb
	z9bFyMUhJLCXUWLF+vnMXYwcYEWXP7GB1AgJrGKS6NkjAGKzCWhI7Du/BKyXWUBd4s+8S8wQ
	trbEsoWvwWxhgSCJxwuuMYLYvAI2EjtWTmYHsVkEVCU6tl4H6xUREJd4e3wmO0SNnsSrW5eh
	7pGV2P37ERPIPRICD1kljm2ayTiBkX8Wkn2zkOybhaR/ASPzKkah3MTMHN3MPFO9xIKCnFS9
	5PzcTYygIJtuJ7yD8fQqq0OMAhyMSjy8BmzFYUKsiWXFlbmHGKU5WJTEeXe5AoUE0hNLUrNT
	UwtSi+KLSnNSiw8xMnFwSjUwtjjM8LhquFP34fq8XZlzvn7ZdWq7Dr/9nVUi63cwR136uyXj
	DVPA2lSv1hamExcmLrLf++VJ6eZ+s8pGwXKzW1OOWOmEGCTee7px6rNDS+5l2nnG6inFhPee
	VT59Zd2pHTt6S8UWcm0o7gv19IiSC0+dlzNp59PL7MWadbnKE0KaZoQELPgXpMRSnJFoqMVc
	VJwIAFq37hoTAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsUieEH+nO7LpOIwgxnXeC26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJXx9dVa1oIzfYwVt+7tZWlg7CvoYuTgkBAwkbj8ia2LkRPIFJO4
	cG89mC0ksIpJomePAIjNJqAhse/8ElYQm1lAXeLPvEvMELa2xLKFr8FsYYEgiccLrjGC2LwC
	NhI7Vk5mB7FZBFQlOrZeB+sVERCXeHt8JjtEjZ7Eq1uXWSH2ykrs/v2IaQIjzywkK2YhWTEL
	ScsCRuZVjAJFqTmJlcZ6iQUFOal6yfm5mxhBQdFQGLyD8c8yq0OMAhyMSjy8BmzFYUKsiWXF
	lbmHGCU4mJVEeAPCgUK8KYmVValF+fFFpTmpxYcYk4EOncgsJZqcDwzYvJJ4QxMTAxNjYzNj
	Y3MTc9KElcR5JawLwoQE0hNLUrNTUwtSi2C2MHFwSjUwTkxS5a/6xhR7Ju5novzSkisXX58O
	E7hZN2nf+Q1nNcR+7Nh3fH3tKp0lBcxbjffNern9aMeNuRIa8w4w9J2RKHZYGbhuRdxMz29c
	s6X/WP0VfC7hql+42PHEuiPpT/uUV+58rVRm+Net8P6h6TteX0h5fWK/Q8V3pwf/fU1W5JV3
	uLznVArd+UWJpTgj0VCLuag4EQBNnrJUTgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282691>

I have git project checked out at ~/llvm.  Inside of there, inside of a=
 =E2=80=9Ctools=E2=80=9D directory, I have another project checked out =
as =E2=80=9Clldb=E2=80=9D:

~/llvm/tools/lldb

I wrote an alias which would help me update all my projects:

	all =3D !find . -type d -name .git | sed 's:/.git::' | xargs -I{} -t g=
it -C {} $1 && :

This would allow me to be inside of ~/llvm and type "git all pull" and =
get all my projects updated.

It seems that at some point this broke.  If try to use this alias under=
 git 2.6.4, it only updates the llvm project.

The interesting thing is that if I pass fetch, instead of pull: "git al=
l fetch", then it seems to work correctly.

Here=E2=80=99s the GIT_TRACE output for =E2=80=9Cgit all pull=E2=80=9D =
when in ~/llvm:

[llvm (master)]$ GIT_TRACE=3D1 git all pull
17:28:43.938363 git.c:558               trace: exec: 'git-all' 'pull'
17:28:43.938813 run-command.c:335       trace: run_command: 'git-all' '=
pull'
17:28:43.940167 run-command.c:335       trace: run_command: 'find . -ty=
pe d -name .git | sed '\''s:/.git::'\'' | xargs -I{} -t git -C {} $1 &&=
 :' 'pull'
17:28:43.940665 run-command.c:195       trace: exec: '/bin/sh' '-c' 'fi=
nd . -type d -name .git | sed '\''s:/.git::'\'' | xargs -I{} -t git -C =
{} $1 && : "$@"' 'find . -type d -name .git | sed '\''s:/.git::'\'' | x=
args -I{} -t git -C {} $1 && :' 'pull'
git -C . pull
17:28:44.191670 git.c:558               trace: exec: 'git-pull'
17:28:44.192253 run-command.c:335       trace: run_command: 'git-pull'
17:28:44.197094 git.c:348               trace: built-in: git 'rev-parse=
' '--parseopt' '--stuck-long' '--'
17:28:44.203237 git.c:348               trace: built-in: git 'rev-parse=
' '--git-dir'
17:28:44.207297 git.c:348               trace: built-in: git 'rev-parse=
' '--git-path' 'objects'
17:28:44.210819 git.c:348               trace: built-in: git 'rev-parse=
' '--is-bare-repository'
17:28:44.213666 git.c:348               trace: built-in: git 'rev-parse=
' '--show-toplevel'
17:28:44.216954 git.c:348               trace: built-in: git 'ls-files'=
 '-u'
17:28:44.227604 git.c:348               trace: built-in: git 'symbolic-=
ref' '-q' 'HEAD'
17:28:44.233503 git.c:348               trace: built-in: git 'config' '=
branch.master.rebase'
17:28:44.244334 git.c:348               trace: built-in: git 'config' '=
pull.ff'
17:28:44.247510 git.c:348               trace: built-in: git 'rev-parse=
' '-q' '--verify' 'HEAD'
17:28:44.250365 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'HEAD'
17:28:44.253328 git.c:348               trace: built-in: git 'update-in=
dex' '-q' '--ignore-submodules' '--refresh'
17:28:44.282912 git.c:348               trace: built-in: git 'diff-file=
s' '--quiet' '--ignore-submodules'
17:28:44.317433 git.c:348               trace: built-in: git 'diff-inde=
x' '--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
17:28:44.332900 git.c:348               trace: built-in: git 'rev-parse=
' '-q' '--git-dir'
17:28:44.366055 git.c:348               trace: built-in: git 'rev-parse=
' '-q' '--verify' 'HEAD'
17:28:44.369245 git.c:348               trace: built-in: git 'fetch' '-=
-update-head-ok'
17:28:44.380626 run-command.c:335       trace: run_command: 'git-remote=
-http' 'origin' 'http://llvm.org/git/llvm.git'
17:28:44.575908 run-command.c:335       trace: run_command: 'rev-list' =
'--objects' '--stdin' '--not' '--all' '--quiet'
17:28:44.583303 run-command.c:335       trace: run_command: 'rev-list' =
'--objects' '--stdin' '--not' '--all'
17:28:44.583756 exec_cmd.c:178          trace: exec: 'git' 'rev-list' '=
--objects' '--stdin' '--not' '--all'
17:28:44.585457 git.c:348               trace: built-in: git 'rev-list'=
 '--objects' '--stdin' '--not' '--all'
17:28:44.591116 run-command.c:335       trace: run_command: 'gc' '--aut=
o'
17:28:44.591576 exec_cmd.c:178          trace: exec: 'git' 'gc' '--auto=
'
17:28:44.593252 git.c:348               trace: built-in: git 'gc' '--au=
to'
17:28:44.597284 git.c:348               trace: built-in: git 'rev-parse=
' '-q' '--verify' 'HEAD'
17:28:44.604021 git.c:348               trace: built-in: git 'show-bran=
ch' '--merge-base' 'refs/heads/master' 'ce00641ac5f4ca2a073b732a7516903=
7a2d9bef0' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0'
17:28:44.610870 git.c:348               trace: built-in: git 'rev-parse=
' '--parseopt' '--stuck-long' '--' '--onto' 'ce00641ac5f4ca2a073b732a75=
169037a2d9bef0' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0'
17:28:44.617283 git.c:348               trace: built-in: git 'rev-parse=
' '--git-dir'
17:28:44.621510 git.c:348               trace: built-in: git 'rev-parse=
' '--git-path' 'objects'
17:28:44.626588 git.c:348               trace: built-in: git 'rev-parse=
' '--is-bare-repository'
17:28:44.629515 git.c:348               trace: built-in: git 'rev-parse=
' '--show-toplevel'
17:28:44.633673 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.stat'
17:28:44.636888 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.autostash'
17:28:44.640171 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.autosquash'
17:28:44.644466 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0^0'
17:28:44.649511 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0^0'
17:28:44.653787 git.c:348               trace: built-in: git 'symbolic-=
ref' '-q' 'HEAD'
17:28:44.659338 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'HEAD'
17:28:44.662978 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'HEAD'
17:28:44.666002 git.c:348               trace: built-in: git 'update-in=
dex' '-q' '--ignore-submodules' '--refresh'
17:28:44.698982 git.c:348               trace: built-in: git 'diff-file=
s' '--quiet' '--ignore-submodules'
17:28:44.735732 git.c:348               trace: built-in: git 'diff-inde=
x' '--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
17:28:44.752604 git.c:348               trace: built-in: git 'merge-bas=
e' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0' 'ce00641ac5f4ca2a073b732a=
75169037a2d9bef0'
17:28:44.758075 git.c:348               trace: built-in: git 'rev-list'=
 '--parents' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0..ce00641ac5f4ca2=
a073b732a75169037a2d9bef0'
17:28:44.765516 git.c:558               trace: exec: 'git-sh-i18n--envs=
ubst' '--variables' 'Current branch $branch_name is up to date.'
17:28:44.766008 run-command.c:335       trace: run_command: 'git-sh-i18=
n--envsubst' '--variables' 'Current branch $branch_name is up to date.'
17:28:44.770269 git.c:558               trace: exec: 'git-sh-i18n--envs=
ubst' 'Current branch $branch_name is up to date.'
17:28:44.770702 run-command.c:335       trace: run_command: 'git-sh-i18=
n--envsubst' 'Current branch $branch_name is up to date.'
Current branch master is up to date.
17:28:44.775429 git.c:348               trace: built-in: git 'gc' '--au=
to'
git -C ./tools/lldb pull
17:28:48.377109 git.c:558               trace: exec: 'git-pull'
17:28:48.377647 run-command.c:335       trace: run_command: 'git-pull'
17:28:48.384848 git.c:348               trace: built-in: git 'rev-parse=
' '--parseopt' '--stuck-long' '--'
17:28:48.391621 git.c:348               trace: built-in: git 'rev-parse=
' '--git-dir'
17:28:48.396502 git.c:348               trace: built-in: git 'rev-parse=
' '--git-path' 'objects'
17:28:48.400801 git.c:348               trace: built-in: git 'rev-parse=
' '--is-bare-repository'
17:28:48.403695 git.c:348               trace: built-in: git 'rev-parse=
' '--show-toplevel'
17:28:48.407029 git.c:348               trace: built-in: git 'ls-files'=
 '-u'
17:28:48.418794 git.c:348               trace: built-in: git 'symbolic-=
ref' '-q' 'HEAD'
17:28:48.426330 git.c:348               trace: built-in: git 'config' '=
branch.master.rebase'
17:28:48.437204 git.c:348               trace: built-in: git 'config' '=
pull.ff'
17:28:48.440558 git.c:348               trace: built-in: git 'rev-parse=
' '-q' '--verify' 'HEAD'
17:28:48.444038 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'HEAD'
17:28:48.448308 git.c:348               trace: built-in: git 'update-in=
dex' '-q' '--ignore-submodules' '--refresh'
17:28:48.484990 git.c:348               trace: built-in: git 'diff-file=
s' '--quiet' '--ignore-submodules'
17:28:48.514798 git.c:348               trace: built-in: git 'diff-inde=
x' '--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
17:28:48.526355 git.c:348               trace: built-in: git 'rev-parse=
' '-q' '--git-dir'
17:28:48.560625 git.c:348               trace: built-in: git 'rev-parse=
' '-q' '--verify' 'HEAD'
17:28:48.565375 git.c:348               trace: built-in: git 'fetch' '-=
-update-head-ok'
17:28:48.579800 run-command.c:335       trace: run_command: 'git-remote=
-http' 'origin' 'http://llvm.org/git/llvm.git'
17:28:48.829976 run-command.c:335       trace: run_command: 'rev-list' =
'--objects' '--stdin' '--not' '--all' '--quiet'
17:28:48.837240 run-command.c:335       trace: run_command: 'rev-list' =
'--objects' '--stdin' '--not' '--all'
17:28:48.837793 exec_cmd.c:178          trace: exec: 'git' 'rev-list' '=
--objects' '--stdin' '--not' '--all'
17:28:48.839494 git.c:348               trace: built-in: git 'rev-list'=
 '--objects' '--stdin' '--not' '--all'
17:28:48.844913 run-command.c:335       trace: run_command: 'gc' '--aut=
o'
17:28:48.845464 exec_cmd.c:178          trace: exec: 'git' 'gc' '--auto=
'
17:28:48.847145 git.c:348               trace: built-in: git 'gc' '--au=
to'
17:28:48.851173 git.c:348               trace: built-in: git 'rev-parse=
' '-q' '--verify' 'HEAD'
17:28:48.857550 git.c:348               trace: built-in: git 'show-bran=
ch' '--merge-base' 'refs/heads/master' 'ce00641ac5f4ca2a073b732a7516903=
7a2d9bef0' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0'
17:28:48.864262 git.c:348               trace: built-in: git 'rev-parse=
' '--parseopt' '--stuck-long' '--' '--onto' 'ce00641ac5f4ca2a073b732a75=
169037a2d9bef0' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0'
17:28:48.870801 git.c:348               trace: built-in: git 'rev-parse=
' '--git-dir'
17:28:48.875849 git.c:348               trace: built-in: git 'rev-parse=
' '--git-path' 'objects'
17:28:48.880555 git.c:348               trace: built-in: git 'rev-parse=
' '--is-bare-repository'
17:28:48.883537 git.c:348               trace: built-in: git 'rev-parse=
' '--show-toplevel'
17:28:48.887435 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.stat'
17:28:48.890846 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.autostash'
17:28:48.894187 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.autosquash'
17:28:48.899616 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0^0'
17:28:48.905231 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0^0'
17:28:48.909854 git.c:348               trace: built-in: git 'symbolic-=
ref' '-q' 'HEAD'
17:28:48.914188 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'HEAD'
17:28:48.918339 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'HEAD'
17:28:48.923372 git.c:348               trace: built-in: git 'update-in=
dex' '-q' '--ignore-submodules' '--refresh'
17:28:48.957439 git.c:348               trace: built-in: git 'diff-file=
s' '--quiet' '--ignore-submodules'
17:28:48.988790 git.c:348               trace: built-in: git 'diff-inde=
x' '--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
17:28:49.000859 git.c:348               trace: built-in: git 'merge-bas=
e' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0' 'ce00641ac5f4ca2a073b732a=
75169037a2d9bef0'
17:28:49.005472 git.c:348               trace: built-in: git 'rev-list'=
 '--parents' 'ce00641ac5f4ca2a073b732a75169037a2d9bef0..ce00641ac5f4ca2=
a073b732a75169037a2d9bef0'
17:28:49.011492 git.c:558               trace: exec: 'git-sh-i18n--envs=
ubst' '--variables' 'Current branch $branch_name is up to date.'
17:28:49.011931 run-command.c:335       trace: run_command: 'git-sh-i18=
n--envsubst' '--variables' 'Current branch $branch_name is up to date.'
17:28:49.016616 git.c:558               trace: exec: 'git-sh-i18n--envs=
ubst' 'Current branch $branch_name is up to date.'
17:28:49.017127 run-command.c:335       trace: run_command: 'git-sh-i18=
n--envsubst' 'Current branch $branch_name is up to date.'
Current branch master is up to date.
17:28:49.023390 git.c:348               trace: built-in: git 'gc' '=E2=80=
=94auto'

As you can see, the URL for =E2=80=9Cgit-remote-http=E2=80=9D in both c=
ases is the same.

Here=E2=80=99s the same output when I don=E2=80=99t use my alias, and j=
ust explicitly type =E2=80=9Cgit -C ./tools/lldb pull=E2=80=9D:

[llvm (master)]$ GIT_TRACE=3D1 git -C ./tools/lldb pull
17:33:32.719929 git.c:348               trace: built-in: git 'pull'
17:33:32.736277 run-command.c:343       trace: run_command: 'merge-base=
' '--fork-point' 'refs/remotes/origin/master' 'master'
17:33:32.746115 run-command.c:343       trace: run_command: 'fetch' '--=
update-head-ok'
17:33:32.746678 exec_cmd.c:128          trace: exec: 'git' 'fetch' '--u=
pdate-head-ok'
17:33:32.749630 git.c:348               trace: built-in: git 'fetch' '-=
-update-head-ok'
17:33:32.755626 run-command.c:343       trace: run_command: 'git-remote=
-http' 'origin' 'http://llvm.org/git/lldb.git'
17:33:32.907411 run-command.c:343       trace: run_command: 'rev-list' =
'--objects' '--stdin' '--not' '--all' '--quiet'
17:33:32.914960 run-command.c:343       trace: run_command: 'rev-list' =
'--objects' '--stdin' '--not' '--all'
17:33:32.915633 exec_cmd.c:128          trace: exec: 'git' 'rev-list' '=
--objects' '--stdin' '--not' '--all'
17:33:32.917963 git.c:348               trace: built-in: git 'rev-list'=
 '--objects' '--stdin' '--not' '--all'
17:33:32.921940 run-command.c:343       trace: run_command: 'gc' '--aut=
o'
17:33:32.922467 exec_cmd.c:128          trace: exec: 'git' 'gc' '--auto=
'
17:33:32.925462 git.c:348               trace: built-in: git 'gc' '--au=
to'
17:33:32.927842 run-command.c:343       trace: run_command: 'rebase' '-=
-onto' '8c27fea58aad24c89280b97997e11b8bfdda919c' '8c27fea58aad24c89280=
b97997e11b8bfdda919c'
17:33:32.928329 exec_cmd.c:128          trace: exec: 'git' 'rebase' '--=
onto' '8c27fea58aad24c89280b97997e11b8bfdda919c' '8c27fea58aad24c89280b=
97997e11b8bfdda919c'
17:33:32.930466 git.c:560               trace: exec: 'git-rebase' '--on=
to' '8c27fea58aad24c89280b97997e11b8bfdda919c' '8c27fea58aad24c89280b97=
997e11b8bfdda919c'
17:33:32.930901 run-command.c:343       trace: run_command: 'git-rebase=
' '--onto' '8c27fea58aad24c89280b97997e11b8bfdda919c' '8c27fea58aad24c8=
9280b97997e11b8bfdda919c'
17:33:32.937571 git.c:348               trace: built-in: git 'rev-parse=
' '--parseopt' '--stuck-long' '--' '--onto' '8c27fea58aad24c89280b97997=
e11b8bfdda919c' '8c27fea58aad24c89280b97997e11b8bfdda919c'
17:33:32.944701 git.c:348               trace: built-in: git 'rev-parse=
' '--git-dir'
17:33:32.949832 git.c:348               trace: built-in: git 'rev-parse=
' '--git-path' 'objects'
17:33:32.954805 git.c:348               trace: built-in: git 'rev-parse=
' '--is-bare-repository'
17:33:32.959788 git.c:348               trace: built-in: git 'rev-parse=
' '--show-toplevel'
17:33:32.964319 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.stat'
17:33:32.968482 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.autostash'
17:33:32.972293 git.c:348               trace: built-in: git 'config' '=
--bool' 'rebase.autosquash'
17:33:32.977557 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' '8c27fea58aad24c89280b97997e11b8bfdda919c^0'
17:33:32.983348 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' '8c27fea58aad24c89280b97997e11b8bfdda919c^0'
17:33:32.990145 git.c:348               trace: built-in: git 'symbolic-=
ref' '-q' 'HEAD'
17:33:32.995278 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'HEAD'
17:33:32.999987 git.c:348               trace: built-in: git 'rev-parse=
' '--verify' 'HEAD'
17:33:33.004018 git.c:348               trace: built-in: git 'update-in=
dex' '-q' '--ignore-submodules' '--refresh'
17:33:33.016616 git.c:348               trace: built-in: git 'diff-file=
s' '--quiet' '--ignore-submodules'
17:33:33.029256 git.c:348               trace: built-in: git 'diff-inde=
x' '--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
17:33:33.036863 git.c:348               trace: built-in: git 'merge-bas=
e' '8c27fea58aad24c89280b97997e11b8bfdda919c' '8c27fea58aad24c89280b979=
97e11b8bfdda919c'
17:33:33.043280 git.c:348               trace: built-in: git 'rev-list'=
 '--parents' '8c27fea58aad24c89280b97997e11b8bfdda919c..8c27fea58aad24c=
89280b97997e11b8bfdda919c'
17:33:33.050406 git.c:560               trace: exec: 'git-sh-i18n--envs=
ubst' '--variables' 'Current branch $branch_name is up to date.'
17:33:33.050965 run-command.c:343       trace: run_command: 'git-sh-i18=
n--envsubst' '--variables' 'Current branch $branch_name is up to date.'
17:33:33.058976 git.c:560               trace: exec: 'git-sh-i18n--envs=
ubst' 'Current branch $branch_name is up to date.'
17:33:33.059502 run-command.c:343       trace: run_command: 'git-sh-i18=
n--envsubst' 'Current branch $branch_name is up to date.'
Current branch master is up to date.
17:33:33.066886 git.c:348               trace: built-in: git 'gc' '--au=
to'

Cameron Esfahani
dirty@apple.com

"Americans are very skilled at creating a custom meaning from something=
 that's mass-produced."

Ann Powers
