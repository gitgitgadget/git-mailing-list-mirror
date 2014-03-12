From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][GSoC] parse-options: Add OPT_SET_INT_NONEG.
Date: Wed, 12 Mar 2014 11:30:11 -0700
Message-ID: <xmqqr467mfrg.fsf@gitster.dls.corp.google.com>
References: <1394535016-9424-1-git-send-email-yshuiv7@gmail.com>
	<CACsJy8Dq5QyZdzCtew0qF37qThH8+05iTrD-ZOeBgbEukmCY5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yuxuan Shui <yshuiv7@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:30:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnvD-00043W-0I
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbaCLSaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:30:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbaCLSaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:30:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C2A271C09;
	Wed, 12 Mar 2014 14:30:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g/GccttqMqia9E01Nwt6ou2bVrY=; b=RG3RNX
	ztaBal1B91zUhFQEnfL6C9dM2uQ1xmnb0IVvQfYGxXmEFNxrcELnmRdPct4B907/
	COqeRd1Goh29r9PjaoMc0RWbYJMn/GtoikJh+Pnm0lz2zOhsBeKFspzq7mnajPLu
	IfVXK5MlEyckMYIc2fbppnJLu1UJ0/GY8bEQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m3jsPRu2nNa9jo/ro3W6gCG0OUBKml/V
	HxVs5vh2FXOEQBH1Fqzz/W9K7Xu8mywe2+vM/ucYcVhsav7Xru1uZULzTFP4Y2pT
	D37aG0BO7NVpAfLfIqlGyX/IAUXF2cobpW+5Z1IN4Y46GjSaLUlwhNLDTzJLDY0/
	TwEHO/AQ5Kc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 321C371C07;
	Wed, 12 Mar 2014 14:30:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4399C71C05;
	Wed, 12 Mar 2014 14:30:13 -0400 (EDT)
In-Reply-To: <CACsJy8Dq5QyZdzCtew0qF37qThH8+05iTrD-ZOeBgbEukmCY5Q@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 12 Mar 2014 17:47:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 59BCE60A-AA14-11E3-A5DC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243955>

Duy Nguyen <pclouds@gmail.com> writes:

> By convention, no full stop in the subject line. The subject should
> summarize your changes and "add ..NONEG" is just one part of it. The
> other is "convert to use ...NONEG". So I suggest "parse-options:
> convert to use new macro OPT_SET_INT_NONEG()" or something like that.
>
> You should also explain in the message body (before Signed-off-by:)
> why this is a good thing to do. My guess is better readability and
> harder to make mistakes in the future when you have to declare new
> options with noneg.

As I said elsewhere, I am not sure if doubling the number of
OPT_<type> macros as your micro suggestion proposes is the right
solution to the problem.

What are we trying to solve?
