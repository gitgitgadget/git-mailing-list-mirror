From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] am: suppress error output from a conditional
Date: Tue, 23 Apr 2013 09:29:55 -0700
Message-ID: <7vhaixjjlo.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-2-git-send-email-artagnon@gmail.com>
	<CANiSa6i+jsZUBgeQcQq2C=d009dU=i6+g35-HoofedaEJRmzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:30:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUg6W-0004Le-95
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab3DWQ36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:29:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756483Ab3DWQ35 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:29:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60D6B199FA;
	Tue, 23 Apr 2013 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qx/9tPT6PBqB9clM17aT3YdC86k=; b=kse1wS
	sR7rnVcZAtvXplMkwVkfYcgm8bscQz/Nh93r9D02k8Z2/MPccFVii9yDPg8O9XvQ
	lU7vv1KwI9JFYh2sAkUdqhDwTcKBYA5oHFc8ytcrh3WMN6bFiBbUeKmG3NdisGnL
	fsp+dPTqClhHQnhMZadvUwbeR1fEAF6cogo0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vxzD7NfxUoFhPFff8SsCXeO82iw3kR9e
	XK0lOY1S3TYbTmc8soYU7jCflJ9psCTnbkSfFXf1C8vAH9wzuFmAbY/wnU2ObOrj
	AeDOcEOHJmAnLYcgw0KuI8Woez2TDVJqnQXEd7bQHxRJvXaiSvj6r7+6FYxK5Iwn
	kS09rKc2zB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58274199F9;
	Tue, 23 Apr 2013 16:29:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBBDD199F8;
	Tue, 23 Apr 2013 16:29:56 +0000 (UTC)
In-Reply-To: <CANiSa6i+jsZUBgeQcQq2C=d009dU=i6+g35-HoofedaEJRmzTg@mail.gmail.com>
	(Martin von Zweigbergk's message of "Tue, 23 Apr 2013 07:38:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08F03C2A-AC33-11E2-9A79-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222185>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Tue, Apr 23, 2013 at 7:01 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> When testing if the $dotest directory exists, and if $next is greater
>> than $last
>
> When can that happen? If one edits the todo?

More importantly, that condition is an unexpected error, which the
user may need to supply to help diagnosing the issue better, isn't
it?
