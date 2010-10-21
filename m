From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Thu, 21 Oct 2010 16:17:04 -0700
Message-ID: <7veibjrv9r.fsf@alter.siamese.dyndns.org>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
 <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 <7vbp6vduly.fsf@alter.siamese.dyndns.org>
 <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
 <20101018163134.GA6343@burratino>
 <AANLkTik3Di=dcC=CxW+Lou515E2wXq8_OaR99mghC+vF@mail.gmail.com>
 <AANLkTi=ydzrvy6_PbFLpA_qcHzF-8s3xbu3XvU5GnQ_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 22 01:17:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P94O2-0000ou-9u
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 01:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0JUXRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 19:17:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab0JUXRY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 19:17:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EAF7E030D;
	Thu, 21 Oct 2010 19:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=igSXIdnvHj0tB28sEprpQNgd1oc=; b=ZUF9aZ
	HFYCIAFhCiQBi130XuCGv4qGdNZHKyQANwFoDRJ2fKr26i7HoYNOUVxFisZIskcM
	+2I/Di5oJOZ2t3XyUwO0HrGr/gMP10TMSKB26dmcxCBXcN62ih3McXLhzlgVqtn+
	lPV9lDvfkpZPDLWy/nm0d0lRYXwe3zidZiHxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=POiCAoE3T6VyZKh8LMWRjmQLdFvODI5Y
	aomgLP7bHNEi33knEaBsYCuzblG8Mo2A5Mdmf0vSJ3WaYbDk5RmN/Q2B6iq0qJEQ
	U5qQIbNKDX/GP2XY8de6fM1WQgAJ9cYlH4LUjbPQgumk5JlWQjFkNCwZIYdLpHda
	jUGlrVlTeYk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC72E0304;
	Thu, 21 Oct 2010 19:17:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81B6FE0302; Thu, 21 Oct
 2010 19:17:06 -0400 (EDT)
In-Reply-To: <AANLkTi=ydzrvy6_PbFLpA_qcHzF-8s3xbu3XvU5GnQ_k@mail.gmail.com>
 (Erik Faye-Lund's message of "Fri\, 22 Oct 2010 00\:00\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 570BCBA4-DD69-11DF-A0BE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159587>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> OK, I did another stab at this, and this is the best I could come up
> with right now, what do you think?

Getting warmer ;-)

Similarly to drop_privileges() you can create prepare_credential that
takes "struct cred *, const char *username, const char *groupname" as
another helper, and make its implementation on the NO_POSIX side barf/die
when called, saying that switching credentials is not supported in
NO_POSIX implementation.  That way, you can keep the main clean without
any conditionals.  Command line argument parser can (and probably should)
stay the same between implementations.

Thanks.
