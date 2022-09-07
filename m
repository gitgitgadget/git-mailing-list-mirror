Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FF5C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 12:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIGM7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 08:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIGM7S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 08:59:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CACA79687
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662555548;
        bh=l7kXllCB5cpjqgZWHYF7d9F7jroQtakmwfjCIjhASeM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JUTCzBAs6ZGpgQkLuJgDldlperQ9btnkhqi21NkHAk9cMIPLDSyN9x3zajPEtbWo0
         CODjoVrPxcURhPJXv8SOSMhYPyp5/Kf74vTdmZJlFJPZrW0GgjYIWEDeDbG9xpv4rw
         C6/mUSbrbWTeSWhtZaBm2UXkT0tqLsQAqCDJk1eQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1pUeVl2dQL-013QGl; Wed, 07
 Sep 2022 14:59:08 +0200
Date:   Wed, 7 Sep 2022 14:59:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Lana Deere <lana.deere@gmail.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
In-Reply-To: <CA+4x=b_KP4rMH-EDmVCD_4LHPiLx32J2OJC6Mm5xpQ-QUcSKuA@mail.gmail.com>
Message-ID: <s46p34qn-rq84-20q6-nr36-594sos6q5qq9@tzk.qr>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com> <YxJkn7K3zRm1u3Vn@tapette.crustytoothpaste.net> <CA+4x=b_KP4rMH-EDmVCD_4LHPiLx32J2OJC6Mm5xpQ-QUcSKuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:slzoxPjBEqqP1DoKIMo50NkvNyMrIeG+ocp5TC0+zeVh7Nv9YSN
 AK1ajYwhF4JKUn3OHhMfThtS0HeOA+OfuRXH6ti+pbPkOYExLfgQKTVkDc/JifmbdpJ43jz
 c2afYTFQMpl1CzDqyQnfCWUx8Awch1pegBMuophgxaYKSaLp7vT81BV8g2/zTyW9/mmGxS1
 Dx3uhk9hpX/IUZf6SFzDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t7l7NXxJu7M=:OuRrAeSzJldiYnEMEqwI0Y
 r0d+lQmlzQ231rIYLAEysIzumlYBfH5MCzUiKXckr2BXSJG4vXL9remwVV1hjm6OykDIHPeHW
 S4J9ZvOGNH8IZZm6OUMpy2/Q+Q4bel3wSM2TipGL/NyqrUwGokq4se9MN0RMP8AVj9RdRB7eJ
 R9E4uZpvsMMhPUvh1lgQttS3CLM+fsZvN0otfJhpXdJNo4ERS1txJ2AdLnEijSQHoL3yxyxUl
 G6u0WVCbImGT1FP3ZfQcX0PUlE4oCHwtJxUUcNO9GWuH453RYVlspe4U42RdCdUrPwShE3uoC
 so3FDj5myC18pT1sOaaFxFcmPLCzMVq2ix4nlzdXIsVpbETawD0gSvYKJ5ZhGvFCqVN+z0/zT
 1MRn6YKGTZiMJq3PaAaVCWVUo7PgpHGRqUwsVOaDzBm5XMOCpNHxqZDfLSA8h9ovu2VjOfWDa
 dULwVLWUzjJCPtuQC0Au726ic+8c9ZZgWxeD+c00fWngwlqOKK05R1T+wlayp5e1SpE6jxia/
 xqWHLnqxJyrpxRsNlJoZqmJYAQzztkPCKbDIh7Im3DEOK3JqlF5yfkxVt910g0L9ROg4e3WOx
 7tLtuOvosd/b63T1JCNz39qYT8uubyIQ539Ss2SLJpdo2ZfpNn9oD9LB5dU2vqN7SrthVd0cc
 YmH/jS7157KCJXoQnOzAZUCbIFQIbtX71HRffBf/25PmbJIRUROjGVYXHD+3mFn8wU2G9STHP
 CmkkCbHpKYaFiuSPFgS4fIuGFTSKM8I3QBpB+eoPC0S7NQqtfhLEU2/6mog1ExyJggaPbhuBl
 tXu56sWkeHRfCmwOJR2dPr/IKriR0akadx9djk+M47umA7dEAC/Ma7A4jJ3ln7bfGbBDmI02/
 n3nAWtqVsH34jbooO5WkSoxD7+/rBy0lcVTjVkJthhY5nO6/fKXpq4aSbGW9Dj9PJ08OgnTxb
 2l1vJkwfiB08USVkq5wRKbDEOfaGN3oramTlS76NvXdZvxlzm58HSTdeMNAxQ9Qht6ADP2Fh6
 z4zYbN9glcw1Ko6PfXe3GbPb41zuCepI5SiamT4FShcmcxdXqA1LmYJhhZ0a7cAC1BdYCr0gK
 d1WVNXpwKF5TuU+NVNUzVJ7QJwtF9mkC1Y13u9YiEIQdMzY5XCx+XoDw+7DmH2zG375NVqYFx
 BizodZXD+c3Q/I1s3ngeKbBb9N
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lana,

as per usual, replies inline.

On Tue, 6 Sep 2022, Lana Deere wrote:

