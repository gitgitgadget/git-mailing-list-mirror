From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include a git-push example for creating a remote branch
Date: Wed, 05 Sep 2007 23:30:31 -0700
Message-ID: <7v8x7ke260.fsf@gitster.siamese.dyndns.org>
References: <20070906044408.GA588@spearce.org>
	<buoodggo0l2.fsf@dhapc248.dev.necel.com>
	<20070906050127.GS18160@spearce.org>
	<fc339e4a0709052257m4ddc5784obe64a8b75b79b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Miles Bader" <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAt1-000510-UU
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbXIFGaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbXIFGaj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:30:39 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbXIFGai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 02:30:38 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 42A6312F1A3;
	Thu,  6 Sep 2007 02:30:55 -0400 (EDT)
In-Reply-To: <fc339e4a0709052257m4ddc5784obe64a8b75b79b19@mail.gmail.com>
	(Miles Bader's message of "Thu, 6 Sep 2007 14:57:26 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57833>

"Miles Bader" <miles@gnu.org> writes:

> Maybe I"m weird, but I tend to think of the refs/... syntax as being
> for "only if you're doing something funny" cases.

The "refs/" syntax is there as the lowest level that is
universally usable to create and any ref.  It can be used to
push to branches, tags, or even remotes (aka "simulated fetch in
reverse").

It is just nobody felt strong enough reason to sugarcoat the
normalized syntax with something like:

	git push --create remote foo v1.2.0

You can be a hero by updating git-push to take such, and make it
interpret as if the user passed the normalized syntax which is:

	git push remote foo:refs/heads/foo v1.2.0:refs/tags/v1.2.0
