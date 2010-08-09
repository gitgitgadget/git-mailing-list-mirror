From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: Replaced /bin/sh with /bin/bash to make scripts
 with Bash syntax work on Solaris.
Date: Mon, 09 Aug 2010 09:44:06 -0700
Message-ID: <7vmxsv7n3d.fsf@alter.siamese.dyndns.org>
References: <1281099365-11978-1-git-send-email-asgeir@twingine.no>
 <7veiebafzn.fsf@alter.siamese.dyndns.org>
 <AANLkTi=niNfKy0JgOG4hqNtXYQPfbkd10NRDDKM1rhfB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Asgeir Storesund Nilsen <asgeir@twingine.no>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:44:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVSc-0002Kh-R1
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172Ab0HIQoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 12:44:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158Ab0HIQoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 12:44:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4982618E0;
	Mon,  9 Aug 2010 12:44:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9hDaFQPj/hBojUy3ZrChJOoMojo=; b=EUKDon
	3uhS8kiUO2mhHohO5hs5muyY/t2zpPMHwvy2seAUJBgWGDYco8kw3Q750gtEDDmO
	I7fkStiXS94ApfIhI6zOqr6cOb+I1ybuVs6iTXd2buRTQ7ooxm4NabBnqgsm+itA
	hBYjXzP55Xvycoc5ZYfCF4xp45MAaBwTqUGwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SYV072w8Mrp+yllqsvLePsKZWUNBiXhv
	3eUCiLKVan7DHFDiwUkg/pMkFg6gKVwMsg/wNPpuSi4riyjJPC9w7NXFNGhusb9G
	X5AcEt4HyazBUNEVrtC3NKSOwnE7aW6ZbDbK+e/wLxfiWE1VuTKov0Xw6zXM1K4q
	nRENtAIZu+g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16CBF18DB;
	Mon,  9 Aug 2010 12:44:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73F4818C7; Mon,  9 Aug
 2010 12:44:08 -0400 (EDT)
In-Reply-To: <AANLkTi=niNfKy0JgOG4hqNtXYQPfbkd10NRDDKM1rhfB@mail.gmail.com>
 (Asgeir Storesund Nilsen's message of "Fri\, 6 Aug 2010 22\:11\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 598D4132-A3D5-11DF-AE47-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152982>

Asgeir Storesund Nilsen <asgeir@twingine.no> writes:

> I absolutely agree on the idea of using pure POSIX, but in reality I guess
> most of both developer and user base are using (GNU/)Linux and thus an
> environment where /bin/sh is in fact Bash?

For example, dash is a much lighter alternative than bash, and groks POSIX
fine.

I think a safer assumption is that /bin/sh is POSIX, and we make sure that
the builder can countermand it with SHELL_PATH; as platforms whose /bin/sh
is _not_ POSIX does not have to have bash as /bin/bash but somewhere else
(e.g. /usr/local/bin/bash).
