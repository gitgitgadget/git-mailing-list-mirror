From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 23:25:05 -0700
Message-ID: <7vskuv30e6.fsf@gitster.siamese.dyndns.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
 <alpine.DEB.1.00.0806271353350.9925@racer>
 <alpine.LNX.1.00.0806271149580.19665@iabervon.org>
 <7vvdzuo61b.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer>
 <7vwsk730mm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDCq8-0000Pl-7i
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 08:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbYF3GZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 02:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbYF3GZT
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 02:25:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbYF3GZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 02:25:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2993211783;
	Mon, 30 Jun 2008 02:25:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 750F511782; Mon, 30 Jun 2008 02:25:12 -0400 (EDT)
In-Reply-To: <7vwsk730mm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 29 Jun 2008 23:20:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4E649F84-466D-11DD-8705-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86881>

Junio C Hamano <gitster@pobox.com> writes:

> Honestly, GIT_CONFIG is purely for scripts like git-svn that muck with
> files that are in the config format to have a way to make sure that they
> access the file they intend to, and being able to use GIT_CONFIG to keep
> git programs from reading from $HOME/.gitconfig is primarily for giving
> our test scripts repeatable environment, nothing more.
>
> I think ignoring end-user GIT_CONFIG like this patch does, instead of
> doing random nonsense, would be a good bugfix for "git clone".

Of course, that would have downsides as well.  Now git-clone tests cannot
be sanely written without setting $HOME to somewhere stable; otherwise
they can be randomly affected by buggy $HOME/.gitconfig files the end user
may have.
