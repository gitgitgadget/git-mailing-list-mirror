From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Rename suffixcmp() to has_suffix() and inverse its result
Date: Tue, 05 Nov 2013 11:12:48 -0800
Message-ID: <xmqqd2meaci7.fsf@gitster.dls.corp.google.com>
References: <20131105045722.20276.20853.chriscool@tuxfamily.org>
	<C9A6A1E9-E08C-4C9B-B18D-CED751ACB975@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Nov 05 20:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vdm3c-00073G-0S
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 20:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab3KETMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 14:12:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab3KETMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 14:12:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E144E045;
	Tue,  5 Nov 2013 14:12:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p39eTAoRZvLgg4yg+8xC9LFRVZY=; b=xs5NRr
	4CTqNu6jbVYGwVzdE8wsMgWy4+vonSD02puxP1W5hk61ww0cGdRD2xl8g5WKy1Hj
	FEH+p99qd9RoCkX8yngG5pBVgyk9BQ9c6jJF56P21kIUOmldfVx+n7lRn9Ph9wwZ
	s6sc8+JoI847IF8r7qJwt9oFMoe10tw2PJyj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UTtpQj6mGo7r3j0pUoLn1593znAimODk
	SfmaEtY8mbfzOSgxBcJmVYpvEGsX2y7hBYwC0vyddD0x2eCTBvQr+f0A9ckOZ0dK
	QleAvJr7Gir7O4NjmLn3qnQ1BRkfzb3D2zv6HsZUIWOQ9CFu9CG7iqzj9g/nGYKs
	XNDTFofrLtA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E17C24E044;
	Tue,  5 Nov 2013 14:12:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41B954E042;
	Tue,  5 Nov 2013 14:12:50 -0500 (EST)
In-Reply-To: <C9A6A1E9-E08C-4C9B-B18D-CED751ACB975@quendi.de> (Max Horn's
	message of "Tue, 5 Nov 2013 19:39:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43676AF8-464E-11E3-BF28-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237336>

Max Horn <max@quendi.de> writes:

> +1 for the change. I find the resulting code easier to understand, too.
> ...
>
> Taking one step back, shouldn't the commit message rather explain
> the new status, instead of referring so much to the past? If I
> imagine somebody reading this in a year, they might not even know
> suffixcmp (e.g. if they joined the project after this patch was
> merged).
>
> How about something like this:
>
> --- 8< ----
>
> Rename suffixcmp() to has_suffix() and invert its result
>
> Now has_suffix() returns 1 when the suffix is present and 0 otherwise.
>
> The old name followed the pattern anything-cmp(), which suggests
> a general comparison function suitable for e.g. sorting objects.
> But this was not the case for suffixcmp().

Yes, much more concise and to the point.
