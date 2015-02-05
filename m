From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correction to git-p4 "exclude" change
Date: Thu, 05 Feb 2015 11:05:28 -0800
Message-ID: <xmqq1tm4mb5z.fsf@gitster.dls.corp.google.com>
References: <1422425284-5282-1-git-send-email-luke@diamand.org>
	<xmqqwq46fx59.fsf@gitster.dls.corp.google.com>
	<CAE5ih7_TJOQ=ttw03V3J9A=jtwUD-Emy-mSp0kNrYKkqMs30ng@mail.gmail.com>
	<CAE5ih7-Eo9uNCRQHO8bOGCuE0w8U_S4q+aYTNfttSHLQM6GVpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:05:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJRkO-00070y-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbbBETFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:05:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753564AbbBETFc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:05:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 864333520F;
	Thu,  5 Feb 2015 14:05:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VHRvyJjfG/LhC17aDLXRYdjwXs0=; b=xVjS5h
	wEu9ljrnMsrt2Gf80d7gvBAaIzy50VseFAzDz1FcoeyPr41vPzLqdZ5F5nKsU+Ub
	RolgqOGxKDPE1vmS0sRff0rWub1jiI2ZOSEZjzDI1aC5bCSVJ7rMkE5gGgSIRoXi
	0l0dBz1jp5ZQccLkVtZmxuEHHyCIOZbMoXBPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LZzoMD0cuOCH0FiNgJKFDHQaENrOrTmp
	1a4ia62MFZEL83PxvsFlnIqePy53tRyNW5zSDXx/Pm1Sdpp8sRubonfnJXu5ek+Y
	gjcegyZbr7ihpQnJ25VXHEPrdHL0C5vmJa1MYy9zY2IzmydFH9aatjhmjnKUSeu9
	7uk2B1+yo/k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CCBB3520E;
	Thu,  5 Feb 2015 14:05:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1E643520D;
	Thu,  5 Feb 2015 14:05:29 -0500 (EST)
In-Reply-To: <CAE5ih7-Eo9uNCRQHO8bOGCuE0w8U_S4q+aYTNfttSHLQM6GVpA@mail.gmail.com>
	(Luke Diamand's message of "Thu, 5 Feb 2015 08:24:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3B90E88-AD69-11E4-BF9E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263384>

Luke Diamand <luke@diamand.org> writes:

> (Resending as plain text).
>
> I could be wrong about this, but my correction above doesn't seem to
> be in 'next'. Does that mean (reading your last "what's cooking") that
> the broken version is going to go out to 'master' soon?

The current copy of "What's cooking" I have reads like so:

    * ld/p4-exclude-in-sync (2015-01-28) 2 commits
     - git-p4: correct "exclude" change
      (merged to 'next' on 2015-01-22 at f6f1fc7)
     + git-p4: support excluding paths on sync

     Will squash into one after 2.3 final.

As we are too late to merge anything new to 'master', and the broken
one is not in 'master', I have been playing lazy to make time to
tend to other issues ;-)  After 2.3 final, we would rewind the tip
of 'next' and will rebuild, and when that happens, I am hoping that
we can make these two into one commit that does not have the "oops,
I forgot a comma and broke the entire command" fix-up as a separate
commit.

Or did I mis-read you?  Do we have broken code already in 'master'
that this hot-fix needs to be applied to unbreak?
