From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] rebase: do not fail silently when the HEAD could not
	be detached
Date: Sun, 8 Feb 2009 00:35:24 +0100
Message-ID: <20090207233524.GD11623@atjola.homenet>
References: <cover.1234027102u.git.johannes.schindelin@gmx.de> <679be9321b4cf4f694917cb9eebba70376a43a0a.1234027102u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 00:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVwjT-0004TS-Ge
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 00:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbZBGXfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbZBGXfj
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 18:35:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:42260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753791AbZBGXfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 18:35:39 -0500
Received: (qmail invoked by alias); 07 Feb 2009 23:35:37 -0000
Received: from i577B935D.versanet.de (EHLO atjola.local) [87.123.147.93]
  by mail.gmx.net (mp067) with SMTP; 08 Feb 2009 00:35:37 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19NzAFi/LNNmAwuU4n8wgPVnVux3uBmarEDN2mHnr
	+bkllVh7f0ryca
Content-Disposition: inline
In-Reply-To: <679be9321b4cf4f694917cb9eebba70376a43a0a.1234027102u.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108901>

On 2009.02.07 18:20:09 +0100, Johannes Schindelin wrote:
> Since 6fd2f5e(rebase: operate on a detached HEAD), rebase operates on=
 a
> detached HEAD.  However, it used "checkout -q" to detach the HEAD, wh=
ich
> hid an error message when, say, an untracked file would have to be
> overwritten to detach the HEAD.

Hm, in 324c2c317 "git-rebase: report checkout failure", that was
switched from a stdout/stderr redirect to -q, so that those error
messages are shown. And with a quick test, rebase/checkout complains
just fine:

doener@atjola:g (master) $ git checkout -q bar
error: Untracked working tree file 'file' would be overwritten by merge=
=2E
doener@atjola:g (master) $ git rebase bar
=46irst, rewinding head to replay your work on top of it...
error: Untracked working tree file 'file' would be overwritten by merge=
=2E
could not detach HEAD

doener@atjola:g (master) $ git --version=20
git version 1.6.2.rc0

Same with next and pu.

Bj=F6rn
