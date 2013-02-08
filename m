From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: Rewrite git-gc section for automatic
 packing
Date: Fri, 08 Feb 2013 15:04:17 -0800
Message-ID: <7v1ucqz9u6.fsf@alter.siamese.dyndns.org>
References: <7ac63ea832711ad4bee636163e277a408cbddda4.1360341577.git.wking@tremily.us>
 <7vd2wa3dxm.fsf@alter.siamese.dyndns.org>
 <20130208183546.GC3616@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Feb 09 00:04:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3wzt-0002mH-AW
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 00:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947211Ab3BHXEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 18:04:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947094Ab3BHXEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 18:04:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A0DCB355;
	Fri,  8 Feb 2013 18:04:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eeBVE26ofun0SwIrRCTWloQASz4=; b=DSVTH/
	l49G3zzmXSORGsfY/CgJUDx7XH/dKYbf5SVlzvZl/Z036DDgZx0LX9pwAN638trb
	bdlbSOZPcSrFdp1K6h/i9uS9z2QOseF0sCQW3V+uhVZ//1uR1gxSiGfixMLP4OCB
	jXmrvvtmWSwiQDzsbPPpdPUFRYwGrAdmLZ6Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FfehY+wZ3uuB/FC9KR3JrGLjtxVDuOmH
	/dcVmx+ZJ2A14ToT1g7ItEssc/nz4FzYfP09FrJdYeoks0Ss9p4yWGJcoz//sprM
	yklRiqHLLX0WCgzxgh6vNpgjs+UqC90R8qaSa72sAwvlTW7+5AtOtzI0WtLNs3Vk
	CwPiUhyVZfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E222B353;
	Fri,  8 Feb 2013 18:04:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBFF3B34C; Fri,  8 Feb 2013
 18:04:19 -0500 (EST)
In-Reply-To: <20130208183546.GC3616@odin.tremily.us> (W. Trevor King's
 message of "Fri, 08 Feb 2013 13:35:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEBB7F1A-7243-11E2-B7A0-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215825>

"W. Trevor King" <wking@tremily.us> writes:

> I just read through the manual cover to cover, so I have a number of
> other fixes in the pipe (from which I've already submitted the
> receive.denyCurrentBranch patch).

Wonderful.

> ...  Should I bundle them all into a
> single series to reduce clutter on the list,...

I do think it makes much difference between a single series that
consists of 47 separate patches and a flood of 47 unrelated patches.
As long as it is not a single patch with 200 hunks, some of which
has to be redone repeatedly, I think it is fine either way.

Many of them may be a no-brainer to accept on the first try, while
some may have to be improved with the input from the list and will
be rerolled.  I would imagine the initial round would be:

	[PATCH v1 00/47] User manual updates
         [PATCH v1 01/47] user-manual: update description of 'xyzzy'
         [PATCH v1 02/47] user-manual: update description of 'frotz'
 	 ...
         [PATCH v1 47/47] user-manual: update description of 'nitfol'

and after reviewing, some of them need to be redone in v2; the cover
letter for v2 would say something like

	[PATCH v2 00/52] User manual updates

	The patches 01-17, 19, 22-36, 39, 42-47 are the same as in
        v1; 48-52 are new.

And people who missed the v1 review cycle may have a chance to look
at and respond to [PATCH v2 06/52] which may result in an update of
that patch to address issues that reviewers of the initial round may
have missed.
