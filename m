From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reset by checkout?
Date: Mon, 02 Jun 2014 14:29:19 -0700
Message-ID: <xmqqvbsj2e6o.fsf@gitster.dls.corp.google.com>
References: <20140531144610.754B.B013761@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Atsushi Nakagawa <atnak@chejz.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:29:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrZnN-0006jV-9c
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbaFBV3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:29:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52084 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaFBV3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:29:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A49CC1D232;
	Mon,  2 Jun 2014 17:29:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qDYsT8jXjeCJQTYGPzvoaNLuAkY=; b=aydtrs
	fktBU5UEF8HZ/oAnTykz39Z3OkuXRsRueZ9bxOYiUkcQ6FHR4VGmmHCl0RpQ5+Uf
	wdaz8mgcrjTPA2PVrUjjcpfVej46CI89rpRCJrRMVQZkw/RGjAdEZyODqi8B/r8Q
	HfnSFpHovAuDvpP97wQN+r/TKyYc7lfx71VAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tSP1gsilKiUzSm++wdXnagBrULyQH9LM
	OKWXDaqOQtX8icuC+s+3H7v47fF3aTIN4AsjJoR8lloO0fkb0ZKUtaepldBqkliO
	zaF2BRTO4Foy3Gzix4JNzTG4SVlPc5dkNXHg5cjih7HI6g1VsBnGHJ5cNFyVTBKm
	N3Oldig+zGU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B8811D22F;
	Mon,  2 Jun 2014 17:29:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C60541D22A;
	Mon,  2 Jun 2014 17:29:20 -0400 (EDT)
In-Reply-To: <20140531144610.754B.B013761@chejz.com> (Atsushi Nakagawa's
	message of "Sat, 31 May 2014 14:46:12 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F5A3F40A-EA9C-11E3-BC4C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250598>

Atsushi Nakagawa <atnak@chejz.com> writes:

> One of the more underrepresented command I use in git use on a regular
> basis is this "reset by checkout".  It's what's currently achieved by
> this convoluted expression:
>
>   `git checkout -B <current-branch-name> <tree-ish>`
>
> This is such an useful notion that I can fathom why there isn't a better,
> first-tier, alternative.

Hmph.  checkout *is* the first-tier way to do this.  Why do you even
want to do it via "reset"?  Is it because you learned "reset" first
and then learned how "checkout" with various modes all do useful
things?
