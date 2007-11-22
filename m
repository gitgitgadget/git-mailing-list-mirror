From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Wed, 21 Nov 2007 16:18:57 -0800
Message-ID: <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
	<1195648601-21736-2-git-send-email-win@wincent.com>
	<1195648601-21736-3-git-send-email-win@wincent.com>
	<20071121152118.GG24108@sigill.intra.peff.net>
	<7vejejfi28.fsf@gitster.siamese.dyndns.org>
	<C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 01:19:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuzmv-0000Gd-R6
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 01:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbXKVATG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbXKVATG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:19:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56251 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbXKVATF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:19:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B023D2EF;
	Wed, 21 Nov 2007 19:19:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 35AD39859B;
	Wed, 21 Nov 2007 19:19:21 -0500 (EST)
In-Reply-To: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> (Wincent
	Colaiuta's message of "Wed, 21 Nov 2007 23:44:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65721>

Wincent Colaiuta <win@wincent.com> writes:

> - Junio, do you mean to suggest with your comment that when passing
> untracked files either directly or indirectly (ie. when passing a dir
> containing untracked files) that they should be added (ie. invoked the
> "add untracked" subcommand) in addition to running the "patch"
> subcommand on the changed files?

What I meant was that if "git add -i" (unrestricted) shows paths
from a set A, "git add -i paths..." should show paths from a
subset of the set A and that subset should be defined with the
existing ls-files pathspec semantics.

For example, if "(a)dd untracked" subcommand shows all untracked
files when "add -i" was invoked without paths limitation, the
restricted form "add -i paths..." would show only untracked paths
that match the given set of patterns.  If "(p)atch" subcommand
shows all modified tracked files when "add -i" was invoked
without paths limitation, the restricted form "add -i paths..."
would show only such modified tracked files whose names match
the given set of patterns.
