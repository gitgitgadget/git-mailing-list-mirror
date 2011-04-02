From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try to remove the given path even if it can't be opened
Date: Sat, 02 Apr 2011 13:33:40 -0700
Message-ID: <7vd3l4gzq3.fsf@alter.siamese.dyndns.org>
References: <AANLkTikfmXiZQquWi4STTCUy0qoY9J_waJ44nrPAvB1d@mail.gmail.com>
 <7vy63tg7yz.fsf@alter.siamese.dyndns.org> <20110402200920.GA18171@blimp.dmz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 22:34:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q67WJ-0004tm-Ft
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 22:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310Ab1DBUeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 16:34:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab1DBUeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 16:34:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7296585E;
	Sat,  2 Apr 2011 16:35:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N4dft+Zuckj9dN7IcaxeLSX/pZw=; b=bLhKNw
	RgcPg1dZ/uj8+Ar1lwlDCJrsKMHdUlWabymOeJAXcKHr4iFtRZi6y/MnRv/v1aEd
	Lz7n34DXTJ+4ONnW56pXwazkb4XqJwWd+NM4pGXikV7ZBsQcOoOEz/UzrSXMZSnA
	1SW0bgEXubc6Zy/kB1sBqEryALKooyrETvciY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bseg4jW46A8kOKYTo6JUxlyPOZ8tBrDl
	PJYPm1YzqshV0cQ5nKStK3+GCdBRWoTHz+ikczNykjhjNZM0iT7TmIx0ECx48Mkl
	fLvlBYXqEJLdedv8kUZ2/4vjRtjcHNjvVY3M7MO5dxsK6kZdnfeCJug9yvDIw0fL
	6w9PaacKRAk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 629285857;
	Sat,  2 Apr 2011 16:35:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 52CEB5850; Sat,  2 Apr 2011
 16:35:32 -0400 (EDT)
In-Reply-To: <20110402200920.GA18171@blimp.dmz> (Alex Riesen's message of
 "Sat, 2 Apr 2011 22:09:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6216CEA-5D68-11E0-BED1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170662>

Alex Riesen <raa.lkml@gmail.com> writes:

>> Please don't do an attachment that has an inline patch and then attach the
>> patch itself again in base64.  It is extremely annoying.
>
> Sorry. Hard to notice on GMail.

Thanks.  I've already queued 0235017 (clean: unreadable directory may
still be rmdir-able if it is empty, 2011-04-01) with a trivial test.
