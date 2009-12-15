From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] octopus: make merge process simpler to follow
Date: Mon, 14 Dec 2009 23:32:50 -0800
Message-ID: <7v3a3c3d5p.fsf@alter.siamese.dyndns.org>
References: <7vk4wrrkce.fsf@alter.siamese.dyndns.org>
 <1260859755-3990-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Jari Aalto <jari.aalto@cante.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 08:33:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKRuE-0002Rv-6P
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 08:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbZLOHdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 02:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756607AbZLOHdJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 02:33:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbZLOHdH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 02:33:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B58F6A7D0F;
	Tue, 15 Dec 2009 02:33:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B4SC4o9l9Nyee0GK1bUQrSTCcEk=; b=frppUa
	zZrrB07GNNnwEUNj18uWGs7YImsNGe0QrCKfh7RhZMwTKtLmmi81W2Z6KNu4sh2U
	+kgNJ8ruK6n2MX+Bcik422gX/p0NE9AlgPussR8FycN+JA2FrY8LWpfLowb4Xqn5
	rkazd9jZsZPxsqkFLjNiXK43p+hpgphGZBHhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zsod+NjqZ2d1ZztHCxOvo7mcslveCdxp
	mcz7v1sD7luJkEq6WYpbmqEMWUVYFD2C/wO90bHnKcIPzx19Efd3I1QruqNUysbw
	adh16aHD35IjU/8cz1RqnbEK5f4rosY/Ic0vurN3NLCM0bl3IctpqJWxLZ6VHsEZ
	kFLDeDDo1lc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73BBFA7D0C;
	Tue, 15 Dec 2009 02:32:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D364FA7D08; Tue, 15 Dec 2009
 02:32:52 -0500 (EST)
In-Reply-To: <1260859755-3990-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Mon\, 14 Dec 2009 22\:49\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11DF9798-E94C-11DE-911D-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135276>

Stephen Boyd <bebarino@gmail.com> writes:

> Its not very easy to understand what heads are being merged given
> the current output of an octopus merge. Fix this by replacing the
> sha1 with the (usually) better description in GITHEAD_<SHA1>.
>
> Suggested-by: Jari Aalto <jari.aalto@cante.net>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> Thanks both. Here's a replacement. Let me know if you want a reroll.

Ah, thanks and sorry for having you do an extra work.  I amended the
assignment further like thi,s but haven't got a chance to push the result out...

	eval pretty_name=\${GITHEAD_$SHA1:-$SHA1}
