From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] git send-email suppress-cc=self fixes
Date: Sun, 09 Jun 2013 16:25:11 -0700
Message-ID: <7vy5ain9yg.fsf@alter.siamese.dyndns.org>
References: <1370455737-29986-1-git-send-email-mst@redhat.com>
	<7v8v2o1ho7.fsf@alter.siamese.dyndns.org>
	<20130605201423.GB31143@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 01:25:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlozB-0004qf-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab3FIXZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:25:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584Ab3FIXZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:25:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA0926E8F;
	Sun,  9 Jun 2013 23:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=G8El6Tj6oo7TCaN5d7sb363GISE=; b=h+GsssK+O5/8ipM0Bkqm
	XlBqcCI8VJTgI3irWMfvcYTeX8GMFxnsl4XpWy01VSjtI4nNCGNvl6ljBGnm2N1E
	puAqM5NMLTQ6yaj4VF6gWZWfNle7mAfcAGhKxCFY6HCsJhgXHR+1NLtHV5jYGbDs
	CvJkTIwZT+BvDfHwPRPu5Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MXdZVF2B7TyGXYIIAr8+rTUTJYasCRHhcVYZX6iyJx+89A
	eb97ZMsKhpCfbP6TllVZGGyC7bWBybkhfBNSi/7Kxpl/R1uKuQrtG/8mSOSgefBg
	hD1QhkOnLTzLDiMerbTsUUNRx2ioAkZ/z+Fkvkz9gVqMpwbXhaOwgUwMkwl+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DEE826E8C;
	Sun,  9 Jun 2013 23:25:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08BBB26E89;
	Sun,  9 Jun 2013 23:25:12 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D59A8030-D15B-11E2-8D00-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227213>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> With respect to this, and a bit off-topic, what's
> the best way to revise patch series?
>
> What I did, given series in patchvN-1/:
>
> 	rm -fr patchvN #blow away old directory if there
> 			# otherwise I get two copies of patches if I renamed any

Not needed with recent "git format-patch -v4" option.

> 	git branch|fgrep '*'
> 	# Figure out on which branch I am, manually specify the correct upstream I'm tracking,
> 	# otherwise I get a ton of unrelated patches.

git-prompt with PS1 you do not need this either.

> 	git format-patch --cover --subject-prefix='PATCH vN' -o patchvN origin/master..

Again, "git format-patch -v4 -o mt-send-email" will deposit the new
ones alongside the older round.

> 	vi patchvN/0000* patchvN-1/0000*

Same (i.e. "vi mt-send-email/v*-0000-*.txt).
