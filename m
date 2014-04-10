From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for commit attributes
Date: Thu, 10 Apr 2014 10:26:17 -0700
Message-ID: <xmqqfvllxfie.fsf@gitster.dls.corp.google.com>
References: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com>
	<CACsJy8BJw3+=vSHzfBYigoK6ejt-DNHJPTcOWS3Nv=zxpF1f7g@mail.gmail.com>
	<xmqqk3axxfoh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Diego Lago <diego.lago.gonzalez@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 19:26:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYIk6-0000k0-5t
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 19:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578AbaDJR0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 13:26:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbaDJR0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 13:26:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7815D7A5B2;
	Thu, 10 Apr 2014 13:26:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QV+9j1JrpgM0iFTgKghqREnUKGU=; b=B1bbW8
	QIRm32idbuwnpZKOGOTTlCFhF4hVvaXK53A5qgT5UL2QPmnJxPrchLKYcPN3L0rQ
	J8T5VRKISAFFYfhIUQGuF/P6IF6ajwNO953yJstInY697/akml2DVnh0ZQtOiSl4
	tOO9ZdCwiAqkfSX2N9LyUCKhyXRNBAqg/IrwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uckqyuVYLNDud5A6AcV2eDvkS0lBBxL1
	OErCXQvSl7rpZ9VRp5s5q0PDuw0TaRQJSP9UkPhTVNVNFlCbsw7sVx29FrdCnSw+
	UB3vVG8/wPfIVWzVHbO/CEcrKEAETY0mMJohhcyv3tJlyHi8jpL0+bpxjqyHBgso
	pCFjX8Fb5RI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63DF57A5B1;
	Thu, 10 Apr 2014 13:26:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39B167A5AC;
	Thu, 10 Apr 2014 13:26:19 -0400 (EDT)
In-Reply-To: <xmqqk3axxfoh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Apr 2014 10:22:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3A7359D2-C0D5-11E3-977E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246020>

Junio C Hamano <gitster@pobox.com> writes:

> I actually think this "recording information about commits" is
> exactly the use-case notes were invented to address, and if it is
> found cumbersome to use, the reason why it is cumbersome needs to be
> discovered and use of notes needs to be improved.  Hooks and/or a
> wrapper around "git commit" to implement their custom workflow may
> be involved as part of the solution and "git notes" may need to
> learn a new trick or two along the way.
>
> I am not interested in hearing "let's add random crud to commit
> object header" before "let's improve notes so that it can be more
> smoothly used" is fully explored.

Oh, I forgot to say that I do not have anything against embedding
the extra info as part of the free-form "log message" text part of
the commit object like you have been suggesting.  If the information
can be cast in stone at the commit time, that would actually be
preferrable, as you do not have to worry about transferring notes
separately.
