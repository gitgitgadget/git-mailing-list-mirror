From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] DEFAULT_DOC_TARGET
Date: Thu, 03 Jan 2013 14:20:31 -0800
Message-ID: <7v4nixx61c.fsf@alter.siamese.dyndns.org>
References: <1357239920-2201-1-git-send-email-gitster@pobox.com>
 <20130103203222.GB4632@sigill.intra.peff.net>
 <20130103210541.GA11783@sigill.intra.peff.net>
 <20130103210731.GB11783@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 23:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqt9m-0002yz-Fr
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 23:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab3ACWUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 17:20:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467Ab3ACWUe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 17:20:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B23F5A3DC;
	Thu,  3 Jan 2013 17:20:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RYHWHlAqbfeymAUpkaJ5qxWwFZM=; b=IDlrFg
	Y/ZrGDtTCBVTS8y+CKiW/2DtS71Y0BJIQ3M1C9WComm59PY3EuLxmetx9DKvzVeN
	uvbHiTzAvGykXd/aXSvOTkdJHVL+YL9yY+l5kyBc5cI/9Wbkuw8qQ8vwDvrL0Phy
	7CgZpr/f10ibWcHcT2uTOcEBPceLFQTRaPXmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=egiIyQFINwJxI0kHTOdZ/cP3o+mbUehA
	M3aFSzkWGkoPIR1EMTmP81+gJaT4tXGgmC1IKd6nblztQsQXwQra1inRAVSy+u/J
	1+OmCePBHk938+jetUTrC4bflj1YSPfeBbldtqtr09LUFaS2aJ/KfX9W2USlAZMR
	vZfJVEWgPow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A42F7A3DB;
	Thu,  3 Jan 2013 17:20:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FA69A3DA; Thu,  3 Jan 2013
 17:20:33 -0500 (EST)
In-Reply-To: <20130103210731.GB11783@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 3 Jan 2013 16:07:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA24DFA4-55F3-11E2-BE5C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212616>

Jeff King <peff@peff.net> writes:

> Not surprising for such a large refactoring, but this has conflicts with
> what's in next. Here's the patch to apply on top of the conflicted tree
> you get from merging this with "next":

Yeah, verifying the manual fixup is a bit tricky indeed.  The output from

 $ git blame -C HEAD^.. -- config.mak.uname | grep '^[^^]'

shows only the first line of the resulting file, and the output from

 $ git blame --reverse -C HEAD^.. -- Makefile | grep '^^'

shows only the three-line "Platform specific tweaks" comment, which
was replaced by your version in config.mak.uname, so nothing extra
was added and nothing important was lost between the two, it seems.

Thanks.
