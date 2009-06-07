From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] add a test for git-send-email for threaded mails without chain-reply-to
Date: Sun, 07 Jun 2009 16:28:33 -0700
Message-ID: <7v7hznaaji.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-3-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 01:29:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDRnw-0000NS-UN
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 01:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbZFGX2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 19:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbZFGX2c
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 19:28:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34903 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbZFGX2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 19:28:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090607232833.KYRH25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jun 2009 19:28:33 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1BUZ1c00Q4aMwMQ03BUZvH; Sun, 07 Jun 2009 19:28:34 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=_6l4x9DqFpAA:10 a=FbKS86_9VuwA:10
 a=A1X0JdhQAAAA:8 a=Zf9CqPgyr4rt7w9_WtYA:9 a=sd0oS9pjFTe4yz62nzJ6LANWGoMA:4
 a=XTUYKXyG0EEA:10 a=5KVauyKsRKMA:10 a=Y6qChIQXU1wA:10
X-CM-Score: 0.00
In-Reply-To: <1244410857-920-3-git-send-email-markus.heidelberg@web.de> (Markus Heidelberg's message of "Sun\,  7 Jun 2009 23\:40\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121021>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> +test_expect_failure 'threading but no chain-reply-to' '
> +	git send-email \
> +		--dry-run \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		--thread \
> +		--nochain-reply-to \
> +		$patches $patches |
> +	grep "In-Reply-To: "
> +'

Thanks, but this is not a very good style, as it won't catch if "git
send-email" dumps core or otherwise fails, exiting with a non-zero status.

Same comments applies to [PATCH 4/6] as well.
