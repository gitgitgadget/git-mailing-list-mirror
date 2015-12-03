From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/5] Split .git/config in multiple worktree setup
Date: Thu, 3 Dec 2015 08:15:05 +0200
Message-ID: <20151203061505.GA4314@wheezy.local>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 07:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4NAo-0004xA-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 07:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819AbbLCGPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2015 01:15:16 -0500
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:48881
	"EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758717AbbLCGPN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 01:15:13 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-07.prod.phx3.secureserver.net with 
	id ouF51r00A5B68XE01uFBlB; Wed, 02 Dec 2015 23:15:12 -0700
Content-Disposition: inline
In-Reply-To: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281945>

On Wed, Dec 02, 2015 at 08:13:41PM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> Let's restart this. From the last discussion [1], we need to make
> core.worktree per-worktree for submodules to work. We also need
> core.sparseCheckout per-worktree.

Thank you. It would be nice to have it, so that features
like submodules work fully.

Now there are extensions support, would it make sense to
mark repositories which use per-worktree config with an
extension? It could clearly separate 2.5-style
multi-worktree repositories (which might exist already
around) from the new format. The extension could be set by
'worktree add' while creating first worktree, for example.

> This series adds a pattern list, with .gitignore syntax mostly, that
> split config var set into two sets, the per-worktree set will be
> stored in .git/worktrees/*/config.worktree instead. The pattern list
> consists of default patterns, built in git binary, and user ones in
> .git/info/config.worktree.

Using builtin defaults might be confusing for users -
editing the info/config.worktree they must keep in mind the
list of defaults (which they seem to don't know). Also, if
anybody wants to extend the default list (like myself, for
submodules), should they edit the info/config.worktree in
provided template of extend the builtin list? What was wrong
with the default in template?

--=20
Max
