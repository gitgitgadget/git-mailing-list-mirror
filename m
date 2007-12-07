From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-help: add -w|--web option to display html man page in a browser.
Date: Thu, 06 Dec 2007 23:05:01 -0800
Message-ID: <7vfxyf7zoi.fsf@gitster.siamese.dyndns.org>
References: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org>
	<7v3aufeowe.fsf@gitster.siamese.dyndns.org>
	<200712070635.18018.chriscool@tuxfamily.org>
	<7v1w9z9h2k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 08:06:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0XHT-0004hy-7Z
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 08:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbXLGHFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 02:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbXLGHF3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 02:05:29 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:39795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbXLGHF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 02:05:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 203772A9E;
	Fri,  7 Dec 2007 02:05:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B1272A9D;
	Fri,  7 Dec 2007 02:05:05 -0500 (EST)
In-Reply-To: <7v1w9z9h2k.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 06 Dec 2007 22:04:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67388>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
> ...
>>> > +init_browser_path() {
>>> > +	browser_path=`git config browser.$1.path`
>>> > +	test -z "$browser_path" && browser_path=$1
>>> > +}
>>>
>>> Please do not contaminate the config file with something the user can
>>> easily use a lot more standardized way (iow $PATH) to configure to his
>>> taste.
>>>
>>> I'd suggest dropping this bit.

Well, I changed my mind.  It is a bit funny to have both firefox and
iceweasel as "valid-tool", but if we consider $browser to define the
external interface and $browser_path to define the implementation, it
sort of makes sense to have that configuration.  browser_path could be
iceweasel for browser firefox.

I'll squash the patch to update the one from the last round (as the last
two patches are not yet accepted in 'next' yet), remove the html
documentation path fallback, but will leave this part in.

browser.*.path and web.browser configuration need to be documented, if
not already, though.
