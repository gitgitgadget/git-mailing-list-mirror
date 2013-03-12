From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 13:39:17 -0700
Message-ID: <7vfw0073pm.fsf@alter.siamese.dyndns.org>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
 <20130312194306.GE2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 12 21:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFVz8-0005uh-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 21:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933530Ab3CLUjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 16:39:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514Ab3CLUjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 16:39:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A41C7A411;
	Tue, 12 Mar 2013 16:39:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qaj9o4aANDSqmYTrYZctVxaOu8w=; b=gbDMr5
	XyUUE3QTxITS2KvrAoQcn1iOJ/DdolpKkBlF1TRV4zaekKbG0OqBOixPSN43p7ur
	AqQ2ziExcqE3S/ukX8pk4YtB/hc/HcCIrP8xt1b9VUaeqJ95W17EcXjcqgFU2gCE
	Y8T9PJuRqzOCY8EODxOPNTvxkl7A5O1y/AeJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YQLuSHFj8jpmg8ppGfHjufp3st50cxaJ
	k60D98tlcZIaV49LACMNV3B7GeodXrV6ffaSq7P5amGWGnIRvJOmtM/gwgSeO7Q7
	ieQfvTU+qKPmMPo+/j8sM6dSs6HnMPx+F8QGYcDu/5Lvxnsa70AtG+tJMZMZzWca
	f00bCWnDJ1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9854EA410;
	Tue, 12 Mar 2013 16:39:19 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FB29A40E; Tue, 12 Mar 2013
 16:39:18 -0400 (EDT)
In-Reply-To: <20130312194306.GE2317@serenity.lan> (John Keeping's message of
 "Tue, 12 Mar 2013 19:43:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9CF3624-8B54-11E2-800C-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217992>

John Keeping <john@keeping.me.uk> writes:

> How about something like "--symlink-all" where the everything in the
> right-hand tree is symlink'd?

Does it even have to be conditional?  What is the situation when you
do not want symbolic links?
