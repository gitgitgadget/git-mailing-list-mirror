From: Eric Wong <e@80x24.org>
Subject: Re: feature request: git svn dommit --preserve-timestamps
Date: Sat, 11 Jun 2016 11:43:31 +0000
Message-ID: <20160611114331.GA1678@dcvr.yhbt.net>
References: <87a8iy6s4e.fsf@free.fr>
 <20160607000902.GA4445@dcvr.yhbt.net>
 <87ziqx5z9h.fsf@free.fr>
 <20160611013948.GA5793@dcvr.yhbt.net>
 <878tycmejb.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter =?utf-8?Q?M=C3=BCnster?= <pmlists@free.fr>
X-From: git-owner@vger.kernel.org Sat Jun 11 13:43:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBhKC-0003rb-F1
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 13:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbcFKLnc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2016 07:43:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50964 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbcFKLnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 07:43:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D3F1FF40;
	Sat, 11 Jun 2016 11:43:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <878tycmejb.fsf@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297095>

Peter M=C3=BCnster <pmlists@free.fr> wrote:
> On Sat, Jun 11 2016, Eric Wong wrote:
>=20
> > The git log after dcommit is tied to the SVN log,
> > so git-svn can only reflect changes which appear in SVN.
>=20
> You mean, it's impossible, to keep the original timestamps??

It might be; just not easy; and I haven't looked at the code
in ages.  But there seems to be similar options for preserving
authorship in git-only  (see below)

> > Unfortunately, you would have to care about svn log as long as
> > SVN exists in your workflow and you need to interact with SVN
> > users.
>=20
> In my case, all development happens on Git, SVN is only some sort of
> copy. And when the original timestamps are lost, I've sometimes some
> real problems in finding a specific commit that matches another event=
=2E

I'm sorry for your situation and hoping you migrate off SVN
entirely, soon :)

> > git svn tries hard to work transparently and as close to the
> > behavior of the upstream SVN repo as possible.
>=20
> That's why I suggest an option, for use cases as mine. Those, who pre=
fer
> to keep the current behaviour just won't use it.
>=20
> If someone could guide me through the code, I could modify it perhaps=
=2E

Maybe you could look at how the _use_log_author and
_add_author_from options work.  I've forgotten their existence
until now and I've never used them myself; but apparently
they're still there.

Unfortunately, if you have other users using git-svn;
it could be tricky to ensure they can see the same timestamps
you see...
