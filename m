From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Tue, 15 May 2012 10:08:11 -0700
Message-ID: <7vwr4de5j8.fsf@alter.siamese.dyndns.org>
References: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch> <xmqqwr5atn89.fsf@junio.mtv.corp.google.com> <87lilqjstf.fsf@thomas.inf.ethz.ch> <xmqqmx66mamc.fsf@junio.mtv.corp.google.com> <CANMpiOQPefL_FNocLJ=pZyAb1hZ7bEvLk6frU3xme6VQrSDD2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Shezan Baig <shezbaig.wk@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 19:08:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SULES-0003fg-9k
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 19:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965909Ab2EORIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 13:08:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964815Ab2EORIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 13:08:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7B2F8719;
	Tue, 15 May 2012 13:08:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zkWw/jbziiygl2F5zqDWA9/PKqA=; b=sPHOwT
	6dDeywh9gsiiq1XlFX1gHGYEBVNBGG+RZSAl2UoXePStZ4QIhp25CRBmwUFBSlJM
	7J0BAbz2zdQO7/aFBQGj18qsI5fXZpVyYM1vVqFMKJYEvGIOST2M8bFgrKlpy/iL
	0hEravbiZlFtuB97k5QmO2R5Kv30pmj8wegZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C14gKlJY6ESZTZUR4L1YXCi9iDLJNfRN
	MVSnygqqJBnQMDoyDn9z1wRy55jbGrpATjNzgy2minzXhTqJ7Lb5kEstDqkPCKL7
	P8bB56YmjmzGeDA2u3IWNTutoLZxBNp4CavQnBsUDDXPvvM9RaLP6qq3HhF34JKQ
	T59yFpyfato=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF29D8718;
	Tue, 15 May 2012 13:08:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 777538717; Tue, 15 May 2012
 13:08:13 -0400 (EDT)
In-Reply-To: <CANMpiOQPefL_FNocLJ=pZyAb1hZ7bEvLk6frU3xme6VQrSDD2A@mail.gmail.com> (Shezan
 Baig's message of "Tue, 15 May 2012 12:26:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E337CB2-9EB0-11E1-BE2F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197843>

Shezan Baig <shezbaig.wk@gmail.com> writes:

> Just wondering if this patch is going to be available in an upcoming
> version of git?

As we can see from the exchange you quoted, I do not think we have nailed
the details of desired behaviour in the updated code down.

Thomas, how would you want to proceed?
