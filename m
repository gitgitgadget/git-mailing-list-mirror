From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] t1510 (worktree): fix '&&' chaining
Date: Thu, 08 Dec 2011 16:00:30 -0800
Message-ID: <7vehwehaw1.fsf@alter.siamese.dyndns.org>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-8-git-send-email-artagnon@gmail.com>
 <20111208171213.GF2394@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 01:00:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYntU-0006yO-9L
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 01:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870Ab1LIAAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 19:00:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805Ab1LIAAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 19:00:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F02677F;
	Thu,  8 Dec 2011 19:00:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xEifU1Obc1kC+enguHWTOLxQIMg=; b=VONc86
	jn7KECyU9kPD0r8EFD2Ke7Aytu3bvk/3Su3GCOSLkuKzJe4KMnLVaXLV0tzRMKNG
	7KocNjqKxICVkdbRjnu8KqphOJ/uZqvh/7Ai1K7yljaVG7OKZ5Jz3BVEAFcCLyae
	5JFHjwHDiaSi7r1hYyOe/KCdaLI+7o6HqboeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jVBJD3UWNOxedkcfIuXP2J3GeTp2zUIu
	WRqkq9TUIYoF5KRiBeolBnI/sDJ877IPSX5Va4L7FzNrUBH0YB99EkOJYgFKRKQh
	XafIIHL50zb1UV9zqowe+iTdTsRKRNO2WZicPxnlXM7lR1W3uMdekqjh2rSthHQ5
	6iH9fjLcJoQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8203677E;
	Thu,  8 Dec 2011 19:00:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A3FA677A; Thu,  8 Dec 2011
 19:00:31 -0500 (EST)
In-Reply-To: <20111208171213.GF2394@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Thu, 8 Dec 2011 11:12:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF72724E-21F8-11E1-882D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186601>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This is also not "Additionally", as in "As a separate change that
> maybe should have been another patch but I am too lazy".  Rather, it
> is a necessary change that is part of the same task.  So I would
> write:
>
> 	Breaks in a test assertion's && chain can potentially hide failures
> 	from earlier commands in the chain.  Fix these breaks.
>
> 	'unset' returns non-zero status when the variable passed was already
> 	unset on some shells, so now that the status is tested we need to
> 	change these instances to 'safe_unset'.
>
> Erm, sane_unset, not safe_unset.  Did you even test this?

Thanks for careful reading and many constructive review comments.
