From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to find out which commit "git rebase --skip"
 skipped?
Date: Fri, 17 Aug 2012 10:48:27 -0700
Message-ID: <7vfw7lv28k.fsf@alter.siamese.dyndns.org>
References: <CAE5ih78tYrX0F3AZ3vrE2p=_h24njhU_rTGEqbBHfJGkGuHmpw@mail.gmail.com>
 <7va9xu3kr5.fsf@alter.siamese.dyndns.org> <502E0F9C.5010303@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:48:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Qf8-00019H-7N
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab2HQRsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:48:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014Ab2HQRsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:48:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 899BA7B01;
	Fri, 17 Aug 2012 13:48:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E5cwcbWEyi3Rk9RWqYD9eEVs4hg=; b=HF+cei
	7dpdN3cEzvtVpZGSfPHVsFJmzWVtbLeb8DFfhFOglyHYNHZWu7aJ9AhYVa5yfPrN
	OQ3PYzQZp/SWzJOxxHDnfRZpvVArwLSK86CIB5GSBqLYm82/dHHfO0HCOz840CxV
	6h8OJunf3veQqrKmBnGsXtn6xPjSQUaGvuII8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qhJsw3wO2qD3nLlTfEJU0RVi9Bn60ziz
	H8vQazsP0vc758yXgE27a1TtCvXgWtqmWo4a5c89YoQs/I7oXaIo+X8LrsCLhnif
	tNv3kZOeLMFk9VyobNsCFH4IEVVV6/0bT8yFyKCmxclSM0SzYCr3jEMwRTWlya6d
	FsFsLufCQCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76D137B00;
	Fri, 17 Aug 2012 13:48:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAD427AFF; Fri, 17 Aug 2012
 13:48:28 -0400 (EDT)
In-Reply-To: <502E0F9C.5010303@diamand.org> (Luke Diamand's message of "Fri,
 17 Aug 2012 10:32:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0C38618-E893-11E1-B350-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203633>

Luke Diamand <luke@diamand.org> writes:

> All I need is to be able to get the commit *immediately* after the
> failed 'git rebase'. It looks like .git/ORIG_HEAD has exactly what I
> need.

Depends on what you meant by "commit that was skipped", but the
above makes me nervous.  ORIG_HEAD is set to the tip of the branch
being rebased at the very beginning, and updated to the current HEAD
(i.e. the result of the last successful step) before --skip is given.
I do not think it ever points into the commits in the original history
that is being replayed.
