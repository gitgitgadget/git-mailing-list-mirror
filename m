From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Sun, 30 Dec 2007 04:05:39 -0800
Message-ID: <7vd4so8k18.fsf@gitster.siamese.dyndns.org>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
	<8763yof9lg.fsf@gollum.intra.norang.ca>
	<Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<20071225044202.GO14735@spearce.org>
	<7v4pe5nt8m.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712291426500.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vodc99gpy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712301124510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<7v63yga20u.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712301201570.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vprwo8kzd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 13:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8wvp-0004rj-P0
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 13:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbXL3MFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 07:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbXL3MFu
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 07:05:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbXL3MFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 07:05:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2792561A2;
	Sun, 30 Dec 2007 07:05:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CD66C61A1;
	Sun, 30 Dec 2007 07:05:41 -0500 (EST)
In-Reply-To: <7vprwo8kzd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Dec 2007 03:45:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69356>

Junio C Hamano <gitster@pobox.com> writes:

> ...  Instead you were adding a newline regardless to the
> end of the first commit, but not doing so for the other ones.

To illustrate, this is what I get when trying to squash four
commits:

    # This is a combination of 4 commits.
    # The first commit's message is:

    Documentation/git-submodule.txt: typofix

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

    # This is the 2nd commit message:

    git-sh-setup: document git_editor() and get_author_ident_from_commit()

    These 2 functions were missing from the manpage.

    Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    # This is the 3rd commit message:

    "git pull --tags": error out with a better message.

    When "git pull --tags" is run without any other arguments, the
    ...

Notice that there is a gap before "# This is the 2nd commit" but
there isn't any gap before "# This is the 3rd commit"?

The patch under discussion happens to fix this inconsistency as
a side effect.
