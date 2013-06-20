From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Thu, 20 Jun 2013 15:05:52 -0700
Message-ID: <7vy5a4phdr.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-4-git-send-email-artagnon@gmail.com>
	<7v38sdzx8o.fsf@alter.siamese.dyndns.org>
	<7vk3lpwkt6.fsf@alter.siamese.dyndns.org>
	<CALkWK0=v25wC1r8ScUkKDhFjctZCDLJtpDx2g2avyYgJVmZCWg@mail.gmail.com>
	<7vd2rgtwl3.fsf@alter.siamese.dyndns.org>
	<CALkWK0mTthYyHRkxqK2Z3uP3uUmtQADyZt7CERY_40iQSQyzAA@mail.gmail.com>
	<7v38scqwej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 00:06:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpmzR-0003UN-CE
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386Ab3FTWF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:05:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758379Ab3FTWF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 18:05:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E54132A69A;
	Thu, 20 Jun 2013 22:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nyrwsoWsuKpbbNKPMM+cCPv+mRM=; b=PyOMct
	ZGvgCbkMXc6GxFpOsDGk8mhtW3NE3I87woGzoOJJJ8+RNACLsf4cqSIIXULWmP5k
	31RTAEJpSVrObzlMxZ+3q0HlQv6mHFR6wkmKIK6RYglzYYakZqbpOIfNCoKRq+TW
	LMv0cm75oloCWrPrOvhG9a50zqlx1zg3GH+es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G76HiESAZPvm+Kd6LjE6s52dRkRgpys8
	9zhkSTgFZayiSx7Qr33p/54BJSC3juWPulS1dojRjNGlX5l8Iv2AtsXDeoEHWv0B
	2oRHD9i1mRe/sl38n+6z55R2SxszoWuarOUyRxYC5Q/0vvqLAgee/FXFG86qjXgc
	4TkM1ILiwfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2992A698;
	Thu, 20 Jun 2013 22:05:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1317A2A692;
	Thu, 20 Jun 2013 22:05:53 +0000 (UTC)
In-Reply-To: <7v38scqwej.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 20 Jun 2013 14:56:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93DE0D9A-D9F5-11E2-BF71-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228548>

Junio C Hamano <gitster@pobox.com> writes:

> Like you said, I do not want to contaminate this series with such an
> unrelated change.  Worse, you are trying to break a sane default by
> replacing it with "anything goes".
>
> We already have a sane default, which is to error out.  We do not
> need your broken default.

This came out as a bit stronger than I wanted to.  Add to the last:

    Even if we later find out that changing the default to loosen it
    to "anything goes" is a good idea, I do not think it belongs to
    this series.
