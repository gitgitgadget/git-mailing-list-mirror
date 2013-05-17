From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Fri, 17 May 2013 11:30:30 -0700
Message-ID: <7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	<7vk3my33vb.fsf@alter.siamese.dyndns.org>
	<CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 20:30:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdPQP-0004hj-3b
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 20:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab3EQSag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 14:30:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823Ab3EQSad (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 14:30:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F00A01D19A;
	Fri, 17 May 2013 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jp+ZMWC9fPw8hU6/WTlF/MUjnOQ=; b=SioI5+
	i6a8W0M28lpoKoNLOoVL3qjOAfKKU/1rQgLcXtpCIev2B/+TK4CMcUbjKhdb4sma
	ajJyiKFYQ+t4zokHOxMI8Qg+ZTgGuOSIVUHZeb0vElul04Iecvh05/NpZHOk5Jiy
	tNgJioyiMjhOHH0PnbEr1AT0DY5K7oeA03cZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XDO638Ph5dBLSpyikp1/stY5ipnabIWh
	y1FtAPmxov2RvYPgI7iQfJXkSUmL3YYF60Siwy7uX3D706pzSYysQ+fSiIxW87JD
	TWslM9y5UuRhSG35GOVX75SRNRzlp2VIvdokwuhzNO0AslbUe/QJjiTbF7GMcmJ4
	DDIayXd0Qjg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E282A1D198;
	Fri, 17 May 2013 18:30:32 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F1051D197;
	Fri, 17 May 2013 18:30:32 +0000 (UTC)
In-Reply-To: <CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 19:04:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB89A578-BF1F-11E2-824C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224729>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is irrelevant, it's an implementation detail of 'git pull'. *THE
> USER* is not running 'git fetch .'

To those who fear running "git pull", the following has worked as a
quick way to "preview" what they would be getting.

	git fetch
        git log ..FETCH_HEAD

and then they can "git merge FETCH_HEAD" to conclude it, or run a
"git pull" for real.  We teach the more explicit form to end users
in our tutorial, but it shows the explicit form only because we want
to illustrate what goes on. Over time we added support to "git fetch"
(and "git pull") to make it possible for users to type less when the
remote and branch involved are obvious, but we carefully avoided
breaking this expectation.

So when "the user" is running "git fetch" on "mywork" branch that
happens to be forked from a local "master", i.e. her configuration
is set as

	[branch "mywork"]
        	remote = .
                merge = refs/heads/master

we still need to have FETCH_HEAD updated to point at what we would
be merging if she did a "git pull".  It may be OK to additionally
fetch objects from 'origin' and update the remote tracking branches
associated with 'origin', but anything from 'origin' should not
contaminate what results in FETCH_HEAD---it should record whatever
we record when we did fetch refs/heads/master from '.'.

As I said in the very beginning, it was a mistake for me to suggest
adding a special case behaviour for '.' remote in the first place.
It breaks a long-standing expectation and workflow built around it.

So sorry for wasting our time, and consider this as a misguided
excursion.
