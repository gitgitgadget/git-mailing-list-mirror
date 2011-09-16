From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: a lone "-h" is asking for help
Date: Fri, 16 Sep 2011 13:53:48 -0700
Message-ID: <7vpqj0dx9f.fsf@alter.siamese.dyndns.org>
References: <7vobykfj7g.fsf@alter.siamese.dyndns.org>
 <CAGdFq_h474OrLzP+CHj_eSdSp53n8x7jz1ORT16dOhvRdQMP+g@mail.gmail.com>
 <7vehzgfffw.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hug3zNwvDZ3c8iG-F8jJSuxsuFghMWtWTmUTdfTrWiqg@mail.gmail.com>
 <7v1uvgfcur.fsf@alter.siamese.dyndns.org>
 <CAGdFq_jc4YDaD+NL6_+buCrOt2yAK+-_MDOJQU5qnS13P65CzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:53:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4fQ6-0003sA-2e
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 22:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab1IPUxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 16:53:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490Ab1IPUxw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 16:53:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9746577D;
	Fri, 16 Sep 2011 16:53:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yO3BGUmOTbG/S2GnKftckbFJ91I=; b=AUSF1B
	xnfzlUSAxftd6PAh8eFZ237KhG0P3aFhrdiwPFogpWqgvTdns2X4amEKt9iNze1x
	3KSkyb/+yGXhbNNqB79HfPdjy/1Qm46HUej7qncrgf9yJdUBKIRWyWNW8LZVRUAP
	h9ZK6lvVREN9ucBj4z5LKAnOivQ0lOqrZM+Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hv6tUcOHJ3UXbA9IuE2d5yE47O6Ng6fI
	TKE16QovlZ5XYUwwtQAw29AuptnvqTdKqIS1ob6WSDKxt2v3NcH+3d0j0XIvxwTg
	aOInANroZhN4dnTp2rHgauyPMQPnXm38TaYX0JVEmXlBCS7WZjhWKzqr9pWGMlHv
	WkBF6LFVVZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A15E8577C;
	Fri, 16 Sep 2011 16:53:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33ECA577B; Fri, 16 Sep 2011
 16:53:50 -0400 (EDT)
In-Reply-To: <CAGdFq_jc4YDaD+NL6_+buCrOt2yAK+-_MDOJQU5qnS13P65CzQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Fri, 16 Sep 2011 22:34:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAC026E2-E0A5-11E0-92E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181556>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> ... Should we have some way to queue patches like
> this, or would someone have to resend after the appropriate release?

For this particular case, I do not think it is worth _my_ time to keep
maintaining that patch.

It is understandable that a new person will be hurt if

	$ git ls-remote -h

does not give a short-help message and instead try to contact and show the
origin repository which may not even exist, and that is why I sent a fix.

But would anybody gets hurt if

	$ git ls-remote -h origin
        $ git ls-remote -h git://git.kernel.org/pub/git/git.git

kept working as they do today, given that we do not advertise -h as
a synonym in "git ls-remote -h" output?

That is why I said "I am not opposed to", and not "I'd volunteer to do
that". It's not worth my time, but since you brought it up, you may care
more about it.
