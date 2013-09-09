From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] sequencer: trivial cleanup
Date: Mon, 9 Sep 2013 02:20:27 +0200
Message-ID: <20130909002026.GF28959@goldbirke>
References: <1378680160-4720-1-git-send-email-artagnon@gmail.com>
 <CAMP44s1fE0XZScL_gU5JAEdC0hPFHPTovqXLx7gqvwVdZbBaVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIpDW-0006rn-1M
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879Ab3IIAUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 20:20:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51757 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab3IIAU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 20:20:29 -0400
Received: from localhost6.localdomain6 (92-249-226-131.pool.digikabel.hu [92.249.226.131])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LwSjL-1W2QdA3FBn-018MoW; Mon, 09 Sep 2013 02:20:28 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s1fE0XZScL_gU5JAEdC0hPFHPTovqXLx7gqvwVdZbBaVw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:mLsy1nw6o36Frfd4K1LRarxTs/vxFCB1R+gXDC0twV7
 /P2ILkTcy62upaJh0vbaUr8i/7ZKgv9H2cv8jeaUOm05aEGsNg
 OlpKK3++dyfmxzb4brZyW00ljiO6WXPK98KP7jFwueOLCr8ngD
 57VElzLOjRJYCzvgJDTG5j411D7MmK0OlcLS3PS59PS67xFCyY
 P5WAQ5cUm9jnDcP6md8WQrEaX7CXKj2VevpL5HCex5gAFvL9Qn
 2hof6Mb9W8RoXVMK2wVklfUNpS6J+Wt/j4OA71D7emr11OKKPh
 rnECe8JyxI6CsYm83gktYM5ImeXRpglmmsp9tK5VdMOgmboD/o
 vMxEyqXC2y9YUUotjB2dlFtuM9xG9orRFvyj4Z5/J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234288>

Hi,

On Sun, Sep 08, 2013 at 05:53:19PM -0500, Felipe Contreras wrote:
> On Sun, Sep 8, 2013 at 5:42 PM, Ramkumar Ramachandra <artagnon@gmail.=
com> wrote:
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > ---
> >  sequencer.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 351548f..8ed9f98 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -466,10 +466,7 @@ static int allow_empty(struct replay_opts *opt=
s, struct commit *commit)
> >         empty_commit =3D is_original_commit_empty(commit);
> >         if (empty_commit < 0)
> >                 return empty_commit;
> > -       if (!empty_commit)
> > -               return 0;
> > -       else
> > -               return 1;
> > +       return empty_commit ? 0 : 1;
> >  }
>=20
> Isn't it the other way around? Moreover, 'return !!empty_commit;'
> would be simpler.

Considering the possible return values from
is_original_commit_empty(), I think all this could be written as

  return is_original_commit_empty(commit);


Best,
G=E1bor
