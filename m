From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] Build in merge
Date: Tue, 01 Jul 2008 16:55:21 -0700
Message-ID: <7v63rpkvme.fsf@gitster.siamese.dyndns.org>
References: <0cde1e7c930589364318b2d0344b345453e23586.1214918017.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 01:57:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDpig-0001Jj-3a
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 01:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609AbYGAXzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 19:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbYGAXzw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 19:55:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757093AbYGAXzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 19:55:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EEF1726751;
	Tue,  1 Jul 2008 19:55:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1D57626750; Tue,  1 Jul 2008 19:55:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 308EF06A-47C9-11DD-A3ED-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87070>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> Interdiff: git diff 01a7dae..7709df7
>
> Individual commits (there is only one change this time): git log 7709df7
>
> Ah and please don't forget to apply the testsuite fix I sent in
> $gmane/86981. (Or is it easier if I resend the whole series?)

Are you sure about that?  I've been deliberately fixing that patch.

As far as I understand it, your series:

 - starts out building infrastructure;
 - adds tests;
 - finally replaces git-merge with the new implementation.

and the test in question comes when git-merge built from that version is
still the scripted version with limitation.

So if you build and test after applying individual steps (you sure do
that, don't you?), the test has to start with expecting failure (from the
scripted git-merge that has the octopus limitation) and then later changed
to expect success when git-merge is replaced.

Have you looked at the series I fixed up before pushing out in 'pu' last
night, specifically 5948e2a and 01a7dae?  If you actually built and tested
5948e2a, you'd notice that the test in that commit *must* expect failure.
