From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] git-remote-testgit: avoid process substitution
Date: Mon, 29 Apr 2013 10:36:16 -0700
Message-ID: <7vehdtjl2n.fsf@alter.siamese.dyndns.org>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net> <5178C583.6000703@viscovery.net>
	<CAMP44s2nWs3XyaLQUnYd=A9u1=8tB7Qp+FN7gf+SrACxmtP8pw@mail.gmail.com>
	<7vobd1udz2.fsf@alter.siamese.dyndns.org>
	<CAMP44s3j5Bk3eqPeN2qkGTWFLO2NKz0taTGYVNvEut_VM=0NXA@mail.gmail.com>
	<7v8v44vpon.fsf_-_@alter.siamese.dyndns.org>
	<517C2349.3050609@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWs00-0007G7-Gp
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758018Ab3D2RgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:36:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757521Ab3D2RgT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:36:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF8BA1A6F5;
	Mon, 29 Apr 2013 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ST57XcFjk0aTKYDkLkap/qyunp4=; b=HwQQBc
	TDrjXJ9+qGj2LMQi55h/G3o/6VdGbDb7zTE+BYHdpRExYraBYGLjDa4ECNE3H2uS
	lRNc76AD/e+q6Bp+MupVWkyQebrdnRmWa09WCba5qZoO6UNvisTPeLfoGTqjj6Oi
	QZ4qhGq/V5qbO69VetGlPdiRNv5XHtDBXeyUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m8LKs++kbrxt4or+OoJP9edhsSe8GtPn
	qGQ5JwWgSLoI30VpkCtZqlGxnqpU1xdSlg5Vs11WGO832mEyXs9ewoyXvO+1pA0V
	15dAf6sQvHUgwY/5Zwxtus2QIyO3UJIqS0vi4gPbNkBJqvxYJGeGw/EQjdZUKJQx
	SoIWBmq+P4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E63A91A6F2;
	Mon, 29 Apr 2013 17:36:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E8971A6EE;
	Mon, 29 Apr 2013 17:36:18 +0000 (UTC)
In-Reply-To: <517C2349.3050609@kdbg.org> (Johannes Sixt's message of "Sat, 27
	Apr 2013 21:13:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CAF01A2-B0F3-11E2-BAED-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222820>

Johannes Sixt <j6t@kdbg.org> writes:

> The patch below doesn't remove the bash dependency, yet, but it addresses
> the problematic mismatch you noticed without the need for $LF. Can you
> please queue it to move the topic forward?

I'll send three-patch series I have (including the two discussed in
the thread) on top of fc/transport-helper-error-reporting as a reply
to this message.  It seems to pass "make SHELL_PATH=/bin/dash test".
