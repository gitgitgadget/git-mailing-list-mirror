From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix gitmkdtemp: correct test for mktemp() return value
Date: Thu, 25 Feb 2010 09:33:41 -0800
Message-ID: <7veik99q4q.fsf@alter.siamese.dyndns.org>
References: <4B864A7B.9000500@flexerasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Filippo Negroni <fnegroni@flexerasoftware.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkhaz-0002Kx-7F
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 18:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067Ab0BYRds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 12:33:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932947Ab0BYRdr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 12:33:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EF5D9D49F;
	Thu, 25 Feb 2010 12:33:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hBbhHI/Nj/2Feb0W2cfxMEkxB68=; b=kdXpt2
	lfShT+8usFVW8f8JQ5QuTg2owUpsBN8QdY4WbfHL4sBOkbvCNserCewsYsVx7VQm
	vFyuGuKYkdmwQTG+/u+hHt7F1Cw4vLuZPxn0YT42V5ZfTrcwUtvYD2UNDstPV+SF
	VPD0BnDxS0/JnXo4LPJEd7gZq7ZZ/Vo7rxLNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f9pDJAvGlQfSvYWI7nTB7YdblizIcUPs
	eWugq4C69UIfpMp36tXBW36TPh6r5ONFtyoTV21yZWw7Pul23yZxjvfsLxuG9j2Y
	k1nDM5T8Hjoyfd0H7RgDu7FsSpCUB5enntP5MT+1Tcx8Qf7XOWHHvza/C3/i012E
	Ud/SMQG5Ao8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B5A69D49E;
	Thu, 25 Feb 2010 12:33:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EB679D498; Thu, 25 Feb
 2010 12:33:42 -0500 (EST)
In-Reply-To: <4B864A7B.9000500@flexerasoftware.com> (Filippo Negroni's
 message of "Thu\, 25 Feb 2010 10\:01\:31 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC8DE83E-2233-11DF-8E7D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141058>

Filippo Negroni <fnegroni@flexerasoftware.com> writes:

> From 5e3b362cdd86150de901312c01beac9596b7e2ba Mon Sep 17 00:00:00 2001
> From: Filippo Negroni <fnegroni@flexerasoftware.com>
> Date: Thu, 25 Feb 2010 09:39:56 +0000
> Subject: [PATCH] Fix gitmkdtemp: correct test for mktemp() return value
>
> In gitmkdtemp, the return value of mktemp is not tested correctly.
> mktemp() always returns its 'template' argument, even upon failre.
> Upon failure, mktemp sets template to be an empty string: its first character is '\0'.
> This patch ensures the return value of mktemp is correctly tested by dereferencing the pointer returned by it.
>
> Signed-off-by: Filippo Negroni <fnegroni@flexerasoftware.com>
> ---

Thanks.

Next time please do not quote the mbox header lines (i.e. start your body
with "In gitmkdtemp, the return value ...".
