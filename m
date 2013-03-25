From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 15:20:16 -0700
Message-ID: <7v38vjw28v.fsf@alter.siamese.dyndns.org>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org> <5150CB34.1030008@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFl1-0006or-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933468Ab3CYWUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:20:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933448Ab3CYWUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:20:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B01EBE80;
	Mon, 25 Mar 2013 18:20:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1KJNRd000NO16CtT7BQdrcX4qpg=; b=N3JRZu
	li8VHGbXX8sPNA2UEjz9pL4d9MmxWF+71qF/x/L4htwig3IbniT+E52B5GZmP5ho
	4UGWwaSAx8al0DR3JWUG3Mo4eBG0gvJj4ZwNqXJbdi2gtXDi6kXNuxk9oC6tDsJH
	OLEyYeRBqFuTFk54uB3xZVjmCb0X/Uadcc8Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ToqH+mnWQjLI1paJ/HslW7wjzKnJ8Qc3
	HhVNJl3Q+UbrEesR+684qZMIRp28ORK2yNBFHEM+yuFGD1EteA3FkOhQwX7KXJ//
	IYBgqvotx2kg4vJqkYLC63oTVFUBQsSJQHvoFEAmo5rpRLxdw40KskZzr7+dwGKI
	D1PCxpQ/NLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D34DBE7F;
	Mon, 25 Mar 2013 18:20:18 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAF2DBE7B; Mon, 25 Mar 2013
 18:20:17 -0400 (EDT)
In-Reply-To: <5150CB34.1030008@nod.at> (Richard Weinberger's message of "Mon,
 25 Mar 2013 23:09:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C867B68-959A-11E2-9D27-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219111>

Richard Weinberger <richard@nod.at> writes:

> Okay, I have to set GIT_DIR _and_ GIT_WORK_TREE to make my scripts safe again?
> I've always set only GIT_DIR because it just worked (till today...).

That means you never run your script inside a subdirectory ;-)

If your $GIT_DIR is tied to a single working tree, a simpler way
would be to add

	[core]
		worktree = /path/to/the/work/tree/

to $GIT_DIR/config.
