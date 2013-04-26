From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 10:07:19 -0700
Message-ID: <7vppxhxltk.fsf@alter.siamese.dyndns.org>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
	<CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
	<7vbo91z30e.fsf@alter.siamese.dyndns.org>
	<vpqzjwl9se7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 26 19:07:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVm7L-0004A9-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 19:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab3DZRHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 13:07:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab3DZRHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 13:07:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A54F1AFD4;
	Fri, 26 Apr 2013 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NywbpHB3nVYn0uCJGh9kb0ClH5o=; b=mUZBfS
	b4GGCaiJA4QIKF68QrYc7BGZtA7ok/JIJ8mf9ILKt5QY8JVTJslsLkYQPSKCz8Zf
	gs69xEsPaDPx4z3Wx3JEOnMjGgtCvr0fDAneraY89vQdAujaS+y+G2BI6AmXn1WT
	qw5fjSkA7RNhvPySz79YH7cVrU+UsPXGMui3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4UK5bhJ17u4SjiZSfgzESSSj7CQFeZT
	OmRVNH0ATnKvP3e/LMlUjR6OVjmFbD9Mxbt2egudHWPVxvd4DUDiZxdpX19fj56s
	a70SeibV53XTy8tFOzX53BVp5TNtQPKRUDSkVpA2x9Ap5hJ6lbDGKVooTunTl/i/
	KC0EK/Msuxk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DB51AFD3;
	Fri, 26 Apr 2013 17:07:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E100E1AFD2;
	Fri, 26 Apr 2013 17:07:20 +0000 (UTC)
In-Reply-To: <vpqzjwl9se7.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Fri, 26 Apr 2013 18:19:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1CB412E-AE93-11E2-B388-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222542>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The nice thing with the confirmation dialog is that it shows the list
> before asking (and unlike 'rm -i', it asks only once).

I wouldn't object to having "clean -i", which automatically defeats
the requireforce option.

As to a huge single list you have to approve or reject as a whole, I
am on the fence.  When running "rm -i", I often wished to see
something like that, but I am fairly sure that I'll call it unusable
the first time I see a list with a few items I want to keep while
removing all others.
