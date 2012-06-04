From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase [-i --exec | -ix] <CMD>...
Date: Mon, 04 Jun 2012 14:06:12 -0700
Message-ID: <7v7gvmss6z.fsf@alter.siamese.dyndns.org>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vhaurt1m6.fsf@alter.siamese.dyndns.org> <vpqk3zmn7k1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 23:06:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbeTk-0001wH-6a
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 23:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab2FDVGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 17:06:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768Ab2FDVGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 17:06:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7842800B;
	Mon,  4 Jun 2012 17:06:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wmOglOu0q5bL235h436iwaF09+4=; b=QYy8ro
	DXcRaqJy9AktoxtyqebMY9A1abtpZtjXPbton4OHwKrYFnYKbJ36UnDSYVWM+mto
	xudBP7gVm1B0bTkEt/0TlY90h5PxXuBM/EPaPhZYevHDklgO0FRdyspTLZH8lqFC
	wTRTKtCuyvpIcfjLf5NFq1fn/l1zF1tYwJgfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eDQBWv/ahCaGcqGaVGpjH4CDhYPoqQrk
	ZHxbC+O5McUXpvxMtoikoUJDjg/B63v6aaeIxOB4eaaH/DE/zGPWqxOAJaYLcqEB
	n+arVtOtuMpjf/ATzCgdM5gLUg896NCwGh7ATqSLC5IJ6UlUw7QCC0CKB5r0yz4j
	4Xl3YaBgm98=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE252800A;
	Mon,  4 Jun 2012 17:06:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 547AC8008; Mon,  4 Jun 2012
 17:06:14 -0400 (EDT)
In-Reply-To: <vpqk3zmn7k1.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 04 Jun 2012 22:30:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E848558-AE89-11E1-9608-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199189>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I'd actually say you want to run it after a squash/fixup serie only.
>
> If the result of --autosquash is
>
> pick foo
> fixup bar
> fixup boz
> pick foobar
>
> I think you want to rewrite it as
>
> pick foo
> fixup bar
> fixup boz
> exec make
> pick foobar
> exec make

That makes sense.
