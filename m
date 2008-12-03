From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 1/2] gitweb: add patch view
Date: Wed, 03 Dec 2008 03:19:09 -0800
Message-ID: <7vbpvtecb6.fsf@gitster.siamese.dyndns.org>
References: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1228298862-28191-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 12:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7pmy-0000aZ-3H
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 12:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYLCLTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 06:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYLCLTm
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 06:19:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYLCLTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 06:19:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C86FB83DB2;
	Wed,  3 Dec 2008 06:19:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1AC5583D70; Wed,
  3 Dec 2008 06:19:10 -0500 (EST)
In-Reply-To: <1228298862-28191-2-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Wed, 3 Dec 2008 11:07:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4698025C-C12C-11DD-A0F8-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102241>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> We thus create a new view that can be fed to git-am directly by exposing
> the output of git format-patch directly. This allows patch exchange and
> submission via gitweb. A hard limit (configurable, defaults to 100) is
> imposed on the number of commits which will be included in a patchset,
> to prevent DoS attacks on the server.

Hmm, I would imagine that "snapshot" would be a much more effective way to
do such an attack, and notice the way we prevent it is to selectively
enable the feature per repository.

Perhaps this configuration should also be a feature defined in %feature,
overridable by each repository?  If you default it to "disabled" (as any
new feature typically does), you do not have to yank a random number such
as 100 out of thin air.
