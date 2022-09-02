Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1BDC54EE9
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 09:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiIBJH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiIBJHX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 05:07:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57A3A1A65
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662109634;
        bh=pzjteLSyd4ME+gTu9ppgIdqLtUYf0mYnaC7E3/g64M4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iF+H7HdilflNGJCVmzQTmmYzYXevuuOZYb0ThLngtKxQF4WciOQ6bVv0hXQqGQe4E
         jWv9GNu915g1FarNQN4GrRtG682dpbtutuSG9afHlyaqDSnf9YtnNh1tEGdpbPAHjj
         vBuoJtq81yjgG/+QD45Ozet7mHiXR32OBCIOfiF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1pGnRo2d18-00vxBF; Fri, 02
 Sep 2022 11:07:14 +0200
Date:   Fri, 2 Sep 2022 11:07:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye <vdye@github.com>
cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH 5/8] scalar-clone: add test coverage
In-Reply-To: <23e8901f-b543-dbb5-c7e1-fa653fdf3d57@github.com>
Message-ID: <9n46p076-q126-o813-8s39-936s6667o7o1@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <a3b7cb0a3bd1f56172db8420b9e80a26be1fda5d.1661961746.git.gitgitgadget@gmail.com> <o429p430-sp18-rr20-p2ro-4r60qs2n83o5@tzk.qr> <23e8901f-b543-dbb5-c7e1-fa653fdf3d57@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/aKTxR+3eacDwLslFB56b9X3xIRqUmnR+5T//gmW9TRjeuQtcPq
 tAtgBR2QXymFGUvb3lHTtcBy1hSHHlpY2OqYp4HkRNJTkKUIQT52FfwZa5si7cUTCT18K9C
 BIRcZmmDIrq2DrpLuJ16spABWF5Mfe5XIft5/IiCPbjY2fBcVuHnDyJhhNL2AOlaWnJgEq7
 PKuoEDnAOWQcJxvxy9dGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aR5GumfFiiY=:RN2W9eFWZKVVZX/dQQpC/H
 J4gIJNStbnbmvVnxjpE3jrXNcnQgzfEccpQkzhuRLSz0KKRD1IO+ueFTH110gRprNT35AeNVd
 Pf+Igils4IwXmdY/Eyv55R35bJ2yVS/gryCWVpMCPdlR0z8f8vgeeJ7H1xS3af8KVwvRyvHah
 OJKZ0a+58xmWz0pfOt94Qgc8BTS9QYN72iv2zal+5oD+n5UV7iN4f28/1QXaZmQNrNHsVGXAu
 TyYtFoOSPXGR2blgrPCg+URP2E3zixmV0bmPKYcqGUgaPSPf08kEV6K2Ll1pZ5145ICPsaQjM
 CP1oXFhLdL32OvdO/brnOzIoCZ5jvD9wgr0C1oH9t/BU95hVhe2goULAZjIFZHhLJmrybUJw6
 AxngTOwhscHHPwsUYTzTd/modNyNxTqa1Bn01LC2jyBlGbISMX1mF+N3Qpgna6P/FgvEbqzgW
 r+JZ9CIAkVo3cP7iUJXQykgDBFoduBn/X6mniNV5RuiI2XeQR8300ASXdkMnIeDgOsJXRJwqW
 JsfZz2ILUBkQkf3fXZxXqJUK7oIJytY7IX+9ISyTqacIRE6bMsKJTo0omA7453KrITLDCKHr/
 hf0NM3AkJyFoS0nEMo83QQVBzRksAbwH3jL6zluuFlBB3usge2wM1n//GL+brunlHJub3tnRa
 Ugi3OB42DM30kr4LMjcul94fB7xG3l2frEK403jGsZtXDxHaw4ekYmjsWZQIWZV0MeY4XghYF
 FWyLUM8oSudMxfZWMWm5We7jPiCs7qB9+ISQ6XvPw9LCDryIagWkjMBJYYBF+EPgNwKQ26QmO
 2J42Mt0+7+veiSkacjN5z0XbD1K515DuBN29Y62RGWWOSKoD6/NEJf2xy8pP+fAnb4cV+2PF1
 eVP7v0A8t2LMBXvmVyJkJHUkDgBnGo1FU2AQoa7q9MDzcQUu7VDKMcdRJ5yz5cbuxTYtwSFOA
 91cekTZayNC1ebhp9/YqHfZGfumpRkNgbWPpQzgHqOVOTxMfATUc4AR4vx45VswSzQcpyg7gr
 DTetnYR5MZ3ceI7h4yNi9rNgJ5qooLZVnpVeYuN400nbT44ymigPOxv2dSvR9oToGlmMkxRzA
 4wj77INL3oltfpVXMJAgwnPdatVTJoW8XfH5ROIU71vKwPlMbNrl/8aZ8Vl3VlHg+YxWgsiUw
 v34N8u0Ukm1fkU0haHe/ymVlQO
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Thu, 1 Sep 2022, Victoria Dye wrote:

> Johannes Schindelin wrote:
>
> > On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
> >
> >> From: Victoria Dye <vdye@github.com>
> >>
> >> Create a new test file ('t9211-scalar-clone.sh') to exercise the opti=
ons and
> >> behavior of the 'scalar clone' command.
> >
> > Great catch!
> >
> > I have one suggestion, given my experience with debugging test failure=
s:
> >
> >> +test_expect_success 'creates content in enlistment root' '
> >> +	test_when_finished cleanup_clone cloned &&
> >> +
> >> +	scalar clone "file://$(pwd)/to-clone" cloned &&
> >
> > This pattern of cloning into `cloned` and removing the directory when =
the
> > test case is done is repeated throughout this test script.
> >
> > In instances where all test cases succeed, that poses no problem.
> >
> > When running the test script with `-i`, also no problem.
> >
> > But when we run into test failures in CI, those directories will be
> > removed before the workflow run can tar them up and upload them for la=
ter
> > inspection.
> >
> > May I suggest an alternative strategy?
> >
> > If we drop all those `test_when_finished cleanup_clone cloned` calls a=
nd
> > instead `scalar clone` into different directories (whose names reflect=
 the
> > test cases' intended purpose), I could imagine having a much easier ti=
me
> > not only diagnosing but also reproducing and fixing test failures in t=
he
> > future.
>
> While I like the simplicity of using 'test_when_finished', I hadn't
> considered the value of having the failed tests' artifacts in the CI
> results. If you think that would be helpful to developers, I'll update
> accordingly (although I'd still clean up the clones whose tests pass to
> avoid archiving more data than we need).

Thank you!

> That being said, even if I update 't9211', my experience with Git's test
> suite is that very few tests preserve test repos this way. Do you expect
> these artifacts to be especially helpful for 'scalar clone' in particula=
r,
> or is this more of a "gently nudge contributors to make this standard
> practice" sort of recommendation?

Thank you for this question, which helps me clarify even to myself what my
intention is.

After considering this, yes, I would like this to be a gentle nudge to
take a tiny step toward improving Git's test suite by recommending a new
standard practice.

Ciao,
Dscho

>
> >
> > When discussing code review practices [*1*], we did not come up with a=
ny
> > standard terminology to describe what I am offering here, and I am uns=
ure
> > how to label this in a catchy way. I want to present this suggestion f=
or
> > you to consider, and I would be delighted if you take it, at the same =
time
> > I will happily let it go should you decide against it.
> >
> > Ciao,
> > Dscho
> >
> > Footnote *1*:
> > https://colabti.org/irclogger/irclogger_log/git-devel?date=3D2022-08-2=
9#l48
>
>
