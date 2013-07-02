From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone -b
Date: Tue, 02 Jul 2013 11:21:58 -0700
Message-ID: <7vppv0960p.fsf@alter.siamese.dyndns.org>
References: <51CD7AB7.3040409@atlas-elektronik.com>
	<51D12A0E.60709@atlas-elektronik.com>
	<7v61wui5xe.fsf@alter.siamese.dyndns.org>
	<51D274AA.2050902@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 20:22:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu5DM-0007I5-2Z
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 20:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab3GBSWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jul 2013 14:22:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab3GBSWC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jul 2013 14:22:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C75FA2B2AE;
	Tue,  2 Jul 2013 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MTuFLz+DnlWI
	GC2pFYpYcxmq3Hg=; b=WvStqeKvtoNJkJuqNHClf+wzrLePVBBooQbksCsoreZE
	+xfoO/x/5udjg0LB9dD2hsjwbfhAJ5WHxVxEvRrx23FglclU8MTOBV7H3xmPweyt
	UQHwcJ0sskm6xhDEMe4bM28iHYkn7kViYWAKz1e1lY7A3YIdS8zEx5IB470RpXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hZOgw/
	azwOF0sN22Nm+3yGh5C3zBJk+VEbRkUPBIhZx1U3F6TzyvhmdPb5nJ7JzYX7Rc7N
	vaLhST+EVQuImeDnBPeEh46eOWZHS0iEUikybIv2xNwhkod6PK/As0FDG+CmcteV
	oVfoYwdZIlakA7dvqU6Fw/y9cnHSSlonvS7Tg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBB372B2AD;
	Tue,  2 Jul 2013 18:22:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C6DE2B2AC;
	Tue,  2 Jul 2013 18:22:00 +0000 (UTC)
In-Reply-To: <51D274AA.2050902@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message
	of "Tue, 2 Jul 2013 08:35:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 495B829A-E344-11E2-BEEC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229413>

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

>> While I wasn't paying much attention to this, I vaguely recall that
>> people pointed out that using a fresh clone every time may not be
>> what you want to do in the first place, and I happen to agree with
>> them (and that is why I am not very much interested in this topic).
> =20
> As I said: We'd be using 'git archive --remote...' if that was
> submodule-aware.

That would still have to transfer full material enough to populate
the working tree for a single revision.  I was wondering why "clone
once, and then update incrementally with 'fetch && reset --hard' &&
clean'" is not used, if the tree is for a build-bot.
