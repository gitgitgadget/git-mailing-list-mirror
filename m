From: Junio C Hamano <gitster@pobox.com>
Subject: Re: importing two different trees into a fresh git repo
Date: Tue, 05 Feb 2013 14:29:31 -0800
Message-ID: <7va9riqtro.fsf@alter.siamese.dyndns.org>
References: <CAPKkNb6+ojb+uvBW+AkhGrhjR85LrJEbmR0KmvaKYb2Cj5Aa4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2r1a-0000ez-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 23:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388Ab3BEW3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 17:29:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383Ab3BEW3d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 17:29:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BA49931D;
	Tue,  5 Feb 2013 17:29:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NBqW6TttxGbUdaspEzh+oasZq6o=; b=s9IyC8
	H4J/r3Qbmob1tIQu/Sdndsa/wP9Qw+js1zCEYhulGhdVslQLsOqiRbgg1Zdp9nMz
	4HDEZw4yo5v1B7yjjo0yv9baqkg1lAs/V6ZqmNQZ/eIk3LAJ7kDQNnh7Po1nzdtn
	n2+IFvmO+tNscHRX6pigsuv/4P5QfQSSsEFN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/vxv2RKKYYvIdt1SMqRVWCAPRsuodE9
	d+JV9oj0IikPghwRXpZgj4PDw3vyHIxN8qwJwjMdkgL6/K1h91bel5NN6P+KUu/0
	VebKvuXXW33Rp0wk7Ok8Z7Ix2U1UohME+y12h/i9pcfGHx68Dw8lj8E+70Z8JGNk
	s4ErpO5r7Pk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F67C931C;
	Tue,  5 Feb 2013 17:29:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2FA7931A; Tue,  5 Feb 2013
 17:29:32 -0500 (EST)
In-Reply-To: <CAPKkNb6+ojb+uvBW+AkhGrhjR85LrJEbmR0KmvaKYb2Cj5Aa4g@mail.gmail.com>
 (Constantine A. Murenin's message of "Tue, 5 Feb 2013 13:46:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8367A31C-6FE3-11E2-BAC7-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215548>

"Constantine A. Murenin" <mureninc@gmail.com> writes:

> I have two distinct trees that were not managed by any RCS, and I'd
> like to import them into a single repository into two separate orphan
> branches, then make sense of what's in there, merge, and unify into
> 'master'.
>
> (To give some context, it's /etc/nginx config files from nginx/1.0.12
> on Debian 6 and nginx/1.2.2 on OpenBSD 5.2.)

As these come from two totally separate sources, I'd find it more
natural to do two repositories, deb-nginx-conf and obsd-nginx-conf,
each with one commit and then pull one into the other (or pull both
to master-nginx-conf if you really wanted to), to me.
