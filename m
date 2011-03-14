From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash: status from current dir not top dir?
Date: Mon, 14 Mar 2011 00:29:51 -0700
Message-ID: <7v1v2agnww.fsf@alter.siamese.dyndns.org>
References: <4D7A8AC9.1030506@gmail.com>
 <20110311223232.GA21410@sigill.intra.peff.net> <4D7B358A.5010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 08:30:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz2EF-0007oE-Pf
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 08:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab1CNHaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 03:30:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab1CNHaD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 03:30:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 792672829;
	Mon, 14 Mar 2011 03:31:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iG+ioc4Ez5V8fLs5lteOwnc9KB0=; b=ZPpcI3
	qnhotBPhsxNwCA4jlQ/cuR6Ov2X/YyfQCfSfiiGnPMO8K9k+XZK8Uo7Q9WaU4wOy
	cZ0BkKO0O0EdaSEoKDCOvGYjHDRgZB5NJd807degdWmEfZKx5yVYpF3qrYeIE/dw
	z0NTLK4IeFQqKW0EmNhikWyALfiE4iUvmIOFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ieu+SvPICgfwX4pTGtRM2Rnia33/yGpv
	CUV1eho2qnBaA7i0b+XazAfQedHYXUrxf/qMYp4x0GseTP1fFiCkq8x3r1QOaRgT
	u8Y9ir6g8gwwpbqZLFCkdZM4vbGRqusR9JhT1gdM9cRpMs4d6pmrSLMgc0A+vbAG
	ZwSUZx3NI30=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 468B12824;
	Mon, 14 Mar 2011 03:31:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 446F92820; Mon, 14 Mar 2011
 03:31:25 -0400 (EDT)
In-Reply-To: <4D7B358A.5010101@gmail.com> (Piotr Krukowiecki's message of
 "Sat, 12 Mar 2011 09:57:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13A2E054-4E0D-11E0-A91C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168984>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Subject: [PATCH] git stash: show status relative to current directory
>
> git status shows modified paths relative to current directory, so it's
> possible to copy&paste them directly, even if you're in a subdirectory.
>
> But "git stash apply" always shows status from root of git repository.
> This is misleading because you can't use the paths without modifications.
>
> This is caused by changing directory to root of repository at the
> beginning of git stash.
>
> This patch makes git stash show status relative to current directory.
> Instead of removing the "cd to toplevel", which would affect whole
> script and might have other side-effects, the fix is to change directory
> temporarily back to original dir just before displaying status.
>
> Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
> ---

Sensible. Thanks.

Don't we want to protect this output with some tests?
