From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Wed, 15 Feb 2012 00:09:23 +0200
Message-ID: <CAMP44s1mV2cE=R49qYSLd8eZPhCpRx0hRnnG_-K3iBxp_YQEpQ@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<CAMP44s3YRHgMPX2Hzydm_TLB27OABWETjABMcwrHmDk-=pN2hw@mail.gmail.com>
	<20120214211552.GA9651@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQZ0-0005R7-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761295Ab2BNWJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 17:09:26 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:64894 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761264Ab2BNWJZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:09:25 -0500
Received: by lbom4 with SMTP id m4so199735lbo.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tSg4eaYNgn1b288bXZny+XZvpUmC/ioWppzgz5iyiv4=;
        b=j2ugu+hKx4Pjn5ULIpDJYNFHxGDxjFk1SSJueTN6zKojUpPl72XaE6jWVZNUe8aN3I
         AjhObJ+7VtZul6lac5V1p3e5snFPHLXV4gynL+AGzQK7jMbAN+SlYKHEWnr371+JZAQ0
         wpQ04j6+SDVI7QJrn8MB6bsEuSNx3QDIwMf/w=
Received: by 10.112.32.1 with SMTP id e1mr8180056lbi.3.1329257363299; Tue, 14
 Feb 2012 14:09:23 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 14:09:23 -0800 (PST)
In-Reply-To: <20120214211552.GA9651@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190774>

On Tue, Feb 14, 2012 at 11:15 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>> On Tue, Feb 14, 2012 at 10:34 PM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>
>>> To summarize the previous discussion[1]: some people had comments, =
and
>>> you seem to have found value in exactly none of them. =C2=A0OK. =C2=
=A0CC-ing
>>> Peff, since he at least probably has looked over this code before.
>>
>> Just because you have comments doesn't mean I *must* address them. W=
e
>> have a difference of opinion, nothing wrong with that.
>
> I said "OK", didn't I?

You also said I didn't find value in any of the comments which is
being passively aggressive. Comments always have value, that doesn't
meant they must all be turned into actionables.

> [...]
>>> In fact it seems to be intended to test the case addressed by f0263=
58e
>>> (name changing, email not) in various mailmap callers: "git shortlo=
g -e",
>>> "git log --pretty", "git blame".
>>
>> No. As the summary says, it's intended to add a simple name
>> translation test, which is missing from all the tests that spawn fro=
m
>> the repository generated in 'Shortlog output (complex mapping)' test=
=2E
>> This is the most minimal patch that can be generated if you add a
>> commit to this repository, and any further tests that are related to
>> it would look the same.
>>
>> As Junio pointed out what is missing from the explanation is that th=
is
>> simple name translation test is targeted toward the 'git blame'
>> commands, because such translation is not tested for them currently.
>
> Um. =C2=A0So this has nothing to do with f026358e at all? =C2=A0Menti=
oning that
> commit and that this test does not pass with an older codebase is not
> useful to the humans that will look over this test later?

I didn't say that. I say the *purpose* of the patch is different.

> Adding explanation and rearranging things so people encountering this
> later have to spend _less_ time to understand it is something I
> consider useful. =C2=A0It means people are less likely to randomly br=
eak
> things. =C2=A0I don't actually understand where the difference of opi=
nion
> comes from here.

The difference of opinion is that I consider the patch already good
enough (adding the comments from Junio). Yeah, now that f026358e is
committed might be worth mentioning, and what's the relationship, but
that's an *extra*. Even if f026358e wasn't there, and nobody knew what
was the issue, and possible fixes, the patch would be good by itself.

Again, some tests > no tests, and don't let the perfect be the enemy
of the good. It even looks like you prefer no changes at all (status
quo) to my proposed changes as you have never said these are "good",
but always paint them as "wrong" or "broken" in fundamental ways, as
if they are not worthy of being applied.

In any case, I will address the comments from Junio, and perhaps add a
note regarding f026358e.

I also can't help but feel you are applying double standards, as this
is the original patch that seems to have broken things:

ommit d20d654fe8923a502527547b17fe284d15d6aec9
Author: Marius Storm-Olsen <marius@trolltech.com>
Date:   Sun Feb 8 15:34:30 2009 +0100

    Change current mailmap usage to do matching on both name and email
of author/committer.

    Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 Documentation/pretty-formats.txt |    2 +
 builtin-blame.c                  |   50 +++++++++++-------
 builtin-shortlog.c               |   22 ++++++--
 pretty.c                         |   57 +++++++++++----------
 t/t4203-mailmap.sh               |  106 ++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 186 insertions(+), 51 deletions(-)

Notice the short commit message. It would have been _nice_ to have a
bigger commit message, but it's better to have this commit than
nothing at all.

And see the relevant commit f026358:

f026358 mailmap: always return a plain mail address from map_user()
 mailmap.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

Notice how there's no tests, which would have reason enough to reject
the patches from many contributors.

Cheers.

--=20
=46elipe Contreras
