From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: add option to omit newlines
Date: Fri, 14 Feb 2014 08:28:38 -0800
Message-ID: <xmqq38jlk6a1.fsf@gitster.dls.corp.google.com>
References: <1392314429-15281-1-git-send-email-oystwa@gmail.com>
	<xmqq38jmlqo6.fsf@gitster.dls.corp.google.com>
	<loom.20140214T085928-630@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 17:28:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WELdA-0008Jm-67
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 17:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbaBNQ2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 11:28:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbaBNQ2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 11:28:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C2576C6F0;
	Fri, 14 Feb 2014 11:28:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mFLwvc/BU+tJ
	U1nUJgSqPHY4aKU=; b=IFOH6sI/RUjlOm/odpim4u0v1Kdb+3gpv5vXqvqTcHXp
	K9T7KhxpfJ0l4NNyzODipI3TIUlOl5Z9MOMSs5tbSZYmtTpxtGJBeOg9+qDAsJpG
	pNR73tNeGIufghMaHRpBh5lmSeNpE9I+gUOx7rwDnixEVzQG6dszJWRSb7cb7So=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZNAcHu
	c1eUS5cp34c8RnZhLSunLhNTryNx0AKh4lC774oH3/pYAD8Zm+FH5+30BcSrXU2N
	bPb6Lx9XNUNi+P1DwzXCbeWB0lDM3UL9ZQmAu2o1WfZqkoQx3A+VoIA+feri9b1a
	kcUF3ubxairhQxnRaW5PlBEBIlmq0G9XQqdsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A42C6C6EF;
	Fri, 14 Feb 2014 11:28:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9493E6C6EE;
	Fri, 14 Feb 2014 11:28:42 -0500 (EST)
In-Reply-To: <loom.20140214T085928-630@post.gmane.org> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Fri, 14 Feb 2014 08:11:43 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 116B7184-9595-11E3-9186-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242109>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> However, when specifying a format string it's just a matter of ending
> the format string in '%00' and you're good to go. But then you get th=
e
> null byte *and* a newline. And with your proposal there would be no w=
ay
> of saying you want neither.

I very well understand that.  All other commands that support "-z"
to give you NUL terminated output do not consider that a downside.
Why should for-each-ref be special?
