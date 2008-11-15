From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Fri, 14 Nov 2008 21:35:08 -0800
Message-ID: <7vy6zl7drn.fsf@gitster.siamese.dyndns.org>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org>
 <1226580075-29289-2-git-send-email-charles@hashpling.org>
 <1226580075-29289-3-git-send-email-charles@hashpling.org>
 <1226580075-29289-4-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 06:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Dqc-0008LP-K6
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 06:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbYKOFgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 00:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbYKOFgO
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 00:36:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYKOFgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 00:36:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8429E16B7F;
	Sat, 15 Nov 2008 00:35:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6763116B79; Sat, 15 Nov 2008 00:35:10 -0500 (EST)
In-Reply-To: <1226580075-29289-4-git-send-email-charles@hashpling.org>
 (Charles Bailey's message of "Thu, 13 Nov 2008 12:41:15 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44B071B2-B2D7-11DD-A71D-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101046>

Charles Bailey <charles@hashpling.org> writes:

> This option stops git mergetool from aborting at the first failed merge.
> This allows some additional use patterns. Merge conflicts can now be
> previewed one at time and merges can also be skipped so that they can be
> performed in a later pass.

Hmm, with this command line:

> -'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>]...

I wonder why this even needs to be an option.  If you do not want to
resolve all of them, you can limit the amount of work you would do by
giving list of paths to work on, can't you?
