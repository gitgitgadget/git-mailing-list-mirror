From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 01:06:55 +0200
Message-ID: <20090405230655.GB20356@atjola.homenet>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> <200904052358.53028.markus.heidelberg@web.de> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markus.heidelberg@web.de, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:08:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqbSD-0001Lx-BI
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbZDEXHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 19:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbZDEXHA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:07:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:48661 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753573AbZDEXHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:07:00 -0400
Received: (qmail invoked by alias); 05 Apr 2009 23:06:56 -0000
Received: from i59F56377.versanet.de (EHLO atjola.local) [89.245.99.119]
  by mail.gmx.net (mp071) with SMTP; 06 Apr 2009 01:06:56 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18v135mr5ovf3SgKxLrPRKH5gaw/GeKtABlqZO79f
	J43X/PH7iCtQIX
Content-Disposition: inline
In-Reply-To: <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115733>

On 2009.04.06 01:35:24 +0300, Felipe Contreras wrote:
> On Mon, Apr 6, 2009 at 12:58 AM, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > Felipe Contreras, 05.04.2009:
> >> For example 'git stage diff' is more natural (at least to me) than=
 'git diff
> >> --cached', same goes for 'git stage rm foo.c' vs 'git rm --cached =
foo.c'.
> >
> > Not for me. If I want to GET a diff, I want to use a command "diff"=
, so
> > "git diff" is more obvious.
> > The next step is to say WHAT exactly to diff. Therefor options to t=
he
> > "diff" command are more logically to me from a hierarchic POV. And =
here
> > I don't think options like "--cached" or "sha1..sha2", despite havi=
ng
> > different style, make any difference.
>=20
> Well, it's a matter of preference, and you would not loose the option
> to do it the way you like. But actually, "git diff --cached" is a
> different action; you can't do "git diff --cached HEAD^.." for
> example.

Sure you can. It diffs the index against HEAD^

> Consider "git rm foo.c" vs "git rm --cached foo.c"... both commands
> are removing a file, the only difference is that one is removing from
> the staging area while the other is removing it from the working
> directory.

The working tree _and_ the index. To delete it only from the working
tree you need "rm", not "git rm".

> Now think about "git branch -d bar", following the "first I
> specify the action, and then the object" thinking, would it make sens=
e
> to have "git rm --branch bar"? Probably not; if you want to do stuff
> with branches, you use "git branch", similarly, if you want to do
> stuff with the staging area, why not use "git stage"?

If you're going that way, you'll also need "clone create", "working-tre=
e
grep", "repo/remote fetch/pull/push", etc.

"git branch", "git tag", "git remote" and maybe "git status" are the
"outsiders", in that the commands (in some forms) end up as "git
<object> <action>" form. The rest is "git <action> <object>".

So "git stage <action>" would extend the minority, and not lead to
unification.

Bj=F6rn
