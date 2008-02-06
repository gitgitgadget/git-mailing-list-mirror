From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make tests independent of global config files
Date: Wed, 06 Feb 2008 01:14:18 -0800
Message-ID: <7vodau1m6t.fsf@gitster.siamese.dyndns.org>
References: <20080206083817.GA19710@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:15:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgMv-0006UA-A1
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760087AbYBFJO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760082AbYBFJO2
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:14:28 -0500
Received: from rune.pobox.com ([208.210.124.79]:59933 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760065AbYBFJO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:14:26 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 296D6193F34;
	Wed,  6 Feb 2008 04:14:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AA8CD193EB7;
	Wed,  6 Feb 2008 04:14:42 -0500 (EST)
In-Reply-To: <20080206083817.GA19710@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Feb 2008 03:38:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72778>

Jeff King <peff@peff.net> writes:

> We could go back to setting HOME to something bogus, but then we have no
> way to suppress the reading of /etc/gitconfig (the only way to do so, I
> think, is to set GIT_CONFIG).
>
> So I think we are stuck adding in some environment magic to suppress the
> reading of ETC_GITCONFIG, and doing something like:
>
> unset GIT_CONFIG
> GIT_ETC_CONFIG=$(pwd)/.git/nonexistant
> GIT_LOCAL_CONFIG=$(pwd)/.git/nonexistant
>
> Thoughts?

Instead how about "GIT_NO_ETC_CONFIG" when set _ignores_ /etc/gitconfig
altogether?

Then you do not have to make excuses like "eh, you can do this
more or less with local config but...".
