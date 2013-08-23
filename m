From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: search author pattern against mailmap
Date: Fri, 23 Aug 2013 13:44:48 -0700
Message-ID: <xmqqsiy0nnlr.fsf@gitster.dls.corp.google.com>
References: <1377265711-11492-1-git-send-email-apelisse@gmail.com>
	<xmqqbo4opajg.fsf@gitster.dls.corp.google.com>
	<20130823183541.GB30130@sigill.intra.peff.net>
	<xmqqwqncnsaz.fsf@gitster.dls.corp.google.com>
	<CALWbr2x28wrzxJ=M6meCX8G0Bh4ObvHkYGqfGTNwPjWMxgJjQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 22:45:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCyE7-0003Q1-QM
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 22:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094Ab3HWUo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 16:44:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755748Ab3HWUoz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 16:44:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A2803B6AA;
	Fri, 23 Aug 2013 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LONlLu4co4X9dm8ifV/ejVd3O8s=; b=DMTMhQ
	1n07n5rsLJxNAdoMIrqhFWcrWZ3nXyCMI/ryUdmkXuD4o6CQazsjFO60BYliyyUQ
	lCjhI4GsUjJk0VNh7L3R9v+pknOkwRT7TQw17mM3MhgdPgJxCdxflcF7lnPsTAld
	PI02KxqUdavDq9ZWw5iz4ooOsB2nhl1Xomj+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AC+ioFdTAUVTSIW5cSkXv01p/NIFdmth
	zW/jIE8SiGuZCKbu/MQHR0ypoo/D9Uc1I1IwX0R+W66IWx6KWlyBY0bO+zwBgDYY
	Ogmlhh97mVok7t5+wrQfAPm9+QP0ajx7gFrpTdW9msbCzo6l6hFqhR3WdgRQHUMe
	jahWFdhejnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 476913B6A9;
	Fri, 23 Aug 2013 20:44:52 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 779F33B6A8;
	Fri, 23 Aug 2013 20:44:51 +0000 (UTC)
In-Reply-To: <CALWbr2x28wrzxJ=M6meCX8G0Bh4ObvHkYGqfGTNwPjWMxgJjQg@mail.gmail.com>
	(Antoine Pelisse's message of "Fri, 23 Aug 2013 21:47:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DBB2BFD2-0C34-11E3-856A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232836>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Fri, Aug 23, 2013 at 9:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> OK, so how about labelling it as a bugfix, like this perhaps?  We
>> obviously need a test or two, though.
>
> OK,
> I will resubmit tomorrow with some tests.

Thanks.

Also, after I sent out that "like this" patch, I realized that the
mailmap string-list no longer has to be on the heap if we are doing
it unconditionally (it can be an auto variable in the function,
sitting next to "struct strbuf buf").
