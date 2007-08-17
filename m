From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [BUG] git --work-tree=... status
Date: Fri, 17 Aug 2007 13:50:51 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070817115051.GA11107@informatik.uni-freiburg.de>
References: <20070812185855.GA16704@informatik.uni-freiburg.de> <7vlkcgim5w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 13:51:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM0Mm-0000KS-5P
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 13:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760541AbXHQLvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Aug 2007 07:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760629AbXHQLvN
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 07:51:13 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:46361 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760541AbXHQLvK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 07:51:10 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IM0M9-0005R7-3g; Fri, 17 Aug 2007 13:51:09 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7HBox0e011386;
	Fri, 17 Aug 2007 13:50:59 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7HBopN1011385;
	Fri, 17 Aug 2007 13:50:51 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlkcgim5w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56061>

Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <ukleinek@informatik.uni-freiburg.de> writes:
>=20
> > The problem seems to be that require_work_tree demands more that I =
think
> > it should.  It calls `git rev-parse --is-inside-work-tree`.
>=20
> I think the semantics of require_work_tree is (currently and has
> been) indeed "you are supposed to be inside the work tree".
>=20
> "git-status $args" is a "git commit --dry-run $args" and $args
> are often filenames relative to $cwd that name paths to include
> in the partial commit, so for this particular case I think it is
> understandable that it wants you to be _IN_ the work tree.
An (IMHO better) alternative is to introduce two flags---say
--absolute-paths and --relative-paths.  --relative-paths is the default
if you're in a work tree, otherwise it's --absolute-paths.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

fib where fib =3D 0 : 1 : zipWith (+) fib (tail fib)
