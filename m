From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2010, #03; Wed, 07)
Date: Wed, 07 Apr 2010 23:33:08 -0700
Message-ID: <7vwrwi78t7.fsf@alter.siamese.dyndns.org>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
 <4BBD7228.8080403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:33:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlIu-0003Be-D1
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204Ab0DHGdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:33:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758166Ab0DHGdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:33:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 516BFA9B3D;
	Thu,  8 Apr 2010 02:33:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=20zsDA2GM1k7ib5ac1pOi1mZL7Q=; b=vfO+OZ
	8sH5BdLQtYMC07WIaprYpiklbjelqa2K41cgnsM3rwq6Jdqg6Gi7ns67S5OZ62CU
	LY4ADct0uJsKL9Fp6of0XmRsm0El3H+r5HslfrDSaV4DXGmKaG+KXdewZ+Oq40Z0
	0JSKPjxesbWvrwWRBNNl8ZRLInm818PkslOI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hIOBt3yObvqECL0yCn4f5MTaRj77sTtA
	BlLGGUK45TL5meK/ce3mV9dS1viGAcV7fjjaozb4gjpTMcVH5AVAwIO2LtRkAhGT
	0m+Cs8ZoUyY7uo7zhlj8XlP0+7ukgPzTiphgIQm6kALxMGbwa9UJB5EZYSgzKCPD
	z/coxGpF8QA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30304A9B3C;
	Thu,  8 Apr 2010 02:33:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92DD7A9B3A; Thu,  8 Apr
 2010 02:33:09 -0400 (EDT)
In-Reply-To: <4BBD7228.8080403@viscovery.net> (Johannes Sixt's message of
 "Thu\, 08 Apr 2010 08\:05\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9AC9B580-42D8-11DF-A89F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144325>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/8/2010 2:48, schrieb Junio C Hamano:
>> * np/malloc-threading (2010-04-07) 2 commits
>>  - Make xmalloc and xrealloc thread-safe (addendum)
>>  - Make xmalloc and xrealloc thread-safe
>> 
>> Updated with Freku's "init_recursive_mutex()".  The fix should eventually
>> go to 'maint' and 'master'.
>
> The addendum does not compile on Windows. I'm working on a replacement.

Thanks.

> BTW, are there Unices that do not have a recursive mutex?

PTHREAD_MUTEX_RECURSIVE is not marked as optional in any way, so I would
imagine an implementation that lacks it would say NO_PTHREADS in the
Makefile.

Cf.

  http://www.opengroup.org/onlinepubs/9699919799/basedefs/pthread.h.html
