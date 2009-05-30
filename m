From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] refuse to merge during a merge
Date: Sat, 30 May 2009 10:37:21 +0200
Message-ID: <20090530083721.GA12963@localhost>
References: <20090527210410.GA14742@localhost> <43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dave Olszewski <cxreg@pobox.com>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 11:45:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAL8T-0001v7-BJ
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 11:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbZE3Jpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 May 2009 05:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755379AbZE3Jpn
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 05:45:43 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:41087 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbZE3Jpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 05:45:43 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 May 2009 11:45:44 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MAK49-0003Wn-58; Sat, 30 May 2009 10:37:21 +0200
Content-Disposition: inline
In-Reply-To: <43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 May 2009 09:45:44.0484 (UTC) FILETIME=[66F2AE40:01C9E10B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120345>

On Thu, May 28, 2009 at 05:12:40PM +0100, John Tapsell wrote:
> > + =A0 =A0 =A0 if (read_cache_unmerged() || file_exists(git_path("ME=
RGE_HEAD")))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("You are in the middle of a conf=
licted merge.");
>=20
> Could the error message also give possible solutions?   "Commit the
> current merge first with 'git commit', or discard the current merge
> attempt with 'git reset --hard'" or something.  Or at least a pointer
> to where to read for more info.

How about this.

fatal: You are in the middle of a [conflicted] merge. To complete the m=
erge
[resolve conflicts and] commit the changes. To abort, use "git reset HE=
AD".

The part about resolving changes is only displayed if there are unmerge=
d
entries. I intentionally left out --hard, because it potentially remove=
s
changes unrelated to the merge (if the work tree was dirty prior to the
merge). The user will find out how to reset the work tree by reading th=
e
docs.

Clemens
