From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/symbolic-ref.c: add option to output
 shortened ref
Date: Mon, 27 Feb 2012 14:28:55 -0800
Message-ID: <7vwr7752s8.fsf@alter.siamese.dyndns.org>
References: <1330380638-9738-1-git-send-email-jk@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Feb 27 23:29:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2943-0003vF-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab2B0W26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 17:28:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755305Ab2B0W26 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 17:28:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B187E67;
	Mon, 27 Feb 2012 17:28:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QSZ7mdJM9Fic
	nlpZWNTt11HX+So=; b=tVyinbvB2NfUVCBuRVaIg8CdMs2fOCIhsjAdSG4Rqed+
	/NHeQCcxUxUmn7Ttg1XsnXwkcahpj46NYyCZ/y7owobc1bmel8/VQAJ3B0RJw3PD
	g8R66DgAbaYSPOP9DKAcgH6t8jXekVJ+cqjN396mJdoMxc5waj6VVCASDtWOW1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cYsKr7
	fT2UmFlrvavMo748fLC2n4tuAHuLbMQsAfKOHipXGFh+MMUanW1067+CyRHgriS9
	N+fPf9kjBFup3jdo0k7L3HnJFk8AWGS5ZO8o/2F+c4lAuUzxQlkKjXBlC0U3N6u1
	1pDXDZQfOYXcTeYta7ejxndAe4Gnjgw7R+nu8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CCC27E65;
	Mon, 27 Feb 2012 17:28:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12E807E63; Mon, 27 Feb 2012
 17:28:56 -0500 (EST)
In-Reply-To: <1330380638-9738-1-git-send-email-jk@jk.gs> ("Jan =?utf-8?Q?K?=
 =?utf-8?Q?r=C3=BCger=22's?= message of "Mon, 27 Feb 2012 23:10:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 700D87C4-6192-11E1-8D08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191687>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> In scripts meant to generate user-consumable output, it can be helpfu=
l
> to resolve a symbolic ref and output the result in a shortened form,
> such as for use in shell prompts. Add a new -s option to allow this.

I think this one (unlike 1/2) makes sense, but a single letter -s feels=
 a
bit too vague.  Always spelling in long option "--short" so that it
matches "%(refname:short)" in for-each-ref might be better, I would thi=
nk.

Especially given that the expected use case is primarily in scripts not
from the command line, being more explicit and easier to read has value
over being short and easier to (mis)type.
