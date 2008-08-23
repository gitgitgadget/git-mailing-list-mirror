From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 11:21:39 +0200
Message-ID: <200808231121.41694.jnareb@gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org> <m37ia8sv49.fsf@localhost.localdomain> <20080823071552.GU23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 11:22:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWpKf-0001D2-Qy
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 11:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbYHWJVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 05:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbYHWJVu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 05:21:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:25878 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbYHWJVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 05:21:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so388481nfc.21
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4mlUUjv+UgPThdufLmZqGos8SASJoi4jtYKtfg75SUQ=;
        b=OKbVILKVXC6lnvu+NHcAk/rACNmTAFNqTGgmo7PRhhGr1hFBXu+eYk+xSFXoH6Hap7
         7y16peifTdf5D/9zb1fEe3voIcpoVUJWfUoCeDqben9W3YaUlmVDKtw4eq0DUqVekgjG
         iSRFg5NxJZCTY11awSjnaULFDvpBsWlQ2LOQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W2NNqPK6ijVF4vuLLegAgcw69n3TGMvSaew0uKQriXuwEC/hJUZmMMgrJiGAV9u605
         ARb7vnJgV74+S1b9umQZa09KIjDCxbBgAPKI9ZM4mpSIJpjhmHokhlCOX7w0wH3D4pBY
         /kSQrNDDto8aU1WbDLYj9gFBY7ej5/UjQ9cDs=
Received: by 10.210.129.19 with SMTP id b19mr2944260ebd.162.1219483307379;
        Sat, 23 Aug 2008 02:21:47 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.219.20])
        by mx.google.com with ESMTPS id 3sm2520180eyj.3.2008.08.23.02.21.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 02:21:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080823071552.GU23334@one.firstfloor.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93450>

Andi Kleen wrote:
> Jakub Nar=EAbski wrote:
> >=20
> > BTW. it is stated countless time in documentation that published
> > history should be not rebased, barring some extenuating
> > circumstances=20
>=20
> Yes and people countless times ignore that recommendation and do=20
> it anyways (for good reasons).  And then other users=20
> have to deal with these rebased trees somehow.

If you are thinking about 'linux-next', it is exception rather than
the rule.

Besides, Git is feature rich and allows many different workflows, so
you should _always_ read the Development/Contributing document for
specific project, if it exists.  (See also explanation below on=20
different workflows).=20

> Anyways it is all solvable but right now ill supported
> in standard commands and the documentation does not really
> cover it. I was just asking (mostly for others to avoid
> going through the same pain as me) for that to be improved
> so that git becomes easier to use.
>=20
> Sadly you guys don't even seem to want to recognize there
> is a problem :-(=20

=46irst, there isn't just _one_ way to deal with non fast-forward=20
(rebased) branch; there are many possible workflow wrt rebasing.

There can be something like 'pu' (proposed updates) branch in git=20
repository, which is basically read-only, rebuild from scratch merging=20
branch gathering topic branches which are not ready yet for 'next'
(for development branch), like work in progress and the like.  It is=20
here to be able to view/examine those topic branches, without crowding=20
public branch namespace.  In short: it is only to view.
Workflow:
  $ git fetch origin   OR   git remote update

Then there is something like 'linux-next' tree, which is also rebuild=20
from scratch, and as far as I understand serves as gathering point for=20
different patches being prepared to enter Linux, and to resolve=20
conflicts early.  It is, if I understand correctly, to check if it=20
compiles and doesn't have bugs, and to test merging your work; _not_
to base your own work on.
Workflow:
  $ git fetch origin   OR   git remote update
  $ git checkout origin/master  # detaches HEAD / not on any branch

=46inally (or not: perhaps there are yet different workflows involving
history rewriting) there are projects which use rebase based workflow.
The information about it should be on project homepage (or wiki).
Workflow:
  $ git pull --rebase  # or configure it: branch.autosetuprebase etc.


Second, this is open source. If you feel that documentation needs=20
improvement, now that you have all this information, you can simply=20
send patch either to manpages, or to Git User's Manual.  Trolling won't=
=20
work ;-P
--=20
Jakub Narebski
Poland
