From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Mon, 09 May 2016 09:19:44 -0700
Message-ID: <xmqqlh3jxkyn.fsf@gitster.mtv.corp.google.com>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
	<20160503235652.GA395@google.com>
	<xmqqd1p1frw4.fsf@gitster.mtv.corp.google.com>
	<20160508220127.GB59077@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 09 18:24:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aznuS-0003cy-33
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbcEIQTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:19:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750927AbcEIQTr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:19:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68156178CF;
	Mon,  9 May 2016 12:19:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vyZX/FaRxbruSRY0y4VIZFySdhg=; b=Q7+p7m
	L8ffdetuqa1a2he0HM19AJKTuUQmyoD0/gSv99E1SFnPu4BxINubtksRvVkD9CGv
	+JTnF8dEcS3QBQjT02yKdu3Sxyp3BV1LSUTv/DINJWp+Pr6xz3VA532+Tjb0n3Z+
	CzzLo0Jq4TG40Vei4s+oyKVAmXTN+n8P+H2Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qR8uJ9ojqDXQHO3RXvi3Vso6E8ZUNzyC
	+2UBWMjpVuhED2oY9hzauVHROVy0baqI7MIxCwAurBaTd4gj10ukJ0ZnjMzGgl3Q
	WDQwihStc8ok2jkAvCPaTdj5BWZSHm+oW2bFv/2EuHf+pfrWQHrnKI0uELEBD34L
	RCFY9e0In9Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FBFB178CE;
	Mon,  9 May 2016 12:19:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAF36178CD;
	Mon,  9 May 2016 12:19:45 -0400 (EDT)
In-Reply-To: <20160508220127.GB59077@book.hvoigt.net> (Heiko Voigt's message
	of "Mon, 9 May 2016 00:01:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D82EB47C-1601-11E6-BC26-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294009>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> > - When upstream adds a new submodule, I have to do the same manual
>> >   work to change the options for that new submodule.
>> 
>> Because a new module is not automatically "init"ed by default?
>> 
>> Isn't "config only" vs "config with gitmodules fallback" orthogonal
>> to that issue?
>
> What do you mean with "orthogonal to that issue"? AFAICS a gitmodule
> fallback does not have that issue.
>
> Actually I would see it more like:
> .gitmodule is the default and .git/config a possibility to override.

The way I read Jonathan's "I have to do the same manual..." above is:

  Back when I cloned, the upstream had one submodule A.  I didn't like
  some aspect of the configuration for that submodule so I did a
  customization in [submodule "A"] section of .git/config for it.

  Now the upstream added another submodule B.  I want a tweak similar
  to what I did to A applied to this one, but that would mean I need
  to edit the entry in .git/config copied by "init" from .gitmodules.

I do not see how difference between ".git/config is the only source
of truth" or ".git/config overrides what is in .gitmodules" would
matter to the above scenario.
