From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Sun, 19 May 2013 21:29:36 -0700
Message-ID: <7v8v3axoi7.fsf@alter.siamese.dyndns.org>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 06:29:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeHjE-0000TU-9x
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 06:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126Ab3ETE3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 00:29:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3ETE3k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 00:29:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B035A159EF;
	Mon, 20 May 2013 04:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=jMl47hZAQYRIOQ8tXdRMtMrBb
	P8=; b=xsDKNTFaik6b+FgCnP4HsKFdmlkcbybpPHpXT9zWbMlWE0AUyLjYlxUqH
	xPZ6ReNDpT0KK6uOul3aGLJuCOaSasQoTq63bjPTHaRk5bunSEILj6ajoXL8DKG+
	UBSa3HVY7bLsdG80OUzPFBN++1KDOwDFk7+o08Wt7COKs6zc0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EAIpPuhqJzCNROr5ULg
	+2PjK+b7xeiuRksWGN5/yHeKBWQ8wNl6sHqDPtUxHZ13dpEqcs93B2CQ+jASj3E9
	B96emJZniipN4/OpH3KtWJGjzF2hkRewfzUNEEpFsk9SvZUrJkQa8tyYWk0nFRoL
	7UU1Z3sQ+g8yfUn+hRsDuEkQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3A75159EE;
	Mon, 20 May 2013 04:29:39 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDA46159EC;
	Mon, 20 May 2013 04:29:38 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E23CD60A-C105-11E2-B1CA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224933>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Originally I wanted to introduce --pretty with git-log's pretty synta=
x
> to for-each-ref, deprecating --format.

If you are going to unify the two mechanisms, I think the "--format"
option of "for-each-ref" needs to become a superset of what the
"--pretty" option of "log/rev-list" can express and shared between
the two.  The former has to handle anything that can be at the tip
of a ref, including commits, so it needs to be able to do anything
the latter can.
