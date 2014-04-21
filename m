From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] remote-helpers: graduate
Date: Mon, 21 Apr 2014 11:06:39 -0700
Message-ID: <xmqqbnvua768.fsf@gitster.dls.corp.google.com>
References: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 20:06:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcIcC-0004yt-Sj
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 20:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbaDUSGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 14:06:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbaDUSGn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 14:06:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98DA07DC27;
	Mon, 21 Apr 2014 14:06:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=URAD3vU8KYuRy7jqL2SCTDLsywY=; b=JBWg3+
	7aLy6yMROPmWHe5N6VmQf1iY/F9QEoGAdB4uIy2TVa0DtnOzfBgQ2DGHEzJEYNyu
	r4wcLfi+nqibaoaEilxiTbclM3CY81rAtiZpz6mekQwAcjUZVbhd0T0ZzbcUtvq8
	QWZbikVRzwRqQRGNYI5wYcoqV8YeqZs0DDgc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jE9Q7b6y/snNHtzmzsi0Z0/LriFSyOeu
	aMDFbfRfinXi8iVMKcOfqjQdJ52P+fJICqpfD4rA06HudE4WXPUvJuQVnNSqPFkn
	7+WmdsOgWojF7XcsOQF1Rm3ZuGNlIgir3VBgfiSiQOgdAFgK25g3g2xf2IS/LgBi
	6/VWbiTpfEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 814B67DC26;
	Mon, 21 Apr 2014 14:06:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB9327DC21;
	Mon, 21 Apr 2014 14:06:40 -0400 (EDT)
In-Reply-To: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 20 Apr 2014 16:39:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B06E6B42-C97F-11E3-A860-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246614>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There doesn't seem to be any reason to keep these remote-helpers in the contrib
> area.

Yay.

I wouldn't phrase it "doesn't seem to be any reason", though.  The
decision to include is not done due to lack of negatives, but
because adding them would be useful.

And I think for these two, it holds true---people seem to have been
experimenting with them and getting good results with occasional bug
reports that are addressed in a reasonable promptness.

Will queue.


> Felipe Contreras (2):
>   remote-helpers: move out of contrib
>   remote-helpers: move tests out of contrib
>
>  .gitignore                                                 |  2 ++
>  Makefile                                                   |  2 ++
>  contrib/remote-helpers/Makefile                            | 14 --------------
>  contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py |  0
>  contrib/remote-helpers/git-remote-hg => git-remote-hg.py   |  0
>  t/Makefile                                                 |  8 +++++++-
>  .../remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t   |  4 ++--
>  .../test-hg-bidi.sh => t/remote-helpers/hg-bidi.t          |  4 ++--
>  .../test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t      |  6 +++---
>  contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t |  4 ++--
>  10 files changed, 20 insertions(+), 24 deletions(-)
>  delete mode 100644 contrib/remote-helpers/Makefile
>  rename contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py (100%)
>  rename contrib/remote-helpers/git-remote-hg => git-remote-hg.py (100%)
>  rename contrib/remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t (98%)
>  rename contrib/remote-helpers/test-hg-bidi.sh => t/remote-helpers/hg-bidi.t (97%)
>  rename contrib/remote-helpers/test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t (98%)
>  rename contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t (99%)
