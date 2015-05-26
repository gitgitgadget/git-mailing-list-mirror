From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Tue, 26 May 2015 23:58:09 +0200
Message-ID: <20150526215809.GA922@book.hvoigt.net>
References: <1432323527-26868-1-git-send-email-sbeller@google.com>
 <xmqqfv6k9v1x.fsf@gitster.dls.corp.google.com>
 <CAGZ79kZHRRqKpSmnEfd7-UOL9QrPOhQYt7wsfaqGVTZkHc+mhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 26 23:58:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMrf-0000OD-HV
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbbEZV6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 17:58:18 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:54293 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbbEZV6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 17:58:17 -0400
Received: from [188.108.15.115] (helo=book.hvoigt.net)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YxMrW-0002Xr-G9; Tue, 26 May 2015 23:58:14 +0200
Content-Disposition: inline
In-Reply-To: <CAGZ79kZHRRqKpSmnEfd7-UOL9QrPOhQYt7wsfaqGVTZkHc+mhQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269985>

On Tue, May 26, 2015 at 10:53:15AM -0700, Stefan Beller wrote:
> On Mon, May 25, 2015 at 3:00 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > Stefan Beller <sbeller@google.com> writes:
> > On the other hand, I probably would not have felt such a strong
> > "strangeness" if it were described like this:
> >
> >     This command can help you inspect, update, and manage
> >     submodules.
> >
> > I haven't analized it enough to say why it is, but I suspect it has
> > something to do with (my own) perception that "git submodule" is no=
t
> > very essential to do any of these things (i.e. .gitmodules is a ver=
y
> > simple text file), but is primarily a helpful wrapper.
>=20
> My perception is that the submodule man page similar to the subtree
> man page tries to explain an underlying concept as well. The other ma=
n
> pages you quoted don't do that as the concepts are explained elsewher=
e(?)
>=20
> As a side note: In the Gerrit test suite I use the JGit implementatio=
n of
> the config command to write out .gitmodules files. So maybe `git subm=
odule`
> can be understood as a specialized form of `git config`.

I do not agree here. That view is too limited. Since in the case of e.g=
=2E 'git
submodule add=E2=80=98 it does not only change the .gitmodules file but=
 adds a gitlink
entry to the index, moves the database into .git/modules, ... .

And even though it is currently not doing much more it might in the
future. E.g. it might make sense to add a 'git submodule gc' command
which allows the user to purge unused submodule databases from the
=2Egit/modules directory.

So I would say it is: "a helper" or "a tool" for submodules. Nothing le=
ss
nothing more. But on the other hand the same is true for other porcelai=
n
commands like e.g. 'git commit'. If you take a look at gitcore-tutorial
you could also describe it as a wrapper for write-tree, commit-tree and
update-ref to create a commit. Yet the man page says: "Record changes t=
o
the repository".

So I am not sure where to draw the line between wrapper and essential
command. As a user I would see it as quite essential since for adding a
submodule I would need to remember a couple of things:

  * clone the database into .git/modules
  * create the gitlink file
  * checkout the files to the desired directory
  * add the url to the .gitmodules file

So why not go with Junios first suggestion and lets drop the "This
command can help you..." and say: "Inspect, update and manage
submodules".

Cheers Heiko
