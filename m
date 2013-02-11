From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow building with xmlparse.h
Date: Mon, 11 Feb 2013 14:35:04 -0800
Message-ID: <7vtxpijx7r.fsf@alter.siamese.dyndns.org>
References: <7vy5eujybf.fsf@alter.siamese.dyndns.org>
 <1360621855-19863-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:35:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U51yG-0007CL-VS
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 23:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778Ab3BKWfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 17:35:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932757Ab3BKWfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 17:35:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80621CAAF;
	Mon, 11 Feb 2013 17:35:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=icCAYDEEs2UF4Xk+4WWg6qo2WsA=; b=RMKeUA
	fJXzBlfU1JWm7pbqTbNdFJrgUVrEjNHtpGnQO72HzPXtPa495ArEFpWZyPoKi6u+
	4DW/KbW0Be7mhsdAjcpDw1fhbwMAvYxZR0w2A+I6PCIn64bnRKRopWi24c5Qxs8n
	aAarwNWrjefdIkMfHHhlyAeiBBoAuxm3ff7rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YmR0WbFsPmQvAu/Gfc0wn/H9udMhvLcw
	kub80Jvg/bcykGgTQSEnlEsvEixQ3qRpwYEdV2cGzmUfYV5rY+8au1oVwkpFN7mb
	XYQEFwE0y+mA4qlM2x8llh1IIS87WlWPoylqG68vJ9gUZtgGPgk73ndRtMeyiasD
	80f4UQmjQQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74406CAAE;
	Mon, 11 Feb 2013 17:35:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA932CAAD; Mon, 11 Feb 2013
 17:35:05 -0500 (EST)
In-Reply-To: <1360621855-19863-1-git-send-email-kraai@ftbfs.org> (Matt
 Kraai's message of "Mon, 11 Feb 2013 14:30:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4880DC0C-749B-11E2-9C0F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216102>

Matt Kraai <kraai@ftbfs.org> writes:

> From: Matt Kraai <matt.kraai@amo.abbott.com>
>
> expat 1.1 and 1.2 provide xmlparse.h instead of expat.h.  Include the
> former on systems that define the EXPAT_NEEDS_XMLPARSE_H variable and
> define that variable on QNX systems, which ship with expat 1.1.
>
> Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
> ---
>  Makefile         | 6 ++++++
>  config.mak.uname | 1 +
>  http-push.c      | 4 ++++
>  3 files changed, 11 insertions(+)
>
> I've changed #ifndef to #ifdef and changed the order of the branches
> in http-push.c.  If you'd also like me to rename the variable (e.g.,
> to NEEDS_XMLPARSE_H), please let me know.

I do not think renaming is necessary (the name you used in the
original and this patch is better than NEEDS_XMLPARSE_H).

I take that you also think the updated order is easier to read;
thanks for sanity-checking ;-).
