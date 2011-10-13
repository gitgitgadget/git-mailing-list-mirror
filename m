From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git pull doesn't recognize --work-tree parameter
Date: Thu, 13 Oct 2011 13:48:43 -0700
Message-ID: <7vwrc839ec.fsf@alter.siamese.dyndns.org>
References: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
 <20111013155923.GA13134@sigill.intra.peff.net>
 <7vbotk6aae.fsf@alter.siamese.dyndns.org>
 <20111013183709.GB17573@sigill.intra.peff.net>
 <7v62js4sop.fsf@alter.siamese.dyndns.org>
 <20111013191457.GA18460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 22:48:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RESD1-0003BS-L1
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 22:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1JMUsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 16:48:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab1JMUst (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 16:48:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E303D5BDB;
	Thu, 13 Oct 2011 16:48:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZT8+NWf5OY6yMdokDXCvlOuoMlo=; b=xJ/Wax
	XOoXEfSyzPSmyB1aSjfvpzNzNdVTosogvO6Hez1lswck701Li8qTYClbf5BKVQXW
	1PazgnEOJBGIJYt3s2sNquFlP9LomJIjfH+NlXt3Gt92IC2QYUAa3yj1uFjPMll/
	xesz+tNsc/MF79qAob74ao8eb372qEQVaWtUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2JkP1Ve3AeiEQGZndjYK9ASnY0XsuhM
	v/2pdM42NisTMDCJxDicGD/NJu6B1YYzpVSZK7vkbEJldzO4YsrmwR87KY/ke1gH
	EOatioj1QD+QW0TAd+Rw9gHJkNEwb1xDmGNJK+kUxs4fwsMDtNAwSt0mFAP11v0n
	P9ofyCwiewg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA3DF5BDA;
	Thu, 13 Oct 2011 16:48:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F0645BD9; Thu, 13 Oct 2011
 16:48:44 -0400 (EDT)
In-Reply-To: <20111013191457.GA18460@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Oct 2011 15:14:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDA88532-F5DC-11E0-B437-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183525>

Jeff King <peff@peff.net> writes:

> I didn't think that could happen now, because you would not be in the
> working tree, and therefore require_work_tree would fail.

Ok, then I was worried about a non-existing problem, which is good.

Then we can introduce cd_to_top that is more sensible than cd_to_toplevel
and perhaps add some warning to the latter about deprecation and
migration.

Thanks.
