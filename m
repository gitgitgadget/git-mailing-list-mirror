From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Sun, 12 Aug 2012 12:11:17 -0700
Message-ID: <7vtxw8exii.fsf@alter.siamese.dyndns.org>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:12:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0dZx-0003O2-9B
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 21:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab2HLTLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Aug 2012 15:11:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933Ab2HLTLU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2012 15:11:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C81007B7A;
	Sun, 12 Aug 2012 15:11:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=J4cvCP58mO5M
	w4yTeobdXqOwDj8=; b=Jnd9lJuNvKzCRy0qKpbfEw1auubvHwsv7FhsroG4GJRK
	fPI6+dc6LujZD+mafRtZwMMCorVmwutpIWNJT8lFjxUMoWReY2h679AiA6odzpkh
	qrms666WRMnwjMmJ/q4kcPV/MZxTiUFLXNLY5F691Kc1uhvhD+PkWrbP/H7sohE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V4rQHe
	xFpqxPxov3K7DQb/sNk6TEaXXHO86aVz7JlqpRrgzyYZ7kqa4a67Xb6kWCsJURnN
	lNw6ZJ/WnOkwkG2+Nvj6VqMX6cfa7d+TmUj72LYhsVw4DUS/AA05Lcunl1eDMPOU
	Ve6U8h2cPHAL07V9D9ltnPF7lmOVuK6fL0/6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B65D27B79;
	Sun, 12 Aug 2012 15:11:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 372017B78; Sun, 12 Aug 2012
 15:11:19 -0400 (EDT)
In-Reply-To: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 12 Aug
 2012 19:01:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F34B6B2-E4B1-11E1-A0F7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203313>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The main reason to group objects by type is to make it possible to
> create another sha1->something mapping for a particular object type,
> without wasting space for storing sha-1 keys again. For example, we
> can store commit caches, tree caches... at the end of the index as
> extensions.

Why can't you do the same with a single "sorted by SHA-1" table?

Not impressed yet.
