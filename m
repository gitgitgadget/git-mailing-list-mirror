From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Mon, 07 Nov 2011 22:15:33 -0800
Message-ID: <7vd3d3ywai.fsf@alter.siamese.dyndns.org>
References: <4EB85768.1060508@avtalion.name>
 <20111107225508.GB28188@sigill.intra.peff.net>
 <7v4nyf1opf.fsf@alter.siamese.dyndns.org>
 <20111108054643.GC29643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ori Avtalion <ori@avtalion.name>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 07:15:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeyJ-0001sH-3f
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 07:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab1KHGPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 01:15:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab1KHGPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 01:15:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0312824FF;
	Tue,  8 Nov 2011 01:15:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4i1kKcdSasJhUzFIfB4yd8x6ITE=; b=GMdi13
	qn2edCfHdbFacX41Tp+q43lKCvuPUFxi/3+q+SbfZruyS3/KwHcaGVCxoGEXd6nI
	tcqL0klxdmDMZ1OkoQGbFmU6WGtsld96y1Nkv96y2abyu/L8Ed1MoMeACagZdMW/
	MT65RJlIYEqXr495BduTAv0lBktw3yKO0qtjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JBMts2/GtEblDZz2wkCWJQ9YoPjWpfKx
	DSxgcRIq+y2yR0oxf66qxCtvpUecPLvkw4FNmDZCExn+sfalYRWRkbJ1WN1uX9+Z
	ueYH5eNAtoYxLJbCOgdwPp8m5rws4jUWT1CFlIvxyShZ7XZcKpkXL+HwQGnYYwnP
	hrAEuudd2oY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE68824FE;
	Tue,  8 Nov 2011 01:15:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6592E24FC; Tue,  8 Nov 2011
 01:15:35 -0500 (EST)
In-Reply-To: <20111108054643.GC29643@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 8 Nov 2011 00:46:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12190044-09D1-11E1-BE50-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185075>

Jeff King <peff@peff.net> writes:

> But I think there are two questions:
>
>   1. Should am's 3-way fallback be made more easily available to users
>      of regular "apply"?
>
>   2. Short of doing a 3-way merge, are there better ways to represent
>      failed hunks in the patch target itself, rather than saving ".rej"
>      files?
>
> I'm actually not sure which one Ori was asking about.

Me neither, but if I have to guess it would be the former. If there were a
solution better than ".rej" in 2-way context, surely "patch" would have
implemented it 10 years before we started ;-).
