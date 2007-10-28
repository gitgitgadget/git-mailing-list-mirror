From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] push: use same rules as git-rev-parse to resolve refspecs
Date: Sun, 28 Oct 2007 00:28:40 -0700
Message-ID: <7vlk9nwvdj.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
	<11935038083369-git-send-email-prohaska@zib.de>
	<11935038084055-git-send-email-prohaska@zib.de>
	<11935038084130-git-send-email-prohaska@zib.de>
	<11935038083116-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2aA-0006YK-B5
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbXJ1H2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbXJ1H2q
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:28:46 -0400
Received: from rune.pobox.com ([208.210.124.79]:46211 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbXJ1H2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:28:45 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8C508151704;
	Sun, 28 Oct 2007 03:29:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D1AB0151703;
	Sun, 28 Oct 2007 03:29:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62531>

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
>
> Note, this breaks existing setups. For example "master" will no longer
> resolve to "origin/master".

It may "break" but I think it is a good change.
