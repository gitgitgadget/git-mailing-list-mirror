From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show help message also for aliased commands
Date: Wed, 17 Feb 2010 18:13:08 -0800
Message-ID: <7v635vwatn.fsf@alter.siamese.dyndns.org>
References: <1266456562-88841-1-git-send-email-patrick.sudowe@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Sudowe <patrick.sudowe@rwth-aachen.de>
X-From: git-owner@vger.kernel.org Thu Feb 18 03:13:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhvti-0007ex-F5
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 03:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab0BRCNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 21:13:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab0BRCNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 21:13:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 260D09AC94;
	Wed, 17 Feb 2010 21:13:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pEd4+2tawZiJtCtSTuATE7/tL9U=; b=j2ta4a
	O0SIymTvPHj06ZdU4FMCNvhODzl3eNWatfQ9ePOIWUuNKdmp1nuBs1uV5QDtSGk2
	hzW5iPUUvVzyjBQ45TCEezt16+msAOgHoh0hwycmTwllMdg11hv0h3g3zNu54AGb
	Eox9rc3vf9JnAo5eZLEMnwPUG8wE5cJMd2pwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UNFMHuTZ1p1OAk60YJQp2KlNn6/bp/+O
	7hNPdUMNdoBkHsgFuPk8XCAM1YMjKYLNbagkeFAqKQsWBzuQDyWVvkIDOao/QRxh
	MvS1YgDzlVxqV9TSiJWWzZ8xKbUhEkuko2O+z69aXvIm6xGfDsh1/hdy/LkP3X3a
	/vZNk6aEnQw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0EAA9AC8F;
	Wed, 17 Feb 2010 21:13:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 941C59AC88; Wed, 17 Feb
 2010 21:13:28 -0500 (EST)
In-Reply-To: <1266456562-88841-1-git-send-email-patrick.sudowe@rwth-aachen.de> (Patrick
 Sudowe's message of "Thu\, 18 Feb 2010 02\:29\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3997609E-1C33-11DF-8C6B-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140287>

Patrick Sudowe <patrick.sudowe@rwth-aachen.de> writes:

> git help 'alias' currently only shows the actual git command
> 'alias' refers to. This patch changes the behavior so that
> the help for the actual git command is shown.

I somehow think this is a horrible change.

I have "[alias] lg = log --oneline --no-merges" and I do appreciate that
it tells the expansion, because I also have other similar ones like
"[alias] lgm = log --notes-ref=amlog", "lgf", etc.

I don't want the expansion to be erased by manual page of "log";
typically the output from man is piped to less(1).

Besides, I may not know what "log" does, but at least I studied what
options it takes when coming up with the hardcoded leading options
already.  I don't want to see the manual page of "log" by default when I
ask git about "lg".  If git tells me "lg" expands to "log --oneline", and
I do not remember what other options "log" takes, I'll ask git myself
about "log", not "lg".
