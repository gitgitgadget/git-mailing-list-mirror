From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] An alias that starts with "!!" runs in the current
 directory.
Date: Wed, 05 May 2010 16:43:47 -0700
Message-ID: <7vpr19j4ng.fsf@alter.siamese.dyndns.org>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
 <20100505005153.GC25390@coredump.intra.peff.net>
 <4BE115EF.8010306@viscovery.net>
 <20100505070131.GA11265@coredump.intra.peff.net>
 <19425.9169.537598.876589@winooski.ccs.neu.edu>
 <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
 <19425.54504.163875.379151@winooski.ccs.neu.edu>
 <19425.58290.42871.986460@winooski.ccs.neu.edu>
 <1273098179.723.10.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Barzilay <eli@barzilay.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Thu May 06 01:44:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9oGB-0005W0-HT
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 01:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab0EEXoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 19:44:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab0EEXoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 19:44:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C32B0DA7;
	Wed,  5 May 2010 19:44:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u8A5KBl0NRHXbPYnasi6/1KQn8c=; b=bB9irc
	zMwvEwYM/Cf8fi+DFlcb7VeX/GqgKrRCzmof5q80LZCbu46CNpElhTVb+E0u77De
	MWEqC0xSlU0abPgF0GvCs32nTWT1QKcCHS+3T2GyjWoneW+LoX6Tpi2bDQkuALRf
	QtnBdTBL6kGUpNayKRu/ePvB+6LAH7Eh9Sli0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhI5hsew45ZMPVW0naTTUtuQoIjXxaPC
	aLW3tk11fJ9fE0ccwuFVSXsg3kufw5dNWB2MiIQTycC8I1SMAmPk3xISLXIpTMIL
	saUTwJpW9cGDSnQZcvFFKH3lqNcO6n9tlDKM5ydpLG+3rLJukMDnC9ge1BJCV6Do
	3lJTxdQFAeA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76653B0DA5;
	Wed,  5 May 2010 19:43:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70CE3B0DA4; Wed,  5 May
 2010 19:43:49 -0400 (EDT)
In-Reply-To: <1273098179.723.10.camel@dreddbeard> (Will Palmer's message of
 "Wed\, 05 May 2010 23\:22\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 12023320-58A0-11DF-BF52-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146429>

Will Palmer <wmpalmer@gmail.com> writes:

> Is there any precedent for the "!!" syntax? Something like ".!", "./!",
> or "!(.)" would make the intention more clear, I'd think, as well as
> leaving room for other extensions to be added later...

While I don't think !! is particularly good (or bad), possible future
extension is always a good reason to think about the notation carefully.

It probably is a good idea to switch aliases to start at the $cwd in 1.8.0
(or perhaps one major release after it), and using a notation that is more
descriptive, something like "!(cwd)" vs "!(root)", may give us a better
transtion strategy than casting cryptic "!!" in the stone.

What other variants might we want to be able to specify while defining and
using aliases?  If cwd vs root is the only distinction, then !(cwd) would
be a bit overkill, but if we used !! for this new feature, I suspect that
it would make it much harder to switch the default in the future.

Comments?
