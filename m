From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add `[decorate]' configuration section.
Date: Wed, 17 Feb 2010 09:50:35 -0800
Message-ID: <7vr5ojwy38.fsf@alter.siamese.dyndns.org>
References: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 18:50:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nho2z-0003NE-Iv
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 18:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab0BQRuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 12:50:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0BQRun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 12:50:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 45E959AA6A;
	Wed, 17 Feb 2010 12:50:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cmzY4ljsYMrULsnb6Dd9X7ZSXVo=; b=kpP8m+
	wuYkovxInG278ZEY0y0XdjQw9wcUTTiBBDs5CDds/8bOdipbE/JQjwik7WmrdIwy
	YjKEbAaz49LKANuWsASmxP2EoE3EU7DCL4c5r5dQOY9BybITmVQ/QPsoZT25++rb
	VUDW46tRXdMyw+c/UManFN1suCLf0dEj0ZcVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rrkzPhRwFGNqXuatN1HMjYnAPFc5hl1S
	4aXyqHJoE5ea3ptaU7uaEr9SJRdMRcnMeXkvFdyx9JjNejOHe8UlJT6QATg7bQFR
	ZYY/DxzCWtATo3mFCQOZUK3iAFDTahJ0RfGk8lxUpgX8ZGQlq6Fr4XPiWVQRDsr1
	ORXDBrL0L1I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ED3C9AA62;
	Wed, 17 Feb 2010 12:50:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72F779AA5E; Wed, 17 Feb
 2010 12:50:37 -0500 (EST)
In-Reply-To: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz>
 (Steven Drake's message of "Wed\, 17 Feb 2010 21\:22\:46 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F62F7508-1BEC-11DF-BEC6-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140239>

Steven Drake <sdrake@xnet.co.nz> writes:

> This can be used to enable the display of ref names of commits that are
> shown by log commands.  Each of the log commands (whatchanged, show,
> reflog, and log) can be enable separately.
>
> e.g:
> 	[decorate]
> 		log
> 		reflog

What is the reason to set these configuration differently except "because
we can"?  Also, if it is a good idea to allow setting them independently,
you would need to make it easier for people who want to set them all to
the same value, e.g. "[decorate] logfamily = short" or something.

I somehow find the older "log.decorate" much more natural and the changes
from it to this version not worth it, but maybe it is just me.
