From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: git fetch <remote> <branch> to update
 remote-tracking branch
Date: Mon, 05 Mar 2012 09:42:43 -0800
Message-ID: <7vmx7v0wrw.fsf@alter.siamese.dyndns.org>
References: <4F54EDC1.80608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antony Male <antony.male@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4bvv-0000FZ-0U
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 18:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab2CERmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 12:42:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756605Ab2CERmp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 12:42:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E39B27892;
	Mon,  5 Mar 2012 12:42:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VR5HAw8JG1dGH8zBHYcqN/Ub2rQ=; b=op9IZ7
	yWVXgqn1AQbfQxOs744BQkKlI1Y85hT0XPBUbpMzoMx17LnhbhSBJh6YDGZ0as34
	Lz+b3dwavn7nd7y+ZpeBnb6hNMgdsOaPhns3n+tVNF6lObUZx7qDsxDoquq3um7V
	7RDhEuHux11d0Ssqgos9CfEAj/TCYrhS99JQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VypGenGCvNK0tXlghfQz4oj+leDXITZl
	grXgnmHBE9owIvMNhKnxAfD9BtJwaP4utetH2EJUtqUmhGwieguizXs3MdAQi1MJ
	hEXZN6hRx3wxsBOKZRrRvVIkUOZDCDp5zecEI9T/lvupu17nHPrtl2GBrkE4ekJI
	vDZxPFA+q/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC4637891;
	Mon,  5 Mar 2012 12:42:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AA13788A; Mon,  5 Mar 2012
 12:42:44 -0500 (EST)
In-Reply-To: <4F54EDC1.80608@gmail.com> (Antony Male's message of "Mon, 05
 Mar 2012 16:45:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D36BBAA-66EA-11E1-9FAD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192259>

Antony Male <antony.male@gmail.com> writes:

> What do people think?

I think this was discussed number of times here, and my vague
recollection of the conclusion last time is that it would be OK to
change the behaviour of single-shot fetch "fetch <remote> <branch>"
against a remote where there is already a default fetch refspec that
covers the <branch> so that such a fetch will update the remote
tracking branch that usually copies from <branch> (and only that
one).

We might need a proper deprecation and migration plan, though.  I
say "might" because offhand I don't know what the extent of damages
to existing users' habits will be if we didn't offer any.
