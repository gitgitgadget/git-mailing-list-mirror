From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 13:42:03 -0700
Message-ID: <7v8v1fv52c.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC723F.2000602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwejl-0008Du-1y
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab3GIUmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:42:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43907 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831Ab3GIUmG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 16:42:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAFA82F99A;
	Tue,  9 Jul 2013 20:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4GailLSJ9KS1Z7KzbbBJBLj9zrU=; b=lgf0o7
	GvC1b3v8VjfwjBXalBFlzIZr7D3oXISOY2xx4riZoAXO5R44PUAZTj3BCGR86Z+r
	aShf2Z8dZG7W9MrS3G1KKN/vU5HZNZkhqaKFMdhTgLIrz5HVH3LG9h68sXA4ehAx
	CwrsyiSpDTBP5Ia1jcTHCQAInZXzeo2flSJ1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kL6R2dj/vuRaOs3NSyrR/ffGIM8RA1wU
	Xdl+l5oP8SnsP0DQZM0vwpYazEfH++1xtBDTlkPLaNC76TXx1Ga8xUcAQt7TR7zK
	S0RpbrtvQINaAFoMGy7ARRvDkFwIo1NB3bj8gvlOcNdz0hIW/r8cL3dzy6b9njrX
	wKJJZdpw4VY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E07A22F999;
	Tue,  9 Jul 2013 20:42:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D5372F997;
	Tue,  9 Jul 2013 20:42:05 +0000 (UTC)
In-Reply-To: <51DC723F.2000602@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 09 Jul 2013 22:27:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0419CA0E-E8D8-11E2-89F4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230005>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> <bikeshed>
> The name "--lockref" is OK, but for me it's less a question of
> "locking", because as far as the user is concerned the push is an atomic
> operation so there is no sense of a "lock" that is being held for a
> finite period of time.

Yeah, I think this is more like "taking a lease".
