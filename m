From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] Reject non-ff pulls by default
Date: Wed, 30 Apr 2014 12:52:15 -0700
Message-ID: <xmqqppjyegsw.fsf@gitster.dls.corp.google.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqr44eg0s0.fsf@gitster.dls.corp.google.com>
	<53614470489f9_f9b15012ecbc@nysa.notmuch>
	<xmqqy4ymeihb.fsf@gitster.dls.corp.google.com>
	<53614d8c23d6_2aa5fa32f06@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:52:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfaYO-0007sr-J3
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbaD3TwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:52:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965070AbaD3TwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:52:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82A617FB3E;
	Wed, 30 Apr 2014 15:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nUNDe16CshWy0WxzGcbRkEfmPck=; b=EpPOKM
	6Jitj54Ug8ldr7XgL7MuJMtCPl63CHjPK+X/W68EcGIeb4fDi2in/4xhMGHGLLVt
	4OXK+TT1wSMUHin+j58DSH4jCuXbE3RlVjEHwZ+nwremkxRSznJNzZQfuKRQJkq0
	gd2zyKI+eGHM2KC4WlnV6ll6Fqz5+DeLygBSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oZ2IlYo9EzZ49QosQKCqnp2usjU13wPb
	/r8XqYe5J8wrZlF2ZnpBE+/4mkdm8C45VtwfbISZO6Nmmj6YGdWyuHAazKSngJZC
	OFCo4uXsUHDsjhQOWN8r25X+qeba6XMSdx4gwJ4n9KCD/nKpr+R0cK3LIRimKHkW
	SyhUNW6nnsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AEE17FB3C;
	Wed, 30 Apr 2014 15:52:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B7297FB3B;
	Wed, 30 Apr 2014 15:52:17 -0400 (EDT)
In-Reply-To: <53614d8c23d6_2aa5fa32f06@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 30 Apr 2014 14:22:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EEDCF9AC-D0A0-11E3-9B03-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247766>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> ...
>> > This plan, however, fell off the cliff.
>> 
>> Yeah, I see that $gmane/234488 explains why the second step in the
>> previous one stopped.  I guess it was in expecting a reroll state,
>> waiting for that other topic (I do not remember offhand) to
>> graduate.
>> 
>> I see nothing touching the affected codepaths now, so this time
>> around we may have a better chance, perhaps?
>
> A chance of what?

A chance not to have the plan "fell off the cliff".

> Do you want me to reroll to include the future
> backwards-incompatible change warning?

Yes, as I said in the other thread ($gmane/247758), if you do not
have that step yet (I haven't looked at the implementation while
discussing the design in this thread and looking at patches in other
topics) I'd strongly recommend adding one.

> Should I include the patch that turns the switch?

Sorry, but you lost me here.  Turns what switch to what value?
