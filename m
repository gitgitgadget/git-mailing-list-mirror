From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix cases ignoring core.commentchar
Date: Sun, 18 Aug 2013 13:29:05 -0700
Message-ID: <7v38q6oi9a.fsf@alter.siamese.dyndns.org>
References: <1376689447-78807-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cTRc1-W7vJX52gb5S0ge4kZgKMBkHJjqWFRDgpuzTfM2g@mail.gmail.com>
	<CAPig+cSFoKb+v5fEXnwr=94B6uo2b57vgHTRgtFMj25M+R9dUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 22:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB9bG-0008IF-Tl
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 22:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712Ab3HRU3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 16:29:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755689Ab3HRU3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 16:29:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EF483A2F1;
	Sun, 18 Aug 2013 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=va7xNFZgMAQmc4HOe2kirUs5dKA=; b=cNrdyG
	tsMX6sNAlazmhFjksvvESStTXiax0hI64UFQabkc4rrQJ8bRtxbX9SojjL2uBL2h
	J/9ks7aIL2dlmt71zHSRcNVIqw4mHIxFDPUkWVyS/KCbbxmkSCm6ifmHkgWvAkjt
	nUq+NjfpF8t5BBSh5pO+6Av7r5zt7EnevMY/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uLAoQYacmptrLCrOiHDGS/7kz6TmZXKm
	CUDswNhsqc3CVQmJWM2kKRNdKfkL7wzKsLWaPf37AlGL7G4jsR3aWJ1KgrA9kDc8
	tQUQjva/rGSDEXexPUz1t6lCWeb3847B8UtUFAS0u7zMY+F1Lebp5+NGVd45viso
	t+OsHTlc6yw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21EB23A2EF;
	Sun, 18 Aug 2013 20:29:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 772F33A2EE;
	Sun, 18 Aug 2013 20:29:07 +0000 (UTC)
In-Reply-To: <CAPig+cSFoKb+v5fEXnwr=94B6uo2b57vgHTRgtFMj25M+R9dUw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 16 Aug 2013 18:19:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4F6BD5E-0844-11E3-AE23-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232515>

Eric Sunshine <sunshine@sunshineco.com> writes:

> One of the fixes in this patch addresses an oversight in
> 180bad3d10fe3a7f (rebase -i: respect core.commentchar, 2013-02-11)
> which is already in 'maint'. Should I split this patch in two so that
> the one fix can be applied to 'maint'?

We are so close to 1.8.4 final and I do not think it makes much
difference in practice, but if we were shooting for the ideal, yeah,
as that part of the patch could make core.commentchar useful for
rebase-i users who are still on 1.8.3.X maintenance track.
