From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Document some functions defined in object.c
Date: Mon, 24 Feb 2014 09:12:44 -0800
Message-ID: <xmqqlhx0bfjn.fsf@gitster.dls.corp.google.com>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
	<1393000327-11402-7-git-send-email-mhagger@alum.mit.edu>
	<alpine.LFD.2.11.1402211222270.17677@knanqh.ubzr>
	<530B073D.5010702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:12:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHz5M-0004fZ-Jt
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbaBXRMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:12:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbaBXRMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:12:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 512306CA92;
	Mon, 24 Feb 2014 12:12:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A0uKSFx5xcebhFBv+siHOg2lkbg=; b=Yncg9p
	Vaz440KCMo3bp0PrPtofvQZKQBgyPFA6811WebSUUzKeiPLlsy/58ZmTJO6s6yd+
	eJhNSwzfKuZIMf6F0Q9/6b6S5xYLigCErtvU59BdpM0+t0EtHx4lqL77nv4UnjaB
	M4XRJNRn/SK2nGZzeqycuE4VjmX4N26Wt98OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FPKTX21A74n216l/XSdHhr3bq6CAsXMg
	G/tI8YhuJIpySYq5NUR4S9FyTFeb5DgqKtWsknt01O0Jwr6L4OYldhLvsE9qFwjZ
	B7oap9k0VZ1B1PJGgYt1XHz1jUdqdJFsHew9Yq6VXHttU0AqbLgzS50oqtjB9o4h
	y2WlOvJ+u5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26ACF6CA91;
	Mon, 24 Feb 2014 12:12:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 284B56CA8E;
	Mon, 24 Feb 2014 12:12:48 -0500 (EST)
In-Reply-To: <530B073D.5010702@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 24 Feb 2014 09:47:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E26E47AA-9D76-11E3-A04A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242614>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Contrariwise, I thought about it again and believe that it *is*
> important for the docstring to mention explicitly that the return value
> is architecture-dependent

As it gives an internal hash value which should not leak to the
outside world (e.g. stored in a file or sent over the wire later to
be read by other platforms), I think that is a good idea.
