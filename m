From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: introduce a pull.rebase option to enable --rebase
Date: Sun, 06 Nov 2011 00:47:34 -0700
Message-ID: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org>
References: <1320507358-3407-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 08:55:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMxZb-0006aU-G0
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 08:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873Ab1KFHri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 02:47:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab1KFHrh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 02:47:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72C94580A;
	Sun,  6 Nov 2011 02:47:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xjXKViFTXT2r
	dA0qzdgZijj0QBM=; b=E0v8r3wSMNGpnu//r66VfeG0cUDqSc2sqdmWMq6NR1XT
	KUpvW9tanbQQ9V2OugN9d4C9dy28sg1x/6A1EfBR6RM+wBbQ7jyXdD3FrQa+K+f+
	RifWCvOGxJEHs2rkaZ6WL/O0jfQSrJ+sPqTDrIagdEg57UwAXLsM1ymjVK7NKd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ry3FqU
	sxQZlTZIUuMRRusHrhqIZz2oDJduBGVYQcMEAIwujLlCNtJxznACmZZZxlZYUybI
	FpUB7iIsFZ8KK/aNY4QOSE3y6Bcw2lMbRnUp4jZW6M1qfOr6xVBmJBhGggf02pJt
	jcoh9zIbPDrWFWbUy5vS6k2ec3EGqRdlMLu90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 626935809;
	Sun,  6 Nov 2011 02:47:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9ED95806; Sun,  6 Nov 2011
 02:47:35 -0500 (EST)
In-Reply-To: <1320507358-3407-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 5 Nov
 2011 15:35:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97C592E8-084B-11E1-B4E9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184904>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This option will be considered at a lower priority than
> branch.<name>.rebase, i.e. we could set pull.rebase=3Dtrue and
> branch.<name>.rebase=3Dfalse and the latter configuration option woul=
d
> win.
>
> Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
> Reviewed-by: Fernando Vezzosi <buccia@repnz.net>
> Reviewed-by: Eric Herman <eric@freesa.org>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

I see many reviewed-by lines, but what kind of review did this patch ha=
ve,
exactly? It seem to break its own test (branch.to-rebase.rebase should
override pull.rebase).

I think I've queued most (if not all) of the patches in flight except f=
or
Ram's sequencer reroll to 'pu' and pu^ passes the test but the tip of p=
u
does not due to this topic.

Thanks for other topics from the Amsterdam together, by the way. I did =
not
comment on them individually but they looked mostly reasonable from a
quick glance.
