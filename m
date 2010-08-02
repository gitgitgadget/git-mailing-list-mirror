From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: mention "git pull" in error message for non-fast
 forwards
Date: Mon, 02 Aug 2010 15:11:28 -0700
Message-ID: <7vfwywk6lr.fsf@alter.siamese.dyndns.org>
References: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr>
 <20100802191211.GA2180@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:11:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3EX-0000z6-1q
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab0HBWLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:11:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0HBWLi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:11:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93A24C948F;
	Mon,  2 Aug 2010 18:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Hil3r0YDUuUc
	p5QWYmhGc37N/AI=; b=KS7fETJo84mj7wgzixSVJEfVOqjpUjHmTuNAfkwQLu04
	EArQqtg2pkq7uRnKkYxzWqBx6SCuNQGngAdW0ZcobuDi37CkPEVFPV3aZaUJO0DP
	MBl53E8+ABgqs+joa23uzqJPdPlPcODtmBfetX9G+dmZ3gYVLvrsBWHv/8mppF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sbt/ZX
	bfmYDB1ubNyQjxkvIXYERqE7GV5Kihj1gWf7mimEta2Xl4/Yeo0CVpS1EOwVExqr
	tLyy4z/rMgxnf6/syV/GV7ENPzepjscMGuaY+43SLQQRxurrGbay8es1jzQoNUyo
	NcKmewgXC/U6/Z7ES/6EMRT/v6mDVamL0RQaM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F31CC948E;
	Mon,  2 Aug 2010 18:11:34 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 885F9C948B; Mon,  2 Aug
 2010 18:11:30 -0400 (EDT)
In-Reply-To: <20100802191211.GA2180@burratino> (Jonathan Nieder's message of
 "Mon\, 2 Aug 2010 14\:12\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E96CCEE2-9E82-11DF-84D5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152470>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This reminds me: sometimes people blindly =E2=80=9Cgit pull=E2=80=9D =
a rebased history
> just to avoid a non-fast-forward push, and it irks me to no end.  So =
if
> I were running the world, the output would be:
>
>  error: rejected non-fast-forward push to '<url>'
>  hint: To prevent you from losing history, non-fast-forward updates a=
re
>  hint: rejected by default.
>  hint: See the 'Note about fast-forwards' section of 'git push --help=
'
>  hint: for details.

I actually like that ;-)

Since we are discussing the "advice" part of the output, I don't think =
it
is so bad to add the three-bullet list below to it, either, though.

>  1. if upstream is ahead of you, you may want to "git pull"
>
> but
>
>  2. if upstream rebased, you may want to "git pull --rebase", and
>     yell at upstream a little while at it.
>
> and
>
>  3. if the history you are pushing to is both (1) known to be unstabl=
e
>     and (2) wrong, you can override it with
>     "git push <remote> +<refspec>".  Be sure to make sure the
>     =E2=80=9C[receive] denyNonFastForwards=E2=80=9D setting is unset =
correctly in this
>     case.
>
> Jonathan
