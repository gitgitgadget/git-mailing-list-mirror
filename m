From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Sun, 15 Apr 2007 19:25:00 -0400
Message-ID: <20070415232459.GB13515@fieldses.org>
References: <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org> <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com> <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org> <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com> <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org> <7v6484vxd5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org> <7vk5wkuf35.fsf@assigned-by-dhcp.cox.net> <87d52bib9e.fsf@morpheus.local> <7vabxfp873.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdE63-0001cB-1W
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbXDOXZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 15 Apr 2007 19:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbXDOXZF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:25:05 -0400
Received: from mail.fieldses.org ([66.93.2.214]:55155 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbXDOXZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:25:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdE5c-0008C0-1w; Sun, 15 Apr 2007 19:25:00 -0400
Content-Disposition: inline
In-Reply-To: <7vabxfp873.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44545>

On Wed, Apr 11, 2007 at 02:32:48AM -0700, Junio C Hamano wrote:
> David K=E5gedal <davidk@lysator.liu.se> writes:
>=20
> > Junio C Hamano <junkio@cox.net> writes:
> >
> >> ...  This _will_ fail, but that is to be expected, as
> >> we intend to replace that with what we just amended.  Just reset
> >> it away and keep going.
> >>=20
> >> $ git reset --hard
> >> $ git rebase --skip
> >
> > Wouldn't
> >
> > $ git rebase --onto HEAD lt/gitlink~3 lt/gitlink
> >
> > do the trick in one step?
>=20
> It is probably more Kosher, and I used to always do that, but it
> is much longer to type,

Also remembering which commit you amended is a pain sometimes.  So I
usually do

	git tag base lt/gitlink~3
	git checkout base
	... edit and amend ...
	git rebase --onto HEAD base lt/gitlink
	git tag -d base

But the trick of letting the rebase fail and skipping looks less
cumbersome.

--b.
