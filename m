From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH] Support diff.autorefreshindex=true in `git-diff --quiet'
Date: Tue, 02 Sep 2008 10:39:47 -0700
Message-ID: <quack.20080902T1039.lthabeqmopo_-_@roar.cs.berkeley.edu>
References: <quack.20080901T0129.lth8wuci80o@roar.cs.berkeley.edu>
	<7vskskw41j.fsf@gitster.siamese.dyndns.org>
	<quack.20080901T0350.lthzlmsgmx6@roar.cs.berkeley.edu>
	<7vy72bnk5x.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaZsB-0006Bm-CQ
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 19:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbYIBRjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 13:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYIBRjw
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 13:39:52 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:57721 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbYIBRjv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 13:39:51 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 17E723446E; Tue,  2 Sep 2008 10:39:47 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7vy72bnk5x.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 01 Sep 2008 23\:20\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94682>

>>>>> On 2008-09-01 23:20 PDT, Junio C Hamano writes:

    Junio> Looking at your patch and thinking about the issue very
    Junio> much tempt me to suggest the attached patch which is at
    Junio> the other extreme of the spectrum.

I think it is the extreme at the same end of the spectrum and I
like it.  (I was tempted to do this but thought there was a reason
those options were ignored by --quiet.)  This is good because it
makes --quiet do what one thinks it does, and what's documented,
with no exceptions (i.e. equivalent to --exit-code > /dev/null).

If anyone actually used the old behavior of ignoring
diff.autorefreshindex (as an optimization, because the script ran
update-index --refresh outside a loop), there could be a --quick
option, or they could use git-diff-files.
