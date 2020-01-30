Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6594C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922A3206F0
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 10:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gQcfaewW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgA3KwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:52:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:42461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3KwP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 05:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580381529;
        bh=8nP49uqvbjAGgw3CTR0XvMtS+h91rVPuPFokES6KHH8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gQcfaewW8s/u2QMox/L1UkrHz8SYepY/Q+DkNmJaeDVv/BbVM6e4X3COm287E+WvZ
         qtmLu9vEX2Fxzpodny5po5j4Xr9Yje9DBh9+hj57EQO4YSvhBYUwo/JYq03dfSJ5qH
         FiO9Sz2xKglOjzUV2NHO6ziM+7PolTwwIbINZIlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1jORRN1Axw-00jMnR; Thu, 30
 Jan 2020 11:52:09 +0100
Date:   Thu, 30 Jan 2020 11:52:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: [PATCHv1 0/6] git-p4: wait() for child processes better
In-Reply-To: <20200129111246.12196-1-luke@diamand.org>
Message-ID: <nycvar.QRO.7.76.6.2001301131280.46@tvgsbejvaqbjf.bet>
References: <20200129111246.12196-1-luke@diamand.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-586209795-1580381530=:46"
X-Provags-ID: V03:K1:wl1QNyZmKwrFM05rJ9FCdtx9FJL1j6v4M9Wns06uERlJL9JJ93Z
 mPcAcBKrqvwGFDl+//pRQn+weLNPnlDI+wnbUY5JFCrcwDJfidOw5eh7Pa/UHFYK5lvgcwK
 lEmuD4xPzgKpRAc38OZHP4SghkgJsNMbquVhvNmC33bEnfy56446Kq0t0YPqMYxLG3jEBfn
 f5vaObEJXkY3BBY3W46Uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VX7rxyNe+N8=:yt3BtXJeWS0hxAK3KVvDDn
 UPe/Kz1I+/nvOgcpkUMfekP902uhp4HiCwPdlq60EJ1cduSYat9Ao9zsvnGKds/9rbSNypSdk
 ZmQ9w9177j7lNmVpbkZ5yXNvjND/O/rzttBCIKJ8+Wt2lYHBH15ZUBr8ViIHAJoJuADR6rlP8
 nT2OpjOMA4LhUZCHYLJxJqbnoBWj5dSxtkQRbkpaw9v13qS7uEtuTXD+rARW+Z1vcmBA1sJz5
 pjYq4bCX1y3VJ9DuGWj9TiZ1KC1bc6dM5Ob/OkGEHAxrQLwZfQ+tAQJ0fTckXBTsk70mmkw5C
 nNgmGvtws9rF+qCSA8l+fFh3/1F9mj8nWAsd5KLUbOOerwULclYyKG3fGkyZ3vd8COPDjhGB4
 wpT/cF4tuvRrNNsEEyaBC5YsSAjeQMAME0rIxR0Hf6E8wn3hV+oCJ7pnLR1GcyL1LloI1qyem
 O/9MQwa/k4KM7Mhbjc3tumiRtiRK3OEbuJVaF6c6bWkcHL8aVtCiT3xDL/wuQUJOmB2iDcZdk
 ol2NfG4NvBahxOBkjo4fdpx4h4pq3J0c+fe8HYbgwMEhqUVKIkl7EVjDNv3vcgIhF30PNH5t/
 pFzWeLAjVqlq/96ayfdVAPxnXkx55fek2uVbGkJ/TZuwxuTo53EA3ififV/6ZEIoRMSBIVBfe
 ULVivy+931BZu0654lUH3R923M9LLeVYYTFXPmYRC5qgjTmmLneFPnqvFKqPwRTZ2Xz44uv0g
 qEXTpLtLCT8Dad7tr8CU8zJAPbnASkWipPKwV/+kmWyzWdPt6JODSb7cf9NYSiCVJmxdP7BzA
 EAJW/G6Je4pc9GxUkj4AqYYeJCXBZHjEshylrj0GIawIVpg9gabfZk7Q9uIxqVnAogdrxc9CL
 kNUIJHj9LICRtlr0UKxASiQJ8Moj9u6EL41TLylQMUcNzkRxWbFYDsv3dmRuW6/cSm3LYRK0f
 xgMlP+bSnFWI36UjcYYWZJMTT6OyeKrfDWzBgilECEQxZTE4ooNiF/BC+eBCS8DdQBpjbHYq4
 VXwY20J2RtvLxwFprG7IyVmWq+8XODbGE1IXCUDOfQvbDejc7lv4xVjB7+feFypCWVLyXussb
 whrImqG5vJ+BsRPbwZEqRTRScKEPvGQiyab2PAYzQpRG0r5jRr7COm4oQW64m64FvV7e6dvIG
 7hnQwqrIoAHwXnjvgrOdhKMZBMg1V7AprNAgahyDs3XCOEPDB8N7VmYh/R7C2Sr5Cj0zMFj6l
 8uuapYuQCEZAWP7g3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-586209795-1580381530=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Luke,

On Wed, 29 Jan 2020, Luke Diamand wrote:

