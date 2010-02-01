From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Wishlist for branch management
Date: Mon, 1 Feb 2010 02:31:55 +0100
Message-ID: <20100201013155.GA11832@atjola.homenet>
References: <4B662BEF.7040503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 02:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbl9D-0004mQ-ES
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 02:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020Ab0BABcD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 20:32:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:54324 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754930Ab0BABcB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 20:32:01 -0500
Received: (qmail invoked by alias); 01 Feb 2010 01:31:59 -0000
Received: from i59F55F45.versanet.de (EHLO atjola.homenet) [89.245.95.69]
  by mail.gmx.net (mp028) with SMTP; 01 Feb 2010 02:31:59 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18lSyoXenEle8H2MSd+wDib57gxLMQOexZl3IjsTU
	1uVwRR0IvTb1mN
Content-Disposition: inline
In-Reply-To: <4B662BEF.7040503@zytor.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138571>

On 2010.01.31 17:18:39 -0800, H. Peter Anvin wrote:
> git branch --current
>=20
> ... list the current branch name, for use in scripts.  Equivalent to:
> 	"git branch | grep '^\*' | cut -c3-"

In scripts, plumbing should be used. I use:
	git rev-parse --symbolic-full-name HEAD

This gives either the full refname of the checked out branch head, e.g.
refs/heads/master, or HEAD in case of a detached HEAD.

> git push --current
>=20
> ... push the current branch, and only the current branch...

Unless you want to push to a different ref remotely, e.g. pushing
refs/heads/master-public to refs/heads/master, you can use:
	git push <remote> HEAD

=46or example, when refs/heads/master is checked out, then:
	git push origin HEAD
acts the same as:
	git push origin refs/heads/master

Bj=F6rn
