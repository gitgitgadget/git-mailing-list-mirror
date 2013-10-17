From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2013, #03; Wed, 16)
Date: Thu, 17 Oct 2013 14:07:32 -0700
Message-ID: <xmqqmwm7y5bf.fsf@gitster.dls.corp.google.com>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>
	<525FB287.7020204@gmail.com>
	<xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 23:07:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWunE-0000OZ-QT
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 23:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762821Ab3JQVHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 17:07:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762372Ab3JQVHf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 17:07:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE1DC4B35B;
	Thu, 17 Oct 2013 21:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LPGgjZTvCqD+76SiFmrin2q2gL0=; b=gitCpn
	VdzTb553+id/Axq91Dmb7uPfX49+fRHbX9QXLcW8d4jymYiX4EvoYySCSQTeMYGO
	FfnoLGSWhcULkIu4zE7fGQJIlfJ2ACtGSdd8QHgOGSryVdvqr3gd6LM09BLpy0+s
	VZTRRQdlzu8o8yRQHv+OUXnUw0lOmza8HALRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=COnSFbyVcLF25lvVLG0L9q5cSY1KchZa
	yYTR5TYu5b/eEin44mnbY9FY6mmg1z3NfVl/N2c0+BLOIVUjiHBmIUvBfI8z7oGR
	+q0oR83BLti0u/0ZCY555w1b6FntxKmCtXUEkjUmv/i4BcaW2EsxKHtDpLY4rYhF
	f5YuLV2u/zM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D322C4B35A;
	Thu, 17 Oct 2013 21:07:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16DF34B34A;
	Thu, 17 Oct 2013 21:07:34 +0000 (UTC)
In-Reply-To: <xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 17 Oct 2013 13:40:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 24978D48-3770-11E3-89F4-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236320>

Junio C Hamano <gitster@pobox.com> writes:

> Karsten Blees <karsten.blees@gmail.com> writes:
>
>> Am 16.10.2013 23:43, schrieb Junio C Hamano:
>>> * kb/fast-hashmap (2013-09-25) 6 commits
>>>  - fixup! diffcore-rename.c: simplify finding exact renames
>>>  - diffcore-rename.c: use new hash map implementation
>>>  - diffcore-rename.c: simplify finding exact renames
>>>  - diffcore-rename.c: move code around to prepare for the next patch
>>>  - buitin/describe.c: use new hash map implementation
>>>  - add a hashtable implementation that supports O(1) removal
>>> 
>>
>> I posted a much more complete v3 [1], but somehow missed Jonathan's fixup! commit.
>
> Thanks; I'll replace the above with v3 and squash the fix-up in.

Interestingly, v3 applied on 'maint' and then merged to 'master'
seems to break t3600 and t7001 with a coredump.

It would conflict with es/name-hash-no-trailing-slash-in-dirs that
has been cooking in 'next', too; the resolution might be trivial but
I didn't look too deeply into it.
