From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] githooks.txt: Improve the intro section
Date: Tue, 26 Apr 2016 12:48:27 -0700
Message-ID: <xmqqr3dsf8xg.fsf@gitster.mtv.corp.google.com>
References: <1461694402-9629-1-git-send-email-avarab@gmail.com>
	<1461694402-9629-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:48:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8yL-000510-JR
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbcDZTsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 15:48:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753235AbcDZTsb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 15:48:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1FCA15998;
	Tue, 26 Apr 2016 15:48:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W5VP9IS5i0mP
	Qk56rKT6PdDx0LY=; b=aUTGp6YBFJk4pajs6V56cBawc+vLJNzYYp1+rVQ/5ZLI
	JG03EW2R0SokVWHtZrrt2tLhJzdrYs2eLp1uKwojijkGX9WDFgHNa4rsoC3U7Yh8
	/NQxu3kaP/g8EVUoZdFAs9carA1bazwOlL4/7uP9P1uJ2FYMocVMerQwBfG7Ef8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=T9/8P6
	3dwrFORmmuc6tJvoM/yTWQ3kzWSkFf0tos41es6zmjLqXXTlSjrwQE3lKiDmAkVs
	c2xdqPBx22KAwHh1L0+ha+OXH8leK8h3ABMrW9kcYytX92VFzMBp2gjFSBFkus8o
	i4Txpvv2M1MiEirIYmMIKujTCs/jxH+5KpeME=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8E7415996;
	Tue, 26 Apr 2016 15:48:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E4A415994;
	Tue, 26 Apr 2016 15:48:29 -0400 (EDT)
In-Reply-To: <1461694402-9629-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 26 Apr
 2016 18:13:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D95AFFE6-0BE7-11E6-B664-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292654>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  * We note what happens with chdir() before a hook is called, nothing
>    documented this explicitly, but the current behavior is
>    predictable. It helps a lot to know what directory these hooks wil=
l
>    be executed from.

I _think_ this item is what you meant by "changed the wording for
all of this to hopefully be more clear in my v4.", but I do not
think it addresses "find it somehow and then chdir()" confusion.

It does say "it is run at", meaning that chdir() happens before it
is run.  That is not sufficient to let the reader guess taht chdir()
happens before the hooks directory is checked relative to that
directory to find the hook to run.

> +When 'git init' is run it may, depending on its configuration, copy
> +hooks to the new repository, see the the "TEMPLATE DIRECTORY" sectio=
n

"... is run, it may, depending on its configuration, copy hooks..."

If that is too much sentence fragments, you could reorder them, e.g.

	'git init' may copy hooks to the new repository, depending
	on its configuration.  See the "TEMPLATE DIRECTORY" section

That would fix "the the" as a side effect ;-).

> +in linkgit:git-init[1] for details. When the rest of this document
> +refers to "default hooks" it's talking about the default template
> +shipped with Git.
> +
> +The currently supported hooks are described below.
> =20
>  HOOKS
>  -----
