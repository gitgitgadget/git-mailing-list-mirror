From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Thu, 26 Feb 2015 12:59:03 -0800
Message-ID: <xmqqr3tcl78o.fsf@gitster.dls.corp.google.com>
References: <54EDBEC2.8090107@peralex.com>
	<CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
	<20150225143116.GA13567@peff.net>
	<xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
	<20150225185128.GA16569@peff.net>
	<xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
	<20150225191108.GA17467@peff.net>
	<54EF0089.6070605@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:59:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5Wf-0006Fp-Ls
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 21:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbBZU7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 15:59:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753969AbbBZU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:59:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B52E3C336;
	Thu, 26 Feb 2015 15:59:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/BmCVUJ3703PsGTcfMcGQVL2Lq8=; b=VW5jD1
	6ppfYYBPm6MS2kYHVqDvbpJrY42Bb98MG3fckK/YU7Hq0PUqrySXUjIvjvg6UvfR
	vYI/YOO3h3dBTBZIjL+T6usLpdL53nqiX7qV3yBDmJKMzIUYDfxFvPc7K+BtZQJH
	BaDuG47iaZn5o4Ua8ri4AU8FHdOo+K2llJCeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nzzWI6wO8o7B6o8A5b2N1XW/+xU6xVZu
	8MQpdNdL19UDYucC8zizU65lEJcPX61suksbazUj3sNvsxheU34Yeb6+WNC6mwGu
	WHm/l7HNcjSJ8ZJeo6Xx4dKugWoOluidTiJAc61Y4B24NCVtBYbRnWK84onwqG/F
	D/IVofA+BhA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 311473C335;
	Thu, 26 Feb 2015 15:59:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B9EF3C334;
	Thu, 26 Feb 2015 15:59:04 -0500 (EST)
In-Reply-To: <54EF0089.6070605@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 26 Feb 2015 12:16:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C3DE57E-BDFA-11E4-AF5B-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264461>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> So, as a summary of the discussion, it seems it's time to switch the
> default to --textconv for git grep?

Hmmm, why?

Nobody seems to be asking for such a change in this thread.  The
original issue IIRC was that the grep output was unnecessary for
some paths and the repository did not mark these paths as such.
Once they are marked as "-diff", there is no reason why you want to
trigger textconv to squelch the hits from grep.

So that does not sound to me a summary of the discussion at all.
