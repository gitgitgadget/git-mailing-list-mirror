From: Max Kellermann <max@duempel.org>
Subject: Re: [stgit PATCH] commands.{new,rename}: verify patch names
Date: Tue, 5 Oct 2010 14:52:25 +0200
Message-ID: <20101005125225.GA12416@mail.blarg.de>
References: <20101005114541.15037.53617.stgit@woodpecker.blarg.de>
 <AANLkTin9PyfY+-1=mJKMZa2FJ5YC2D27iPtiocCWY+eP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gustav =?iso-8859-1?Q?H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 14:59:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P376q-0004vY-17
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 14:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab0JEM7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 08:59:00 -0400
Received: from swift.blarg.de ([94.23.243.62]:53884 "EHLO swift.blarg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab0JEM7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 08:59:00 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2010 08:59:00 EDT
Received: by swift.blarg.de (Postfix, from userid 500)
	id D10E916335; Tue,  5 Oct 2010 14:52:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin9PyfY+-1=mJKMZa2FJ5YC2D27iPtiocCWY+eP@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158194>

On 2010/10/05 14:44, Gustav H=E5llberg <gustav@gmail.com> wrote:
> On Tue, Oct 5, 2010 at 1:45 PM, Max Kellermann <max@duempel.org> wrot=
e:
> > +def check_patch_name(name):
> > + =A0 =A0"""Checks if the specified name is a valid patch name. For
> > + =A0 =A0technical reasons, we cannot allow a slash and other chara=
cters."""
> > + =A0 =A0return len(name) > 0 and name[0] !=3D '.' and re.search(r'=
[\x00-\x20]', name) is None
>=20
> I don't quite understand how the above would filter out slashes.

Oh damn, you're right.  I had slashes explicitly forbidden in a
previous revision of my patch, that got lost when I added my "kill all
whitespace" change.  I'll resubmit.

>  sh$ git tag -- --foo
>  sh$ git rev-parse --foo
>  <failure>

I guess this is a problem because "git-rev-parse" doesn't follow the
convention of the "--" option separator.
