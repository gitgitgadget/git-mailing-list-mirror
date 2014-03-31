From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from master to HEAD
Date: Mon, 31 Mar 2014 13:45:24 -0700
Message-ID: <xmqq38hy5c7v.fsf@gitster.dls.corp.google.com>
References: <20140328030556.GD25485@odin.tremily.us>
	<c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
	<5339C36B.5020502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 22:45:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUj5N-0007XB-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 22:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbaCaUp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 16:45:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbaCaUp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 16:45:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D55B7945D;
	Mon, 31 Mar 2014 16:45:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PcDx0ZZhiVLehWzdb4GJSRx5nCg=; b=vnmay0
	ipxOL3N7ZYKytR9V2lPRsqIyRjyQfU6eT8wLFlGsUtREA3opm0QEK5LeR4T+rxFD
	DqVv27+R45QO8f2r2xISgTJQHndoPSMWGBwh9fnwY84XloWmkG87V819xu99fJE+
	ndIAhcRPQGxNcYSHRLZge16yk+GJXNSr+yVgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lGQ+g0iGHHfv1NznflLExdM+YTeTIoRx
	ovLzIaEfuCy6HnnP7aurZPZC2UYfv55zcRa/06rhdoAxb+epFeJrxDqvjy3n82j6
	Jtx0g3Z8lJDrhFh65SxObfYd8ozY3v/7FZqBSIZd4lVZrWHhBuIkuowxhtpU8UFN
	0YB1CtYieNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A7097945C;
	Mon, 31 Mar 2014 16:45:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA5C279459;
	Mon, 31 Mar 2014 16:45:25 -0400 (EDT)
In-Reply-To: <5339C36B.5020502@web.de> (Jens Lehmann's message of "Mon, 31 Mar
	2014 21:35:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6315A0D8-B915-11E3-AC2B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245526>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I'd prefer a solution that doesn't change any defaults for the
> checkout use case (again). Maybe it is a better route to revert
> this series, then add tests describing the current behavior for
> checkout submodules as a next step before adding the branch mode
> for rebase and merge users again?

Sounds like a good idea to revert the entire series, as that would
give us longer to think the whole thing through.  It would certainly
avoid unexpected fallout in 2.0 where we already have other changes,
all of which are known/designed to be backward incompatible with a
set of carefully planned transition plans.  This submodule change
may have meant well, but does not seem to sit well together with
these other changes.

Perhaps in 2.1 or 2.2.
