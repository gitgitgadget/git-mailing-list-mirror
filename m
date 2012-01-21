From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Suppress stderr and fix the "both added" test
Date: Sat, 21 Jan 2012 13:27:05 -0800
Message-ID: <7v39b8d9w6.fsf@alter.siamese.dyndns.org>
References: <1327141578-54796-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jcwenger@gmail.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 22:27:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoiSy-0002ji-0O
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 22:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab2AUV1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 16:27:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47279 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab2AUV1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 16:27:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8BAB704E;
	Sat, 21 Jan 2012 16:27:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dceV/zmbk3FfDw/AS6H8BzAMvjY=; b=GYTwwv
	mM917AMKGFAppUtnmlND/pt5Kn1/jufM7aXKB54JRnZn94qvhHjSxw8/FZHmrKJO
	YPX2LUfVRsj5xB6/cnrgKLJSxvOmKZXZWRfYJyHUw2ydrkCmTAR5O9sMF+jYPy1z
	26mGYkKg+9oQzwC1pgPZHb4IDk3eAYnsAoiqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wFMOcIbBEKm7RyKJKWge49PvAlefJVaR
	VctT8NWddmdw2OnbaD04WTetEDrVFBYFmvA04Btg3mzG8LdHH+P9aQ7WrLbFZkcJ
	oTHbuxWdGXg5ikmYT9gZe6C3iAHRHpXb43Y4vvcoFD+G1k3WL254HybpgmB+vdAQ
	kN50Wf0uYlo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA3C704D;
	Sat, 21 Jan 2012 16:27:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 744AC704C; Sat, 21 Jan 2012
 16:27:07 -0500 (EST)
In-Reply-To: <1327141578-54796-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sat, 21 Jan 2012 02:26:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABAC9C90-4476-11E1-9DD2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188931>

David Aguilar <davvid@gmail.com> writes:

> Silence error messages when "git checkout-index" is used to
> checkout a stage that does not exist.  This can happen now that
> mergetool calls checkout_staged_file() unconditionally when
> creating the temporary $BASE, $LOCAL, and $REMOTE files.
>
> Fix the test so that it checks the contents of the "both added"
> file.  The test was passing as a consequence of accidentally
> handing a bad path to "cat".
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This applies on top of da/maint-mergetool-twoway in pu.

Thanks.

It might make sense to squash this into the previous patch, which luckily
hasn't hit 'next' yet, though---which I can do locally without need for
re-send if you like.
