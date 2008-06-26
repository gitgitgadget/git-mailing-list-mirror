From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase interactive: usability issue
Date: Wed, 25 Jun 2008 20:32:04 -0700
Message-ID: <7vbq1ovpl7.fsf@gitster.siamese.dyndns.org>
References: <20080625233208.GE5737@dpotapov.dyndns.org>
 <alpine.DEB.1.00.0806260416410.4503@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 26 05:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBiF9-0001uW-9Y
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 05:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbYFZDcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 23:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbYFZDcX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 23:32:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYFZDcX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 23:32:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E695D7BE;
	Wed, 25 Jun 2008 23:32:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8FCE1D7BC; Wed, 25 Jun 2008 23:32:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806260416410.4503@eeepc-johanness> (Johannes
 Schindelin's message of "Thu, 26 Jun 2008 04:17:55 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A8A53B4-4330-11DD-A7DA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86388>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> NACK.
>
> You just broke the 'edit' command.

Really?  I thought it would be Ok for "edit" command.

The patch checks the presense of /amend and complains only if it does not
exist, while you create /amend when you respond to "edit" insn.

I was relunctant about the patch not because of "edit", but because I am
not convinced that it will _never_ make sense to be able to amend while
the sequence stops with a conflict (as the patch does not give us any way
to override this rather heavy-handed denial to continue).

I also was hoping that with enough hooks git-commit already calls, this
could have been experimented and implemented with hooks without touching C
layer at least initially, while people can convince themselves that the
approach is sane (i.e. it _never_ makes sense to do amend upon conflict).
