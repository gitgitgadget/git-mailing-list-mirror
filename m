From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just
 a branch
Date: Tue, 13 Oct 2009 03:03:31 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910130250270.5105@dr-wily.mit.edu>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vr5t8coex.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0910121708030.5105@dr-wily.mit.edu> <7vaazw6uyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxbRu-0003oz-TM
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563AbZJMHEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 03:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933561AbZJMHEN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:04:13 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:59874 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933533AbZJMHEL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:04:11 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9D73SwJ005509;
	Tue, 13 Oct 2009 03:03:28 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9D73V2r022581;
	Tue, 13 Oct 2009 03:03:32 -0400 (EDT)
In-Reply-To: <7vaazw6uyi.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130134>

On Mon, 12 Oct 2009, Junio C Hamano wrote:
> But I do not know how it hurts to still have bisect states around, in
> order to find where you want to go next.  Could you elaborate?

Mostly little irritations.  Extra bisect/* refs show up in gitk.  If yo=
u=20
use __git_ps1 in your prompt (from git-completion.bash), it adds=20
|BISECTING to your prompt.

Also, I just noticed that if you start a new bisection without ever=20
cleaning up the old one, the next =E2=80=98git bisect reset=E2=80=99 wi=
ll bring you back=20
to HEAD before the old bisection instead of HEAD before the new one, wh=
ich=20
is not what you would expect if you forgot that the old bisection ever=20
happened.

> I am inclined to ask you to come up with a paragraph in the=20
> documentation to discuss how the optional <branch> (now it will be=20
> <commit>) parameter to the reset subcommand is meant to be used and=20
> re-submit the original patch, perhaps with an updated commit log=20
> message.

I note that the =E2=80=98git checkout=E2=80=99 documentation mentions <=
branch> and not=20
<commit>, perhaps to emphasize that HEAD will become attached to the=20
branch if you specify a branch name.  Do you think it makes sense for=20
these to be documented differently?

Anders
