From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git am" crash (builtin/apply.c:2108) + small repro
Date: Wed, 14 Nov 2012 14:50:26 -0800
Message-ID: <7vd2zfajf1.fsf@alter.siamese.dyndns.org>
References: <CAOKKMFG4JsNyMY7=SB6EuR8_GnpAu-ysH02J5pwD1cNzUgaieQ@mail.gmail.com>
 <CACsJy8B9NDmGnopoFEAA0T4mgG+54npYnbb_d4tihRNB=xrGnw@mail.gmail.com>
 <CAOKKMFFGz5Waz3OV4_uTgwDaL=S9NWAnLnACPzSkGpu_rrChvQ@mail.gmail.com>
 <CACsJy8B4xeLSDPC42JifZwC7VWTPRd2iZfnxtPhf7u3OzOm_6Q@mail.gmail.com>
 <7vtxtz2x1g.fsf@alter.siamese.dyndns.org>
 <7vlifb2tfp.fsf@alter.siamese.dyndns.org>
 <CAOKKMFE=gwF4d+R2SD+3eRWqvZwkAt2hX8aPT8fvcwEZXiZbuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Alexey Spiridonov <snarkmaster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 23:50:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYln9-00035r-HG
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 23:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933198Ab2KNWu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 17:50:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932997Ab2KNWu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 17:50:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64537ACF3;
	Wed, 14 Nov 2012 17:50:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5RTD4QQLLlCDiiQaiIqtbItPcU0=; b=XhTgZk
	oaP3gFhIKkdmyxbaLEa2jOyP5DbDoQz8lr24iLhzRxrrC7IpVbC6ev7aLAzRzcRU
	ypSyihcoUCPlUbzRWYHqPqVxKyet95ADmNj9HM5CoLnSKYN3+KPEC0D7BpaX0jsm
	41E61gATttOqSEsyLN7soJo4NojZnnjp9t1+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KwCoRmjjV8INfYmB/8c2jjdfweFJ/QCs
	N8E4NL6IMngA0gwcDfGMiZxA13iRgxGW41z2uGDh4699FZsT81ea2S1dDDwyFxRi
	HJtylHCV8OC8zFAtB+DZ/OR1IJoSK48fxDDmBaKmy6WhwKmlEgYkeLHcCjw7xvJZ
	2RZrqz6XZtc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52563ACF2;
	Wed, 14 Nov 2012 17:50:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7E1BACF1; Wed, 14 Nov 2012
 17:50:27 -0500 (EST)
In-Reply-To: <CAOKKMFE=gwF4d+R2SD+3eRWqvZwkAt2hX8aPT8fvcwEZXiZbuQ@mail.gmail.com> (Alexey
 Spiridonov's message of "Mon, 5 Nov 2012 14:55:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF356CBC-2EAD-11E2-BD21-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209756>

Alexey Spiridonov <snarkmaster@gmail.com> writes:

> Thanks for looking into this, guys!
>
> I seem to run into this with some regularity, but my setting is
> apply.whitespace=strip rather than 'fix'.

'strip' is an old synonym for 'fix'.
