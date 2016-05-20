From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Fri, 20 May 2016 10:50:20 -0700
Message-ID: <xmqqoa80ei03.fsf@gitster.mtv.corp.google.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
	<CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
	<573E30C8.4070600@sapo.pt>
	<CAPig+cRo3tjt9N0YO8sNn90dL3dP0asfmKTr5rerS9YLO6QBtw@mail.gmail.com>
	<xmqqbn40fzu8.fsf@gitster.mtv.corp.google.com>
	<573F4BEC.7000906@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 20 19:50:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3oZK-0008C4-8L
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbcETRu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 13:50:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751317AbcETRuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:50:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F28D1A248;
	Fri, 20 May 2016 13:50:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OtSTxAxytevvenjZ0dHLpQT9xLE=; b=QUaJG+
	AONaiqfgmiEAmZUZS6wRedi7zmogGgo6cYO2H5nS8MT5f8bqoRia3+AxdaNIsVQB
	dZfePMJcNSCQzrdFXvMA1e+YepkM60z1lAi18FQ8Y5BvT0Le39ZnmjAtb7CRQmL1
	eymj9j5haUbCVUcXoZGk0Lk6SaVzr5D1moFv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=edcbP0bQwJSo/AtDks+0yGy8syc0d4pd
	S4nPD04MEYS60IJ4t5VC3BacsLF542vDPJ7p8bgkUKuYDoCLtWdGelQj+1SR2AsQ
	TnVX/mxjgJszZTElg4/WYmTBjC/NKnoTgIeIsdzHxuky6rCNGayZUEXmb5kxFz3F
	P7szRjg/2Gc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36D631A247;
	Fri, 20 May 2016 13:50:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF1561A246;
	Fri, 20 May 2016 13:50:22 -0400 (EDT)
In-Reply-To: <573F4BEC.7000906@sapo.pt> (Vasco Almeida's message of "Fri, 20
	May 2016 17:39:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5353133C-1EB3-11E6-A82A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295193>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Alternatively, we could leave sed alone as it were before this patch and
> use test_i18ngrep instead of grep to fake success under GETTEXT_POISON.
> I think I prefer this way. What do you think?

That is equivalent to saying that "we would translate 'lgf' to
end-user's language", which does not make much sense to me.

Wouldn't the introductory explanation, up to "Did you mean this?",
be the only thing that is translated?
