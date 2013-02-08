From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: Rewrite git-gc section for automatic
 packing
Date: Fri, 08 Feb 2013 15:04:58 -0800
Message-ID: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
References: <7ac63ea832711ad4bee636163e277a408cbddda4.1360341577.git.wking@tremily.us>
 <7vd2wa3dxm.fsf@alter.siamese.dyndns.org>
 <20130208183546.GC3616@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Feb 09 00:05:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3x0Y-0003A1-G9
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 00:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947233Ab3BHXFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 18:05:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947164Ab3BHXFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 18:05:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B75A3B3AA;
	Fri,  8 Feb 2013 18:05:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jQ0bAZ81EB1vX1VZ3Dh0/RhMm2k=; b=Q8n9FQ
	l1z/sxvexpAXiFseQbEaRwpmiqUHJZc/Y7ec0dcoVAJ9XQX04Aa39rLleahNdxQ8
	yGRK9Et4RLjBj4Hv77ccMpND7uQfkkcinRi16++0Fw3kn+BXpKSLKsicdHE+tyWy
	X4NPiiRad9xI138wQ8aNP1sAV96tft0F6nVeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W4ysoNou3ZpjUqV34J/9NTxb6P4o4IcV
	I7zw0br9VSPJepqhCrBwJ4tWx7+2ezxRYVoYU2C8qoFLrcikK4xaxUx50oHRTUWB
	u6qGClopOWVq7wVpzJqpeEZ0lw6EKVdLYPnpATnAxX/tmYIfL+b1P3BN0v0c4bnD
	ecpZBBGJbo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB21BB3A9;
	Fri,  8 Feb 2013 18:05:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B4C7B3A7; Fri,  8 Feb 2013
 18:05:00 -0500 (EST)
In-Reply-To: <20130208183546.GC3616@odin.tremily.us> (W. Trevor King's
 message of "Fri, 08 Feb 2013 13:35:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6B316DC-7243-11E2-A89C-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215826>

"W. Trevor King" <wking@tremily.us> writes:

> I just read through the manual cover to cover, so I have a number of
> other fixes in the pipe (from which I've already submitted the
> receive.denyCurrentBranch patch).

Wonderful.

> ...  Should I bundle them all into a
> single series to reduce clutter on the list,...

I do not think it makes much difference between a single series that
consists of 47 separate patches and a flood of 47 unrelated patches.
As long as it is not a single patch with 200 hunks, some of which
has to be redone repeatedly, I think it is fine either way.

Hopefully, many of them may be a no-brainer to accept on the first
try, while some may have to be improved with the input from the list
and will be rerolled.  I would imagine the initial round would be:

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
