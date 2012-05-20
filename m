From: Carsten Mattner <carstenmattner@googlemail.com>
Subject: Re: [PATCH 0/2] completion: backwards compatibility fix
Date: Sun, 20 May 2012 19:27:20 +0200
Message-ID: <CACY+Hvrj_out4Lm+8Wi3egdc+bs4MWLpVy2X98Uo__r3mSpBOQ@mail.gmail.com>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
	<CACY+HvqhJf6ywTaDgT5ie-3iBQAGwngTYPiCvKgw6mJB=1+fOg@mail.gmail.com>
	<CAMP44s2sJaW-n7EGTu+hNNkaEnGkk7wKDQD56bgq2=qeeFqWrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 19:27:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW9ug-0003uQ-E7
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 19:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524Ab2ETR1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 13:27:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64756 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649Ab2ETR1V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 13:27:21 -0400
Received: by obbtb18 with SMTP id tb18so6912273obb.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=doGGyS65aSIX7os/STfoT0pnECns7RCtkqAG+6gCLHg=;
        b=lGIUpuPAM9LOjUFP3/xwtmWaxfDzT2IF9801FfmQyzVKiXjinii66Guw/5ivy3+4TF
         rcctQ7wrUiYobdBln1ZEyZ/D7WN401nBrnT0vlF/xFfvFrrmVVCfvqZWuC5LZRwn3+ap
         g4BMcylkOXGMyxwZqUiaojBqp6nb5WFPKA8D0+9iSVZE3A+od0IVdgL5+n+4V07fz0Uj
         4r3RAqdTSQ3LhObJLtYH1m7b1BNOp4TQsNFGnmJfSNS3DdRcro4QRNyw7A+c36Rwvna2
         uqwyGgWfdRakaFOE5Nyvr9inGiy0r8OYON6ALZf+yWHLkBRV49XxHH3zjb1/PVtmjfWc
         hlHA==
Received: by 10.50.47.230 with SMTP id g6mr4943389ign.74.1337534840519; Sun,
 20 May 2012 10:27:20 -0700 (PDT)
Received: by 10.50.6.231 with HTTP; Sun, 20 May 2012 10:27:20 -0700 (PDT)
In-Reply-To: <CAMP44s2sJaW-n7EGTu+hNNkaEnGkk7wKDQD56bgq2=qeeFqWrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198064>

On Sun, May 20, 2012 at 12:28 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, May 20, 2012 at 11:02 AM, Carsten Mattner
> <carstenmattner@googlemail.com> wrote:
>> On Sat, May 19, 2012 at 4:41 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Hi,
>>>
>>> These two patches are meant to fix the backwards compatibility of _=
git, and
>>> _gitk. This also helps my zsh's wrapper.
>>>
>>> Felipe Contreras (2):
>>> =A0completion: rename _git and _gitk
>>> =A0completion: add support for backwards compatibilit
>>>
>>> =A0contrib/completion/git-completion.bash | =A0 22 ++++++++++++++++=
+-----
>>> =A0t/t9902-completion.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
>>> =A02 files changed, 18 insertions(+), 6 deletions(-)
>>>
>>> --
>>> 1.7.10.2
>>>
>>
>> Thanks Felipe. With the 2 patches applied all the following
>> completion definitions work.
>>
>> complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null =
\
>> =A0 || complete -o default -o nospace -F _git g
>> __git_complete g _git
>> __git_complete g _main_git
>>
>> Ignoring backwards compatibility, which one would you suggest
>> I use? Keep in mind that I originally copied the first
>> long completion defintion from git-completion.bash a long time
>> ago.
>
> I would use '__git_complete g _git', but keep in mind that none of
> these forms have a promise to stay. Eventually the final one would be
> '_GIT_complete g _git' (hopefully), but if you want to be safe from
> changes maybe the first (original) would be best; even though there's
> no promise it won't break, we would probably try our best not to brea=
k
> it (again).

What about adding a small note at the top of the completion script
together with the other documentation? Does it make sense to keep
the known to work and public invocation in there?

> BTW. If your system has the '-o bashdefault' option you probably don'=
t
> need the full form, just:
> % complete -o bashdefault -o default -o nospace -F _git g
>
> Or if your system doesn't:
> % complete -o default -o nospace -F _git g

I like the short versions. They seem to work.
