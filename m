From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule.<path>.branch vs. submodule.<name>.branch
Date: Thu, 27 Mar 2014 14:37:57 -0700
Message-ID: <xmqqsiq3coga.fsf@gitster.dls.corp.google.com>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
	<xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
	<5334606F.5010109@web.de> <20140327185405.GS4008@odin.tremily.us>
	<xmqqwqffctyg.fsf@gitster.dls.corp.google.com>
	<20140327210106.GV4008@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Mar 27 22:38:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTI06-0004Ub-QJ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 22:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbaC0ViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 17:38:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbaC0ViH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 17:38:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56C1A78FE9;
	Thu, 27 Mar 2014 17:38:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ipwY8UxURKA2MufPXd+LbFG0UN0=; b=cdZUDK
	47n/HTJj+aesU6sBFrZWFvkBw+/MM8qAVUodcAKMeu3AEGXv/CTIGmLL5a7Cwqyh
	fblco/9vQvgK5l3iDqoCvn2bV+Xx68PM2NesoxgWXb4XmlJUj7APFDUlg4gjmNUp
	ytKolbTa+VYDFucNulvVJa6gIuD26BaGcfOTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GJOdmiHFIUqkJHhEIkY6PzgTMPhPDWJe
	030/J7LD8haCUiKHF8emH+XcvMyQ7MtUcawji+L+Rx8xiFDKz1deE6+eMt3FoLhq
	V6nEGeAPBIVam5EG1oCx/9T8QNaCjXXHC6So4WK6qkwiYUDYhUh9/Bg27Hjt6SHN
	2sa3Zxcm+G8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FED578FE8;
	Thu, 27 Mar 2014 17:38:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B83878FE5;
	Thu, 27 Mar 2014 17:37:59 -0400 (EDT)
In-Reply-To: <20140327210106.GV4008@odin.tremily.us> (W. Trevor King's message
	of "Thu, 27 Mar 2014 14:01:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 11213208-B5F8-11E3-AC1F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245328>

"W. Trevor King" <wking@tremily.us> writes:

>>   [side note] Isn't that a typo of submodule.<name>.branch?
>
> Good catch.
>
> The transition from submodule.<path>.* to submodule.<name>.* happened
> in 73b0898d (Teach "git submodule add" the --name option, 2012-09-30),
> which landed in v1.8.1-rc0 on 2012-12-03.  

Thanks for digging.

Strictly speaking, I think this was not even a transition (rather,
there was no way to give a submodule a name that is different from
its path).  In any version of git whose git-submodule.sh has
module_name helper function, the path and the name were conceptually
two different things, and we should have been using the name, not
path, throughout.

> ...  Both should be updated
> to submodule.<name>.branch.

I agree.  Thanks.
