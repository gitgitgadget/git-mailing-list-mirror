Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE40C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 20:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiFRUTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFRUTo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 16:19:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62137BE0C
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655583573;
        bh=KJQnAOBJ5aKGMdc7Gb2UYiuA16TNjIOjf9S+8pj1Msw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MaFbxc5jQLey9jsEX8M8DHZPMRrNw3Mg3FuwnhThZdS4a8Ls/wZuR+UC5qc0HVx3P
         6o6WTSHYgEU/n2OcJy+OPvQX1AEPtNTCI+Dm11WaGERKEr05B48DyJ4KMq89wztHVO
         vmmBnhj2oWY8IfGSvnzk6ZrPWZnRrYqc/PwXMhEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.234] ([89.1.215.185]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw7f-1nKUHH3Op1-00j0X5; Sat, 18
 Jun 2022 22:19:32 +0200
Date:   Sat, 18 Jun 2022 22:19:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v6+ 2/7] archive --add-virtual-file: allow paths containing
 colons
In-Reply-To: <20220615213656.zp36wdwbcz7yevac@lucy.dinwoodie.org>
Message-ID: <nycvar.QRO.7.76.6.2206182213290.349@tvgsbejvaqbjf.bet>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com> <20220528231118.3504387-1-gitster@pobox.com> <20220528231118.3504387-3-gitster@pobox.com> <20220615181641.vltm3qtbsckp5s56@lucy.dinwoodie.org> <xmqqpmj9zohk.fsf@gitster.g>
 <20220615213656.zp36wdwbcz7yevac@lucy.dinwoodie.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-27214116-1655583572=:349"
X-Provags-ID: V03:K1:ciW30uc6a5mT02RS8mN1vVWpbuwqZZo7VwJQzaxMA7uCnUiyV8i
 M89eN5ph0x0P8iNJE/UsMjBmGkqnceeyUQVhaNesN/QaxW6V7z0aZl4mCBooP5TTwf5+QCb
 dF/3sb/XxLEVSuXDJiRX38i5jbjjBsbHyY/SfZ5uHVWqW3IDBoiNmAaLzCY0gER02yI+hbO
 IHR5OwgvPubuqpskrilhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zuOUi623bwM=:tBTDmSl1ZWOVbE385UGPmX
 IZrIjTSrOtk/l94hxtrrr0LElWoPG50p9wX9tKTamXJi1lfv7esLU+NXiGkMrTSPHif8A367c
 SulzMAoCTQhfl3aGirWme2DKmE7PJ2918R+3Y/BbGtv2JuMGT3axV3jy6uu+PVuUq7wcjdfky
 E1Nr9j/f0nbr6kkjtwBJpEEXoFCEpIfJG9TL6WtkYG3OePW3nEpkMcNx5mVl/3okfkB+qbBdT
 Y9ZlzwyHOkmwmJ3HIJlb9NzJAdK2Vdnc+R5A7cCmLceUGcFlKAOjozCoz7MMJTZNaL+i4qfWP
 yWF+U5rBq0leWzis35rjWgABKPeQN8+xWmLUfLHBi1cRxcN3MB6M7tEapy5kHA1nklHdVDGe3
 54XRF6+DyM9k1yk2NtcS0JfyBmJjKP1xUJfYO+FRvQK0qiFwpCKm7gJwCIqfg8faGYd0foCaP
 MYN+mOR8BOQWANtwLtzODE0fwmjRHVHJY31mclP58d26nQalqHets3I6va0HZrTJ5z5vKJK9d
 QMN6vBDKe2S/ZROBxj0i+gEdUUQbdh70z1TXCTtoCKSAZDKfWwXsgKnWa4xjMcEOSBco/gHAa
 BrUQwCe0teLOLblytR/noCGVKfZbGFD15GNLrfskE1hTOFCTnBK7VgQinpnj4VoRRHGSI2upz
 23sPAPX4jrrWr7HT/ntBhQ0dqf7SafhT54V0kClra2CBTvpGv6iA91k1vryaQy0pT7tT+IyiS
 1wHVZClvlPRSd8msVE9DQJ8FSMQS3skVv7EouuWfeEke5y/Gq4oFyAutr62iOCmLGFCdH4RHf
 KOfTmAqtGjAwXSOXW75qrhoXA6chA4XtNPqGmq7/15ZrftVdV8ztA8aeZTuNVSvtYSWl1x1yj
 eIMLzJPKSbUoUQZ3CrnNad2bEt8YBrMxfaCdkkF1hTRIxp495g6sxm3O/AQINVH+iS1HlqM4L
 65EZ1FWYvzcrZVydYJ3oG6hZZDUpNqumBnqoae3XzwempKrLqvpa0pZ2COGriAbDrW76WyJCr
 e/+0XLDxAJFEx89ZNbwUhaPt+hhO86+rBLrJ9imtEe90iFUt1V1scrs4ssCISBfiIOO187fhi
 EPN/hdct2EqPMEfpSTD8sLlVN5PHb3VOgZu+7Xo8svqmXwhnVOpmK//Ug==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-27214116-1655583572=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Wed, 15 Jun 2022, Adam Dinwoodie wrote:

