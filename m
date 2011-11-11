From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Fri, 11 Nov 2011 08:38:07 -0800
Message-ID: <7vvcqqr4wg.fsf@alter.siamese.dyndns.org>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
 <7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
 <CAMP44s0vsQ5sfx8arrRDo+-g9Zff_MmCz5t+yghwCMx_pL4Xzg@mail.gmail.com>
 <7vvcquy05c.fsf@alter.siamese.dyndns.org>
 <CAMP44s0bm+bydNnMWPHpz8B8wMf6XN9LTiiCD-nrYSHGAV5c5Q@mail.gmail.com>
 <7vobwmvuei.fsf@alter.siamese.dyndns.org>
 <m3wrb7lzg8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 17:39:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROu8q-0005Mt-6p
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 17:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab1KKQiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 11:38:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545Ab1KKQiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 11:38:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C4305B78;
	Fri, 11 Nov 2011 11:38:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Wam0DMNpah96MxllLqyXxRPpho=; b=xmZS20
	HV6v0v4xYjzEVoM4NL4yYLKSoczcV6uT1n0V9OilBhCnhV2MdzKSvNodgh8Q2sQ6
	CFy8eytawm/XoWzAoJ3cPyisioBfDWSvuM+O+RA/z2ui2CtbsJ3P8yG2Ig/91h9W
	KX7aBA+bDyL0DDZyCdOh2qmR47G2TPdKu/mOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jzda5m4NV8W1G/uFrH881BKbaeYWNyAl
	wQ4jHcdakhQ1HqpSaU/T8ZD7PR47NcIAY/EY8OLJjEv100qz8rLa78YVnw+3O1mD
	ZhIUMWkwOXLt4khq4Y3bns0D3fk9B8zbJkVgnOKmgFcoHd8TFMINzX6d3C0nEZIe
	X589p1efSaQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 530825B77;
	Fri, 11 Nov 2011 11:38:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACD865B76; Fri, 11 Nov 2011
 11:38:08 -0500 (EST)
In-Reply-To: <m3wrb7lzg8.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 11 Nov 2011 02:35:19 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89A25124-0C83-11E1-BEAC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185274>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Perhaps these 'git remote' commands should be removed in 1.8 then.
>> 
>> It is true that it was a long-term goal to deprecate many parts of the
>> "git remote" script that started as a hack to scratch itches "git fetch"
>> in the older days did not directly scratch for people, e.g. fetching from
>> multiple remotes in one go.
>> 
>> I do not think 1.7.X series to 1.8 is a big enough jump to remove
>> duplicated features, though.
>  
> I am using "git remote update" to fetch a _subset_ of remotes;
> does "git fetch" offers such feature already?

Heh, look at builtin/remote.c::update() and report what you see.  It just
calls into "git fetch" and let the command fetch either from a single
repository or from a remote group. "git remote update" is not even aware
of the remote groups; the expansion is done by "git fetch".

Whoever added "multiple repositories" feature to "git fetch" in order to
support "remote update <group>" apparently under-documented it.
