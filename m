From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] gitk assumes initial commit is empty
Date: Thu, 29 Sep 2011 09:40:27 -0700
Message-ID: <7vwrcrti84.fsf@alter.siamese.dyndns.org>
References: <4E8481A2.6060301@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:40:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Jf2-0004oK-MJ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757090Ab1I2Qkc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 12:40:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757014Ab1I2Qkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 12:40:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5437D56F2;
	Thu, 29 Sep 2011 12:40:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+qsDZkj4A+Qx
	Ll/fMV50brjQNOA=; b=Mz46qmvsJyIa6pJ8CWt9Lf5eQgYyfr7xOcHKfL5fMPYw
	MIag875iTJacfrwi2FmGM0CB3vsGpMJ0eMVyW2AdhSPkRVQ8OHcFtoL7FYPSBD6c
	M4hykIfhOJot/c+ezbsnlib4vJmSy2UQEFqTGTvQ9zUV/Uc2NGzrIW4kPuUPg08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t9Wn/C
	Dp7Qsy6OLxV9vXdHukKGEwXlft31Jc9i3XSvMk2MGvaMYXLzKNd3eaH3wzahFYuU
	bnc8hOm9ExjEJeAqQkzZ+M8OLZt54C3jsy5ntcVLXmbSebxVLJRwfPn1JSaw7Ngv
	m6hrZ0i1Tx98mIb1D+2FMMmNRZzM99ydjtLto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6F156F1;
	Thu, 29 Sep 2011 12:40:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D51DF56F0; Thu, 29 Sep 2011
 12:40:29 -0400 (EDT)
In-Reply-To: <4E8481A2.6060301@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Thu, 29 Sep 2011 16:33:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE02F0F4-EAB9-11E0-A109-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182408>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> In gitk, the next commit shows changes to some files, like if they ex=
isted
> in the parent commit. So it seems that gitk assumes that initial comm=
it
> is empty, which doesn't have to be true.

It is not about assuming but by unfortunate design.

In early days, all projects managed by git (except for git itself) had =
the
product of a fairly mature development hsitory in their first commit, a=
nd
it was deemed unnecessary clutter to show additions of these thousands =
of
paths as a patch.

This was not just about gitk but git itself. "git log" learned to show =
the
patch for the initial commit without requiring --root command line opti=
on
only at 0f03ca9 (config option log.showroot to show the diff of root
commits, 2006-11-23).

These days I think gitk should learn to do the same ;-)
