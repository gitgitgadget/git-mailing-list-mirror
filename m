From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Mon, 6 Jul 2015 15:39:41 -0400
Message-ID: <20150706193941.GA1730@flurp.local>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
 <20150705191101.GB9815@flurp.local>
 <xmqqa8v92qdf.fsf@gitster.dls.corp.google.com>
 <CAPig+cTfkDqSDRqDjA=CNkT1c7Fo0zaLiwi2bAbCLZxPHi5=Bg@mail.gmail.com>
 <xmqqfv5118a3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 21:40:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCCF9-0007kJ-7b
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 21:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbbGFTju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 15:39:50 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38405 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbbGFTjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 15:39:48 -0400
Received: by igrv9 with SMTP id v9so123856979igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XWqoXujW9+dsMZ4gKonTLQyxAMycJY6ME9J0kPCdgDs=;
        b=Kmp2HM5GeogvadL7xKrgoetdxYS74FEndV1Lta6iLkaIVWxuhnqL9MseL3iNHXzESv
         VLLcSexFj7aijfS+vKtBiVVXAiuFXi5j0hwBb0yWHQxsKzJmELDH/DMnRdK9cTf5w6da
         i3Qts1ntvtF3sIf14YoGV311Zd7OPVOf37xZBAJ3Zmlz8LavSOPSMbRJLisPMRKexQ1o
         dIBF7v82pg/cFrCJz1WxF5s42NMxE30z5imU7aZE28edP9Xqs/rM+OqeE+j5jNQSusDC
         AMXYT1KDB8PWPN6gebpUU+4IishP7yJ0QUHreYkryfriXZ7NORsAtWWQd23ybEvjuGOt
         UBAA==
X-Received: by 10.107.30.195 with SMTP id e186mr750806ioe.57.1436211587772;
        Mon, 06 Jul 2015 12:39:47 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id p8sm10291634iga.13.2015.07.06.12.39.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 12:39:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfv5118a3.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273452>

On Mon, Jul 06, 2015 at 10:54:28AM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > How about this instead: prefixing with "As originally implemented",
> > with a couple s/is/was/ thrown in...
> >
> >     As originally implemented, creation of linked-worktrees was
> >     accomplished via `git checkout --to <path> <branch>`, and clean=
up
> >     of leftover administrative files, after `<path>` is deleted, wa=
s
> >     done with `git prune --worktrees`. However, a recent unrelated
> >     change to `git prune` led to a discussion that concluded that
> >     worktree-related maintenance functionality didn't belong in `gi=
t
> >     prune`.
> >
> > Is that sufficient to clue in the reader that "checkout --to" is no=
t
> > final form,...
>=20
> Yeah, I think that is a good way to address my concern.
>=20
> The current draft release notes to 2.5 mentions this feature as
> experimental and warns that its UI is bound to change.  We will
> ship the upcoming release with "checkout --to" and the more places
> we advise the users that this UI is not final, the better.

Here it is in patch form. (I wouldn't be surprised if the non-ASCII
characters in Duy's name in the context line get botched again...)

---- 8< ----
=46rom: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] rn-5: make it clear that "git checkout --to" is not fi=
nal
 form

We don't want to mislead reader who is only lightly skimming the text
or who doesn't read the entire article that "git checkout --to" is the
final form.
---
 rev_news/drafts/edition-5.md | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/rev_news/drafts/edition-5.md b/rev_news/drafts/edition-5.m=
d
index 241e9df..b71c99c 100644
--- a/rev_news/drafts/edition-5.md
+++ b/rev_news/drafts/edition-5.md
@@ -35,12 +35,13 @@ Unix-only and somewhat fragile `contrib/git-new-wor=
kdir` script,
 linked-worktrees recently migrated to the *master* branch, but is not
 yet part of any release.
=20
-Creation of linked-worktrees is accomplished via `git checkout --to <p=
ath>
-<branch>`, and cleanup of leftover administrative files, after `<path>=
` is
-deleted, is done with `git prune --worktrees`. However, a recent unrel=
ated
-change to `git prune` led to a
+As originally implemented, creation of linked-worktrees was accomplish=
ed
+via `git checkout --to <path> <branch>`, and cleanup of leftover
+administrative files after manual deletion of `<path>` was done with `=
git
+prune --worktrees`. However, a recent unrelated change to `git prune` =
led
+to a
 [discussion](http://thread.gmane.org/gmane.comp.version-control.git/27=
2447/focus=3D272546)
-that concluded that worktree-related maintenance functionality doesn't
+that concluded that worktree-related maintenance functionality didn't
 belong in `git prune`.
=20
 Consequently, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy submitted a
--=20
2.5.0.rc1.197.g417e668