> git-p4 handles most errors by calling die(). This can leave child
> processes still running, orphaned.
>
>     https://public-inbox.org/git/20190227094926.GE19739@szeder.dev/
>
> This is not a problem for humans, but for CI, it is.

Just to make sure that we're talking about the same thing. Looking at

https://dev.azure.com/git/git/_test/analytics?definitionId=3D11&contextTyp=
e=3Dbuild

I am not even sure that `git-p4` is our biggest problem there. In that
list, the only flaky `git-p4` test I see is t9806.5. And it failed only
once recently:
https://dev.azure.com/git/git/_build/results?buildId=3D1640&view=3Dms.vss-=
test-web.build-test-results-tab

The log looks like this:

=2D- snip --
[...]
expecting success of 9806.5 'sync when no master branch prints a nice erro=
r':
	test_when_finished cleanup_git &&
	git p4 clone --branch=3Drefs/remotes/p4/sb --dest=3D"$git" //depot@2 &&
	(
		cd "$git" &&
		test_must_fail git p4 sync 2>err &&
		grep "Error: no branch refs/remotes/p4/master" err
	)

+ test_when_finished cleanup_git
+ test 0 =3D 0
+ test_cleanup=3D{ cleanup_git
		} && (exit "$eval_ret"); eval_ret=3D$?; :
+ git p4 clone --branch=3Drefs/remotes/p4/sb --dest=3D/home/vsts/work/1/s/=
t/trash directory.t9806-git-p4-options/git //depot@2
Initialized empty Git repository in /home/vsts/work/1/s/t/trash
directory.t9806-git-p4-options/git/.git/
Perforce db files in '.' will be created if missing...
Perforce db files in '.' will be created if missing...
Perforce db files in '.' will be created if missing...
Perforce db files in '.' will be created if missing...
Perforce db files in '.' will be created if missing...
Importing from //depot@2 into /home/vsts/work/1/s/t/trash directory.t9806-=
git-p4-options/git
Doing initial import of //depot/ from revision @2 into refs/remotes/p4/sb
+ cd /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
+ test_must_fail git p4 sync
+ _test_ok=3D
+ git p4 sync
Performing incremental import into refs/remotes/p4/master git branch
Depot paths: //depot/
+ exit_code=3D1
+ test 1 -eq 0
+ test_match_signal 13 1
+ test 1 =3D 141
+ test 1 =3D 269
+ return 1
+ test 1 -gt 129
+ test 1 -eq 127
+ test 1 -eq 126
+ return 0
+ grep Error: no branch refs/remotes/p4/master err
Error: no branch refs/remotes/p4/master; perhaps specify one with --branch=
.
+ cleanup_git
+ retry_until_success rm -r /home/vsts/work/1/s/t/trash directory.t9806-gi=
t-p4-options/git
+ nr_tries_left=3D60
+ rm -r /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
+ test_path_is_missing /home/vsts/work/1/s/t/trash directory.t9806-git-p4-=
options/git
+ test -e /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
+ echo Path exists:
Path exists:
+ ls -ld /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
drwxr-xr-x 3 vsts docker 4096 Jan 24 22:20 /home/vsts/work/1/s/t/trash dir=
ectory.t9806-git-p4-options/git
+ test 1 -ge 1
+ echo /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git /hom=
e/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
+ false
+ eval_ret=3D1
+ :
=2D- snap --

FWIW I see the same test being flaky in Git for Windows (but it _also_
only happened once in the past 14 days):
https://dev.azure.com/git-for-windows/git/_test/analytics?definitionId=3D1=
7&contextType=3Dbuild
and
https://dev.azure.com/git-for-windows/git/_build/results?buildId=3D49174&v=
iew=3Dms.vss-test-web.build-test-results-tab

The log suggests to me that there is a path that has not been cleaned up,
and _maybe_ it is timing-related, but it is also possible that a child
process is still running that should have cleaned it up.

Are your patches about this failure?

I see that PATCH 5/6 talks about G=C3=A1bor's analysis of t9800.6 in
https://public-inbox.org/git/20190227094926.GE19739@szeder.dev/ which
_looks_ similar.

FWIW I looked over your patches and they seem relatively obvious, even for
somebody like me who barely gets to code in Python anymore.

Thanks,
Dscho

>
> This change improves things by raising an exception and cleaning up
> further up the stack, rather than simply calling die().
>
> This is only done in a few places, such that the tests pass with the cha=
nges
> suggested in the link (adding sleep strategically) but there are still
> plenty of places where git-p4 calls die().
>
> This also adds some pylint disables, so that we can start to run pylint
> on git-p4.
>
> Luke Diamand (6):
>   git-p4: make closeStreams() idempotent
>   git-p4: add P4CommandException to report errors talking to Perforce
>   git-p4: disable some pylint warnings, to get pylint output to
>     something manageable
>   git-p4: create helper function importRevisions()
>   git-p4: cleanup better on error exit
>   git-p4: check for access to remote host earlier
>
>  git-p4.py | 180 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 109 insertions(+), 71 deletions(-)
>
> --
> 2.20.1.390.gb5101f9297
>
>

--8323328-586209795-1580381530=:46--
