From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] upload-archive: use start_command instead of fork
Date: Mon, 03 Oct 2011 12:31:43 -0700
Message-ID: <7vd3edg9cw.fsf@alter.siamese.dyndns.org>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
 <1317329963-6656-5-git-send-email-kusmabite@gmail.com>
 <7vy5x1gbr6.fsf@alter.siamese.dyndns.org>
 <CABPQNSbN-sktYQUkLoywhCkc0_axgjY6Y9sN8ipeu6M+2VOVTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
	rene.scharfe@lsrfire.ath.cx
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 03 21:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAoEx-0000qi-5q
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386Ab1JCTbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:31:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619Ab1JCTbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:31:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B8CE5764;
	Mon,  3 Oct 2011 15:31:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KkzO/GkEivzAaBaufIgHRyjSngQ=; b=QPZREc
	hUH9WuM6PfLwr7jPqcSkdIRuHhi+0kKm4JVMe3LL2vVKMEVPWxwjkIWgkven9WE4
	rfpATiXr5pkgNW3Wwkxxkm6+yonS/fJiq0Ll19pQ5ObY7RdXYpjmmA/slCNlSglD
	Ye3vAFAes43eW+MdNozec2kos9cbKlBBKJQY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJLwtCHFmfJybFjOau0n0H6JnMisxqJ5
	r4SVIGMGKO6yHUULZrPCzr+0F15r27WbT/Lj2//c3xZTXBRB4gIh8c0sb/nUt4FO
	vviSmjozQFCbq9x0DXeMJFcWqf1Lnq/fJcWKKBM9c+u1FxToyiCA3f7dYFu66lAX
	wl0YSnD55EM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7332C5763;
	Mon,  3 Oct 2011 15:31:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E56C575C; Mon,  3 Oct 2011
 15:31:44 -0400 (EDT)
In-Reply-To: <CABPQNSbN-sktYQUkLoywhCkc0_axgjY6Y9sN8ipeu6M+2VOVTA@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 3 Oct 2011 20:48:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5427324A-EDF6-11E0-9D64-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182702>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> It should, the change is completely server-side. The first two entries
> in sent_argv aren't sent over the network protocol, but the ones that
> follow them are.
>
> Or did I misunderstand your concern?

No you didn't. Thanks.
