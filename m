From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Illustration PATCH] add -i: accept single-keypress input
Date: Tue, 03 Feb 2009 01:05:49 -0800
Message-ID: <7vbptjdh5e.fsf@gitster.siamese.dyndns.org>
References: <20090203062437.GB21367@sigill.intra.peff.net>
 <1233651248-26717-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Suraj Kurapati <sunaku@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 03 10:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUHFl-0006zi-2B
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 10:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbZBCJGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 04:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZBCJGG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 04:06:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbZBCJGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 04:06:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D2B8B95219;
	Tue,  3 Feb 2009 04:06:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6111C95216; Tue,
  3 Feb 2009 04:05:57 -0500 (EST)
In-Reply-To: <1233651248-26717-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Tue, 3 Feb 2009 09:54:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E1B85400-F1D1-11DD-ABAF-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108168>

Thomas Rast <trast@student.ethz.ch> writes:

> Demonstrate how to add Term::ReadKey functionality to the main add -i
> prompt function list_and_choose().
>
> Not really great because if several input choices share a common first
> character, it prompts for the _rest_ of the line, meaning the choice
> of the first character cannot be undone again.

Hmm, you could trigger the action immediately after seeing _enough_ number
of characters to disambiguate instead of stop-and-prompt, I guess?  That
way, you would get a single-key merely as a degenerate case when the
choices are all distinct.
