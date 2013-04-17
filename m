From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 10:08:36 -0700
Message-ID: <7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
	<7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
	<87wqs1xi9h.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 17 19:10:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USVsC-0006R8-8A
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 19:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936148Ab3DQRIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 13:08:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935445Ab3DQRIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 13:08:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0EB0176D1;
	Wed, 17 Apr 2013 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TZ+eJ7y4pOSRDyP99QQJV6CWo4o=; b=bHQXIY
	P2VKAVU3+7yAqGXhYUrkZGpu0Z9ELykPqWGpHiEFxKNaH3vfw11/615Fkc/qSnZ1
	GSrrqvuLB7fEEloy+65za1QUWC7srn6/fX3VhhcXuGVVDaYibDRKaVrvfQgVNVI/
	MNlOeEzr3lM8vO0VbOtdg2z1D3tuU9oX9Sl8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hUGYydjyOA7XKZgYJ+HsU3kzL+FtnaPm
	NqC5S6cpy81QsAxApOGrmtePSl3k8911aciDVfUMfA1RCOG+EJyN8qRjyZpcJeHb
	MwrzhJIzumQ8A1Gz6cCptuOjjUgl5EZx6kqk/k/J/UkwO/cMRt+VeDN5jFzl6u/c
	dxymSlTpe5s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8A7D176D0;
	Wed, 17 Apr 2013 17:08:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D826176CD;
	Wed, 17 Apr 2013 17:08:38 +0000 (UTC)
In-Reply-To: <87wqs1xi9h.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Wed, 17 Apr 2013 17:56:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72492EF4-A781-11E2-A3ED-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221553>

Thomas Rast <trast@inf.ethz.ch> writes:

> I can see that problem, but along the same lines, why shouldn't I have
> an expectation that when I say 'git add "*.py"' it removes stuff that I
> have removed?

You _should_ have that expectation.

If it does not remove with the code that has been prepared for 2.0
(that is a bit beyond 'next'), then it is a big problem, but I think
it does remove the removed python source without "-A", as long as
you give a pathspec "*.py" (with quotes around it) that match it.

I think it is just the warning code avoiding extra complexity and
overhead, if you are talking about not getting warning in the
pre-2.0 step that is in 'next'.  Patches are very much welcomed,
especially the ones that come before I get around to it ;-)
