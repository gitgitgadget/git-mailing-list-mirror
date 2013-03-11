From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH
 compatibility
Date: Mon, 11 Mar 2013 10:01:20 -0700
Message-ID: <7vfw01an1b.fsf@alter.siamese.dyndns.org>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v38w1c3ms.fsf@alter.siamese.dyndns.org>
 <7vobepany3.fsf@alter.siamese.dyndns.org> <vpqtxohubmb.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 18:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF66g-0004Jx-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 18:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab3CKRBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 13:01:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086Ab3CKRBX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 13:01:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48385B6D4;
	Mon, 11 Mar 2013 13:01:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jfyIYfTsfkxq8hAYJND0Ioj/ZoM=; b=qHiuAU
	F8MlalMyV7R/d68KHYRgQajihQTUSe1VRZTwk5Yh9Y5aWNcD2jxLtJgI+o5sH67k
	92CCUhxbU1HRyB7XTHd7F+DJuAn+x4pMnuHXg6YJB1krJsMi/1HUx/3o5BNW49M9
	r2Iad0A0fcphRlO15E0GmUh1VKEze4iPdMr5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OadaGS/GZ5u9q8RUDS+EN/1pnTf7JV5Z
	jAwn0T8urJF/u9hw4YNe1xX4VGoBdljcyq0FU+BxAM+ZxznuKEFXJwyOhfmY5H88
	F98cyzxSyVD8AG/8Z9JN9zY+H11M8JOWQcyDORYMLd2libY2GdImBAN0thq+eYpR
	OhN0fJaQqV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D22BB6D3;
	Mon, 11 Mar 2013 13:01:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8662B6D2; Mon, 11 Mar 2013
 13:01:21 -0400 (EDT)
In-Reply-To: <vpqtxohubmb.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 11 Mar 2013 17:47:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CAC7BDC-8A6D-11E2-872C-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217891>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So here is an updated based on your patch.
>
> Perfect, thanks.
>
>> The correct thing to do in the longer term may be to stop dot-sourcing
>> the source meant for bash into zsh, but this patch should suffice as
>> a band-aid in the meantime.
>
> I disagree with this particular part though. I think using the same code
> for bash and zsh makes sense, and it implies restricting to the common
> subset.

Having to restrict to the common subset means that whenever bash
adds new and useful features that this script could take advantage
of to improve the user experience, they cannot be employed until zsh
catches up (and worse yet, it is outside the control of this script
if zsh may ever catch up in the specific feature).
