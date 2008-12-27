From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] git-shortlog.txt: improve documentation about .mailmap
	files
Date: Sat, 27 Dec 2008 19:21:40 +0100
Message-ID: <20081227182140.GA28946@chistera.yi.org>
References: <1230290283-6268-1-git-send-email-dato@net.com.org.es> <1230292553-7613-1-git-send-email-dato@net.com.org.es> <7viqp5et48.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 19:25:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGdqr-0001Nz-2w
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 19:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYL0SVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 13:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbYL0SVr
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 13:21:47 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4050
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYL0SVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 13:21:46 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id A2786801BF66;
	Sat, 27 Dec 2008 19:21:44 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGdnA-0007t9-PB; Sat, 27 Dec 2008 19:21:40 +0100
Content-Disposition: inline
In-Reply-To: <7viqp5et48.fsf@gitster.siamese.dyndns.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104012>

* Junio C Hamano [Sat, 27 Dec 2008 03:48:39 -0800]:

> Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> > The previous .mailmap example made it seem like .mailmap files are =
only
> > useful for commits with a wrong address for an author, when they ar=
e about
> > fixing the real name. Explained this better in the text, and replac=
ed the
> > existing example with a new one that hopefully makes things clearer=
=2E

> Thanks.

Thanks for your review!

> > -If the file `.mailmap` exists, it will be used for mapping author
> > -email addresses to a real author name. One mapping per line, first
> > -the author name followed by the email address enclosed by
> > -'<' and '>'. Use hash '#' for comments. Example:
> > +If a file `.mailmap` exists in the toplevel directory of the repos=
itory,
> > +it will be used for mapping author email addresses to a canonical =
real
> > +name. This can be used to coalesce together commits by the same pe=
rson
> > +where their name was spelled differently (whether with the same em=
ail
> > +address or not).

> We didn't stress "the toplevel" earlier, partly because it is obvious=
 that
> the file cannot be anything but project-tree wide (as opposed to bein=
g per
> subdirectory, similar to .gitignore and .gitattributes).  I guess it =
would
> not hurt to be explicit, even though it feels slightly silly.

Hm. I'd prefer to keep it in if you don't mind much.

> "..., it is used to map author email addresses to..." would flow easi=
er.

Changed.

> > +The format of the file is one mapping per line, first the desired =
author
> > +name followed by the email address enclosed by '<' and '>'. Use ha=
sh '#'
> > +for comments.

> You already introduced the term "a canonical real name" in the earlie=
r
> description.  It would be easier to read if you stick to it and say "=
Each
> line consists of the canonical real name of an author, whitespaces, a=
nd an
> email address, enclosed by '<' and '>', to map to the name".

Changed.

> Can a hash '#' character be anywhere on a line?  E.g. how is an entry=
 like
> this processed?

> 	Jane Doe <jane@desktop.(none)> # early mistake...

It is processed correctly. Good suggestion to have it documented. I did=
:

  Use hash '#' for comments, either on their own line, or after the
  email address.

> > +... For example, if your history contains commits by these
> > +committers:

> I think you meant "authors", not "committers".

Ok.

> > +------------
> > +Author: Joe Developer <joe@random.com>
> > +Author: Joe R. Developer <joe@random.com>
> > +Author: Jane Doe <jane@the-does.name>
> > +Author: Jane Doe <jane@laptop.(none)>
> > +Author: Jane D. <jane@desktop.(none)>
> > +------------

> I'd suggest dropping "Author: ".  You said you are listing people.

And ok.

> Isn't random.com a real domain (the same goes for the-does.name)?  It
> would be preferrable to use addresses from .example (or .xz) top-leve=
l
> domain.

I wanted to use a real TLD to clearly convey that these were for real
addresses and not misconfigured ones. How about "example.com"? (This is
used in other Documentation files.)

> Clarify that there are actually two people in the list above, and exp=
lain
> that they are one Joe with two spellings who prefers to be referred t=
o
> with his middle initial, and one Jane with three spellings who prefer=
s to
> show the family name fully spelled out.  Do not force your readers gu=
ess
> which spelling is preferred for each person in the example.  It would=
 make
> it easier for them to understand the example you will give them next =
and
> to agree that the mailmap is "proper".

Good point. As always, what it's obvious to the writer may not be to th=
e
reader. Thanks.

I also added a sentence mentioning that names can appear more than once=
,
but addresses can't.

Can you take another look? (Amended patch coming.)

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- You look beaten.
- I just caught Tara laughing with another man.
- Are you sure they weren't just... kissing or something?
- No, they were laughing.
                -- Denny Crane and Alan Shore
