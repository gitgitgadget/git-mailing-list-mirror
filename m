From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 10:51:16 +0200
Message-ID: <20091019085116.GB2796@atjola.homenet>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mohit Aron <mohit.aron@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mznxc-0000SX-Ra
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbZJSIvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 04:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755885AbZJSIvP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:51:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:45206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755743AbZJSIvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:51:15 -0400
Received: (qmail invoked by alias); 19 Oct 2009 08:51:18 -0000
Received: from i59F5B861.versanet.de (EHLO atjola.homenet) [89.245.184.97]
  by mail.gmx.net (mp069) with SMTP; 19 Oct 2009 10:51:18 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/dV6UbnTbdC5qNuTNpGJfJ9GPUx+kG6Fku29h2vB
	hWVOd+qKJRYPUk
Content-Disposition: inline
In-Reply-To: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130681>

On 2009.10.19 01:32:24 -0700, Mohit Aron wrote:
> I'm setting up a shared repository and I'd like to prevent users from
> creating branches in it (they can of course create local branches in
> their own clone of this repository). How can I accomplish this ? I
> looked at 'git help config' and it seems I need something similar to
> the parameter receive.denyDeletes - this prevents deletion of
> branches.

You could write a pre-receive or update hook (depending on whether you
want the whole push to fail, or just the branch head creation, see
githooks(5)).

If a ref is created, the old value is 40 0 (just zeros, forty of them).
And if the refname starts with refs/heads/, then a branch head is being
created. And in that case, you could refuse the push.

Bj=F6rn