> On Wed, Jun 15, 2022 at 01:00:07PM -0700, Junio C Hamano wrote:
> > Adam Dinwoodie <adam@dinwoodie.org> writes:
> >
> > >> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> > >> index d6027189e2..3992d08158 100755
> > >> --- a/t/t5003-archive-zip.sh
> > >> +++ b/t/t5003-archive-zip.sh
> > >> @@ -207,13 +207,21 @@ check_zip with_untracked
> > >>  check_added with_untracked untracked untracked
> > >>
> > >>  test_expect_success UNZIP 'git archive --format=3Dzip --add-virtua=
l-file' '
> > >> +	if test_have_prereq FUNNYNAMES
> > >> +	then
> > >> +		PATHNAME=3D"pathname with : colon"
> > >> +	else
> > >> +		PATHNAME=3D"pathname without colon"
> > >> +	fi &&
> > >>  	git archive --format=3Dzip >with_file_with_content.zip \
> > >> +		--add-virtual-file=3D\""$PATHNAME"\": \
> > >>  		--add-virtual-file=3Dhello:world $EMPTY_TREE &&
> > >>  	test_when_finished "rm -rf tmp-unpack" &&
> > >>  	mkdir tmp-unpack && (
> > >>  		cd tmp-unpack &&
> > >>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
> > >>  		test_path_is_file hello &&
> > >> +		test_path_is_file "$PATHNAME" &&
> > >>  		test world =3D $(cat hello)
> > >>  	)
> > >>  '
> > >
> > > This test is currently failing on Cygwin: it looks like it's exposin=
g a
> > > bug in Cygwin that means files with colons in their name aren't
> > > correctly extracted from zip archives.  I'm going to report that to =
the
> > > Cygwin mailing list, but I wanted to note it for the record here, to=
o.
> >
> > Does this mean that our code to set FUNNYNAMES prerequiste is
> > slightly broken?  IOW, should we check with a path with a colon in
> > it, as well as whatever we use currently for FUNNYNAMES?
> >
> > Something like the attached patch?
> >
> > Or does Cygwin otherwise work perfectly well with a path with a
> > colon in it, but only $GIT_UNZIP command has problem with it?  If
> > that is the case, then please disregard the attached.
>
> The latter: Cygwin works perfectly with paths containing colons, except
> that Cygwin's `unzip` is seemingly buggy and doesn't work.  The file
> systems Cygwin runs on don't support colons in paths, but Cygwin hides
> that problem by rewriting ASCII colons to some high Unicode code point
> on the filesystem,

Let me throw in a bit more detail: The forbidden characters are mapped
into the Unicode page U+f0XX, which is supposed to be used "for private
purposes". Even more detail can be found here:
https://github.com/cygwin/cygwin/blob/cygwin-3_3_5-release/winsup/cygwin/s=
trfuncs.cc#L19-L23

> meaning Cygwin-native applications see a regular colon, while
> Windows-native applications see an unusual but perfectly valid Unicode
> character.

Now, I have two questions:

- Why does `unzip` not use Cygwin's regular functions (which should all be
  aware of that U+f0XX <-> U+00XX mapping)?

- Even more importantly: would the test case pass if we simply used
  another forbidden character, such as `?` or `*`?

> I tested the same patch to FUNNYNAMES myself before reporting, and the
> test fails exactly the same way.  If we wanted to catch this, I think
> we'd need a test that explicitly attempted to unzip an archive
> containing a path with a colon.
>
> (The code to set FUNNYNAMES *is* slightly broken, per the discussions
> around 6d340dfaef ("t9902: split test to run on appropriate systems",
> 2022-04-08), and my to-do list still features tidying up and
> resubmitting the patch =C3=86var wrote in that discussion thread.  But i=
t
> wouldn't help here because this issue is specific to Cygwin's `unzip`,
> rather than a general limitation of running on Cygwin.)

I'd rather avoid changing FUNNYNAMES at this stage, if we can help it.

Thanks,
Dscho

--8323328-27214116-1655583572=:349--
