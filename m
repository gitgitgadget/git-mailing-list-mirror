From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 000/142] Use the $( ... ) construct for command substitution instead of using the back-quotes
Date: Tue, 25 Mar 2014 11:41:39 -0700
Message-ID: <xmqqy4zyktng.fsf@gitster.dls.corp.google.com>
References: <1395768283-31135-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 19:41:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSWIJ-0006El-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 19:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbaCYSlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 14:41:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbaCYSlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 14:41:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A6C76ADA;
	Tue, 25 Mar 2014 14:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ost9ufbWqy7sMcAXzpiRRsO19bA=; b=NuZGED
	xZUqCugUK8Ay/XvvgMPJR4OPkhO7Y/bG7tfaBV4hDThexpGRrNqrHkpc4JAPBEEa
	diz8LBWwU8EOW6vijfA7IwpW2RA2w9qUBpQETlUB3dE4IJWYXqFHrFGsYstPOgSR
	JK8j5ygXgFPj652O7Mhkn5I6pdA4Ng2I7z/uE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XF+3lCp6iT2jR3/tnuIRVc8VFGhwfkf3
	E/XAKD6V1IzJ2WAZ66h8my2J7TAUGoKvhrPfK2dzQjkhGb8TG2pbP1vCNC5UpOW1
	CjENo62pGiB8y0kRmPILwRUbD+m5bFGKvMEQJ9JPBW5oh8VdUmjMbVEOWINHGoQY
	yMm6X4sPay4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2DE276AD9;
	Tue, 25 Mar 2014 14:41:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EB9C76AD1;
	Tue, 25 Mar 2014 14:41:40 -0400 (EDT)
In-Reply-To: <1395768283-31135-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 25 Mar 2014 10:22:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1B0EE104-B44D-11E3-BAEF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245144>

Elia Pinto <gitter.spiros@gmail.com> writes:

> This is a second reroll after the 
> Matthieu Moy review. Changes from v1:
>
> - Dropped the silly patches to t6111-rev-list-treesame.sh, 
>   t0204-gettext-reencode-sanity.sh.
>
> - Simple reformatting of the commit message.
>
> - added the toy script used for doing the patch.

In other words, Mattheiu pointed out two examples of breakages and
they were the only mistakes after you re-reviewed the mechanical
changes, and there is no more?

 - Cleaning up is a good thing, but

 - Mechanical and mindless conversion is always error-prone, and

 - Eyeballing each and every change is required, but

 - Nobody has time or energy to go through 140+ patches in one go,
   with enough concentration necessary to do so without making
   mistakes (this applies to yourself, too---producing mechanical
   replacement is a no-cost thing, finding mistakes in mechanical
   replacement takes real effort).

That is why we strongly discourage people from such a whole-tree
clean-up just for the sake of clean-up and nothing else, and instead
encourage them to clean-up as a preparatory step for real work on
the files involved.  Sure, it would not give us as wide a coverage
as a mechanical whole-tree replacement in one-go, but that is the
only practical way to avoid mistakes.

If it were "four patches per every Monday" kind of trickle, we might
be able to spend some review bandwidth while reviewing other
patches, though.

So.... I am not very enthused about reviewing and applying these
patches in their current form.

Thanks.
