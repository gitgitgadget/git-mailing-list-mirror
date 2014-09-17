From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unblock and unignore SIGPIPE
Date: Wed, 17 Sep 2014 16:02:31 -0700
Message-ID: <xmqq61glvojc.fsf@gitster.dls.corp.google.com>
References: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
	<xmqqd2av1bsg.fsf@gitster.dls.corp.google.com>
	<20140917081148.GB16200@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick Reynolds <patrick.reynolds@github.com>,
	git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 01:02:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUOFC-0007gt-HF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 01:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574AbaIQXCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 19:02:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55245 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198AbaIQXCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 19:02:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8AA3E3A178;
	Wed, 17 Sep 2014 19:02:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6X1DAxRa5+okh+Bp0W8FSdg7+7w=; b=T9CPa3
	vkrBXq51Qo0sq5KbjIBv/Sghn2EkJ3JPlMV0XIuPX+p9s0LRsBn6c2lWwJa0gW3b
	BzLXsezFR2Q+fw3ttINQIc9EHnNYmnkgJpP8Nr0+x9UnA1u9JWYv141hVP7sJEEb
	E8vzqOOxjtmdZ3Y4qROSBjS+u4s9QRXZNsV1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0NBHeJIpqoL0tlBxN0Hp2AS5rmBdiDs
	cY0CDW9eTkz0cdNL2PuxaIx09l6DSZTFcWNbW7AEEQn1OYAETtWLjzVkwmuzfEHy
	DobVpWgMK9UiZ34KrmCTB4VIu9rkq2Q+k9FbGBWfpnVYf0lFRH0dDgsZxF6KZsPF
	GeW0Z4i++sE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F3BC3A177;
	Wed, 17 Sep 2014 19:02:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 040413A176;
	Wed, 17 Sep 2014 19:02:32 -0400 (EDT)
In-Reply-To: <20140917081148.GB16200@peff.net> (Jeff King's message of "Wed,
	17 Sep 2014 04:11:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B50E46E0-3EBE-11E4-88D2-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257252>

Jeff King <peff@peff.net> writes:

> I see in your proposed patch below you put them into t0000. I wonder if
> t0005 would be a more obvious place.

Yup.  That is a good idea.
