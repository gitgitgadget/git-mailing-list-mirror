From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Complain in the tests about git config not failing
 with, keys without a section
Date: Fri, 02 Mar 2012 10:40:58 -0800
Message-ID: <7v8vjiethh.fsf@alter.siamese.dyndns.org>
References: <4F50A79E.5060206@philosof.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rune Schjellerup Philosof <rune@philosof.dk>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3XPf-0007aC-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 19:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791Ab2CBSlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 13:41:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755745Ab2CBSlB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 13:41:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBCEA64C9;
	Fri,  2 Mar 2012 13:41:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+OX93J1KaZcKH8gQOYWIEgPoWIY=; b=vd13nl
	Jrx63TQc11EG5bQc+KppYj+ifHzgR4pma/X35qnOV8Nmxqk9u22haekDonvdvPo2
	vatdkYJURcTwP9tnYzHStkP1L5YphKrq7AiFyLrqWNzdB8wgiiPV7a+ehfr2sff3
	2Abavm6Ou2bV7RxHwDd6YcYrQXIL8q7Am9ck4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=izdsZBlNy84xqg0BPWTG5k5dQKdY/C4X
	99B9mxOlJngKwb6O0ftdNsjGnNTy7r0fB4iVywoetQ0y4tp8ofK4Zr1wY9AIe/EI
	EsJ+cZDppMFURx2EZLFz4vdV9m2X0BcSZNe7qxs2z7NSBgM6tSRxLAFF3XNPFQzi
	TJOAloGQCjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B244864C8;
	Fri,  2 Mar 2012 13:41:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E81564C6; Fri,  2 Mar 2012
 13:41:00 -0500 (EST)
In-Reply-To: <4F50A79E.5060206@philosof.dk> (Rune Schjellerup Philosof's
 message of "Fri, 02 Mar 2012 11:57:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41AF1EDA-6497-11E1-89C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192058>

Rune Schjellerup Philosof <rune@philosof.dk> writes:

> From c4fc13a5a1e8c1eab9873232e6e8b7e0523cd6ea Mon Sep 17 00:00:00 2001
> From: Rune Philosof <rune.git@philosof.dk>
> Date: Fri, 2 Mar 2012 10:42:23 +0100
> Subject: [PATCH 1/2] Complain in the tests about git config not failing with
>  keys without a section

What are these lines?

>
> git is supposed to fail when having a key without a section, but does not.

I do not think anybody said it is supposed to fail in this case.

Historically, we always allowed single level names in our configuration
parser, at least for reading, from pretty much day one, I think.  The
documentation only talks about two and three level names, because we do
not use such a name ourselves in the code, and the behaviour for a single
level name is just "undefined", which is very different from "must fail".
