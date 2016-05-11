From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: only add a no-op pthread_sigmask() when needed
Date: Wed, 11 May 2016 14:01:17 -0700
Message-ID: <xmqqvb2kjoma.fsf@gitster.mtv.corp.google.com>
References: <26c2fb5560246fc7f980da24a239edc333864527.1462885167.git.johannes.schindelin@gmx.de>
	<xmqqvb2lpzij.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605111655350.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 11 23:01:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0bG2-0006FC-7E
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 23:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbcEKVBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 17:01:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751391AbcEKVBV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 17:01:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC70E19131;
	Wed, 11 May 2016 17:01:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9QPkmEHa/frvADLtiZzNM3rIqx4=; b=GOcEN8
	tdVDz4mIYQtmak+/tjhU23TfC9KoKtMD5BMhkilkFaJKLb1tW5eFrW0FHCAWGJcS
	PGI/3+++1Aoci5+b+zsy5Eovq/hXlKjrvwebe2dnd6GLaglpYugBcALVyIsycfMW
	X7NyN0eyMDl3jEevIC2vtSufw/eERYx2yrYZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NDf9gQSWPveVtAL9lYxTRO2uyVb28I9r
	5kaQPqyzp6iNlZhcJcGnmb+EyPtArOf6FPcYBWPUvl4x1yURvCQ4G05lEfKUpJ9N
	KEgN5Ce0Cyqd2IrVTMBLJdCA25TuG1sWoSmWqZBxgG28ai6jrYy+5RR2xA+/vURm
	pf6+D0At1Cc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2D1D1912D;
	Wed, 11 May 2016 17:01:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DA641912C;
	Wed, 11 May 2016 17:01:19 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605111655350.4092@virtualbox> (Johannes
	Schindelin's message of "Wed, 11 May 2016 17:06:26 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8245B32E-17BB-11E6-89F0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294364>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I guess that you're preferring my 2. above. Going on that assumption, I
> will send out another iteration.

OK.

>> Also is
>> https://lists.gnu.org/archive/html/bug-gnulib/2015-04/msg00068.html
>> relevant?  Does /mingw64/x86_64-w64-mingw32/include/ implement "macro
>> only without function"?
>
> Yes, it has that problem. Do we care, really?

Not really.  I was curious how actively this area is evolving;
knowing that would help me judge pros-and-cons between your 1 & 2
above.
