From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Sun, 04 Apr 2010 22:27:22 -0700
Message-ID: <7vsk7apiyt.fsf@alter.siamese.dyndns.org>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
 <1270392557-26538-1-git-send-email-avarab@gmail.com>
 <20100404224324.GB12655@gmail.com>
 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
 <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 07:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyeql-0000Gu-Rg
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 07:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab0DEF1f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 01:27:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0DEF1e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 01:27:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D412A70C6;
	Mon,  5 Apr 2010 01:27:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+SAda0gbWomD
	qG7HUBSE0LJcT/A=; b=BygkI4VGktSDr1C8ggfYvGzxT8/GdfOJGtUd+FMrb32s
	aLhjAu33n1Jyj9RFMSFMoeoJjTW7ODFkrfF3K+vc3MLx9DvT/Jw8gwW9NVMEsL4R
	zXIczcyt/68cBz2mcNL8wz08cGR5iDGBrJRSsIm22243mjkxT/nJ/ghD/wqirvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=COdA9+
	I6tIQlbx1j0D7S5S2HtsMdsA1DJ2dAoUp2U6Ggud407Bq1ZnqpFd853TOCxIw1Ig
	ZGa5SmIsuGEy4lvG0gXPRZCbi57kdqSRkbBp5C6mmK7R3N3MX2JAZVGQEsnf+eSC
	PJ+W5g4a3J8Fp8RVSwdEZpz3KuqtitYFxnXYU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B90A6A70C0;
	Mon,  5 Apr 2010 01:27:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00E4CA70B8; Mon,  5 Apr
 2010 01:27:23 -0400 (EDT)
In-Reply-To: <buor5mu7acd.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Mon\, 05 Apr 2010 14\:10\:58 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED1372FC-4073-11DF-A274-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143969>

Miles Bader <miles@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> As a Porcelain, "git commit" has some leeway to enforce sensible pol=
icy on
>> the users, and "forbid commit that does not explain anything" is one=
 such
>> policy.  It is not generally a good idea to expose the full capabili=
ties
>> of plumbing to Porcelain if it leads to bad user behaviour, and such
>> "artificial" limitations are safety features we do not want to remov=
e.
>
> Isn't the requirement of using a longish option like
> "--allow-empty-message" enough of a warning to users though?

Yes, but re-read the part you omitted from your quote, where =C3=86var =
makes it
sound as if exposing plumbing's flexibility to the Porcelain layer is
unconditionally a good thing.  My point is it never is.

And as you said (and as Sverre alluded to with his --allow-empty), long=
ish
option is one way to ensure that we do not unconditionally expose
flexibility from the plumbing without thinking.
