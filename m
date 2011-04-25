From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] send-pack: avoid deadlock when pack-object dies
 early
Date: Mon, 25 Apr 2011 10:51:46 -0700
Message-ID: <7vwriijk25.fsf@alter.siamese.dyndns.org>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104142136.25778.j6t@kdbg.org>
 <20110414202110.GA6525@sigill.intra.peff.net>
 <201104142243.33522.j6t@kdbg.org>
 <20110414205113.GA7451@sigill.intra.peff.net>
 <7vsjtkfs10.fsf@alter.siamese.dyndns.org> <4DB48B2C.2090904@kdbg.org>
 <4DB48CCD.40304@kdbg.org> <20110425165007.GB1589@sigill.intra.peff.net>
 <4DB5B261.1080804@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEPx7-0005Wo-9J
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 19:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758690Ab1DYRwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 13:52:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587Ab1DYRv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 13:51:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87C3E5028;
	Mon, 25 Apr 2011 13:53:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/GQVDqJtE8I73RcEUwQIn/+FNo0=; b=T52lyy
	twrd6DYMArjDFZ/iNrq4X2ZPACYaHcpagCw1M9dtnHezh60o2oeMrQ7TkttaGdr8
	qDSi/6KHwOLuBhO0d23AVhOEn+R97LcCsxqL5vc7ApQPXFFUPGNUB8j0e3xnSPv3
	2Bb3Ilo6DfV6OkV+L40s6V0NRF6dHj0KuKty0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cxR4muO0mKgYPx4Y0A1BAqTNgbU+wRZR
	NzRp14q8b8Eg7hnkBjkhEukvdKsNkx6PsYqlaTAGI5xTH7wG9BoZa2hUUEoaRh48
	CE2uCxOBCi0BAERI5TfCyes2RfyJWBodqsWFQYlS10+beHsuXqN8UVjJXS7Ix6sQ
	ToIjsj/eDnw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52D995026;
	Mon, 25 Apr 2011 13:53:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3F90B5025; Mon, 25 Apr 2011
 13:53:50 -0400 (EDT)
In-Reply-To: <4DB5B261.1080804@kdbg.org> (Johannes Sixt's message of "Mon, 25
 Apr 2011 19:41:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCF6B762-6F64-11E0-96EE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172034>

Johannes Sixt <j6t@kdbg.org> writes:

> ... Therefore, I assumed that we use the
> former symbol to decide whether to use threaded async procedures.
> Obviously, the symbol was introduced only later. Will resend.

Thanks.
