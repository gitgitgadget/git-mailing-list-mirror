From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH] Support diff.autorefreshindex=true in `git-diff --quiet'
Date: Mon, 01 Sep 2008 03:50:29 -0700
Message-ID: <quack.20080901T0350.lthzlmsgmx6@roar.cs.berkeley.edu>
References: <quack.20080901T0129.lth8wuci80o@roar.cs.berkeley.edu>
	<7vskskw41j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:55:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka747-0004lQ-Gv
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYIAKua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbYIAKua
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:50:30 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:33437 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbYIAKu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:50:29 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 4AAFB34443; Mon,  1 Sep 2008 03:50:29 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7vskskw41j.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 01 Sep 2008 03\:31\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94572>

>>>>> On 2008-09-01 03:31 PDT, Junio C Hamano writes:

    Junio> Karl Chen <quarl@cs.berkeley.edu> writes:
    >> When diff.autorefreshindex is true, if a file has merely
    >> been 'touched' (mtime changed, but contents unchanged),
    >> then `git-diff --quiet' will now return 0 (indicating no
    >> change) instead of 1, and also silently refresh the index.

    Junio> My knee-jerk reaction is that I do not particularly
    Junio> like this, but I haven't thought things through.  What
    Junio> does --exit-code do with or without the configuration
    Junio> variable?

git diff --exit-code silently refreshes the index and returns 0,
as documented and as I expect.  So I further expect "git diff
--exit-code --quiet" to be have the same semantics as "git diff
--exit-code >/dev/null".

What don't you like about this?  Isn't this the point of
diff.autorefreshindex ?
