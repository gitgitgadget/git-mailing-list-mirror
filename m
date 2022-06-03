Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B0C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 10:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiFCKeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 06:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbiFCKeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 06:34:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE33BA74
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 03:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654252437;
        bh=KwdRB5TEMULI94BSFzj9ag6/nDarKmKPVXfANGfGb8k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k7XIFVshX7l9+VeMmI2rg6xbcd+YO6sKSk9GqHQSNS6ceDTms1Ap/Lj1xE+e9JuDa
         d1PQLqOuJQx/NeRjAEYLPfHi2C/7MUphTZB4YugpEiw+iJULx0ASpzqGsPPOqjMLai
         uCUXlHkrcoOLNS6hPPlBxzh6W7mLwxUeyIF+aXbc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw3N-1nWm6I0Xjv-00j5p8; Fri, 03
 Jun 2022 12:33:57 +0200
Date:   Fri, 3 Jun 2022 12:33:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <derrickstolee@github.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: also run the `scalar` tests
In-Reply-To: <3c6d4a5c-8b39-8771-f578-0ea3c5b57869@github.com>
Message-ID: <nycvar.QRO.7.76.6.2206031204470.349@tvgsbejvaqbjf.bet>
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com> <6ad0d3d401da7787d0e7afb3f804b705731bf2dd.1654160735.git.gitgitgadget@gmail.com> <3c6d4a5c-8b39-8771-f578-0ea3c5b57869@github.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dmyy7zqc9jdwn4T01jg9uYbjk/1X4sFKMK6eqPsx4q2RJGpgGyM
 9D++xrRF5nMfAnOa2OVVPAq5v5r8B40uphDz2Wj8skxOH8vJz6Ujt9kmANJWdmcv3j/3QFm
 8yLAXOQWA3Pco6kcL/9SELxL6FMQEWngnFfYoDtVX9pRXD0XWqrHPIYc87NU3PNH0ud0Jxi
 jXpFHYpAvV93LZXvRSn/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:exdq7QrdOAs=:Dr3R7fFeKrJbk34KyQXPKB
 9I+CJuKaBt7oBkvXDcy+IMFsmDREGL49QZvewcIDUTZlJYrZRi2Qux36AS5FHd4jIik6gQdiW
 UIi76FxSiHTnjBCH57n5nmApjUqh9yVQ4m3drrW+nOSB2ujGn2F5ENQ6EK8YYYMiGJBnV3BbW
 L+PFs4ilWDsMXHtkZdN9nixCbx4FWXigc7LSFlAS+wB9L6Ck5SIQAVCPnzDjq5DF4mSrE6/ay
 AoJWXINxE6qitc51NaOOcD1L1ahmVwobdncp1q1ghipaFQIeaNu4HyVO0kLUd07R48yOtjPRQ
 sz8dcygj0UJAcKTDFwDm596YDdJIG9y4FbRQsRGN5i3MKGsQ4NwdPok+ZdbTKLlXi08O9Du+Q
 5ZPpYYZqQAR7h+mnB/t92fmO7TlJ5kNRs1BPLPlLxDisxQEZFmVtbtt4ZSaPNjIBNQ34W9gIW
 UwH3GMIMkQQdX+NjHIGC9tA0zv/tXd7Kk9/vD1D2O1zsre0QubmpzOXy9ZmP4WPwZu/fEzTpr
 XG/QOTM6VNu69gRMV1qfX1Qi0DiA2K2NDcv1qkvYuLHqr4A2ku3FZ0QL4uL1w7TY6aczHyGCX
 CyBNEqT41mK10J4CZKKhO6+hvUmbbIFq6NiN8UULPgrhHe/9d3RW/Y2IL3by+w7KDw+umP8U9
 NMV1u5oG9zuu3sj3l7zqmRAzjNCXjr7tIScsR2/aVFh/+Ygs8su4mBU1bB1ZPx5dEXSU8ttdc
 8ROM7ejno++dNcrRwlX/ll2TAzdPoopVpi8AdgdZLxEqCKRsEl68J2X6hlhfqaLuuDOCvXCfl
 iu1vSMG0Yggbyx5FoyfMwdeHjxS1eYBKThfKbI/ID4zZFvmdEO0IAMpSN2U1vt3qezNc7LCjr
 77Y4MSiZW/w2DUH/awiXxsTu9/Fgol7kJZGwUlGAM7rHZDveaY6MIyqc8l9yY8/jklVYn1tAp
 63T2QXQ77lbR9VK4pQmQ7uKcMIZq0j/qCiRylsBY0uqjShbMZoaPTHbFFYzu2OLR/ZW7vbvwx
 d4gJJ8UAqNSOqEUymzhfSSVH9EmX7HRkrHVHNLfVqMtsyDVzaqmq+YMhFo12QsvcLReZ+Uhi5
 Mc472eopcigaSrIjawSkzw7i90tQtne5NVx7P7IqrOHoj9T3OIhKj0+yA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, 2 Jun 2022, Derrick Stolee wrote:

