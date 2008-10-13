From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git/spearce.git (Oct 2008, #02; Sun, 12)
Date: Mon, 13 Oct 2008 07:25:49 -0700
Message-ID: <7vhc7gbmhe.fsf@gitster.siamese.dyndns.org>
References: <20081012212543.GG4856@spearce.org>
 <20081013013752.8fc16695.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 16:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpOOf-0004kU-37
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 16:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbYJMO0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 10:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757219AbYJMO0C
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 10:26:02 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202AbYJMO0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 10:26:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E7F28995A;
	Mon, 13 Oct 2008 10:25:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 05A9A89955; Mon, 13 Oct 2008 10:25:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB39AF04-9932-11DD-BAFE-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98115>

Stephen Haberman <stephen@exigencecorp.com> writes:

> (I also have a test comment typo and test_expect_failure change to make
> to rebase-i-p from Junio's feedback and would like to know the
> preferred way to submit those--e.g. a patch on top of your pu, a patch
> on top of the existing series, or a new series all together. Given it
> is not next, I'm guessing a new series all together.)

You guessed it right.

As sh/maint-rebase3 is about a pure fix, while the other -i-p is a more
involved enhancement, I am guessing Shawn decided not to queue the latter
for 1.6.0.X, and I agree with that.  The final shape of the history should
look like:

 * maint will eventually get sh/maint-rebase3 to be in 1.6.0.X, which in
   turn will eventually be merged to master;

 * master will eventually get sh/rebase-i-p.

When two series have dependencies like this, it is generally the easiest
and cleanest to prepare them to match such a final shape of the history.
Hence, we would want two series built like this:

 * sh/maint-rebase3 applicable to the tip of 'maint' (this is already done;
   what is in sh/maint-rebase3 is exactly that);

 * apply the above locally to 'maint', merge the result locally to
   'master', and prepare sh/rebase-i-p series applicable on top of that
   merge.

Thanks.
