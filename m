From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Wed, 12 Mar 2014 09:59:05 -0700
Message-ID: <xmqq38innyjq.fsf@gitster.dls.corp.google.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>
	<xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>
	<531D51EC.6050503@gmail.com>
	<xmqqk3c1rfqj.fsf@gitster.dls.corp.google.com>
	<xmqq7g80r1pm.fsf@gitster.dls.corp.google.com>
	<53200C1A.7070002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 17:59:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNmUv-0004bO-FR
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 17:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbaCLQ7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 12:59:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbaCLQ7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 12:59:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EF45715AC;
	Wed, 12 Mar 2014 12:59:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ZJVWGNfhAstUXipwGTuryUMiWU=; b=lhYMBZ
	lwHTpyh8bqNlmltsnuHkl6/Ja5BHbkNrP+bn71N3mfaVltGwEhNNr+PCxEtCCT6N
	sVxPjEr7Ejyl11Ou1YVC/OZC2r9mZsCkTANJI3waB8LeSrbf2ciJY9h/ZSPz1e3d
	PRvZc+FqGceskp22tWjln7Lhb8f3t/VkijZ0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BFq3MrfSjDU7/XETYlIf0Zqz2SdV04FE
	PyZCGtyCjQ0yfm/W0mHH0pl2ogwTj/ciAqdOK8EJx5j9+vRc1dP6hJMZV+zoT/IZ
	jE7Jr6YLz53kzMOOQsGP9j37Ur0eKM6+bZ43W89qn31HpHeDEjC3I8RQ/daOXejV
	Z60j/PbgUso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A93D715AA;
	Wed, 12 Mar 2014 12:59:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4F0D715A7;
	Wed, 12 Mar 2014 12:59:07 -0400 (EDT)
In-Reply-To: <53200C1A.7070002@gmail.com> (Ilya Bobyr's message of "Wed, 12
	Mar 2014 00:26:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A01A2570-AA07-11E3-8A12-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243945>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> I though that an example just to describe `argh' while useful would
> look a bit disproportional, compared to the amount of text on
> --parseopt.
>
> But now that I've added a "Usage text" section to looks quite in place.

Good thinking.

> I was also wondering about the possible next step(s).  If you like
> the patch will you just take it from the maillist and it would
> appear in the next "What's cooking in git.git"?  Or the process is
> different?

It goes more like this:

 - A topic that is in a good enough shape to be discussed and moved
   forward is given its own topic branch and then merged to 'pu', so
   that we do not forget.  The topic enters "What's cooking" at this
   stage.

 - Discussion on the topic continues on the list, and the topic can
   be replaced or built upon while it is still on 'pu' to polish it
   further.

   . We may see a grave issue with the change and may discard it
     from 'pu'.  

   . We may see a period of inaction after issues are pointed out
     and/or improvements are suggested, which would cause the topic
     marked as stalled; this may cause it to be eventually discarded
     as "abandoned" if nobody cares deeply enough.

 - After a while, when it seems that we, collectively as the Git
   development circle, agree that we would eventually want that
   change in a released version in some future (not necessarily in
   the upcoming release), the topic is merged to 'next', which is
   the branch Git developers are expected to run in their daily
   lives.

    . We may see some updates that builds on the patches merged to
      'next' so far to fix late issues discovered.

    . We may see a grave issue with the change and may have to
      revert & discard it from 'next'.

 - After a while, when the topic proves to be solid, it is merged to
   'master', in preparation for the upcoming release.
