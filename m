From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: Don't fail if work dir contains file named 'HEAD'
Date: Tue, 03 Jan 2012 11:44:41 -0800
Message-ID: <7vwr98tvti.fsf@alter.siamese.dyndns.org>
References: <913BB2F9-3C51-44D0-BFEC-3A49A5EC9E15@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:44:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAHx-0001Cz-27
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab2ACToo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 14:44:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438Ab2ACTon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:44:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64DFC5AB9;
	Tue,  3 Jan 2012 14:44:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oqoecqaG3uLsnd+dGy8ctfM+5N0=; b=QzqGfhkrPqAxtojRD4hR
	nwOlpzeT23/LrzjLuQzb2Sz0/tKEsJcx7OAIx/D3VxbyAYlW04UXY0oK680bfXqR
	y+BxZsWAF44uLFbJc7kdUM/S2w6+b11+x/FPFgmqbRwB84COiDBgIIaUXASKu6nx
	XKVploR9BqAwib0+6KNeZic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qyrNXbbJMHp+FFRPX5gBjxIHNpHtRw+0S0QMJXl3pSkASa
	BmjkToufj0SKuxL+QcGUqzbnAbjP2dIx/RIdzRUmxY2LPOwRXtl5ByTMZDmlCD2u
	y4CgwFz25kgE2pwMuLy9o6DPxpliGdL+5L+Sx8HcQL0euZR6SSZv3eSdcIZW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D96A5AB8;
	Tue,  3 Jan 2012 14:44:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF15A5AB7; Tue,  3 Jan 2012
 14:44:42 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61C12B82-3643-11E1-BAD7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187882>

Jonathon Mah <me@JonathonMah.com> writes:

> When performing a plain "git stash" (without --patch), git-diff would fail
> with "fatal: ambiguous argument 'HEAD': both revision and filename". The
> output was piped into git-update-index, masking the failed exit status.
> The output is now sent to a temporary file (which is cleaned up by
> existing code), and the exit status is checked. The "HEAD" arg to the
> git-diff invocation has been disambiguated too, of course.
>
> In patch mode, "git stash -p" would fail harmlessly, leaving the working
> dir untouched.
>
> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---

Thanks.
