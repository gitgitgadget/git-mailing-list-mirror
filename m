From: Alex Scarborough <alex@gameclay.com>
Subject: Re: [PATCH] rebase -p: Preserve fast-forwardable merges
Date: Mon, 25 Jan 2010 10:53:06 -0800
Message-ID: <dd10f5481001251053x2ac9fa62r57a46f1231e36560@mail.gmail.com>
References: <dd10f5481001222329i58e7b709m2c547c74161b6771@mail.gmail.com>
	 <alpine.DEB.1.00.1001251508400.8733@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Alex Scarborough <alex@gameclay.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:53:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZU3k-0004rI-Ox
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 19:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab0AYSxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 13:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855Ab0AYSxH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 13:53:07 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33596 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab0AYSxH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 13:53:07 -0500
Received: by yxe17 with SMTP id 17so3006250yxe.33
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 10:53:06 -0800 (PST)
Received: by 10.151.29.8 with SMTP id g8mr9030717ybj.250.1264445586354; Mon, 
	25 Jan 2010 10:53:06 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001251508400.8733@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137978>

On Mon, Jan 25, 2010, Johannes Schindelin wrote:
> On Fri, 22 Jan 2010, Alex Scarborough wrote:
>
> > Previously, rebase -p would not preserve a merge commit if the merg=
e
> > could be resolved as a fast-forward. =C2=A0rebase -p now passes --n=
o-ff to
> > git merge when recreating a merge commit, which ensures that merge
> > commits created with git merge --no-ff are preserved.
>
> For my use case (well, it used to be my use case), namely keeping a n=
umber
> of topic branches on top of an upstream up-to-date, this is not the
> desired action. =C2=A0In my use case, merged topic branches should ju=
st vanish,
> and not even leave a merge commit.

I see.  In that use case this patch would be rather irritating :)

What do you think of adding a --no-ff option to git rebase which, when =
used
with -p, will recreate merge commits even if they could be resolved as =
a
fast-forward?  That would leave your use case unchanged while giving my
use case a way out, so to speak.

Either way, I suggest we change the documentation for rebase -p to stat=
e
that it does not preserve merge commits that can be fast-forwarded afte=
r
rebasing.

If it sounds good, I should be able to roll some patches by the end of =
the
week.

-Alex Scarborough
