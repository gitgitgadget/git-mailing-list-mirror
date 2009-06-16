From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/4] submodule, repack: migrate to git-sh-setup's say()
Date: Mon, 15 Jun 2009 23:18:37 -0700
Message-ID: <7v3aa0g0qq.fsf@alter.siamese.dyndns.org>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
	<1245117905-19351-2-git-send-email-bebarino@gmail.com>
	<1245117905-19351-3-git-send-email-bebarino@gmail.com>
	<1245117905-19351-4-git-send-email-bebarino@gmail.com>
	<7viqiwg1rl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Adam <thomas.adam22@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 08:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGS0Q-0006ZE-9Z
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 08:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757794AbZFPGSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 02:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756470AbZFPGSf
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 02:18:35 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41914 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbZFPGSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 02:18:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616061837.FZSW18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 16 Jun 2009 02:18:37 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4WJd1c0024aMwMQ04WJdd9; Tue, 16 Jun 2009 02:18:37 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=H7danD3z24sA:10 a=ybZZDoGAAAAA:8
 a=jwwKN2mw9110mS-KmYwA:9 a=DqABpJhalrFHHLj9LdnZK_nRZTQA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7viqiwg1rl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 15 Jun 2009 22\:56\:30 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121658>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> If the convention is "GIT_QUIET, when set to non-empty string, squelches
> the output", then I think the callers should be more consistent and the
> call to prune-packed should say something like this, which is admittedly a
> roundabout way:
>
> 	git prune-packed ${GIT_QUIET:+-q}
>
> for consistency (and then what you set to GIT_QUIET in the first hunk I
> quoted does not matter anymore---it can even be t or 1 or whatever).
>
> I think this does not matter too much, because I suspect that in the
> longer term scripted Porcelains are going away, but still...

What I meant was that my _style_ comment does not matter too much.  The
addition of "quiet" _is_ a worthwhile thing to do, I think.
