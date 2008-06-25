From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 13:50:06 -0700
Message-ID: <7v8wwtz1c1.fsf@gitster.siamese.dyndns.org>
References: <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
 <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com>
 <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net>
 <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu>
 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080625195003.GB15077@mit.edu>
 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
 <20080625203822.GA7827@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:51:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbxb-0001DO-Uo
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbYFYUu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYFYUu0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:50:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYFYUu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:50:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E24814DA8;
	Wed, 25 Jun 2008 16:50:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0DC454DA5; Wed, 25 Jun 2008 16:50:13 -0400 (EDT)
In-Reply-To: <20080625203822.GA7827@mit.edu> (Theodore Tso's message of "Wed,
 25 Jun 2008 16:38:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 552A5778-42F8-11DD-B6D2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86346>

Theodore Tso <tytso@mit.edu> writes:

> The one thing I would worry about is the potential ambiguity if you do
> something like "git checkout FOOBAR", and FOOBAR was both a branch
> name as well as a file name.  How should it be interpreted?  I'd argue
> the real problem was we conflated two distinct operations: "switching
> to a new branch", and "reverting a file" to the same name, checkout.

I just replied to Avery about that.  -- is always the way to disambiguate
between refs (that come before --) and paths (that come after --), not
limited to "git checkout" but with other commands such as "git log", "git
diff", etc.
