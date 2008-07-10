From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revisions: refactor handle_revision_opt into
 parse_revision_opt.
Date: Thu, 10 Jul 2008 00:36:34 -0700
Message-ID: <7vfxqiqjgd.fsf@gitster.siamese.dyndns.org>
References: <1215639514-1612-1-git-send-email-madcoder@debian.org>
 <1215639514-1612-2-git-send-email-madcoder@debian.org>
 <20080710071418.GD3195@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:37:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqiu-0003IL-TR
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYGJHgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbYGJHgz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:36:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbYGJHgz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:36:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AD13C24E52;
	Thu, 10 Jul 2008 03:36:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D535E24E51; Thu, 10 Jul 2008 03:36:46 -0400 (EDT)
In-Reply-To: <20080710071418.GD3195@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Jul 2008 03:14:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7675E72-4E52-11DD-AB93-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87953>

Jeff King <peff@peff.net> writes:

> but it also seems like the top bit of that for loop is boilerplate, too:
>
>>  	for (;;) {
>>  		switch (parse_options_step(&ctx, options, shortlog_usage)) {
>>  		case PARSE_OPT_HELP:
>>  			exit(129);
>>  		case PARSE_OPT_DONE:
>>  			goto parse_done;
>>  		}

Another thing we should be able to refactor is the option help formatter.
Cf. 071438a (Teach git-merge -X<option> again., 2008-07-09)
