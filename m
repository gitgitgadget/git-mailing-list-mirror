From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-id: Add support for mbox format
Date: Fri, 16 Apr 2010 11:30:35 -0700
Message-ID: <7vk4s7cks4.fsf@alter.siamese.dyndns.org>
References: <1271434948-14134-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 20:30:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2qJV-0000bg-0b
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 20:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab0DPSan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 14:30:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158Ab0DPSan (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 14:30:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 896DCAB247;
	Fri, 16 Apr 2010 14:30:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b12esTSEUGNcpVRCtkZ8AadXAz8=; b=fc278t
	+o8hd4v0CR9BaJbP+5FzunEzw2eKayN71kYYWS29WJr/HqFe4z9eC8ibfn/GXLM8
	GqwUNhPkEERuP8wpuAdZ9LnfwCiKLlVErz9yTmomXjedEkaA5EZDJiO7B0soGOfR
	vK4ai7H7OCjuxeGa/NmFbNZpd0KSsh0LCC3ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hqoO+4VBHtTLpm3SfFRdV1HnYHnOsBVL
	72n+F1z1jiUX8lpDQh9bUqYPXQYztT0jpNZyTdOajswu6H3kb/StqM6uEpphINcm
	FqlaEDlE6VeiN6XbGxGjKVN3NcnYkpEoRG4GNnhMEXzSW/Xu4vNPY/cvFquojCIR
	V9DrmcmtWwk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 671A3AB246;
	Fri, 16 Apr 2010 14:30:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8A95AB245; Fri, 16 Apr
 2010 14:30:36 -0400 (EDT)
In-Reply-To: <1271434948-14134-1-git-send-email-bonzini@gnu.org> (Paolo
 Bonzini's message of "Fri\, 16 Apr 2010 18\:22\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 283C4488-4986-11DF-A586-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145092>

Paolo Bonzini <bonzini@gnu.org> writes:

> I have an alias that takes two arguments and compares their patch IDs.
> I would like to use to make sure I've tested exactly what I submit
> (patch by patch), like
>
>    git patch-cmp origin/master.. file-being-sent
>
> However, I cannot do that because git patch-id is fooled by the
> "-- " trailer that git format-patch puts.
>
> This patch adds a bit of lookahead to git patch-id in order to detect
> the trailer and split the patch when it comes.  In addition, commit
> ids in the "From " lines are considered and printed in the output.

How well does this interact with mime encoded output?

I somehow have a feeling that this is solving a wrong problem.
