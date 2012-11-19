From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/2] New zsh wrapper
Date: Mon, 19 Nov 2012 10:55:58 -0800
Message-ID: <7vpq39xw01.fsf@alter.siamese.dyndns.org>
References: <1353236889-15052-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Khouzam <marc.khouzam@gmail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 19:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaWWG-0008NK-1a
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 19:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab2KSS4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 13:56:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754204Ab2KSS4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 13:56:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F25290C2;
	Mon, 19 Nov 2012 13:56:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WETQFaYXE+U2CLcNjGFEDKRGL2c=; b=CnaMGc
	5Dx53t61uPmSXgAqqwhx1V99WXLmW1gRu2bcUK3S73yDaP7Q8hRhBJr1qe3gwysm
	gNHXZYTwq8K4ZhQnDwmNdrlQD0+kEfAsa5T33DQ2o4XwPQKSGaOePaj/ANgVbj8r
	SYlDEfCpPLikCSkhoMYDv9Z4nzY+zUaTulf5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mbXTxmpJDzaNJW9cAaE6shgdKM9Ep1rS
	kRDrAIEXKLbM5IUGedC8pmgFsQ+K2TVhTB/XDBNXdNfpolpTZiCDmdkPkpPdjwCH
	gaAWwcMjvO/O6D/KVRUWwKsQR1ZG9AOLHyUA8iv9QpxY6jxkM0zuRIc5O6LJPfYV
	0NDflwwqByc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08EB590C1;
	Mon, 19 Nov 2012 13:56:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45A4290BE; Mon, 19 Nov 2012
 13:56:00 -0500 (EST)
In-Reply-To: <1353236889-15052-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 18 Nov 2012 12:08:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C264A9B2-327A-11E2-A274-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210048>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The second patch is new, in order for users to get the same features when
> sourcing the bash script (they don't need to change anything). They'll get a
> warning suggesting to check the new script git-completion.zsh. Eventually, that
> support would be dropped from the bash script.
>
> Some people were suggesting something like this, so here it is.
>
> Can we merge the zsh wrapper now?
>
> Felipe Contreras (2):
>   completion: add new zsh completion
>   completion: start moving to the new zsh completion
>
>  contrib/completion/git-completion.bash | 104 +++++++++++++++++++--------------
>  contrib/completion/git-completion.zsh  |  78 +++++++++++++++++++++++++
>  2 files changed, 139 insertions(+), 43 deletions(-)
>  create mode 100644 contrib/completion/git-completion.zsh

Thanks; I am a bit puzzled as to the progression of this series, as
it spanned many months.  I *think* the following are the previous
ones, but I may be mixing up v$n patches for other series, so just
to make sure (please correct if I am mistaken):

 * (v1) http://thread.gmane.org/gmane.comp.version-control.git/189310
   with only git-completion.zsh without any changes to the bash
   side;

 * (v2) http://thread.gmane.org/gmane.comp.version-control.git/189381
   without bash side changes;

 * (v3) http://thread.gmane.org/gmane.comp.version-control.git/196720
   without bash side changes;

 * (v6) http://thread.gmane.org/gmane.comp.version-control.git/208170
   with COMPREPLY changes;

 * This one, with removal of zsh specific workarounds from bash
   completion script.

I do not care too much about how v4 and v5 looked like; I primarily
am interested in knowing if I can discard 208170 from my inbox
safely ;-).

Thanks.
