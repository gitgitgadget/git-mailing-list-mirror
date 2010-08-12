From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked
 files
Date: Thu, 12 Aug 2010 13:00:52 -0700
Message-ID: <7viq3fsirv.fsf@alter.siamese.dyndns.org>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
 <vpqsk2kjks7.fsf@bauges.imag.fr>
 <AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jens.Lehmann@web.de
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:01:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojdxh-0006w5-ER
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab0HLUBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 16:01:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0HLUBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 16:01:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E286BCD21D;
	Thu, 12 Aug 2010 16:01:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bWRoJlw2hyZ74i3+RYN16cNYpYE=; b=gGxm5Z
	q2vO8Xy5j2GvKVZzzJbXCgpT9dSF9/MQs6yBVISy2kR1rfvfx3aER7OIKxdH6bP3
	5SEmf6kLsDIKmx+rUCHACg0AKycoijHckD81Ifcq/Ht+Z8l6ksQj+wZdCugz6Iv+
	lT0rucOVPyKbYrLliK2J1ubk9sy170MEShxN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZktEfENFazGOQNWvfncg94eP/DwxUd+Z
	7+piue+90D61BYEwurB7wBX4CgBjlbrlQTfV3e7MGT/PPugqOJX/XFSR2VqreVJ+
	qM1ZyBfgb3XYjYhEsHQXC2kO3Ouio4koMJ10H3CxoMmtE+tPSRuBtgeCGLL6di9d
	+eJERcCgeKg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 95AF9CD21C;
	Thu, 12 Aug 2010 16:00:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA7C3CD21B; Thu, 12 Aug
 2010 16:00:54 -0400 (EDT)
In-Reply-To: <AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
 (Greg Brockman's message of "Thu\, 12 Aug 2010 11\:54\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53AAE70A-A64C-11DF-851F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153404>

Greg Brockman <gdb@MIT.EDU> writes:

> First of all, as you point out 'git add foo.pdf' works where foo.pdf
> has been explicitly ignored, while in contrast 'git add dir/file'
> fails when file has only been indirectly ignored because it is in an
> ignored directory.  In the former case, the user explicitly specified
> a policy for that file.  In the later case, the policy is only
> indirectly expressed because that file happens to be in an ignored
> directory.

Sorry, but I don't get this argument.  When the user says "everything in
this directory is ignored", why does it make it less direct than "this
particular file is ignored"?
