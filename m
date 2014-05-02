From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 12:53:45 -0700
Message-ID: <xmqqy4yk9cty.fsf@gitster.dls.corp.google.com>
References: <536106EA.5090204@xiplink.com>
	<xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
	<536152D3.5050107@xiplink.com>
	<5361598f8eaf7_4781124b2f02b@nysa.notmuch>
	<536173F5.7010905@xiplink.com>
	<53617877b41a9_41a872f308ef@nysa.notmuch>
	<20140501094610.GB75770@vauxhall.crustytoothpaste.net>
	<5362664C.8040907@xiplink.com> <20140501175623.GY6227@odin.tremily.us>
	<53628CB1.8010302@xiplink.com> <20140501183008.GZ6227@odin.tremily.us>
	<5362ACD6.50505@xiplink.com>
	<xmqqbnvgasib.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:53:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJWs-0002H3-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbaEBTxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:53:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50666 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbaEBTxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 15:53:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79CB8128E0;
	Fri,  2 May 2014 15:53:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oawejIIo+bHX+6wp8rlKuHuJmlo=; b=v9lxBK
	SoqGixNRXK8zmCb0cqCwIfZq73ER0+L+RGic8JSmO8H96B4nCoFkLUJLhi/3db7A
	3m2TQ1o2PenP+icgkxPiznBqHQrNGxNlBLr4yuHKlA+W+R0KrpVkSg7vmWJsmhE7
	AUorkIp9Llnc2om5e+cMV7c6rvBLvYhtN02XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=luUgt7iAuu+ImZ+Tf1syl86f8fzt1uss
	M/mqMl2x6g+ycws0a2sc9tLwwvRQKhkTMTc99Am9AVP2EuodaLtIjGt/gzgPbze8
	S4V4sefbhePKxo9xA1Z3XpRUfjMG+CSaoUVXTxcc6dac09BCeWl2QWLnzpUivlL0
	umTGMBsKJsQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EED2128DF;
	Fri,  2 May 2014 15:53:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 05514128DD;
	Fri,  2 May 2014 15:53:46 -0400 (EDT)
In-Reply-To: <xmqqbnvgasib.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 02 May 2014 12:29:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 793B4BC4-D233-11E3-B847-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247964>

Junio C Hamano <gitster@pobox.com> writes:

> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> I may be mistaken, but I think "git pull" evolved to try to address the
>> detached-HEAD risk (at least in part).
>
> You are totally mistaken.
>
> "git pull" was part of the things to make git usable by Linus before
> 1.0 release, and matches the integrator workflow perfectly well.
> The detached HEAD came much much later.
>
> The issue we are discussing with "git pull" is that if a non
> integrator does a "git pull" from the upstream, in order to push the
> result of integrating the local work with it back to the upstream,
> by default "git pull" creates a merge in a direction that is wrong
> when seen in the "first-parent chain is the trunk" point of view.
>
> One way to solve that _might_ be to use the detached HEAD as you
> illustrated in your long-hand in the thread that had Brian's
> example, but that is not even a failed 'git push' recommends to do
> to the users, and there was no link between how 'git pull' behaves
> and use of detached HEAD at all.

One other thing to keep in mind is that the "first-parent" view
itself is fairly new, compared to "git pull" (and it is even newer
than detached HEAD IIRC, but I do not think detached HEAD has much
to do with the current "'git pull' is often harmful" confusion,
except that it may be one ingredient for a possible solution).

Back when we started "A simple CVS/SVN like workflow can be done by
cycles of 'git pull', do your work, 'git push'", the order of
parents in resulting merges was not an issue.

I am only saying these to give people the historical background to
discuss a possible solution.  I am not saying that it is a possible
solution to discourage the "first-parent chain is the mainline of
the development" world view.
