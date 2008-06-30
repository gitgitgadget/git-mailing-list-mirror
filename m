From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 23:44:22 -0700
Message-ID: <7vod5j2zi1.fsf@gitster.siamese.dyndns.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
 <alpine.DEB.1.00.0806271353350.9925@racer>
 <alpine.LNX.1.00.0806271149580.19665@iabervon.org>
 <7vvdzuo61b.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer>
 <7vwsk730mm.fsf@gitster.siamese.dyndns.org>
 <7vskuv30e6.fsf@gitster.siamese.dyndns.org>
 <20080630064031.GA30600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDD8p-000424-Sq
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 08:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbYF3Gok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 02:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbYF3Goj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 02:44:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYF3Goj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 02:44:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 654BA11E4D;
	Mon, 30 Jun 2008 02:44:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 99C8111E44; Mon, 30 Jun 2008 02:44:29 -0400 (EDT)
In-Reply-To: <20080630064031.GA30600@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 30 Jun 2008 02:40:32 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01F3E274-4670-11DD-9E56-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86884>

Jeff King <peff@peff.net> writes:

>> Of course, that would have downsides as well.  Now git-clone tests cannot
>> be sanely written without setting $HOME to somewhere stable; otherwise
>> they can be randomly affected by buggy $HOME/.gitconfig files the end user
>> may have.
>
> I thought we went through all of this before, and it led to 8bfa6bd6.
> The test scripts set GIT_CONFIG_NOSYSTEM and GIT_CONFIG_NOGLOBAL to
> achieve the same suppression effect.

Ah, thanks.  Actually I was scratching my head trying to figure out why it
does not break after I wrote the above ;-)