> The 'git ls-remote origin' command on both produces about 3600 lines
> of output which appears to consist of all the branches in our repo.
> The two outputs are identical according to diff.  Both include a
> single mention of the switch-to-qt5 branch,
>
> $ diff /tmp/ls-remote*
> [no output here]
> $ grep switch-to-qt5 /tmp/ls-remote.*
> /tmp/ls-remote.2.18:6a9363081d05c313ba6a6ac59183193f1340bb1f
> refs/heads/feature/switch-to-qt5
> /tmp/ls-remote.2.37:6a9363081d05c313ba6a6ac59183193f1340bb1f
> refs/heads/feature/switch-to-qt5
>
> The 'git config -l' from both versions is almost the same - two lines
> have moved around.
> $ diff /tmp/config*
> 1,2d0
> < filter.lfs.required=3Dtrue
> < filter.lfs.clean=3Dgit-lfs clean -- %f
> 4a3,4
> > filter.lfs.required=3Dtrue
> > filter.lfs.clean=3Dgit-lfs clean -- %f
>
> $ cat /tmp/config.2.37
> filter.lfs.smudge=3Dgit-lfs smudge -- %f
> filter.lfs.process=3Dgit-lfs filter-process
> filter.lfs.required=3Dtrue
> filter.lfs.clean=3Dgit-lfs clean -- %f
> user.name=3DLana Deere
> user.email=3Dlana.deere@gmail.com
> filter.lfs.clean=3Dgit-lfs clean -- %f
> filter.lfs.smudge=3Dgit-lfs smudge -- %f
> filter.lfs.process=3Dgit-lfs filter-process
> filter.lfs.required=3Dtrue
> color.branch=3Dfalse
> color.diff=3Dfalse
> color.grep=3Dfalse
> color.interactive=3Dfalse
> color.pager=3Dfalse
> color.showbranch=3Dfalse
> color.status=3Dfalse
> color.ui=3Dfalse
> core.repositoryformatversion=3D0
> core.filemode=3Dtrue
> core.bare=3Dfalse
> core.logallrefupdates=3Dtrue
> remote.origin.url=3Dhttp://lana@githost:7990/scm/dp/sw.git
> remote.origin.fetch=3D+refs/heads/master:refs/remotes/origin/master

At first I thought that this would be the root cause:
`feature/switch-to-qt5` is not included in the refs to fetch.

But then I added a test case for that specific scenario:

=2D- snip --
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 081808009b2..6e6ddeb7e63 100755
=2D-- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -218,6 +218,17 @@ test_expect_success 'fail if upstream branch does not=
 exist' '
 	test_cmp expect file
 '

+test_expect_success 'fetch upstream branch even if refspec excludes it' '
+	git branch tirili &&
+	git branch tirili2 &&
+	git init -b tirili downstream &&
+	git -C downstream remote add -t tirili origin "file://$(pwd)/.git" &&
+	git -C downstream config branch.tirili.remote origin &&
+	git -C downstream config branch.tirili.merge refs/heads/tirili2 &&
+	git -C downstream pull 2>err &&
+	! grep "configuration specifies to merge" err
+'
+
 test_expect_success 'fail if the index has unresolved entries' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&

=2D- snap --

And that test case passes!

The reason is that we specifically add the ref that needs to be merged to
the list of refs to be fetched:
https://github.com/git/git/blob/v2.37.2/builtin/fetch.c#L605-L614

Now, clearly it is not quite working as intended in your scenario. The
message you pasted is produced by the code in
https://github.com/git/git/blob/v2.37.2/builtin/pull.c#L421-L494, which is
only entered if there are no entries in `.git/FETCH_HEAD` except
`not-for-merge` ones.

Lana, would you mind pasting the contents of `.git/FETCH_HEAD` just after
a failed `git pull`?

Ciao,
Johannes

> branch.master.remote=3Dorigin
> branch.master.merge=3Drefs/heads/master
> branch.feature/switch-to-qt5.remote=3Dorigin
> branch.feature/switch-to-qt5.merge=3Drefs/heads/feature/switch-to-qt5
>
>
> .. Lana (lana.deere@gmail.com)
>
> On Fri, Sep 2, 2022 at 4:16 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2022-09-02 at 19:27:55, Lana Deere wrote:
> > > I'm testing an upgrade to git 2.37.2 from the current version we're
> > > using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> > > gives me an error but 2.18.0 things all is fine:
> > >
> > > $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> > > Your configuration specifies to merge with the ref
> > > 'refs/heads/feature/switch-to-qt5'
> > > from the remote, but no such ref was fetched.
> > >
> > > $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> > > From http://githost:7990/scm/dp/sw
> > >  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> > > Already up to date.
> > >
> > > Anyone have any ideas about this?  All I could find on google was a
> > > suggestion that the "no such ref" message indicates the remote branc=
h
> > > was deleted, but that's not the case here.
> >
> > Can you provide the output of `git ls-remote origin` (assuming that's
> > the remote you're using) and `git config -l` (the latter with both
> > versions)?  I don't know of any reason why Git 2.37 should be broken i=
n
> > this regard, but I suspect that there's a difference in configuration
> > between the two leading to this.
> > --
> > brian m. carlson (he/him or they/them)
> > Toronto, Ontario, CA
>
