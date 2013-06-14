From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] prompt: squelch error output from cat
Date: Fri, 14 Jun 2013 15:58:16 +0200
Message-ID: <20130614135816.GL2091@goldbirke>
References: <1371131209-32479-1-git-send-email-artagnon@gmail.com>
 <20130613143942.GK2091@goldbirke>
 <CALkWK0kwVahUF_kwk4jRr7Qr5_H-FY_aXWLkQcaZV-YrV_mgjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:58:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUWN-0006DS-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab3FNN63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:58:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:59878 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab3FNN60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:58:26 -0400
Received: from localhost6.localdomain6 (f051192048.adsl.alicedsl.de [78.51.192.48])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MNiNa-1UgMyJ1EWg-0079mP; Fri, 14 Jun 2013 15:58:17 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0kwVahUF_kwk4jRr7Qr5_H-FY_aXWLkQcaZV-YrV_mgjw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:rCcjd8Wd/6q37FJ6uv0abw7UQxVZ/PAaCzKhoDRoHR0
 v6Cz6YKckgvgvoSRHbe/Xg4VMas5pzu0EHgbQxfx0Rh0f9sL7E
 J2w62eoqQD+vYEnNQf8DiUopkkFm0yeN+tq8KMvKc59yqWyd12
 7hdrjd7nQvz6t9ruoWySM5ayTyg+UC2bTT3twTdwek/MV9+pLC
 oJI5NLl7KnesHueJMrhjZxMMTb/4dpRBXYkT6ADnz7jeHcvakJ
 5h6/MhbtzQPmVvLQwqEYVRYmjMnJ6wASh7zpUg7RrS6Ir8Zqkt
 Br+O/+OsVX3QP5v9+flnulwcWv4rMmS1Olu/hT0nT0FVBmzMI7
 vqWwV9nQFNJyWI94T/JY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227871>

On Thu, Jun 13, 2013 at 08:15:59PM +0530, Ramkumar Ramachandra wrote:
> SZEDER G=E1bor wrote:
> > Just curious: when do those files don't exist?  When using an older
> > version of git with a newer prompt, obviously, but are there other
> > cases?
>=20
>   # On terminal one
>   $ git rebase --interactive master
>   # Ignore editor, and open terminal two
>   cat: .git/rebase-merge/msgnum: No such file or directory
>   cat: .git/rebase-merge/end: No such file or directory
>   $

Interesting, I wouldn't have thought of that.

I was wondering whether there are cases and code paths in git rebase,
where it knows what to write into those files but it does not write
them, which might be worth fixing additionally.  In case of this
halfway-started rebase I don't see any point in displaying 0/42, so I
don't think any additional fix would be necessary.


Thanks,
G=E1bor
