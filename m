From: Sergey Organov <sorganov@gmail.com>
Subject: Re: rebase flattens history when it shouldn't?
Date: Wed, 06 Aug 2014 19:34:55 +0400
Message-ID: <8738d91vj4.fsf@osv.gnss.ru>
References: <87k374xkpq.fsf@osv.gnss.ru> <20140723175218.GB12427@google.com>
	<8738drj2fc.fsf@osv.gnss.ru> <53E2452D.6000109@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:35:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF3F1-0000KR-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbaHFPe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:34:58 -0400
Received: from mail.javad.com ([54.86.164.124]:51919 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbaHFPe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:34:58 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id CF6826184E;
	Wed,  6 Aug 2014 15:34:56 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XF3Et-0002HC-4K; Wed, 06 Aug 2014 19:34:55 +0400
In-Reply-To: <53E2452D.6000109@ira.uka.de> (Holger Hellmuth's message of "Wed,
	06 Aug 2014 17:09:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254868>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> On 23.07.2014 21:33, Sergei Organov wrote:
>> What actually bothers me is the unfortunate consequence that "git pull"
>> is not always a no-op when nothing was changed at the origin since the
>> last "git pull". THIS is really surprising and probably should better be
>> fixed. Requiring -f is just one (obvious) way to fix this.
>
> That would invalidate the simple rule that "git pull" is equivalent to
> "git fetch" + "git rebase".

Sorry, I don't see how it would invalidate this. My suggestion even
won't change git-pull source code at all, only git-rebase code.

> git rebase depends on both branches it operates on, not just one. The
> same goes for "git merge", I assume it is just a coincidence that git
> merge does have this characteristic you now expect both to have.

git pull --reabse=false
git pull --rebase=preserve

both have this property.

git pull --rebase=true

almost always has this property, unless there are local merge commits to 
be rebased.

So, I'd rather say it's likely behavior of "git pull --rebase=true" that
is a coincidence.

-- 
Sergey.
