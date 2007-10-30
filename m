From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/10] push: use same rules as git-rev-parse to resolve refspecs
Date: Tue, 30 Oct 2007 01:28:55 -0700
Message-ID: <7v3avtngzc.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935812741-git-send-email-prohaska@zib.de>
	<1193593581114-git-send-email-prohaska@zib.de>
	<1193593581486-git-send-email-prohaska@zib.de>
	<11935935812185-git-send-email-prohaska@zib.de>
	<11935935822846-git-send-email-prohaska@zib.de>
	<11935935821136-git-send-email-prohaska@zib.de>
	<11935935823045-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImmTT-0001VR-Vk
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbXJ3I3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbXJ3I3E
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:29:04 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:45549 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbXJ3I3C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:29:02 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9D9622FA;
	Tue, 30 Oct 2007 04:29:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D85CB8F2BC;
	Tue, 30 Oct 2007 04:29:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steffen Prohaska <prohaska@zib.de> writes:

> This commit changes the rules for resolving refspecs to match the
> rules for resolving refs in rev-parse. git-rev-parse uses clear rules
> to resolve a short ref to its full name, which are well documented.
> The rules for resolving refspecs documented in git-send-pack were
> less strict and harder to understand. This commit replaces them by
> the rules of git-rev-parse.
>
> The unified rules are easier to understand and better resolve ambiguous
> cases. You can now push from a repository containing several branches
> ending on the same short name.

As you introduced long names around 5/10 to have two different
ones for clarity with the goal of unifying them, so once you
unified the rules, it probably is a good idea to rename the long
"do_this_with_X_rule()" and "do_this_with_Y_rule()" functions
back to "do_this()", isn't it?
