From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Feature Request] Better Subversion integration
Date: Fri, 15 Feb 2008 23:38:17 +0100
Message-ID: <20080215223817.GA13178@efreet.light.src>
References: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com> <20080210035611.GA2454@atjola.homenet> <20080211084704.GB20741@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Sam Granieri Jr <sjgdev@gmail.com>,
	Git Users List <git@vger.kernel.org>
To: Sebastian Harl <sh@tokkee.org>
X-From: git-owner@vger.kernel.org Fri Feb 15 23:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ9D0-0006fz-Bi
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 23:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761165AbYBOWie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 17:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760807AbYBOWid
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 17:38:33 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:58431 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271AbYBOWi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 17:38:28 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3AE21572FA;
	Fri, 15 Feb 2008 23:38:26 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id tyZHoewZGD48; Fri, 15 Feb 2008 23:38:22 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 450E157348;
	Fri, 15 Feb 2008 23:38:21 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JQ9CD-0006pm-3W; Fri, 15 Feb 2008 23:38:17 +0100
Content-Disposition: inline
In-Reply-To: <20080211084704.GB20741@albany.tokkee.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73992>

On Mon, Feb 11, 2008 at 09:47:04 +0100, Sebastian Harl wrote:
> Hi,
>=20
> On Sun, Feb 10, 2008 at 04:56:11AM +0100, Bj=C3=B6rn Steinbrink wrote=
:
> > SVN tags aren't like git tags. A "tag" in SVN is just another direc=
tory,
> > which you can modify at will.
>
> Well, a SVN tag could be represented as a Git branch _and_ a Git tag
> pointing to the head of that branch. Whenever any such "tag branch"
> advances, the user should be notified, the user responsible for the
> further commits to the SVN "tag" should be seriously hurt and the Git
> tag should be overwritten (git tag -f).

There's no need to have a Git _branch_ together with the tag -- tag is =
also
a ref.

=46or the rest, the user definitely has to be notified, because git pus=
h will
_not_ push out the updated tag if the previous version of it was alread=
y
pushed. So the user will have to deal with that manually.

If there was to be a support for tags in git-svn, I would actually sugg=
est to
simply make the name mapping more flexible and simply say, that branche=
s in
tags/ should be imported to refs/tags (while the rest going to
refs/remotes/svn). You see, subversion tags are not annotated (so they =
don't
need special handling) and git-update-ref will update tags just fine.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
