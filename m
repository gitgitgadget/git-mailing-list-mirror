From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 09 Dec 2009 14:30:06 +0100
Message-ID: <vpqiqcgp95t.fsf@bauges.imag.fr>
References: <20091208144740.GA30830@redhat.com>
	<7vfx7lcj18.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 14:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIMch-0006nG-8O
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 14:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbZLINaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 08:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755827AbZLINaT
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 08:30:19 -0500
Received: from mx1.imag.fr ([129.88.30.5]:45192 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826AbZLINaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 08:30:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nB9DRfsP027828
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Dec 2009 14:27:41 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NIMcI-0007Qg-UD; Wed, 09 Dec 2009 14:30:06 +0100
In-Reply-To: <7vfx7lcj18.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 08 Dec 2009 12\:22\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Dec 2009 14:27:41 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134967>

Junio C Hamano <gitster@pobox.com> writes:

> So perhaps a good way to move forward is to teach "git cherry-pick A..B"
> to be a thin wrapper that invokes a new hidden mode of operation added to
> "rebase" that is not advertised to the end user.
>
> I would suggest calling the option to invoke that hidden mode not
> "--revisions", but "--reverse" or "--opposite" or something of that
> nature, though.  It makes "rebase" work in different direction.

Intuitively,

  git rebase --reverse A..B

would mean "take the range A..B, and start applying the patches from
B, going in reverse order up to A", like "git log --reverse". So, I'd
find it misleading.

Perhaps "git rebase --cherry-pick A..B" would be a better name. No
objection for --opposite either.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
