From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/4] Introduce "double conversion during merge" more
 gradually
Date: Thu, 01 Jul 2010 09:25:19 -0700
Message-ID: <7v630z41ao.fsf@alter.siamese.dyndns.org>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
 <3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com> <4C2C6BC5.1030905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 18:25:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUMa3-0004RS-O5
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 18:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab0GAQZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 12:25:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146Ab0GAQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 12:25:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B0DC048B;
	Thu,  1 Jul 2010 12:25:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DwOscZwN4CCESpIaIZtHgO18Gno=; b=NattIi
	SPBZ4pScHFELBQLtdEFm/tjj/7OoYHJxu3KBEjhoTDnojzSMZPyETQzqgktuPjJz
	EJdD7rHuEB3SNUfh9xUffoVWlv/BCyuxaMecpc/kV/D6Lg6rZe/gcoPlKmfcirGc
	pczvNq+0fM5oiY0E5r0S3XDc3L+kQ5P+R7Jes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WyyKroBgF3d6P0UuMIqKsP6cGLNNB1mx
	G7i55mbnzDtW/U3a6EWLa4oXjPV98keBh0BYHdnLedbTodauOtpYsdVf3YItmSd9
	CN2uI6bAAYK7I7mPH6n+GjMVRupmgfX5Ts7tYLuO8vgrl2MIAVJJux04zvQ2Prej
	jUKd3lTP0Bg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC279C048A;
	Thu,  1 Jul 2010 12:25:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 090D5C0489; Thu,  1 Jul
 2010 12:25:20 -0400 (EDT)
In-Reply-To: <4C2C6BC5.1030905@viscovery.net> (Johannes Sixt's message of
 "Thu\, 01 Jul 2010 12\:19\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 408D7D62-852D-11DF-A260-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150053>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 7/1/2010 11:09, schrieb Eyvind Bernhardsen:
>> +core.mergePrefilter::
>
> BTW, any particular reason that this is in the core namespace rather than
> merge namespace? It could be merge.prefilter.

Good point.

Somehow to me "prefilter" does not sound to convey what really is going on
here, though.
