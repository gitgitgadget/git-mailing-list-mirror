From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: simplify __git_complete_revlist_file
Date: Sun, 6 May 2012 00:40:14 +0200
Message-ID: <20120505224014.GH2164@goldbirke>
References: <1335897776-3726-1-git-send-email-felipe.contreras@gmail.com>
	<7vfwbj79od.fsf@alter.siamese.dyndns.org>
	<CAMP44s0z5ghcDQOeL1TrJJ7nw4=tN5MhACqcmf4EjxsNNWiQnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 00:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQneK-0001TN-UH
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 00:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab2EEWkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 18:40:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:60053 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab2EEWkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 18:40:20 -0400
Received: from localhost6.localdomain6 (p5B130A62.dip0.t-ipconnect.de [91.19.10.98])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Lla4p-1RqdgU2MTv-00bKV3; Sun, 06 May 2012 00:40:17 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0z5ghcDQOeL1TrJJ7nw4=tN5MhACqcmf4EjxsNNWiQnA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:QjjtlEXLfAn5ZSdn2FVJi8KFJStGaK7rtMeHMQm0jdB
 UZl9PiUGFVgg0NihD7tOld9/Sa8LPcIvHfC6Q8L5r2znKErtr3
 KlTs/BmYeTTfBKKNdMxtT1wlVG1s3azFQhArQFvAmSc1sXhX3W
 U4YtxKKbHGIQKRunjtLhlzb7LeCQ5ZpKy4I1tjsYtFz87AsK+X
 54iUOstOSEjHGgFAq3uCyMpXHyXYcmvhTwIUt4HZwLhSQfJByF
 A2x9jd3uqFJm+e3zR9QMvVrnykYLZ/8aCzRKh+pPuNAvzew95k
 AgCMQW0dXhate2AUfhOVKwyPwT3AKXXnZFhYOi4K84Dc/RCkHO
 xbjo2sk1oOPZFBvgIPrA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197140>

Hi,


On Wed, May 02, 2012 at 01:46:32AM +0200, Felipe Contreras wrote:
> On Wed, May 2, 2012 at 1:39 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> Use new __gitcomp_nl; this is the last place that uses COMPREPLY a=
nd
> >> compgen directly.

I didn't dare to touch that code back then while doing the
__gitcomp_nl() changes; that sed command looked way too scary ;) But
all it does is to process the output of 'git ls-tree' and removes the
cruft and appends a space to filenames and a '/' to directories
(without a trailing space).  So invoking __gitcomp_nl() with an empty
suffix parameter is OK, as it doesn't change the current behavior.

> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> ---
> >> =A0contrib/completion/git-completion.bash | =A0 =A06 ++----
> >> =A01 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/comp=
letion/git-completion.bash
> >> index 31f714d..d877a23 100755
> >
> > This seems to be based on 'maint', which has 31f714d, but I see two=
 hits
> > with "git grep 'COMPREPLY.*compgen' contrib/completion" there, so I=
 am not
> > sure if that is where you wanted it to apply.
>=20
> The last place that is not the __gitcomp* functions, of course.
>=20
> > I see this was not addressed to me (neither was the other zsh one),=
 so I
> > take it that the patch is still for discussion, at least for the pu=
rpose
> > of today's integration round. =A0Ping me when it is ready for eithe=
r 'pu' or
> > 'next'.
>=20
> I'd say at least one person should say LGTM before asking you to inte=
grate it.

Yeah, it's good to go.


Best,
G=E1bor
