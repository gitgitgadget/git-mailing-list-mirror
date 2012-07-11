From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] branch: add --unset-upstream option
Date: Wed, 11 Jul 2012 09:53:07 -0700
Message-ID: <7vfw8yfde4.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-4-git-send-email-cmn@elego.de>
 <7v629vijf2.fsf@alter.siamese.dyndns.org>
 <1342016087.6458.10.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 18:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp0AA-0007w2-3B
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 18:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978Ab2GKQxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jul 2012 12:53:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932958Ab2GKQxK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2012 12:53:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09856449F;
	Wed, 11 Jul 2012 12:53:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Nmjr/Oy51XxT
	ZEiRhVYkQueSkkQ=; b=vgSoLLs8lzR0rMbxeU+onKBUV5h6ZC1JRoithlZ2rr7r
	V6nfsE/Jn5NH+rcTDmJ6BjEbdshduM5eNrG2C1dhKwA0h9002cMwDQoFK+0v3MmF
	r/PGj9vxTsBPe2kj/xVQq1D8nFgyryTG9RiGyUApQaOrD2S01WgKAkg3DkjWrBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ke9yFK
	+KwDuYWyURKg99XyS2OnDJH8uZytIyTQn80ZCk7n0I4BVmZLr5O8oKXPIg0JAH4s
	Gk295H3PS6wJeWcNhBnjKPJX0HqVLOKalqyXCyDDBBNlHxy6opmaLxRoOYcTB4vX
	/uVelGgzpPBGhywm2lESj1odTp0PmpGbyhva4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 012BB449E;
	Wed, 11 Jul 2012 12:53:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 855EA449B; Wed, 11 Jul 2012
 12:53:08 -0400 (EDT)
In-Reply-To: <1342016087.6458.10.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 11 Jul 2012 16:14:47
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E45C1442-CB78-11E1-8B74-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201316>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> I've added a bit of code to also remove branch.foo.rebase, which
> I'd also consider to be part of the upstream information.

If "git branch -t" or "git branch --set-upstream" took another
option "--integrate-with=3D[rebase|merge]" to set the variable, I
would agree that removing branch.$name.rebase would be the right
thing to do, but because it is not, I do not know if it is sensible
to remove it upon --unset-upstream.

I actually thought about commenting on that exact variable in my
review, saying that the patch was correct that it didn't touch it.
