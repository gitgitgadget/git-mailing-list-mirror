From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Fri, 20 May 2011 10:18:17 -0700
Message-ID: <7vtycp2sva.fsf@alter.siamese.dyndns.org>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com>
 <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
 <7v62p68ut0.fsf@alter.siamese.dyndns.org>
 <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
 <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de>
 <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com>
 <74D1D7FC-A747-4F85-8B1E-7ABFC9DA70A3@gieschke.de>
 <BANLkTimG8E_Riz3rYC9PMw_2-D=Za0Ar6w@mail.gmail.com>
 <BANLkTingSqEM5=4=rLq7Yu1x9YXstiSsNw@mail.gmail.com>
 <A4C82C4A-4A6A-412C-89D5-803F6DC85FD3@gieschke.de>
 <BANLkTikRCXLJfOJFZ7j0TV_rxsySgQwSsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Gieschke <rafael@gieschke.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri May 20 19:18:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNTLP-0006FD-8j
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 19:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab1ETRSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 13:18:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab1ETRS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 13:18:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D53055590;
	Fri, 20 May 2011 13:20:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=99DsSxD4W3urJtDVHSCHReGdj9k=; b=UWna2H
	NmoI2p6cwqNOjVrPedlfWDmuJHi2n628a8QcXHhEVKqVICD9z4wHyO/8v14exO8R
	i+U7acjI/lySXnS4XqIgBO6zpOHwMUkgVEsAieqbVL5z9mGfsnoBOF/4J58ehc/Q
	76MdJKLt28z6g4LxuQJD1Sd5Rb1qK1xurI0Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOSwoCvox7DC3TrnDsps3kS+7R5ZeBD/
	jc79YCXYRjqciYFDyIg3FmG7YSZV8WgqE2/PAHg95rBPAkghy2JIPp0ci9ziD48J
	yJZo02QF+hBjLoKpjqLji1hDS90Z1vggDFmIiKYpiVgwd9LBElKh9kvvpxJxiJp3
	QXM1fY8oKRA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90924558F;
	Fri, 20 May 2011 13:20:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 419C0558E; Fri, 20 May 2011
 13:20:27 -0400 (EDT)
In-Reply-To: <BANLkTikRCXLJfOJFZ7j0TV_rxsySgQwSsw@mail.gmail.com> (Erik
 Faye-Lund's message of "Fri, 20 May 2011 12:48:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 778F8A40-8305-11E0-A173-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174069>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Actually, I'm thinking that we should avoid ever using getpass:

Good thinking.

> Instead,
> we should make our own function (based on your most recent patch?)
> that fills a caller-specified strbuf instead (git_getpass already have
> a static strbuf that we can fill).

Heh, I thought you earlier felt "a bit pointless" to "a properly
abstracted common version" I outlined earlier in the thread ;-)
