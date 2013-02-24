From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Sun, 24 Feb 2013 13:24:55 -0800
Message-ID: <7vvc9h4d7c.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com>
 <CAHXAxrMgJf2C3dAe1O2DW5qFYFnCDhbQNmpnvK4ZOduJnqwQWg@mail.gmail.com>
 <7vvc9i5cbw.fsf@alter.siamese.dyndns.org>
 <CAHXAxrO_AeLoHw6TaVkDZsS=J6Ro+qEuMs4rbyCoFuHAGT+6vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 22:25:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9j4X-0001sO-0x
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 22:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759292Ab3BXVY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 16:24:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634Ab3BXVY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 16:24:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F6FFB6C5;
	Sun, 24 Feb 2013 16:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0XNUEFclm25UclxRQ06YCl5LXN8=; b=ui2oEt
	T2m1xpdiQEt/4R0yPicqsVh7YL8Q4ccaqUM7BoQUfedZLqKEuHXFTg5NCMqblqm/
	PgAnVHtn5Ds16XWmXGihGSdqp1tEKa4FBsc8LAu+snb8GnqAecUnE3E/xfQfCxST
	qLhmH2kq/iLQhmqhghlbN7Z/RBVetqxRs2x7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYpE+yCvJt++xU57Uh5SwYYt6wKu2X3Y
	QGUAjpiZqBqeOw2h7+j347G/Tt4+N1s0PMUi4Q6kyNbncil3gdTCtXvy9EbW7mPQ
	D2dgMFP9X4eY5gvxTFSAkh7HsDIgMHOILVvDi2HU33zAuFSUuY4vTOEd2Aju5g7f
	vR9oB59kkbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648E0B6C4;
	Sun, 24 Feb 2013 16:24:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D18E0B6C2; Sun, 24 Feb 2013
 16:24:56 -0500 (EST)
In-Reply-To: <CAHXAxrO_AeLoHw6TaVkDZsS=J6Ro+qEuMs4rbyCoFuHAGT+6vg@mail.gmail.com> (Mike
 Gorchak's message of "Sun, 24 Feb 2013 16:12:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A30D9296-7EC8-11E2-A3C0-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217002>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

> CFLAGS="-I/usr/qnxVVV/include" LDFLAGS="-I/usr/qnxVVV/lib" ./configure
> --prefix=/usr

Oh, I didn't notice that, but the definition of ALL_CFLAGS may be
what is wrong.  It allows CFLAGS to come before BASIC_CFLAGS that
adds -Icompat/, which goes against the whole point of having
replacement headers in compat/ directory.
