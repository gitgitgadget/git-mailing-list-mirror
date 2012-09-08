From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Sat, 08 Sep 2012 12:03:39 -0700
Message-ID: <7vwr04tjzo.fsf@alter.siamese.dyndns.org>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de>
 <1347124173-14460-2-git-send-email-jengelh@inai.de>
 <k2g0up$28h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sat Sep 08 21:03:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQJp-00020v-U9
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 21:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab2IHTDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 15:03:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530Ab2IHTDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 15:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B7507366;
	Sat,  8 Sep 2012 15:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Quuy/kp1LyDrkkXETeCqi7TLRKs=; b=Ny0GCs
	kHF6hg2R/sMw9H1KHJwZx9ibrkSAmeh4vj86xwcRo9dpN2FCts80IvXeQPpI/Uq5
	uglJ1kBLez9VrENEn+BL5VRgoT9t3ZeNbvZlKJVK6Su3/gKQQg5/L3+3iN/hhLI2
	xudOmLtmDkPIw8oVVOiqCprEril156y1WVjqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hb3R1lwAFXQ3DixTWw/xN6biFQgmH8KI
	JcH90hcp1tc7mKjjCYrrAsL3++Z1lSzXSFK0lgHTwROgp0/Oltqg6U+QK6txLF5u
	9QXVyZyPW1Aqd4hrcMFPzDaA7YjqrJkSmKk6jU34+GMVxBVopd6GY/xw71Gz5I36
	seeQLt1USQ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8AE7365;
	Sat,  8 Sep 2012 15:03:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BB2A7364; Sat,  8 Sep 2012
 15:03:40 -0400 (EDT)
In-Reply-To: <k2g0up$28h$1@ger.gmane.org> (Joachim Schmitz's message of "Sat,
 8 Sep 2012 19:57:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7050D78-F9E7-11E1-87F2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205028>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> + setenv("REMOTE_PORT", portbuf, true);
>
> setenv() is not a function available on all plattfomrs.

Please do some homework before adding irrelevant noise.  At the
minimum, run "git grep" to see if we already use it in other places,
and investigate why we can use it safely across platforms we already
support.
