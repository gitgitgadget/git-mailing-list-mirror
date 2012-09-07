From: Junio C Hamano <gitster@pobox.com>
Subject: Re: help doing a hotfix bisect: cherry-pick -m ??
Date: Fri, 07 Sep 2012 12:27:32 -0700
Message-ID: <7v627py6or.fsf@alter.siamese.dyndns.org>
References: <CAJfuBxwBn-WFw+nci1MpdWQvyXkrhyB3maXPwMAsxggTE3gz3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:27:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA4DP-0006d5-SE
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 21:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab2IGT1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 15:27:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab2IGT1f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 15:27:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0E7A8270;
	Fri,  7 Sep 2012 15:27:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B6Hu7s53sWfh+Ld0qdvw2B7vi1w=; b=tUeBuz
	YG4x4MqBvnMhkmzN6uOJy3lnjJBLytAXZaE8Y3HGiGKrkEJhmECILwcZNOJoKTi7
	TPw8N/5xXpdAvfug6F1XvQSWP4T3B/uzDStMfE2Olg4o4Ktw+Quxw+6OnxUANkLv
	nlNpXlvLaT5t/wpW6La++2SESRvJznsxjSMV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjQDk+ZyNNCBLbAXoTNYR1xUbiwVzO6i
	ACUfJBo3HKfw8IvhvEZy7M/D+Ulc8rKO8LIU1jgj2mTcj4/ONQpjI44jWaosr+wM
	/WcUWcPraFsbRrAEjouFopo6yrotS8eqgj3JVPi+M00gvvuEVWHO/LBnMm/a4ihS
	s0WoK1/XLPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE894826F;
	Fri,  7 Sep 2012 15:27:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EDAA826E; Fri,  7 Sep 2012
 15:27:34 -0400 (EDT)
In-Reply-To: <CAJfuBxwBn-WFw+nci1MpdWQvyXkrhyB3maXPwMAsxggTE3gz3Q@mail.gmail.com> (Jim
 Cromie's message of "Fri, 7 Sep 2012 12:44:06 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 131C4F46-F922-11E1-8E26-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204991>

Jim Cromie <jim.cromie@gmail.com> writes:

> Broader question:

> Im thinking that having a hotfix branch, and merging --no-commit would
> work better,
> especially when bisection lands on a commit which already contains
> some of those in the hotfix branch.

When your history leading to the "bad" commit contains only part of
the hot-fix branch and not all of it, that may work better.
