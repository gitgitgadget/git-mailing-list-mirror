From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in
	git-status
Date: Fri, 29 Oct 2010 17:06:08 -0400
Message-ID: <1288386368.7988.22.camel@drew-northup.unet.maine.edu>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	 <1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
	 <20101028183513.GC14212@burratino>
	 <7vaaly9eji.fsf@alter.siamese.dyndns.org>
	 <20101028220956.GC16125@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 23:15:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBwHh-0000rf-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 23:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab0J2VOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 17:14:43 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:57419 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758487Ab0J2VOl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 17:14:41 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9TL6EK0030649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Oct 2010 17:06:19 -0400
In-Reply-To: <20101028220956.GC16125@burratino>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9TL6EK0030649
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288991264.73137@rHxluoHf+P3m/qTdH5oQbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160363>


On Thu, 2010-10-28 at 17:09 -0500, Jonathan Nieder wrote:
> Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
> >>  # Changes to be committed:
> >>  #   (use "git reset HEAD <file>..." to unstage)
> >>  #
> >>  #       new file:   foo.c
> >>  #
> >>  # Changes not staged for commit:
> [...]
> > Hmm, perhaps we'd want to restate the first one as well to read
> >=20
> >     Changes staged for commit:
> >       (use "git reset HEAD <path>..." to unstage)
> >=20
> > for consistency as well?
>=20
> My first impression is no.  Since the main purpose of this text is to
> be shown by "git commit", it might even make sense to say:
>=20
> # Changes to be committed:
> #   (use "git reset -- <path>..." to unstage)
> #
> #	new file:    foo.c
> #
> # Changes not to be committed:
> #   (use "git add <path>..." to update what will be committed)
> #   (use "git checkout -- <path>..." to discard changes in working
> #   directory)
> #
> #	typechange:  bar.c

This one gets my vote out of the replacements I've seen. I appreciate
leaving the "git add" idiom untouched.

> > Listing by filename gives a false impression that we are talking ab=
out the
> > whole file contents, and looks a bit confusing until it is explaine=
d to
> > you why when the same file appears in both of the first two section=
s.
>=20
> Iould be nice if the "staged changes" section gave a hint that there
> were unstaged changes present.  Maybe something like the
> "unsaved file" indicator used by some text editors:
>=20
> 	new file:    foo.c*

Perhaps in the to be/ not to be sections we could indicate the mtime of
staged changes in comparison with those not staged?

staged:
#	modified:    foo.c    4:30 PM
unstaged
#	modified:    foo.c    4:50 PM

If we decide to do this I think it should be a separate patch from this
set (functionality change as opposed to a terminology change). It would
however make clear something that Thore initially complained about:

> changed but not updated:
>
> I=E2=80=99m still not sure what =E2=80=9Cupdate=E2=80=9D was ever sup=
posed to mean in this
> sentence. I just edited the file, so it=E2=80=99s updated, for crying=
 out
> loud!"
http://article.gmane.org/gmane.comp.version-control.git/159287=20


--=20
---------------------------------+-------------------------------------=
-
Drew Northup                     |          Technical Support Specialis=
t
University of Maine System       |                Drew.Northup@Maine.ed=
u
Computing Center                 |                 phone: (207) 561-351=
3
Orono, ME 04469                  |                   fax: (207) 561-353=
1
