From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Sun, 04 Apr 2010 19:11:31 -0700
Message-ID: <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
 <1270392557-26538-1-git-send-email-avarab@gmail.com>
 <20100404224324.GB12655@gmail.com>
 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 04:11:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nybn7-00042k-Ia
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 04:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab0DECLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 22:11:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab0DECLk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 22:11:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB60A77B9;
	Sun,  4 Apr 2010 22:11:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XnvORbPPBwmJ
	BlxGmwrQf8NWeiw=; b=KQiRnfSkkFCJeCsGoyYcuOhbsxIGWfeJTb8qkeNnqHg7
	Bru6cUs6c3eRv+g0YaolQHQCU/OuGk4Pq6YZRpAxv/DkDQJlRHulJXJAmWLCtit2
	EQSnv0ZuA+LnR1iW4zoAG6vYhYj7sXPwtddClCs5oz4UAA/09Z2caHXUKbD/TMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t5/LNd
	QLy1vBCSgOKbnOob+yH7ggQo3QKLS9890NLy+8Gq3Yfq+a1v+pjVqply5dsp9NaK
	LDQ0YmjSba1geWXQJnHPYecG6/JQWQjr+Ny4RsXc3/m2kmTBafHsscGeLC+xonwE
	JAXUduQIBaPWenbk57pBnXiCshkWYvEJWQeHQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49070A77B5;
	Sun,  4 Apr 2010 22:11:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9770AA77A8; Sun,  4 Apr
 2010 22:11:32 -0400 (EDT)
In-Reply-To: <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 4 Apr
 2010 23\:53\:26 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 901074C6-4058-11DF-A4A1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143965>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It's not so much about supporting scripting as exporting the
> capabilities of the porcelain to the frontend utilities without
> artificial limitations.

As a Porcelain, "git commit" has some leeway to enforce sensible policy=
 on
the users, and "forbid commit that does not explain anything" is one su=
ch
policy.  It is not generally a good idea to expose the full capabilitie=
s
of plumbing to Porcelain if it leads to bad user behaviour, and such
"artificial" limitations are safety features we do not want to remove.
