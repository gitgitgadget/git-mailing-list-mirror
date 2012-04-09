From: Junio C Hamano <gitster@pobox.com>
Subject: Re: In tree object, Must the
Date: Mon, 09 Apr 2012 13:05:48 -0700
Message-ID: <7vhawsvffn.fsf@alter.siamese.dyndns.org>
References: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com>
 <7vobr0wyml.fsf@alter.siamese.dyndns.org>
 <CAJo=hJv==GrxLH6U9MAwckcEXiYtKeMEpEMNVTJLcSKro2QV_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: semtlenori@gmail.com, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 22:05:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHKqa-0005Ia-0s
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 22:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab2DIUFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 16:05:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902Ab2DIUFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 16:05:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 121F36EAB;
	Mon,  9 Apr 2012 16:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u/hZjGGCz+xO2X7CSMg0vy8giDQ=; b=oz298r
	lUe0dfsPpLKAEpKp1dHg3lWBQgGmjz9sD8+KwkwunGLQdVbrke7XChiWfGz+Q2YT
	fCICYGd2vQCVj9+uBt7fDuXP68VfNHKYfVs1SETdCs9JQ5XrPkmGYGQfWar3F6Qv
	YleHh5jx/mmMWS9+fcGTTJCGZscMyNRc0GhAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kvwpQG8QmnftZqbq6auT7xAwssbPlxxf
	k+3LfqUKj6gQh2NLwN9H5/rfgA7/Lpdv9G1CH9bVj0cpfY69UiHXWSGhJxyDb3E8
	8wyhvcf4rLtXo44tBkxEtlelUw6SpITOlAHcFNvI/02srcNY/J9ltzrhOOpDY9Vs
	vlw+ZUhi7sc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09DB36EAA;
	Mon,  9 Apr 2012 16:05:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 960C96EA9; Mon,  9 Apr 2012
 16:05:49 -0400 (EDT)
In-Reply-To: <CAJo=hJv==GrxLH6U9MAwckcEXiYtKeMEpEMNVTJLcSKro2QV_w@mail.gmail.com> (Shawn
 Pearce's message of "Mon, 9 Apr 2012 11:29:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66E03198-827F-11E1-A7E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195036>

Shawn Pearce <spearce@spearce.org> writes:

> ... And that niggly bit about subtrees sorting as
> though their names end in '/' even though they don't really matters.

Yeah, in older and buggier unpack-trees it might have made the code
simpler while walking the index and the tree in parallel, but when we have
to deal with D/F conflicts, we have to find a entry with matching name
anyway, so it turned out not to be a win at all.