> On 6/2/2022 5:05 AM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Since Scalar depends on `libgit.a`, it makes sense to ensure in the CI
> > and the PR builds that it does not get broken in case of industrious
> > refactorings of the core Git code (speaking from experience here).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  .github/workflows/main.yml | 15 +++++++++++++++
> >  ci/run-build-and-tests.sh  |  2 ++
> >  ci/run-test-slice.sh       |  5 +++++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index c35200defb9..785222aa7b3 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -91,6 +91,13 @@ jobs:
> >          HOME: ${{runner.workspace}}
> >          NO_PERL: 1
> >        run: . /etc/profile && ci/make-test-artifacts.sh artifacts
> > +    - name: build Scalar
> > +      shell: bash
> > +      run: |
> > +        make -C contrib/scalar &&
> > +        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
> > +        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
> > +        cp bin-wrappers/scalar artifacts/bin-wrappers/
>
> I see later you have a "copy Scalar" step which has some duplication
> here. The only difference is that you have "make -C contrib/scalar".
>
> Doesn't Scalar get built in our basic "make" build when the
> environment includes INCLUDE_SCALAR=3DYesPlease? So, for that reason I
> expected the environment to change, but not need this "make -C ..."

I originally did it that way, but somewhere along the refactoring, I
removed that `INCLUDE_SCALAR` conditional (except in the CMake
definition).

Hmm.

Now that you mention it, I guess it would be a good idea to reinstate it.
Let me play with that for a bit.

> >      - name: zip up tracked files
> >        run: git archive -o artifacts/tracked.tar.gz HEAD
> >      - name: upload tracked files and build artifacts
> > @@ -161,6 +168,8 @@ jobs:
> >        run: compat\vcbuild\vcpkg_copy_dlls.bat release
> >      - name: generate Visual Studio solution
> >        shell: bash
> > +      env:
> > +        INCLUDE_SCALAR: YesPlease
>
> This is a bit isolated. Is there a way to specify the environment more
> generally?

I did that on purpose, to limit the scope as much as possible.

It would of course be an option to set that environment variable for the
entire `vs-build` job. Or even for the entire workflow.

But I thought there was value in keeping the scope focused, so that
contributors who investigate failing builds could figure out quickly, say,
how to reproduce the issue locally.

>
> >        run: |
> >          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=3D`pwd`=
/compat/vcbuild/vcpkg/installed/x64-windows \
> >          -DNO_GETTEXT=3DYesPlease -DPERL_TESTS=3DOFF -DPYTHON_TESTS=3D=
OFF -DCURL_NO_CURL_CMAKE=3DON
> > @@ -174,6 +183,12 @@ jobs:
> >        run: |
> >          mkdir -p artifacts &&
> >          eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=3DYes=
Please ARTIFACTS_DIRECTORY=3Dartifacts NO_GETTEXT=3DYesPlease 2>&1 | grep =
^tar)"
> > +    - name: copy Scalar
> > +      shell: bash
> > +      run: |
> > +        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
> > +        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
> > +        cp bin-wrappers/scalar artifacts/bin-wrappers/
> >      - name: zip up tracked files
> >        run: git archive -o artifacts/tracked.tar.gz HEAD
> >      - name: upload tracked files and build artifacts
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index 280dda7d285..661edb85d1b 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -51,4 +51,6 @@ esac
> >  make $MAKE_TARGETS
> >  check_unignored_build_artifacts
> >
> > +make -C contrib/scalar $MAKE_TARGETS
> > +
>
> Again, this should "just work" when using INCLUDE_SCALAR in the
> environment, right?
>
> >  save_good_tree
> > diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
> > index f8c2c3106a2..b741fd8f361 100755
> > --- a/ci/run-test-slice.sh
> > +++ b/ci/run-test-slice.sh
> > @@ -14,4 +14,9 @@ make --quiet -C t T=3D"$(cd t &&
> >  	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
> >  	tr '\n' ' ')"
> >
> > +if test 0 =3D "$1"
> > +then
> > +	make -C contrib/scalar test
> > +fi
> > +
>
> This is still necessary for now.

Thank you for your review! I will play around with the idea to modify the
top-level `Makefile` so that a `make INCLUDE_SCALAR=3DYepOfCourse` would
automatically include Scalar. I am just concerned that this would already
open the discussion about taking Scalar out of `contrib/`, and I do want
to discourage this discussion before the remaining upstreamable patches
from https://github.com/microsoft/git/pull/479/commits made it into Git's
main branch (except of course the patch to move Scalar out of `contrib`,
https://github.com/microsoft/git/pull/479/commits/0e7b7653b29a).

Thanks,
Dscho
