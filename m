From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 04 Jan 2008 00:24:01 -0800
Message-ID: <7vejcym21q.fsf@gitster.siamese.dyndns.org>
References: <20080104081429.GA30635@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:24:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAhrI-0005Vq-TE
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYADIYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbYADIYS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:24:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbYADIYS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:24:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 304E94C8B;
	Fri,  4 Jan 2008 03:24:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 449604C8A;
	Fri,  4 Jan 2008 03:24:08 -0500 (EST)
In-Reply-To: <20080104081429.GA30635@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Jan 2008 03:14:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69556>

Jeff King <peff@peff.net> writes:

> I encountered some weirdness today with git-diff-{files,tree,index} and
> --color.  They parse the --color command line option, but do _not_ call
> git_config(git_diff_ui_config), so if the user has colors specified in
> the config, they are not used.

This is very deliberate.  ui_config is about the Porcelains.

> Ordinarily, I would say "nobody should use --color with diff-files". But
> we do, in git-add--interactive (see Wincent's 4af756f3).

The plumbing deliberately not calling ui_config does not have
anything to do with them supporting explicit --color options.
