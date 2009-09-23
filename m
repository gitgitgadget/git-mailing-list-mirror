From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs
 in a repository
Date: Tue, 22 Sep 2009 17:02:57 -0700
Message-ID: <7vd45io7da.fsf@alter.siamese.dyndns.org>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
 <878wgcbb52.fsf@users.sourceforge.net>
 <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
 <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
 <4AB78910.7010402@viscovery.net>
 <6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
 <4AB7A2E7.5000601@viscovery.net> <874oqvc0n3.fsf@users.sourceforge.net>
 <19129.24056.422939.880134@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Murphy\, John" <john.murphy@bankofamerica.com>,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 02:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqFKL-0000kt-V8
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 02:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbZIWADM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 20:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbZIWADL
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 20:03:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbZIWADL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 20:03:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EBD55BC13;
	Tue, 22 Sep 2009 20:03:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2senIzWDFEchbGL0xPDH3zkcatk=; b=qgNV5k
	1Cnz6LAc+MiV6gOMrdmcDM6+jF62tZ+SDbm1++ggfQp7wEtrHnwRu6aClZqHD618
	kZcrPjKCQo9nd+7xgumuFjT68QVTwuVk3rq0R2RWj2657nuhGhrIdK5fb6tYylq9
	hurhj+0Vjkqu/JcV7Ys5X5EWMn0D0i5QEcHhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bxq7EYj1oVYHmcNvKNyTjzN6vJudxhFQ
	gG71uW+Q5msGNSFHjgGPkAEgQcAl2Ub0Loie7D0Cghj0bQJnQNvKLiROAprWAZ9A
	Y6uCWieeuo8Kn5CreP5kkG5qAVRFI2JT1WvQyRM7zAuQIO5lE4UJVfVURFxE18Z4
	rJRsj74RMqM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF94E5BC12;
	Tue, 22 Sep 2009 20:03:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 39D655BC0E; Tue, 22 Sep 2009
 20:02:58 -0400 (EDT)
In-Reply-To: <19129.24056.422939.880134@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Wed\, 23 Sep 2009 09\:30\:00 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 79FEDE1A-A7D4-11DE-965C-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128963>

Paul Mackerras <paulus@samba.org> writes:

> If git log had an argument to tell it to mark those commits that were
> a starting point or a finishing point, then I could simplify this
> logic enormously, plus we wouldn't have to pass a long parameter list
> to git log.  It may still turn out to be necessary to add a negative
> argument for each previous starting point, though, when refreshing the
> list.
>
> I think the simplest fix for now is to arrange to take the
> non-optimized path on windows when the list of revs gets too long,
> i.e., set $vcanopt($view) to 0 and take that path.  That means that
> refreshing the view will be slow, but I think it's the best we can do
> at this point.

Hmph.

The negative ones you can learn by giving --boundary, but I do not think
the set of starting points are something you can get out of log output.

Even if you could, you would have the same issue giving them from the
command line anyway.  The right solution would likely to be to give the
same --stdin option as rev-list to "git log", I think.
