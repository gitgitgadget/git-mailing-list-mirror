From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each
 email.
Date: Thu, 08 Sep 2011 10:12:46 -0700
Message-ID: <7vbouvx8j5.fsf@alter.siamese.dyndns.org>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
 <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
 <vpq7h5jtngj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Georgi Chorbadzhiyski <gf@unixsol.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:07:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1ngS-0000zM-AL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1IHXGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:06:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163Ab1IHXGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:06:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB5543A0;
	Thu,  8 Sep 2011 13:12:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1SZl1cO448ZBfkWb+UD8dHcs3/c=; b=t6Jute
	PDNnv67IaZHjURLQlslW/8r7GHMbWXm2W6iHF4FKoVkEfIRsWpMQEqjSIlr1w/k4
	LPhraine56FSA9UdYpPbYnQzL+4zugJ5nCOyGaBGJhDBzAyQ2F2qeZIcT8wJBzk7
	a3mdf8FctiTXlsuwvpr123NwHM+OVJ8ANcCes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wQyqWM5QhRLYmeha105c+/tY1FcSqNx8
	bXV7TIbqJ+3G0qadFNb0BWqAcdxK6TtDEuSk5eZ2oOV9jJnsFmUxwBkfL5G4u+bW
	3EnQEc7TXWkZ3DrWvwjnZIFIfateOmMQOwDGnSvYcgeaqe85X6grO+wlxIZJgwrv
	hx4vzg1zSYU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E64604392;
	Thu,  8 Sep 2011 13:12:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A263438C; Thu,  8 Sep 2011
 13:12:49 -0400 (EDT)
In-Reply-To: <vpq7h5jtngj.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 08 Sep 2011 11:03:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C77208F0-DA3D-11E0-8ACA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180997>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> There have been discussion (and IIRC a patch) proposing this already in
> the past. One advantage of sleeping a bit between each email is that it
> increase the chances for the receiver to receive the emails in the right
> order.

Huh? Even in the presense of MTAs in the middle that are free to reorder
messages?

IIRC, "git send-email" does its best to force ordering by assigning
monotonically increasing timestamps on the Date: field, so that the
recipients can sort the messages based on it, in addition to the
In-Reply-To field to help threading. I personally do not think there is
anything more than that that should done in the program.
