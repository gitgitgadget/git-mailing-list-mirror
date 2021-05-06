Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9162DC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FB461157
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhEFOyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 10:54:21 -0400
Received: from mout.web.de ([212.227.15.14]:56653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234759AbhEFOyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 10:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1620312796;
        bh=ncpJNsMFJRQRHOdXy6JW+kXUQI2WXrZOER1XtPJmESw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PFZD5f66MkzYqNrp5uTJJq5CUR+28Jp++q2egl/52oQAyXkH0kwom8iCF5YyER0m3
         Pbv+60QU0DORX00Yot2i7083Lk4opLyZXMFgUwFNktbu5a0oKW1We/R/GZ0R9/+1vw
         775JCBsHwU0veCLH3ZVXrA8R5RTnHLERjcRuYnq4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKaDH-1leOWh1GWF-001xmS; Thu, 06
 May 2021 16:53:16 +0200
Date:   Thu, 6 May 2021 16:53:15 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Mark Amery <markrobertamery@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
Message-ID: <20210506145315.rrqcndm7esequ4ok@tb-raspi4>
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
 <20210504151954.aczbvml4rh7t2svc@tb-raspi4>
 <xmqqtuni58ra.fsf@gitster.g>
 <20210506043429.zqgzxjrj643avrns@tb-raspi4>
 <CAD8jeghZKDcp=weHtcMZ4z8KaO1jQJqfPqaRtYgtiwrX-1+NNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD8jeghZKDcp=weHtcMZ4z8KaO1jQJqfPqaRtYgtiwrX-1+NNg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:p5vzaPQtFTcPQNIj8RIxHTFdHl05BBQ46Dee1wx3HKnHM+K5e2s
 +Qv30OF22VZVxLy/JJHTPjVwHMpYOFRUr3NzNiJH2GasJTV0fhOottwP/LVVnvYl0yRnLdq
 wZwyP+Of9ZVVmBmeT8Mi13jY5Tvi09gwTCgC5Ha3mgrqE+ePYv8Gx9/vpqFHUospdj08wp3
 4L4vYnkT1lyD8+27NOX3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j5EMt6sDOWY=:NOng3H4PMPd9PFLCm9NU9S
 VdHAW+6uRb3bdzoI3Xdskr+dY2P3jGFB5P0yjQH1xIbcMC3pAkG/QuHCe/+3djufk8oGE5A8V
 UeqM40Kxt0ncF0KWdvaOXBRYEVdbxdy57xXSHN1xumcxOVIUHQBFoGwE1u12LCwV+amtxKoXD
 QK4iq+ZeMGOEe5k4lupaY+w3jJ4dM4Fg+DAwFs04N2n8rl7+NBFfJ5gl3Bpor1uCqrRYGlzZL
 ZK2CbRSoftrY3S64YEkQfiW0hTVFVXnaPlLRYhnvcflUw6YsF9cHPw9REXqRzbm+E1KfqObAp
 hJhamSqHT/GXyMlDHgOpO1PThchomBUTLHKReSCDi0OYxM1EeKKm5yl3zJbu3WBjD81APvv8I
 lsf7aV6dlIwc8E76+ZW6Dl7AMhxpfJsLBSLmRepD33Vya/ZOiAQgFDohqg7XE/8hZR340xX2n
 U2YVnLv2VgAIOdFfiSeLeOkfMQv9jXluSbhQFSnccDT7Gm1TuI5RRDf+XA7CPK9R75XEk8jWi
 dZVbGNKMT7XRUguPA3znho0Z0702eYu4qCLM9lxTFSDQ+tJaCKaUylXsl8GKTFrDLhI9VeP2p
 BVuGCvvQ/sf41dDBlt0Ainq480z8zB2MJWgxRqnQRVYh9Maj4JPce/a2GISpd6aSVFVEAkvih
 mJxCDMISqi1FdVeO8MgOgbKtVKiuSG05/gIwxbMZ6AXs2GKEEGSM9zRjMURm+HeDYoMFBqprE
 un9FPitS1c9joVznZCR481r0n31L5wFzGmyabYoMoDbJOx9qOinZJnQ18C+AFxkK0DS/gKi0L
 dpu1zrYVZ3HjhNr7iPCsXDOSDVQ/FfhkxU+fWtI4ZIOU3tIKcYmtZmTGL1hgkOjytMqpc6nNV
 TWa9F89SyU68uy/U7EVJUsvbYytBeOPkZQrT63y2lkzPt0/133juOWNrAf9iGh5KsszxsNpMU
 gj7y8hiqsAy1wk9gVItnwrrWxH+2sSY7jfJesXoxeN2NkJj/7ds9O5PYYUVIfbtE4RaOf+/aP
 FaMc6qef+dgBTcpWZ0qYgVlOfP/uzZV6GXKWjjh4792EZrGI7mn+Su26wzTTm7CVzjS5ul7qA
 QTuPEvQYUfd0/TUnOI+Iam4BwLFF2YHY9AYLcb3wwWQWHc1ZcCbZYzEifBNuFGDXfq80olGGX
 vQwDZG3+jPdPmZKX+zWBhRQp6ZFgRYkbURvrccuSCRVGpMSvoew9yBnS6/INSQmLZK/Fk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 10:12:40AM +0100, Mark Amery wrote:
> So, I'm just a dumb Git user who doesn't even write C, so much of this
> discussion is over my head, but I have a few thoughts that may be
> helpful:
>
> =E2=80=A2 The mv utility on Mac is capable of doing `mv b=C3=A4r.txt b=
=C3=84r.txt` just
> fine. Maybe `git mv` can learn something from whatever `mv` does?

Yes, Git can do the same.
The thing is, that Git avoids to overwrite of existing files.
Just to be nice.
In that sense, if the destination exists, Git refuses the mv,
unless you use git mv -f
Having said that,
git mv b=C3=A4r.txt b=C3=84r.txt will not work (without the -f)

git mv bear.txt BEAR.txt does work,

>
> =E2=80=A2 On a case-insensitive file system, `git mv somedir sOMEdir` is=
 a
> rename. But on a case-sensitive file system, it might NOT be a rename;
> it might be the case that `somedir` and `sOMEdir` both exist and that
> the command should put `somedir` inside `sOMEdir`. I mention this
> because I can imagine some naive attempts at fixing the original bug
> by doing a case-insensitive comparison of the two names ending up
> breaking this behaviour on case-sensitive file systems by wrongly
> treating such a command as a rename. It's probably worth having a test
> that this scenario gets handled cleanly on case-sensitive file
> systems? (I haven't checked whether Torsten's proposed diff falls into
> this trap or not.)

Tests are needed - I should have started with those.
But I didn't intend to send a patch (yet), just sharing
ideas and knowledge. Which may enable someone to write a patch.

>
> =E2=80=A2 Above, Torsten mentions that there are filesystem-specific rul=
es
> about what names are equal to each other that Git can't easily handle,
> because they go beyond just ASCII case changes. In that case, maybe
> the right solution is to always defer the question to the filesystem
> rather than Git trying to figure out the answer "in its head"?

There are different trade-offs:
So far I am only aware of people asking for the
git mv bear.txt BEAR.txt rename.
Just because they are all SW developers ? I don't know.
And just because SW developers are developping Git,
the case-insensitive string compare is good enough,
it is working for them/us.
So things are as they are.

>
>   That is: first check the inode or file ID of the src and dst passed
> to `git mv`. If they are different and the second one is a folder,
> move src inside the existing folder. If either they are the same or
> the second one is not a folder, then do a rename.

Yes. In short: patches are welcome.
In long: inodes don't work on Windows (without a major effort)

>
>   It seems to me that this approach automatically handles stuff like
> `git mv b=C3=A4r.txt b=C3=84r.txt` plus any other rules about names bein=
g equal
> (like two different sequences of code points that both express "=C3=A0")=
,
> all without Git ever needing to explicitly check whether two names are
> case-insensitively equal. Am I missing something?

That could be a solution. There may are situations/configurations,
where inodes don't work:
What happens if a Windows server exports a file system to MacOs ?
To Linux ?
Do we have working inodes ?
What about other networking combinations ?
Our code should handle them well as well.

>
> Sorry if any of the above is dumb or if I'm reiterating things others
> have already said without realising it.

No problem. Actually I realized that we used top-posting here,
So I remove the reset to make it more readable.

[]
